package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.bidRule.dto.DealObjectDto;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.UserService;
import com.example.rma.service.bid.LeaveEarlyService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.bidRule.BidRuleService;
import com.example.rma.service.bidRule.TransitionService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.criteria.CriteriaBuilder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BidController {

    @Autowired
    private BidRuleService bidRuleService;

    @Autowired
    private UserService userService;

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private LeaveEarlyService leaveEarlyService;

    @Autowired
    private BidObjectService bidObjectService;

    @Autowired
    private TransitionService transitionService;

    @GetMapping("/bid")
    public String getBid(@AuthenticationPrincipal User principal,
                         @RequestParam(name = "employee", required = false) Institution employee,
                         @RequestParam(name = "responsible", required = false) Institution responsible,
                         @RequestParam(name = "author", required = false) Institution author,
                         Model model){
        List<DealObjectDto> dealObjectList = new ArrayList<>();
        Institution institution = userService.findInstitutionByUser(principal);

        System.out.println(responsible);
/*
        if(responsible == null){
            responsible = institution;
        }*/

        List<BidRule> bidRuleList = bidRuleService.findByEnterpriseAndActive(institution.getEnterprise(), true);

        dealObjectList = bidObjectService.findDealObjectByParam(responsible, author, null, employee);

        model.addAttribute("dealObjectList", dealObjectList);
        model.addAttribute("bidRuleList", bidRuleList);
        model.addAttribute("employee", employee);
        model.addAttribute("responsible", responsible);
        model.addAttribute("author",author);

        return "bidList";
    }

    @GetMapping("/bidCreate")
    public String getCreateBid(@AuthenticationPrincipal User principal,
                               @RequestParam(name = "bidRule") BidRule bidRule,
                               Model model){

        String urlName = bidRule.getBidType().getUrlName();

        if(urlName.length() > 0){
            return "redirect:/bid/"+ bidRule.getId() + "/"+ urlName;
        }

        return "redirect:/bid";
    }

    @GetMapping(path ="/bid/{bidRule}/leaveEarly")
    public String getCreateLeaveEarly(@AuthenticationPrincipal User principal,
                                      @PathVariable BidRule bidRule,
                                      Model model){

        model.addAttribute("bidRule", bidRule);

        return getFormNameByBidRule(bidRule);
    }

    @PostMapping(path ="/bid/{bidRule}/leaveEarly")
    public String createCreateLeaveEarly(@AuthenticationPrincipal User principal,
                                         @PathVariable BidRule bidRule,
                                         @RequestParam(name = "date") String date,
                                         @RequestParam(name = "timeLeave") String timeLeave,
                                         @RequestParam(name = "comment") String comment,
                                         Model model){
        Map<String, String> errors = new HashMap<>();

        errors = leaveEarlyService.create(bidRule, principal, date, timeLeave, comment);

        if(!errors.isEmpty()) {
            model.mergeAttributes(errors);
            model.addAttribute("bidRule", bidRule);
            model.addAttribute("dateS", date);
            model.addAttribute("timeLeave", timeLeave);
            model.addAttribute("comment", comment);
            return getFormNameByBidRule(bidRule);
        }


        return "redirect:/bid";
    }

    private String getFormNameByBidRule(BidRule bidRule){
        return bidRule.getBidType().getFormName();
    }


    @GetMapping(path ="/bid/{dealObject}/action/{transition}")
    public String getDealObjectDoAction(@AuthenticationPrincipal User principal,
                                        @PathVariable DealObject dealObject,
                                        @PathVariable Transition transition,
                                        Model model){

        try {
            Protocol protocol = transitionService.doTransition(dealObject, transition);
        } catch (BusinessException e) {
            e.printStackTrace();
        }


        return "redirect:/bid";
    }


}
