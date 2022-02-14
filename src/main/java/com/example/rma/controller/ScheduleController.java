package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.domain.dto.InstitutionWorkScheduleDto;
import com.example.rma.domain.dto.WorkScheduleDto;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.SubdivisionService;
import com.example.rma.service.UserService;
import com.example.rma.service.WorkScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    @Autowired
    private UserService userService;

    @Autowired
    private SubdivisionService subdivisionService;

    @Autowired
    private WorkScheduleService workScheduleService;

    @Autowired
    private InstitutionService institutionService;

    @GetMapping
    public String getSchedule(@AuthenticationPrincipal User principal ,
                              Model model){
        Institution institution = userService.findInstitutionByUser(principal);
        LocalDate date = LocalDate.now();
        List<WorkScheduleDto> workScheduleDtoList = workScheduleService.getScheduleByWeek(institution, date);

        model.addAttribute("workScheduleDtoList", workScheduleDtoList);
        List<InstitutionDto> institutionDtoList = institutionService.findColleaguesByInstitution(institution);
        List<Institution> institutionList = institutionDtoList.stream().map(institutionDto -> institutionService.findInstitutionByInstitutionDto(institutionDto)).collect(Collectors.toList());

        institutionList.add(institution);
        List<InstitutionWorkScheduleDto> institutionWorkScheduleDtoList = workScheduleService.getInstitutionListScheduleByWeek(institutionList, date);

        model.addAttribute("institutionWorkScheduleDtoList", institutionWorkScheduleDtoList);

       // model.addAttribute("institution", institution);
        return "Schedule";
    }
}
