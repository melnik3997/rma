package com.example.rma.controller;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.Subdivision;
import com.example.rma.repository.InstitutionRepo;
import com.example.rma.service.SubdivisionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping
public class LookupController {

    @Autowired
    private InstitutionRepo institutionRepo;

    @Autowired
    private SubdivisionService subdivisionService;


    @GetMapping("/institutionForLookup")
    public List<Institution> getInstitutionForLookup(@RequestParam(name = "enterpriseId", required = false) Long enterpriseId,
                                                     @RequestParam(name = "findText", required = false) String findText ) {
        findText = "%"+ findText+"%";
        return institutionRepo.findByParam(enterpriseId, findText);
    }

    @GetMapping("/institutionForLookup/{institution}")
    public Institution getInstitutionForLookupById(@PathVariable Institution institution ) {
        return institution;
    }

    @GetMapping("/subdivisionForLookup")
    public List<Subdivision> getSubdivisionForLookup(@RequestParam(name = "enterpriseId", required = false) Long enterpriseId,
                                                     @RequestParam(name = "findText", required = false) String findText ) {
        findText = "%"+findText+"%";

        List<Subdivision> subdivisionList = subdivisionService.findByParam(enterpriseId, findText);
        System.out.println("subdivisionList " + subdivisionList);
        return subdivisionList;
    }

    @GetMapping("/subdivisionForLookup/{subdivision}")
    public Subdivision getSubdivisionForLookupById(@PathVariable Subdivision subdivision ) {
        return subdivision;
    }


}
