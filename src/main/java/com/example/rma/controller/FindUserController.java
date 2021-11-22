package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.repository.InstitutionRepo;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

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
                                     @RequestParam(required = false, name ="userName") String userName,
                                     Model model) {
        /*
        if(!StringUtils.isEmpty(userName)) {
            String[] arrName = userName.trim().split(" ");

            String lastName = arrName[0];
            String fistName;
            String secondName;
            if(arrName.length == 2)
             fistName = arrName[1];
            if(arrName.length == 3)
            secondName = arrName[2];

            List<Institution> institutionList = institutionRepo.findByLastName(lastName);
            List<InstitutionDto> institutionDtoList = institutionRepo.findInstitutionDtoByParam(0l, userName);

            model.addAttribute("institutions", institutionDtoList );


        }
        else {
            model.addAttribute("institutions", institutionRepo.findAll());
        }
*/
        if(userName.length()>0) {
            String param = "%" + userName + "%";
            Enterprise enterprise = userService.findInstitutionByUser(user).getEnterprise();
            List<InstitutionDto> institutionDtoList = institutionRepo.findInstitutionDtoByParam(enterprise.getId(), param);
            model.addAttribute("institutions", institutionDtoList );
        }

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
