package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.bidRule.*;
import com.example.rma.service.EnterpriseService;
import com.example.rma.service.bidRule.BidRuleService;
import com.example.rma.service.bidRule.StateMachineService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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
        model.addAttribute("enterprise",enterprise);

        List<BidRule> bidRuleActiveList = bidRuleService.findByEnterpriseAndActive(enterprise, true);
        List<BidRule> bidRuleUnActiveList = bidRuleService.findByEnterpriseAndActive(enterprise, false);

        model.addAttribute("bidRuleActiveList", bidRuleActiveList);
        model.addAttribute("bidRuleUnActiveList", bidRuleUnActiveList);


        return "bidRuleListEnterprise";
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping(path = "/bidRule/{bidRule}/stateMachineList")
    public String getStateMachineList(@PathVariable BidRule bidRule,
                                      Model model){

        model.addAttribute("bidRule", bidRule);
        model.addAttribute("stateList", stateMachineService.findByBidRule(bidRule));

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

        Map<String, String> errors = stateMachineService.create(state);

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

        model.addAttribute("bidRuleList", bidRuleService.findByEnterprise(bidRule.getEnterprise()));
        model.addAttribute("bidRuleDisabled", true);
        model.addAttribute("bidRule", bidRule);
        model.addAttribute("actionTypeList", ActionType.values());

        List<State> stateList = stateMachineService.findByBidRule(bidRule);

        model.addAttribute("targetStateList",stateList );
        model.addAttribute("sourceStateList",stateList );

        return "transitionForm";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping(path = "/bidRule/{bidRule}/stateMachineList/addTransition")
    public String createStateMachineListAddTransition(@PathVariable BidRule bidRule,
                                                      Transition transition,
                                                      Model model){



        return "transitionForm";
    }
}
