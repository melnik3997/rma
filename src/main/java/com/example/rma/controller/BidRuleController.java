package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.bidRule.*;
import com.example.rma.service.EnterpriseService;
import com.example.rma.service.UserService;
import com.example.rma.service.bidRule.BidRuleService;
import com.example.rma.service.bidRule.StateMachineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class BidRuleController {

    @Autowired
    private BidRuleService bidRuleService;

    @Autowired
    private EnterpriseService enterpriseService;

    @Autowired
    private StateMachineService stateMachineService;

    @Autowired
    private UserService userService;

    @Autowired
    private EntityManager em;


    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/enterprise/{enterprise}/bidRuleList/add")
    public String addBitRuleByEnterprise(@PathVariable Enterprise enterprise,
                                            Model model){
        model.addAttribute("enterprise",enterprise);
        model.addAttribute("bidTypeList", BidType.values());

        model.addAttribute("enterpriseList", enterpriseService.findAll());
        model.addAttribute("enterpriseDisabled", true);
        return "bidRuleForm";
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping(path = "/enterprise/{enterprise}/bidRuleList/add")
    public String saveBitRuleByEnterprise(@PathVariable Enterprise enterprise,
                                          @Valid BidRule bidRule,
                                          BindingResult bindingResult,
                                          Model model){
        System.out.println("bidRule  " + bidRule.getName());

        bidRuleService.create(bidRule);
        return "redirect:/enterprise/"+enterprise.getId()+"/bidRuleList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping( "/enterprise/{enterprise}/bidRuleList")
    public String getBitRuleByEnterprise(@PathVariable Enterprise enterprise,
                                         Model model){
        getBidRuleData(enterprise, model);


        return "bidRuleListEnterprise";
    }

    private void getBidRuleData(@PathVariable Enterprise enterprise, Model model) {
        model.addAttribute("enterprise",enterprise);

        List<BidRule> bidRuleActiveList = bidRuleService.findByEnterpriseAndActive(enterprise, true);
        List<BidRule> bidRuleUnActiveList = bidRuleService.findByEnterpriseAndActive(enterprise, false);

        model.addAttribute("bidRuleActiveList", bidRuleActiveList);
        model.addAttribute("bidRuleUnActiveList", bidRuleUnActiveList);
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/bidRule/{bidRule}/stateMachineList")
    public String getStateMachineList(@PathVariable BidRule bidRule,
                                      Model model){

        model.addAttribute("bidRule", bidRule);
        model.addAttribute("stateList", stateMachineService.findStateDtoByBidRule(bidRule));

        return "stateMachineList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/bidRule/{bidRule}/stateMachineList/addState")
    public String getStateMachineListAddState(@PathVariable BidRule bidRule,
                                              Model model){

        getDataForStateForm(bidRule, model);

        return "stateForm";
    }

    private void getDataForStateForm(@PathVariable BidRule bidRule, Model model) {
        model.addAttribute("bidRuleList", bidRuleService.findByEnterprise(bidRule.getEnterprise()));
        model.addAttribute("bidRuleDisabled", true);
        model.addAttribute("bidRule", bidRule);
        model.addAttribute("stateTypeList", StateType.values());
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping(path = "/bidRule/{bidRule}/stateMachineList/addState")
    public String createStateMachineListAddState(@PathVariable BidRule bidRule,
                                                 State state,
                                                 Model model){

        Map<String, String> errors = stateMachineService.createState(state);

        if(!errors.isEmpty()){
            model.mergeAttributes(errors);
            getDataForStateForm(bidRule, model);
            model.mergeAttributes(ControllerUtils.parsersAttribute(state));

            return "stateForm";
        }

        return "redirect:/bidRule/"+bidRule.getId()+"/stateMachineList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/bidRule/{bidRule}/stateMachineList/addTransition")
    public String getStateMachineListAddTransition(@PathVariable BidRule bidRule,
                                              Model model){

        getDateForTransition(bidRule, model);

        return "transitionForm";
    }

    private void getDateForTransition(@PathVariable BidRule bidRule, Model model) {
        model.addAttribute("bidRuleList", bidRuleService.findByEnterprise(bidRule.getEnterprise()));
        model.addAttribute("bidRuleDisabled", true);
        model.addAttribute("bidRule", bidRule);
        model.addAttribute("actionTypeList", ActionType.values());
        model.addAttribute("enterprise", bidRule.getEnterprise());

        List<State> stateList = stateMachineService.findStateByBidRule(bidRule);

        model.addAttribute("targetStateList",stateList );
        model.addAttribute("sourceStateList",stateList );
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping(path = "/bidRule/{bidRule}/stateMachineList/addTransition")
    public String createStateMachineListAddTransition(@PathVariable BidRule bidRule,
                                                      @RequestParam(name = "institution", required = false) Institution institution,
                                                      Transition transition,
                                                      Model model){
        transition.setInstitution(institution);

        System.out.println("getInstitution "+transition.getInstitution());

        Map<String, String> errors = stateMachineService.createTransition(transition);

        if(!errors.isEmpty()){
            model.mergeAttributes(errors);
            getDateForTransition(bidRule, model);
            model.mergeAttributes(ControllerUtils.parsersAttribute(transition));

            return "transitionForm";
        }

        return "redirect:/bidRule/"+bidRule.getId()+"/stateMachineList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/bidRule/{bidRule}/active")
    public String setActiveBidRule(@PathVariable BidRule bidRule,
                                   Model model){
        Map<String, String> errors = bidRuleService.activeBidRule(bidRule);

        if (!errors.isEmpty()){
            getBidRuleData(bidRule.getEnterprise(), model);

            model.mergeAttributes(errors);
            return "bidRuleListEnterprise";
        }

        return "redirect:/enterprise/"+bidRule.getEnterprise().getId()+"/bidRuleList";

    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/bidRule/{bidRule}/deactivate")
    public String setDeactivateBidRule(@PathVariable BidRule bidRule,
                                       Model model) {
        Map<String, String> errors = bidRuleService.deactivateBidRule(bidRule);

        if (!errors.isEmpty()) {
            getBidRuleData(bidRule.getEnterprise(), model);

            model.mergeAttributes(errors);
            return "bidRuleListEnterprise";
        }

        return "redirect:/enterprise/" + bidRule.getEnterprise().getId() + "/bidRuleList";
    }
}
