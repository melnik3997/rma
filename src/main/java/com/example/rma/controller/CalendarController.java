package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.domain.calendar.dto.Month;
import com.example.rma.service.SettingsService;
import com.example.rma.service.UserService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
public class CalendarController {

    @Autowired
    private UserService userService;

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private SettingsService settingsService;


    @GetMapping("/calendar")
    public String getCalendar(@AuthenticationPrincipal User user, Model model){
        String calendarTypeName = CalendarType.getDefault().getName();

        model.addAttribute("calendarType", calendarTypeName.substring(0, 1).toUpperCase() + calendarTypeName.substring(1) );

        Institution institution = userService.findInstitutionByUser(user);

        CalendarEnterprise calendarEnterprise = calendarService.findByEnterpriseAndCalendarTypeAndActive(institution.getEnterprise(), CalendarType.getDefault(), true );
        Integer year ;
        if(calendarEnterprise != null){
            year = calendarEnterprise.getYearInt();
        }else {
            year = null;
        }

        model.addAttribute("year", year);

        return "calendar";
    }

    @GetMapping("/calendar/{calendarEnterprise}")
    public String getCalendarByCalendarEnterprise(@AuthenticationPrincipal User user,
                                                  @PathVariable CalendarEnterprise calendarEnterprise, Model model){
        model.addAttribute("calendarEnterprise", calendarEnterprise);

        String calendarTypeName = calendarEnterprise.getCalendarType().getName();

        model.addAttribute("calendarType", calendarTypeName.substring(0, 1).toUpperCase() + calendarTypeName.substring(1) );

        int year = calendarEnterprise.getYearInt();


        model.addAttribute("year", year);

        return "calendar";
    }

    @GetMapping("/calendarListEnterprise/{enterprise}")
    public String getCalendarListEnterprise(@PathVariable Enterprise enterprise,
                                            Model model,
                                            @PageableDefault(sort = { "active","yearInt" }, direction = Sort.Direction.DESC) Pageable pageable){
        model.addAttribute("calendarList", calendarService.findCalendarEnterpriseByEnterprise(enterprise, pageable));
        model.addAttribute("enterprise", enterprise);
        model.addAttribute("url", "/calendarListEnterprise/" +enterprise.getId() );

        return "calendarList";
    }

    @GetMapping("/calendarAdd/{enterprise}")
    public String getCreateCalendarForEnterprise(@PathVariable Enterprise enterprise, Model model){

        model.addAttribute("calendarTypeList", CalendarType.values());
        model.addAttribute("enterpriseName", enterprise.getName());

        return "calendarAdd";
    }

    @PostMapping("/calendarAdd/{enterprise}")
    public String createCalendarForEnterprise(@PathVariable Enterprise enterprise,
                                              @RequestParam(name = "year") String year,
                                              @RequestParam(name = "calendarType") String calendarTypeStr,
                                              Model model){

        System.out.println(year +"  "+ calendarTypeStr);
        boolean error = false;
        int yearInt = 0;
        try {
            yearInt = Integer.parseInt(year);
        }catch (Exception e){
            model.addAttribute("yearError", "Не корректное значение");
            error = true;
        }
        if(!error) {
            CalendarType calendarType = CalendarType.valueOf(calendarTypeStr);

            Map<String, String> errors = calendarService.createCalendarEnterprise(enterprise, calendarType, yearInt, false);

            if (errors.size() != 0) {
                error = true;
                model.mergeAttributes(errors);
            }
        }
        if(error){
            model.addAttribute("calendarTypeList", CalendarType.values());
            model.addAttribute("enterpriseName", enterprise.getName());
            model.addAttribute("year", year);
            model.addAttribute("calendarTypeStr", calendarTypeStr);
            return  "calendarAdd";

        }
        return "redirect:/calendarListEnterprise/"+enterprise.getId();
    }


}
