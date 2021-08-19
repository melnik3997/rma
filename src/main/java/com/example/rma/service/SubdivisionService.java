package com.example.rma.service;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.dto.Node;
import com.example.rma.domain.Subdivision;
import com.example.rma.repository.SubdivisionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SubdivisionService {

    @Autowired
    private SubdivisionRepo subdivisionRepo;

    @Autowired
    private PositionService positionService;

    @Autowired
    private  UserService userService;


    public List<Subdivision> getSubdivisionByParent(Subdivision subdivision){

        return subdivisionRepo.findByParent(subdivision);
    }



    public List<Subdivision> findByEnterpriseAndParent(Enterprise enterprise, Subdivision parent){

        return subdivisionRepo.findByEnterpriseAndParent(enterprise, parent);
    }

    public Map<String, String>  delete(Subdivision subdivision){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;
        if(getSubdivisionByParent(subdivision).size() != 0) {
            errors.put("deleteError", "У падразделения есть подченненые подразделения, удаление не возможно!");
            error = true;
        }


        if(positionService.checkActiveBySubdivision(subdivision) && !error){
            errors.put("deleteError", "У падразделения есть активные сотрудники, удаление не возможно!");
            error = true;
        }

        if(!error){
            subdivisionRepo.delete(subdivision);
        }
        return errors;
    }

    public List<Subdivision> findAll(){
        return subdivisionRepo.findAll();
    }

    public List<Subdivision> findByEnterprise(Enterprise enterprise){
        return subdivisionRepo.findByEnterprise(enterprise);
    }

    public Map<String, String> addSubdivision(Subdivision subdivision){
        Map<String, String> send = new HashMap<>();

        if(checkSubdivisionBrief(subdivision))
            send.put("briefError", "Подразделение с таким сокращением уже есть");

        if(subdivision.getLeader() == null)
            send.put("leaderError", "Поле управляющий должно быть заполнено");

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


    public Institution getInstitutionBySubdivision(Subdivision subdivision){

        return userService.findInstitutionByUser(subdivision.getLeader());
    }

    public Subdivision findSubdivisionByInstitution(Institution institution){
        return positionService.findActiveByInstitutionAndGeneral(institution).getSubdivision();
    }




    public List<Subdivision> findByParam (Long enterpriseId, String name){
        return subdivisionRepo.findByParam(enterpriseId, name);
    }
}

