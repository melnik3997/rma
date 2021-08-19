package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.domain.calendar.dto.Month;
import com.example.rma.service.UserService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class CalendarController {

    @Autowired
    private UserService userService;

    @Autowired
    private CalendarService calendarService;


    @GetMapping("/calendar")
    public String getCalendar(){

        return "calendar";
    }

    @GetMapping("/calendarListEnterprise/{enterprise}")
    public String getCalendarListEnterprise(@PathVariable Enterprise enterprise, Model model){

        model.addAttribute("calendarList", calendarService.findCalendarEnterpriseByEnterprise(enterprise));

        return "calendarList";
    }
}
