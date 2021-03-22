package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.repository.InstitutionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class FindUserController {

    @Autowired
    private  InstitutionRepo institutionRepo;

    @GetMapping("/findUserByLastName")
    public String findUserByLastName(@AuthenticationPrincipal User user,
                                     @RequestParam(required = false, name ="userName") String userName,
                                     Model model) {
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

            model.addAttribute("institutions", institutionList );


        }
        else {
            model.addAttribute("institutions", institutionRepo.findAll());
        }

        return "/findUser";
    }
}
