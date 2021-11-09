package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.domain.dto.InstitutionWorkScheduleDto;
import com.example.rma.domain.dto.WorkScheduleDto;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    @Autowired
    private UserService userService;

    @Autowired
    private WorkScheduleService workScheduleService;

    @GetMapping
    public String getSchedule(@AuthenticationPrincipal User principal ,
                              Model model){
        Institution institution = userService.findInstitutionByUser(principal);
        LocalDate date = LocalDate.now();

        List<WorkScheduleDto> workScheduleDtoList = workScheduleService.getSchedule(institution, date);

        model.addAttribute("workScheduleDtoList", workScheduleDtoList);

        List<InstitutionWorkScheduleDto> institutionWorkScheduleDtoList = new ArrayList<>();

        InstitutionWorkScheduleDto institutionWorkScheduleDto = new InstitutionWorkScheduleDto(institution.getId(), institution.getFIO(), workScheduleDtoList);

        institutionWorkScheduleDtoList.add(institutionWorkScheduleDto);

        model.addAttribute("institutionWorkScheduleDtoList", institutionWorkScheduleDtoList);

        model.addAttribute("institution", institution);
        return "Schedule";
    }
}
