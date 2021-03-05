package com.example.rma.controller;

import com.example.rma.domain.User;
import com.example.rma.domain.dto.SettingsDto;
import com.example.rma.service.SettingsService;
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
public class SettingsController {

    @Autowired
    private SettingsService settingsService;


    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/settings")
    public String settingsList(Model model){
        model.addAttribute("settingsList", settingsService.getAllSettingsDto());

        return "settings";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/settings")
    public String createSetting( @AuthenticationPrincipal User user,
                                 @RequestParam(required = false, name = "sysName" ) String sysName,
                                 @RequestParam(required = false, name = "type" ) String type,
                                 @RequestParam(required = false, name = "value" ) String value,
                                 Model model){

        Map<String, String> error =  settingsService.saveSetting(sysName, type, value);


        model.addAttribute("settingsList", settingsService.getAllSettingsDto());
        if(error.size() > 0){
            model.mergeAttributes(error);
            return "/settings";
        }
        return "redirect:/settings";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/settings/delete/{sId}")
    public String delete( @AuthenticationPrincipal User user,
                          @PathVariable Long sId,
                                 Model model){
        settingsService.deleteBySID(sId);
        return "redirect:/settings";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/settings/edit/{sId}")
    public String editDisplay( @AuthenticationPrincipal User user,
                        @PathVariable Long sId,
                        Model model){
        model.addAttribute("settings", settingsService.getSettingsBySId(sId));
        return "/settingsEdit";
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/settings/edit/{sId}")
    public String edit( @AuthenticationPrincipal User user,
                        @PathVariable Long sId,
                        @RequestParam(required = false, name = "sysName" ) String sysName,
                        @RequestParam(required = false, name = "type" ) String type,
                        @RequestParam(required = false, name = "value" ) String value,
                        Model model){

        Map<String, String> error =  settingsService.editSetting(sId, sysName, type, value);


        model.addAttribute("settingsList", settingsService.getAllSettingsDto());
        if(error.size() > 0){
            model.mergeAttributes(error);
            model.addAttribute("settings", new SettingsDto(sId, sysName, type, value));
            return "/settingsEdit";
        }
        return "redirect:/settings";
    }
}
