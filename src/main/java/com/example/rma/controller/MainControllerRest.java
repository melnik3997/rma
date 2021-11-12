package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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

        String m = calendarService.getRusNameMonthByNumber(date.getMonth().getValue());

        int year = date.getYear();
        return dayWeek + " " + s + " " + m + " " + year;
    }

    @GetMapping("/getWorkSchedule")
    public WorkScheduleDto getWorkSchedule(@AuthenticationPrincipal User user){

        return workScheduleService.getWorkScheduleDto(userService.findInstitutionByUser(user));
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
