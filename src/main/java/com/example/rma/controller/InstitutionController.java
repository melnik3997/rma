package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.Role;
import com.example.rma.domain.User;
import com.example.rma.repository.EnterpriseRepo;
import com.example.rma.repository.InstitutionRepo;
import com.example.rma.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/institution")
public class InstitutionController {

    @Autowired
    InstitutionRepo institutionRepo;

    @Autowired
    EnterpriseRepo enterpriseRepo;

    @Autowired
    private FileService fileService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String editUserForm(@PathVariable User user, Model model){
        model.addAttribute("userId", user.getId());
        model.addAttribute("institution", institutionRepo.findByUser(user));
        model.addAttribute("enterpriseList", enterpriseRepo.findAll());
        return "institutionForm";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("{user}")
    public String saveInstitution(@RequestParam("userId") User user,
                                  @Valid Institution institution,
                                  BindingResult bindingResult,
                                  @RequestParam Map<String, String> form,
                                  @RequestParam("enterpriseId") Enterprise enterprise,
                                  @RequestParam(required = false, name = "institutionId" ) Long institutionId,
                                  @RequestParam("file") MultipartFile file,
                                  @RequestParam("dateOfBirthS") String dateOfBirth,
                                  Model model) throws IOException {
        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy", Locale.ENGLISH);

        boolean error = false;
        try {
            institution.setDateOfBirth(formatter.parse(dateOfBirth));
        } catch (ParseException e) {
            model.addAttribute("dateOfBirthError", "Ошибка формата даты");
            error = true;
        }
        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            System.out.println(errorsMap);
            errorsMap.remove("dateOfBirthError");
            model.mergeAttributes(errorsMap);


            if(errorsMap.size() != 0){
                error = true;
            }
        }
        if(error){
            model.addAttribute("userId", user.getId());
            model.addAttribute("institution", institutionRepo.findByUser(user));
            model.addAttribute("enterpriseList", enterpriseRepo.findAll());
            model.addAllAttributes(ControllerUtils.parsersAttribute(institution));
            System.out.println( "model " + model);
            return "institutionForm";
        }
        institution.setEnterprise(enterprise);
        if (institutionId != null)
            institution.setId(institutionId);

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            String resultFileName = fileService.saveFile(file);

            institution.setFileName(resultFileName);
        }else if(institutionId != null){
            Optional<Institution> institutionFromDBOp = institutionRepo.findById(institutionId);
            if(institutionFromDBOp.isPresent()){
                Institution institutionFromDB = institutionFromDBOp.get();
                institution.setFileName( institutionFromDB.getFileName());
            }

        }
        institutionRepo.save(institution);

        return "redirect:/user";


    }








}
