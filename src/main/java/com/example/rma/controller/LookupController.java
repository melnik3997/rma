package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.repository.InstitutionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping
public class LookupController {

    @Autowired
    InstitutionRepo institutionRepo;

    @GetMapping("/institutionForLookup")
    public List<Institution> getInstitutionForLookup(@RequestParam(name = "enterpriseId", required = false) Long enterpriseId,
                                                     @RequestParam(name = "findText", required = false) String findText ) {

        System.out.println( "findText " +  findText);

        findText = "%"+ findText+"%";

        List<Institution> institutionList = institutionRepo.findByParam(enterpriseId, findText);
        System.out.println( "institutionList  " +  institutionList);

        return institutionList;
    }

    @GetMapping("/institutionForLookup/{institution}")
    public Institution getInstitutionForLookupById(@PathVariable Institution institution ) {

        return institution;
    }


}
