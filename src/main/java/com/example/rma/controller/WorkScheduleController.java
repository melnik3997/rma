package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.WorkSchedule;
import com.example.rma.service.WorkScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Controller
@RequestMapping("/workSchedule")
public class WorkScheduleController {

    @Autowired
    private WorkScheduleService workScheduleService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{institution}")
    public String editWorkScheduleForm(@PathVariable Institution institution,
                                       Model model) {
        model.addAttribute("workSchedule", workScheduleService.findActiveByInstitution(institution));
        model.addAttribute("institution", institution);
        return "workScheduleForm";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("{institution}")
    public String saveWorkScheduleForm(@PathVariable Institution institution,
                                       @RequestParam(name = "workTime") String workTimeS,
                                       @RequestParam(name = "lunchBreak") String lunchBreakS,
                                       @RequestParam(name = "lunchBreakIn", required = false) boolean lunchBreakIn,
                                       @RequestParam(name = "active", required = false) boolean active,

                                       @RequestParam(name = "timeBeginS", required = false) String timeBeginS,
                                       @RequestParam(name = "timeFinishS", required = false) String timeFinishS,
                                       Model model) {

        boolean errors = false;
        if (checkTime(timeBeginS)) {
            model.addAttribute("timeBeginError", "Не введена дата");
            timeBeginS = "";
            errors = true;
        }
        if (checkTime(timeFinishS)) {
            model.addAttribute("timeFinishError", "Не введена дата");
            timeFinishS = "";
            errors = true;
        }


        if (errors) {
            model.addAttribute("workTime", workTimeS);
            model.addAttribute("lunchBreak", lunchBreakS);
            model.addAttribute("lunchBreakIn", lunchBreakIn);
            model.addAttribute("active", active);
            model.addAttribute("timeBeginS", timeBeginS);
            model.addAttribute("timeFinishS", timeFinishS);
            return "workScheduleForm";
        }
        LocalTime timeBegin = LocalTime.parse(timeBeginS, DateTimeFormatter.ISO_LOCAL_TIME);
        LocalTime timeFinish = LocalTime.parse(timeFinishS, DateTimeFormatter.ISO_LOCAL_TIME);

        WorkSchedule workSchedule = new WorkSchedule(institution, Double.parseDouble(workTimeS), Double.parseDouble(lunchBreakS), lunchBreakIn, timeBegin, timeFinish, active);
        System.out.println(workSchedule);
        Map<String, String> error = workScheduleService.create(workSchedule);
        if (!error.isEmpty()) {
            model.addAttribute("workTime", workTimeS);
            model.addAttribute("lunchBreak", lunchBreakS);
            model.addAttribute("lunchBreakIn", lunchBreakIn);
            model.addAttribute("active", active);
            model.addAttribute("timeBeginS", timeBeginS);
            model.addAttribute("timeFinishS", timeFinishS);
            model.mergeAttributes(error);
            return "workScheduleForm";
        }
        return "redirect:/workSchedule/list/"+institution.getId();
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/list/{institution}")
    public String getWorkScheduleList(@PathVariable Institution institution,
                                      Model model) {

        model.addAttribute("institution", institution);
        model.addAttribute("workScheduleList", workScheduleService.findByInstitution(institution));


        return "workScheduleList";
    }

    public boolean checkTime(String time) {
        return time.equals("__:__");
    }

}
