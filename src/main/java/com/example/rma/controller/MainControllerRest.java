package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.Post;
import com.example.rma.domain.PresenceWork;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.DayWeek;
import com.example.rma.domain.calendar.dto.Month;
import com.example.rma.domain.dto.WorkScheduleDto;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.PresenceWorkService;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping
public class MainControllerRest {

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
        return workScheduleService.getWorkScheduleDto(userService.findInstitutionByUser(user));
    }
    @RequestMapping(method = RequestMethod.GET,
            value = "/getWorkSchedule/{calendar}")
    public WorkScheduleDto getWorkScheduleByCalendarId(@AuthenticationPrincipal User user,
                                                       @PathVariable Calendar calendar){
        System.out.println("Вызов id");

        return workScheduleService.getWorkScheduleDto(calendar, userService.findInstitutionByUser(user));
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
        return workScheduleService.getWorkScheduleDto(userService.findInstitutionByUser(user));
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
        double sumTime = 0D;
        List<PresenceWork> presenceWorkList =presenceWorkService.getByInstitutionAndCalendar(institution, calendarService.findCalendarByNowDateAndInstitution(institution));

        for (PresenceWork presenceWork: presenceWorkList) {
            long duration = Duration.between(presenceWork.getTimeBegin(), presenceWork.getTimeFinish() == null ? LocalTime.now() : presenceWork.getTimeFinish()).getSeconds();
            sumTime = sumTime +  duration / 60.0 /60.0 ;
        }
        System.out.println("sumTime " + sumTime);
        return  sumTime;
    }

    @GetMapping("/getInstitutionIsWorkNow")
    public boolean getInstitutionIsWorkNow(@AuthenticationPrincipal User user){
        Institution institution = userService.findInstitutionByUser(user);
        boolean b =presenceWorkService.isActive(institution, calendarService.findCalendarByNowDateAndInstitution(institution));
        System.out.println("b " + b);
        return  b;
    }

    @RequestMapping(method = RequestMethod.POST,
            value = "/endWork")
    public WorkScheduleDto endWork(@AuthenticationPrincipal User user){
        System.out.println("end");
        return workScheduleService.getWorkScheduleDto(userService.findInstitutionByUser(user));
    }


}
