package com.example.rma.controller;

import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String getUserList(Model model){
       // model.addAttribute("userList",userService.findAll());
        model.addAttribute("userList", userService.findAllUserDto());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String editUserForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String saveEditUser(@RequestParam("userId") User user,
                               @RequestParam Map<String, String> form,
                               @RequestParam String username){

        userService.editUser(user, form, username);

        return "redirect:/user";
    }

    @GetMapping("profile")
    public String getProfile(Model model,
                             @AuthenticationPrincipal User user) {
        model.addAttribute("username", user.getUsername());
        model.addAttribute("email", user.getEmail());

        return "profile";
    }

    @PostMapping("profile")
    public String updateProfile(@AuthenticationPrincipal User user,
                              @RequestParam(required = false) String password,
                              @RequestParam(required = false) String email){

        userService.updateProfile(user, password, email);

        return "profile";

    }





}
