package com.example.rma.service;

import com.example.rma.domain.Enterprise;
import com.example.rma.repository.EnterpriseRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EnterpriseService {

    @Autowired
    private EnterpriseRepo enterpriseRepo;

    @Autowired
    private UserService userService;

    @Autowired
    private SubdivisionService subdivisionService;

    public List<Enterprise> findAll(){
        return enterpriseRepo.findAll();
    }

    public void save(Enterprise enterprise){
        enterpriseRepo.save(enterprise);
    }

    public Map<String, String> delete(Enterprise enterprise){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(checkInstitutionByEnterprise(enterprise)){
            error = true;
            errors.put("deleteError", "Не возможно удалить организацию так как в ней есть работники!");
        }
        if(checkSubdivisionByEnterprise(enterprise) && !error){
            error = true;
            errors.put("deleteError", "Не возможно удалить организацию так как в ней есть подразделения!");
        }

        if (!error)
            enterpriseRepo.delete(enterprise);
        return errors;
    }

    public boolean checkInstitutionByEnterprise(Enterprise enterprise){
        return userService.getByEnterprise(enterprise).size() !=0;
    }

    public boolean checkSubdivisionByEnterprise(Enterprise enterprise) {
        return subdivisionService.findByEnterprise(enterprise).size() !=0;
    }

    public Enterprise findById(Long id){
        return enterpriseRepo.findById(id).orElse(null);
    }
}
