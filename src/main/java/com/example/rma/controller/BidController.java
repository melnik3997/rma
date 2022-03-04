package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.bidRule.*;
import com.example.rma.domain.bidRule.dto.DealObjectDto;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.exception.BusinessException;
import com.example.rma.service.UserService;
import com.example.rma.service.bid.LeaveEarlyService;
import com.example.rma.service.bid.TimeOffService;
import com.example.rma.service.bidRule.BidObjectService;
import com.example.rma.service.bidRule.BidRuleService;
import com.example.rma.service.bidRule.TransitionService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
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

    @Autowired
    private TimeOffService timeOffService;

    @GetMapping("/bid")
    public String getBid(@AuthenticationPrincipal User principal,
                         @RequestParam(name = "employee", required = false) Institution employee,
                         @RequestParam(name = "responsible", required = false) Institution responsible,
                         @RequestParam(name = "author", required = false) Institution author,
                         Model model,
                         @PageableDefault(sort = { "id" }, direction = Sort.Direction.DESC) Pageable pageable,
                         RedirectAttributes redirectAttributes,
                         @RequestHeader(required = false) String referer,
                         HttpServletRequest request){
        Page<DealObjectDto> dealObjectList ;
        Institution institution = userService.findInstitutionByUser(principal);

        if(responsible == null && employee == null && author == null){
            responsible = institution;
        }

        List<BidRule> bidRuleList = bidRuleService.findByEnterpriseAndActive(institution.getEnterprise(), true);

        dealObjectList = bidObjectService.findDealObjectByParam(responsible, author, null, employee, pageable);

        model.addAttribute("dealObjectList", dealObjectList);
        model.addAttribute("bidRuleList", bidRuleList);
        model.addAttribute("employee", employee);
        model.addAttribute("responsible", responsible);
        model.addAttribute("author",author);
        model.addAttribute("enterprise", institution.getEnterprise());

        String atr = ControllerUtils.getQueryUrl(request);

        model.addAttribute("url", "/bid" + atr );
        System.out.println(" request.getRequestURL " +  request.getQueryString());

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
        model.addAttribute("open", false);

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
            model.addAttribute("open", false);
            return getFormNameByBidRule(bidRule);
        }


        return "redirect:/bid";
    }

    @GetMapping(path ="/bid/{bidRule}/timeOff")
    public String getCreateTimeOff(@AuthenticationPrincipal User principal,
                                      @PathVariable BidRule bidRule,
                                      Model model){

        model.addAttribute("bidRule", bidRule);
        model.addAttribute("open", false);

        return getFormNameByBidRule(bidRule);
    }

    @PostMapping(path ="/bid/{bidRule}/timeOff")
    public String createCreateTimeOff(@AuthenticationPrincipal User principal,
                                         @PathVariable BidRule bidRule,
                                         @RequestParam(name = "date") String date,
                                         @RequestParam(name = "comment") String comment,
                                         Model model){
        Map<String, String> errors = new HashMap<>();

        errors = timeOffService.create(bidRule, principal, date, comment);

        if(!errors.isEmpty()) {
            model.mergeAttributes(errors);
            model.addAttribute("bidRule", bidRule);
            model.addAttribute("dateS", date);
            model.addAttribute("comment", comment);
            model.addAttribute("open", false);
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
                                        Model model,
                                        RedirectAttributes redirectAttributes,
                                        @RequestHeader(required = false) String referer){

        try {
            Protocol protocol = transitionService.doTransition(dealObject, transition);
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();

        components.getQueryParams()
                .entrySet()
                .forEach(pair -> redirectAttributes.addAttribute(pair.getKey(), pair.getValue()));

        return "redirect:" + components.getPath();
    }


    @GetMapping(path ="/bid/{dealObject}/rollback")
    public String getDealObjectRollback(@AuthenticationPrincipal User principal,
                                        @PathVariable DealObject dealObject,
                                        @RequestParam(name = "employee", required = false) Institution employee,
                                        @RequestParam(name = "responsible", required = false) Institution responsible,
                                        @RequestParam(name = "author", required = false) Institution author,
                                        Model model,
                                        RedirectAttributes redirectAttributes,
                                        @RequestHeader(required = false) String referer){

        System.out.println("employee" + employee);
        System.out.println("responsible" + responsible);
        System.out.println("author" + author);
        try {
            transitionService.rollback(dealObject);
        } catch (BusinessException e) {
            e.printStackTrace();
        }
        UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();

        components.getQueryParams()
                .entrySet()
                .forEach(pair -> redirectAttributes.addAttribute(pair.getKey(), pair.getValue()));

        return "redirect:" + components.getPath();
    }

    @GetMapping(path ="/bid/{dealObject}/open")
    public String getOpenBid(@AuthenticationPrincipal User principal,
                                      @PathVariable DealObject dealObject,
                                      Model model){

        BidRule bidRule = dealObject.getBidRule();

        String urlName = bidRule.getBidType().getUrlName();
        if(urlName.length() > 0){
            return "redirect:/bid/"+ urlName + "/open/" + dealObject.getId() ;
        }
        return "redirect:/bid";
    }


    @GetMapping(path ="/bid/timeOff/open/{dealObject}")
    public String openTimeOff(@PathVariable DealObject dealObject,
                              Model model){

        System.out.println("dealObject " + dealObject);
        List<DealObjectAttr> dealObjectAttrList = bidObjectService.findDealObjectAttrByDealObject(dealObject);
        BidRule bidRule = dealObject.getBidRule();
        String comment = bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.COMMENT);
        Calendar calendar = calendarService.findCalendarById(Long.parseLong(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.CALENDAR)));
        String date = calendar.getDateS();

        model.addAttribute("bidRule", bidRule);
        model.addAttribute("dateS", date);
        model.addAttribute("comment", comment);
        model.addAttribute("open", true);
        return getFormNameByBidRule(bidRule);

    }

    @GetMapping(path ="/bid/leaveEarly/open/{dealObject}")
    public String openLeaveEarly(@PathVariable DealObject dealObject,
                                 Model model){

        List<DealObjectAttr> dealObjectAttrList = bidObjectService.findDealObjectAttrByDealObject(dealObject);
        BidRule bidRule = dealObject.getBidRule();
        String comment = bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.COMMENT);
        Calendar calendar = calendarService.findCalendarById(Long.parseLong(bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.CALENDAR)));
        String date = calendar.getDateS();
        String timeLeave = bidObjectService.getValueDealObjectAttrByType(dealObjectAttrList, DealObjectAttrType.TIME_END);

        model.addAttribute("bidRule", bidRule);
        model.addAttribute("dateS", date);
        model.addAttribute("comment", comment);
        model.addAttribute("timeLeave", timeLeave);
        model.addAttribute("open", true);
        return getFormNameByBidRule(bidRule);

    }

}
