package com.example.rma.controller;

import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Struct;
import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
@PreAuthorize("hasAuthority('ADMIN')")
public class UserController {

    @Autowired
    private UserRepo userRepo;

    @GetMapping
    public String getUserList(Model model){

        Iterable<User> users = userRepo.findAll();

        model.addAttribute("userList",users);

        return "userList";
    }

    @GetMapping("{user}")
    public String editUserForm(@PathVariable User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PostMapping
    public String saveEditUser(@RequestParam("userId") User user,
                               @RequestParam Map<String, String> form,
                               @RequestParam String username){
        user.setUsername(username);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRole().clear();

        for (String key : form.keySet()) {
            if(roles.contains(key)){
                user.getRole().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
        return "redirect:/user";
    }


}
