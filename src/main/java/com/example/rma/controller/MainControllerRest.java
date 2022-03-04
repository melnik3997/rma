package com.example.rma.controller;

import com.example.rma.domain.*;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.DayWeek;
import com.example.rma.domain.dto.WorkScheduleDto;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.ActuallyWorkService;
import com.example.rma.service.PresenceWorkService;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping
public class MainControllerRest {

    @Autowired
    private ActuallyWorkService actuallyWorkService;

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private WorkScheduleService workScheduleService;

    @Autowired
    private UserService userService;

    @Autowired
    private PresenceWorkService presenceWorkService;

    @GetMapping("/getDate")
    public String getDate(){
        LocalDate date = LocalDate.now();
        int s = Integer.parseInt(date.format(DateTimeFormatter.ofPattern("dd")));

        String dayWeek = DayWeek.valueOf(date.getDayOfWeek().name()).getName();

        String m = calendarService.getRusNameMonthRodByNumber(date.getMonth().getValue());

        int year = date.getYear();
        return dayWeek + " " + s + " " + m + " " + year + " г.";
    }

    @GetMapping("/getDate/Day")
    public Integer getDateDay(){
        LocalDate date = LocalDate.now();
        return Integer.parseInt(date.format(DateTimeFormatter.ofPattern("dd")));
    }

    @GetMapping("/getWorkSchedule")
    public WorkScheduleDto getWorkSchedule(@AuthenticationPrincipal User user){
        System.out.println("Вызов ");
        return workScheduleService.getWorkScheduleDtoForToday(userService.findInstitutionByUser(user));
    }
    @RequestMapping(method = RequestMethod.GET,
            value = "/getWorkSchedule/{calendar}")
    public WorkScheduleDto getWorkScheduleByCalendarId(@AuthenticationPrincipal User user,
                                                       @PathVariable Calendar calendar){
        System.out.println("Вызов id");

        return workScheduleService.getWorkScheduleDtoForToday(calendar, userService.findInstitutionByUser(user));
    }

    @RequestMapping(method = RequestMethod.POST,
            value = "/startWork")
    public WorkScheduleDto startWork(@AuthenticationPrincipal User user){
        System.out.println("start");
        try {
            presenceWorkService.action(userService.findInstitutionByUser(user), LocalTime.now());
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        return workScheduleService.getWorkScheduleDtoForToday(userService.findInstitutionByUser(user));
    }

    @GetMapping("/getPresenceWork")
    public List<PresenceWork> getPresenceWork(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        List<PresenceWork> presenceWorkList =presenceWorkService.getByInstitutionAndCalendar(institution, calendarService.findCalendarByNowDateAndInstitution(institution));
        System.out.println("presenceWorkList " + presenceWorkList);
        return  presenceWorkList;
    }

    @GetMapping("/getPresenceWorkTimeSum")
    public double getPresenceWorkTimeSum(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        return presenceWorkService.getPresenceWorkTimeSumForToday(institution);
    }



    @GetMapping("/getInstitutionIsWorkNow")
    public boolean getInstitutionIsWorkNow(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        boolean b =presenceWorkService.isActive(institution, calendarService.findCalendarByNowDateAndInstitution(institution));
        System.out.println("b " + b);
        return  b;
    }

    @GetMapping("/getInstitution")
    public Institution getInstitution(@AuthenticationPrincipal User user){
        return  userService.findInstitutionByUser(user);
    }

    @RequestMapping(method = RequestMethod.POST,
            value = "/endWork")
    public WorkScheduleDto endWork(@AuthenticationPrincipal User user){
        System.out.println("end");
        return workScheduleService.getWorkScheduleDtoForToday(userService.findInstitutionByUser(user));
    }


    @RequestMapping(method = RequestMethod.POST,
            value = "/createActuallyWork")
    public Object createActuallyWork(@AuthenticationPrincipal User user,
                                             @RequestBody(required = false) ActuallyWork actuallyWork) throws Exception {
        Institution institution = userService.findInstitutionByUser(user);
        System.out.println("createActuallyWork " + actuallyWork.getTime() + " " + actuallyWork.getComment() + " " + actuallyWork.getInstitution().getFIO());
        actuallyWork.setCalendar(calendarService.findCalendarByNowDateAndInstitution(institution));


        try {
            actuallyWork =actuallyWorkService.create(actuallyWork);
        } catch (BusinessException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return actuallyWork;
    }
    @RequestMapping(method = RequestMethod.GET,
            value = "/getRemainderActuallyWork")
    public Double getRemainderActuallyWork(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return actuallyWorkService.getSumByInstitutionAndCalendar(institution, calendar);

    }

    @RequestMapping(method = RequestMethod.GET,
            value = "/getActuallyWorkList")
    public List<ActuallyWork> getActuallyWorkList(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return actuallyWorkService.findByInstitutionAndCalendar(institution, calendar);

    }

    @RequestMapping(method = RequestMethod.POST,
            value = "/deleteActuallyWork")
    public Object getActuallyWorkList(@AuthenticationPrincipal User user,
                                                  @RequestBody(required = false) ActuallyWork actuallyWork){
        System.out.println("getInstitution " + actuallyWork.getTime());
        try {
            actuallyWorkService.delete(actuallyWork, user);
        } catch (BusinessException e) {
            return new ResponseEntity(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return actuallyWork;

    }



}
