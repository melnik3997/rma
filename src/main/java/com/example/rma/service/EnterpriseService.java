package com.example.rma.service;

import com.example.rma.domain.Enterprise;
import com.example.rma.repository.EnterpriseRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EnterpriseService {

    @Autowired
    private EnterpriseRepo enterpriseRepo;

    public List<Enterprise> findAll(){
        return enterpriseRepo.findAll();
    }

    public void save(Enterprise enterprise){
        enterpriseRepo.save(enterprise);
    }

    public void delete(Enterprise enterprise){
        enterpriseRepo.delete(enterprise);
    }
}
