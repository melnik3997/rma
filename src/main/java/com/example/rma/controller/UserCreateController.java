package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;


@Controller
public class UserCreateController {

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/userCreate")
    public String openUserCreate(Model model){
        return "/userCreate";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/userCreate")
    public String createUser(@AuthenticationPrincipal User principal,
                             @RequestParam(required = false) String userName,
                             @RequestParam(required = false) String email,
                                     Model model) {
        Map<String, String > result = userService.addUserForAdmin(userName, email);

        if(result.size() != 0){
            model.mergeAttributes(result);
            model.addAttribute("userName", userName);
            model.addAttribute("email", email);
            return "userCreate";
        }
        return "redirect:/user";
    }
}
