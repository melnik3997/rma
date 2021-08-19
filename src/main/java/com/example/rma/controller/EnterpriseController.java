package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Message;
import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.service.EnterpriseService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;

@Controller
public class EnterpriseController {

    @Autowired
    private EnterpriseService enterpriseService;

    @Autowired
    private CalendarService calendarService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/enterprise")
    public String getEnterpriseList(Model model){
        model.addAttribute("enterpriseList",enterpriseService.findAll());
        return "enterpriseList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/enterpriseAdd")
    public String getEnterpriseAdd(Model model){
        return "enterpriseAdd";
    }

    @PostMapping("/enterpriseAdd")
    public String addEnterprise(@AuthenticationPrincipal User user,
                             @Valid Enterprise enterprise,
                             BindingResult bindingResult,
                             Model model) {
        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            System.out.println(errorsMap);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", enterprise);
            return "enterpriseAdd";
        }
        else {
            enterpriseService.save(enterprise);
            return "redirect:/enterprise";
        }
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/enterprise/{enterprise}")
    public String editEnterprise(@PathVariable Enterprise enterprise, Model model){
        model.addAttribute("enterprise", enterprise);

        calendarService.createCalendarEnterprise(enterprise, CalendarType.WORK, 2021);
        return "enterpriseEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/editEnterprise")
    public String saveEditEnterprise(@RequestParam("enterpriseId") Enterprise enterprise,
                                     @Valid  Enterprise enterpriseEd,
                                     BindingResult bindingResult,
                                     Model model){

        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute("enterprise", enterprise);
            return "enterpriseEdit";
        }
        else {
            enterpriseEd.setId(enterprise.getId());
            enterpriseService.save(enterpriseEd);
            return "redirect:/enterprise";
       }
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/deleteEnterprise")
    public String saveDeleteEnterprise(@RequestParam("enterpriseId") Enterprise enterprise,
                                       Model model) {

        Map<String, String> errorsMap =  enterpriseService.delete(enterprise);
        if(errorsMap.size() != 0) {
            model.mergeAttributes(errorsMap);
            model.addAttribute("enterprise", enterprise);
            return "enterpriseEdit";
        }
        return "redirect:/enterprise";

    }

}
