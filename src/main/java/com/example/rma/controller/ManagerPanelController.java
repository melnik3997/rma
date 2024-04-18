package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarClose;
import com.example.rma.domain.calendar.CalendarCloseDto;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.UserService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ManagerPanelController {

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('MANAGER')")
    @GetMapping("/managerPanel")
    public String getLeaderPanel(@AuthenticationPrincipal User user,
                                 @RequestParam(name = "dateBegin", required = false) String dateBegin,
                                 @RequestParam(name = "dateEnd", required = false) String dateEnd,
                                 Model model,
                                 @PageableDefault(sort = { "dateD" }, direction = Sort.Direction.DESC) Pageable pageable,
                                 HttpServletRequest request){
        Institution institution = userService.findInstitutionByUser(user);
        LocalDate dateBeginD = null;
        LocalDate dateEndD = null;
        Map<String, String> errors = new HashMap<>();
        try {
            dateBeginD = LocalDate.parse(dateBegin, DateTimeFormatter.ofPattern("dd.MM.yyyy"));
            dateEndD = LocalDate.parse(dateEnd, DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        }catch (Exception e){
            LocalDate dataNow = LocalDate.now();
            dateBeginD = calendarService.getDateFormat(dataNow.format(DateTimeFormatter.ofPattern("yyyy-MM"))+ "-01");
            dateEndD = calendarService.getDateFormat(dataNow.format(DateTimeFormatter.ofPattern("yyyy-MM"))+ "-01").plusMonths(1L).minusDays(1L);
            dateBegin = dateBeginD.format(DateTimeFormatter.ofPattern("dd.MM.yyyy"));
            dateEnd = dateEndD.format(DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        }

        System.out.println("dateBeginD " + dateBeginD);
        System.out.println("dateEndD " + dateEndD);

        CalendarEnterprise calendarEnterprise = calendarService.findCalendarEnterpriseByEnterprise(institution.getEnterprise());

        Page<CalendarCloseDto> calendarCloseDtoPage = calendarService.findByCalendarEnterpriseAndDateBeginAndDateEnd(calendarEnterprise,
                                                                                                                    dateBeginD, dateEndD, pageable);
        String atr = ControllerUtils.getQueryUrl(request);
        model.addAttribute("calendarCloseDtoPage", calendarCloseDtoPage);
        model.addAttribute("url","/managerPanel" + atr);
        model.addAttribute("dateBegin", dateBegin);
        model.addAttribute("dateEnd", dateEnd);


        return "managerPanel";
    }

    @PreAuthorize("hasAuthority('MANAGER')")
    @GetMapping ("/managerPanelClose")
    public String closeCalendar(@AuthenticationPrincipal User user,
                                @RequestParam(name = "dateClose", required = false) String dateClose,
                                Model model,
                                RedirectAttributes redirectAttributes,
                                @RequestHeader(required = false) String referer){
        Institution institution = userService.findInstitutionByUser(user);
        LocalDate dateCloseD = null;
        Map<String, String> errors = new HashMap<>();
        UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();

        components.getQueryParams()
                .entrySet()
                .forEach(pair -> redirectAttributes.addAttribute(pair.getKey(), pair.getValue()));
        try {
            dateCloseD = LocalDate.parse(dateClose, DateTimeFormatter.ofPattern("dd.MM.yyyy"));
        }catch (Exception e) {
            errors.put("error", "Не корректная дата") ;
            return "redirect:" + components.getPath();
        }
        Calendar calendar = calendarService.findCalendarByDateAndInstitution(institution, dateCloseD);

        CalendarClose calendarClose = new CalendarClose(calendar, institution, LocalDateTime.now());

        try {
            calendarService.calendarCloseCreate(calendarClose);
        } catch (BusinessException e) {
            System.out.println(e);
            errors.put("error", e.getMessage()) ;
        }


        return "redirect:" + components.getPath();
    }


}
