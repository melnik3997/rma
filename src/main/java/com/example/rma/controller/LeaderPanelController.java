package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/leaderPanel")
public class LeaderPanelController {

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private UserService userService;

    @Autowired
    private WorkScheduleService workScheduleService;

    @Autowired
    private SubdivisionService subdivisionService;

    @Autowired
    private PresenceWorkService presenceWorkService;

    @Autowired
    private ActuallyWorkService actuallyWorkService;

    @PreAuthorize("hasAuthority('LIEDER')")
    @GetMapping()
    public String getLeaderPanel(@AuthenticationPrincipal User user,
                                 Model model){

        Institution institution = userService.findInstitutionByUser(user);

        List<InstitutionDto> institutionDtoList = institutionService.findSubordinatesByInstitution(institution);

        institutionDtoList = institutionService.enrichmentInstitutionDto(institutionDtoList);

        model.addAttribute("subdivision" , subdivisionService.findSubdivisionByInstitution(institution));
        model.addAttribute("institutionDtoList" , institutionDtoList);

        return "leaderPanel";
    }
}
