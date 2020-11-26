package com.example.rma.controller;

import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserRepo userRepo;

    @GetMapping("/registration")
    public String registration(){

        return "registration";
    }
    @PostMapping("/registration")
    public String addNewUsr(User user, Map<String, Object> model){
        User userFromDb =  userRepo.findByUsername(user.getUsername());

        if(userFromDb != null) {
            model.put("message", "Данный пользователь уже есть!");
            return "registration";
        }
        user.setActive(true);
        user.setRole(Collections.singleton(Role.USER));
        userRepo.save(user);

        return "redirect:/login";
    }

}
