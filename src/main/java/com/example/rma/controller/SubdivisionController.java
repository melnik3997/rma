package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Subdivision;
import com.example.rma.domain.User;
import com.example.rma.service.EnterpriseService;
import com.example.rma.service.SubdivisionService;
import com.example.rma.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;


@Controller
public class SubdivisionController {

    @Autowired
    private SubdivisionService subdivisionService;
    @Autowired
    private EnterpriseService enterpriseService;
    @Autowired
    private UserService userService;



    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/subdivisionEnterprise/{enterprise}")
    public String getSubdivisionList(@PathVariable Enterprise enterprise,
                                     Model model) throws JsonProcessingException {
        List<Subdivision> subdivisionList = subdivisionService.findAllByEnterprise(enterprise);
        model.addAttribute("subdivisionList",subdivisionList);
        model.addAttribute("enterprise",enterprise);

        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String json = ow.writeValueAsString(subdivisionService.findByEnterpriseAndParent(enterprise, null));
        System.out.println(json);
        return "subdivisionList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/subdivisionTree/{enterprise}")
    public String getSubdivisionTree(@PathVariable Enterprise enterprise,
                                     Model model) throws JsonProcessingException {

        model.addAttribute("enterprise", enterprise);
        return "node";
    }


    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/subdivisionEnterprise/add/{enterprise}")
    public String getSubdivisionAdd(@PathVariable Enterprise enterprise,
                                     Model model){

        getDataForAdd(enterprise, model);

        return "subdivisionForm";
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/subdivisionEnterprise/{enterprise}/edit/{subdivision}")
    public String getSubdivisionEdit(@PathVariable(name = "enterprise") Enterprise enterprise,
                                     @PathVariable(name = "subdivision") Subdivision subdivision,
                                     Model model){

        getDataForAdd(enterprise, model);
        model.addAttribute("subdivisionModel", subdivision);
        model.addAttribute("subdivisionModelId", subdivision.getId());

        return "subdivisionForm";
    }

    private void getDataForAdd(Enterprise enterprise, Model model) {
        List<Enterprise> enterpriseList = new ArrayList<>();
        enterpriseList.add(enterprise);
        model.addAttribute("enterprise",enterprise);
        model.addAttribute("enterpriseList",enterpriseList);
        model.addAttribute("enterpriseDisabled",true);

        model.addAttribute("parentList", subdivisionService.findAllByEnterprise(enterprise));
        model.addAttribute("parentRequired",false);

        model.addAttribute("institutionList",userService.getByEnterprise(enterprise));
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/subdivisionEnterprise/add/{enterprise}")
    public String saveSubdivision( @PathVariable Enterprise enterprise,
                                   @Valid Subdivision subdivision,
                                   BindingResult bindingResult,
                                   @RequestParam(required = false, name = "parentId") Subdivision parent,
                                   @RequestParam("leaderId") User leader,
                                   @RequestParam(required = false, name = "subdivisionId" ) Long subdivisionId,
                                   Model model)  {
        boolean error = CheckErrorBinding(bindingResult, model);
        subdivision.setLeader(leader);
        subdivision.setEnterprise(enterprise);
        subdivision.setParent(parent);
        if(error){
            getDataForError(enterprise, subdivision, model);
            return "subdivisionForm";
        }
        Map<String, String> result = subdivisionService.addSubdivision(subdivision);
        if (result.size() > 0){
            model.mergeAttributes(result);
            getDataForError(enterprise, subdivision, model);
            return "subdivisionForm";
        }
        return "redirect:/subdivisionEnterprise/" + enterprise.getId() ;
    }

    private boolean CheckErrorBinding(BindingResult bindingResult, Model model ){
        boolean error = false;
        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            if(errorsMap.size() != 0){
                error = true;
            }
        }
        return error;
    }

    private void getDataForError( Enterprise enterprise,  Subdivision subdivision, Model model) {
        getDataForAdd(enterprise, model);
        model.addAllAttributes(ControllerUtils.parsersAttribute(subdivision));
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("subdivisionEnterprise/{enterprise}/edit/{subdivision}")
    public String editSubdivision( @PathVariable(name = "enterprise") Enterprise enterprise,
                                     @PathVariable(name = "subdivision") Long subdivisionId,
                                     @Valid Subdivision subdivision,
                                     BindingResult bindingResult,
                                     @RequestParam(required = false, name = "parentId") Subdivision parent,
                                     @RequestParam("leaderId") User leader,
                                     Model model) {
        boolean error = CheckErrorBinding(bindingResult, model);
        subdivision.setLeader(leader);
        subdivision.setEnterprise(enterprise);
        subdivision.setParent(parent);
        if(error){
            getDataForError(enterprise, subdivision, model);
            return "subdivisionForm";
        }
        subdivision.setId(subdivisionId);
        Map<String, String> result = subdivisionService.addSubdivision(subdivision);
        if (result.size() > 0){
            model.mergeAttributes(result);
            getDataForError(enterprise, subdivision, model);
            return "subdivisionForm";
        }

        return "redirect:/subdivisionEnterprise/" + enterprise.getId() ;
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("subdivisionEnterprise/{enterprise}/delete/{subdivision}")
    public String deleteSubdivision( @PathVariable(name = "enterprise") Enterprise enterprise,
                                   @PathVariable(name = "subdivision") Long subdivisionId,
                                   Model model) {

        System.out.println("Вызов");
        return "redirect:/subdivisionEnterprise/" + enterprise.getId() ;
    }



}
