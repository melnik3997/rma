package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.repository.InstitutionRepo;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class FindUserController {

    @Autowired
    private  InstitutionRepo institutionRepo;

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private UserService userService;


    @GetMapping("/findUserByLastName")
    public String findUserByLastName(@AuthenticationPrincipal User user,
                                     @RequestParam(required = false, name = "userName") String userName,
                                     Model model,
                                     @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable,
                                     HttpServletRequest request) {


        String param = "%" + userName + "%";
        Enterprise enterprise = userService.findInstitutionByUser(user).getEnterprise();
        Page<InstitutionDto> institutionDtoList = institutionRepo.findInstitutionDtoByParam(enterprise.getId(), param, pageable);
        model.addAttribute("institutions", institutionDtoList);

        String atr = ControllerUtils.getQueryUrl(request);
        model.addAttribute("url", "/findUserByLastName" + atr);


        model.addAttribute("findValue", userName);

        return "/findUser";
    }


    @GetMapping("/institutionChain/{institution}")
    public String findInstitutionChain(@AuthenticationPrincipal User user,
                              @PathVariable( name ="institution") Institution institution,
                              Model model) {

        model.addAttribute("ChainLeaderByInstitutionList", institutionService.findChainLeaderByInstitution(institution) );

        model.addAttribute("institution", institutionService.findInstitutionDtoByInstitution(institution));

        model.addAttribute("leaderInstitution", institutionService.findLeaderByInstitution(institution) );

        model.addAttribute("subordinatesInstitution", institutionService.findSubordinatesByInstitution(institution) );

        model.addAttribute("colleaguesInstitution", institutionService.findColleaguesByInstitution(institution) );

        return "/institutionChain";
    }
}
