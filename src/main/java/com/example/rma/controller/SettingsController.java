package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Settings;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.SettingsDto;
import com.example.rma.repository.SettingsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.List;


@Controller
public class SettingsController {

    @Autowired
    private SettingsRepo settingsRepo;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/settings")
    public String settingsList(Model model){
        return "settings";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/settings")
    public String createSetting( @AuthenticationPrincipal User user,
                                 @RequestParam(required = true, name = "sysName" ) String sysName,
                                 @RequestParam(required = true, name = "type" ) String type,
                                 @RequestParam(required = true, name = "value" ) String value,
                                 Model model){

        if(!StringUtils.isEmpty(sysName) && !StringUtils.isEmpty(type) && !StringUtils.isEmpty(value)){
            Long maxSID;
            maxSID = settingsRepo.findMaxSId();
            if(maxSID == null)
                maxSID = 0l;

            maxSID++;
            Settings settings = new Settings();
            settings.setsId(maxSID);
            settings.setSysName("Type");
            settings.setValue(type);
            settingsRepo.save(settings);


            Settings settings1 = new Settings();
            settings1.setsId(maxSID);
            settings1.setSysName("SysName");
            settings1.setValue(sysName);
            settingsRepo.save(settings1);

            Settings settings2 = new Settings();
            settings2.setsId(maxSID);
            settings2.setSysName("Val");
            settings2.setValue(value);
            settingsRepo.save(settings2);

            List<Object[]> settingsDtoList = settingsRepo.findAllSettings();

            System.out.println(settingsDtoList);

            for (Object[] o : settingsDtoList) {

                for (Object o1 : o ) {
                    System.out.println(o1);
                }


            }

        }

        return "redirect:/settings";
    }
}
