package com.example.rma.service;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Node;
import com.example.rma.domain.Subdivision;
import com.example.rma.repository.SubdivisionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SubdivisionService {

    @Autowired
    private SubdivisionRepo subdivisionRepo;


    public List<Subdivision> getSubdivisionByParent(Subdivision subdivision){

        return subdivisionRepo.findByParent(subdivision);
    }

    public List<Subdivision> findByEnterpriseAndParent(Enterprise enterprise, Subdivision parent){

        return subdivisionRepo.findByEnterpriseAndParent(enterprise, parent);
    }

    public void deleteParentSubdivision(Subdivision subdivision){

        subdivisionRepo.deleteByParent(subdivision);
    }
    public void delete(Subdivision subdivision){
        subdivisionRepo.delete(subdivision);
    }

    public List<Subdivision> findAll(){
        return subdivisionRepo.findAll();
    }

    public List<Subdivision> findAllByEnterprise(Enterprise enterprise){
        return subdivisionRepo.findByEnterprise(enterprise);
    }

    public Map<String, String> addSubdivision(Subdivision subdivision){
        Map<String, String> send = new HashMap<>();

        if(checkSubdivisionBrief(subdivision))
            send.put("briefError", "Подразделение с таким сокращением уже есть");

        if (send.size() == 0)
            subdivisionRepo.save(subdivision);

        return send;
    }

    public List<Node> subdivisionToNode(List<Subdivision> subdivisionList){

        return subdivisionList.stream().map(Node::new).collect(Collectors.toList());

    }

    private boolean checkSubdivisionBrief(Subdivision subdivision)
    {
        Subdivision fromDB = subdivisionRepo.findByBrief(subdivision.getBrief());
        if (fromDB != null){
            return ! fromDB.getId().equals(subdivision.getId());
        }
        return false;
    }


/*
    public List<Subdivision> getFullParentSubdivisionBySubdivision(Subdivision subdivision){

        List<Subdivision> subdivisions = new ArrayList<>();

        Long startId = subdivision.getId();
        Long id = subdivision.getId();

        while (true){
            if(startId.equals(id)){
                List<Subdivision> list = getSubdivisionByParent()
            }



        }

        return subdivisions;

    }*/
}

