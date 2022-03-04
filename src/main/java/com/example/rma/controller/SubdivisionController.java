package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Subdivision;
import com.example.rma.domain.User;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.service.EnterpriseService;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.SubdivisionService;
import com.example.rma.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    @Autowired
    private InstitutionService institutionService;



    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/subdivisionEnterprise/{enterprise}")
    public String getSubdivisionList(@PathVariable Enterprise enterprise,
                                     Model model) throws JsonProcessingException {
        List<Subdivision> subdivisionList = subdivisionService.findByEnterprise(enterprise);
        model.addAttribute("subdivisionList",subdivisionList);
        model.addAttribute("enterprise",enterprise);
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
    @RequestMapping(method = RequestMethod.GET, value = "/subdivisionEnterprise/add/{enterprise}/sub/{subdivision}")
    public String getSubdivisionAddSub(@PathVariable Enterprise enterprise,
                                    @PathVariable Subdivision subdivision,
                                    Model model){

        model.addAttribute("parent", subdivision);
        model.addAttribute("parentDisabled", true);

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
        model.addAttribute("institutionLeader", subdivisionService.getInstitutionBySubdivision(subdivision));
        model.addAttribute("subdivisionModelId", subdivision.getId());

        return "subdivisionForm";
    }

    @GetMapping("/subdivisionEnterprise/{enterprise}/employee/{subdivision}")
    public String getEmployeeBySubdivision(@PathVariable(name = "enterprise") Enterprise enterprise,
                                           @PathVariable(name = "subdivision") Subdivision subdivision,
                                           Model model,
                                           Pageable pageable){
        Page<InstitutionDto> institutionDtoList = institutionService.findInstitutionBySubdivision(subdivision, pageable);
        model.addAttribute("enterprise", enterprise);
        model.addAttribute("institutionDtoList", institutionDtoList);
        model.addAttribute("url","/subdivisionEnterprise/" + enterprise.getId() +"/employee/" +subdivision.getId()   );

        return "employeeList";
    }



    private void getDataForAdd(Enterprise enterprise, Model model) {
        List<Enterprise> enterpriseList = new ArrayList<>();
        enterpriseList.add(enterprise);
        model.addAttribute("enterprise",enterprise);
        model.addAttribute("enterpriseList",enterpriseList);
        model.addAttribute("enterpriseDisabled",true);

        model.addAttribute("parentList", subdivisionService.findByEnterprise(enterprise));
        model.addAttribute("parentRequired",false);

      //  model.addAttribute("institutionList",userService.getByEnterprise(enterprise));
    }


    @PreAuthorize("hasAuthority('ADMIN')")
    @RequestMapping(method = RequestMethod.POST, value = "/subdivisionEnterprise/add/{enterprise}/sub/{subdivisionParent}")
    public String saveSubdivisionSub( @PathVariable Enterprise enterprise,
                                      @PathVariable Subdivision subdivisionParent,
                                      @Valid Subdivision subdivision,
                                      BindingResult bindingResult,
                                      @RequestParam(required = false, name = "parentId") Subdivision parent,
                                      @RequestParam(name = "leaderId", required = false) User leader,
                                      @RequestParam(required = false, name = "subdivisionId" ) Long subdivisionId,
                                      Model model)  {
        boolean error = ControllerUtils.checkErrorBinding(bindingResult, model);

        subdivision.setLeader(leader);
        subdivision.setEnterprise(enterprise);
        subdivision.setParent(subdivisionParent);
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
        return "redirect:/subdivisionTree/" + enterprise.getId() ;
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/subdivisionEnterprise/add/{enterprise}")
    public String saveSubdivision( @PathVariable Enterprise enterprise,
                                   @Valid Subdivision subdivision,
                                   BindingResult bindingResult,
                                   @RequestParam(required = false, name = "parentId") Subdivision parent,
                                   @RequestParam(name = "leaderId", required = false) User leader,
                                   @RequestParam(required = false, name = "subdivisionId" ) Long subdivisionId,
                                   Model model)  {
        boolean error = ControllerUtils.checkErrorBinding(bindingResult, model);

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
        return "redirect:/subdivisionTree/" + enterprise.getId() ;
    }



    private void getDataForError( Enterprise enterprise,  Subdivision subdivision, Model model) {
        getDataForAdd(enterprise, model);
        model.addAttribute("institutionLeader", subdivisionService.getInstitutionBySubdivision(subdivision));
        if(subdivision.getId() == null) {
            model.addAllAttributes(ControllerUtils.parsersAttribute(subdivision));
        }else{
            model.addAttribute("subdivisionModel", subdivision);
        }
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
        boolean error = ControllerUtils.checkErrorBinding(bindingResult, model);
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

        return "redirect:/subdivisionTree/" + enterprise.getId() ;
    }
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("subdivisionEnterprise/{enterprise}/delete/{subdivision}")
    public String deleteSubdivision( @PathVariable(name = "enterprise") Enterprise enterprise,
                                   @PathVariable(name = "subdivision") Subdivision subdivision,
                                   Model model) {

        Map<String, String> result = subdivisionService.delete(subdivision);

        if (result.size() > 0){
            model.mergeAttributes(result);
            getDataForError(enterprise, subdivision, model);
            return "subdivisionForm";
        }
        return "redirect:/subdivisionTree/" + enterprise.getId() ;
    }



}
