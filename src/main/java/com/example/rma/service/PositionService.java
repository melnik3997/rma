package com.example.rma.service;

import com.example.rma.domain.*;
import com.example.rma.repository.PositionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class PositionService {

    @Autowired
    private PositionRepo positionRepo;

    @Autowired
    private UserService userService;


    public List<Position> findActiveByUser(User user){

        return findActiveByInstitution(userService.findInstitutionByUser(user));
    }

    public List<Position> findDisActiveByUser(User user){

        return findDisActiveByInstitution(userService.findInstitutionByUser(user));
    }

    public List<Position> findActiveByInstitution(Institution institution){
        return  positionRepo.findByInstitutionAndActive(institution, true, Sort.by(Sort.Direction.DESC, "general", "number"));
    }
    public List<Position> findDisActiveByInstitution(Institution institution){
        return  positionRepo.findByInstitutionAndActive(institution, false, Sort.by(Sort.Direction.DESC,  "number"));
    }
    public Position findActiveByInstitutionAndGeneral(Institution institution){
        return findActiveByInstitution(institution).stream().filter(Position::isGeneral).findAny().orElse(null) ;
    }


    public List<Position> findActiveBySubdivision(Subdivision subdivision){
        return  positionRepo.findBySubdivisionAndActive(subdivision, true);
    }

    public boolean checkActiveBySubdivision(Subdivision subdivision){
        return !findActiveBySubdivision(subdivision).isEmpty();
    }

    public List<Position> findByPost(Post post){
        return positionRepo.findByPost(post);
    }

    public int findMaxNumberByInstitution(Institution institution){
        return positionRepo.findMaxNumberByInstitutionId(institution.getId());
    }

    public Map<String,String> save(Position position){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(position.getInstitution() == null){
            errors.put("institutionError", "Не заполненно поле работник!");
            error = true;
        }else if(position.getPost() == null){
            errors.put("posError", "Не заполненно поле должность!");
            error = true;
        }else if(position.getSubdivision() == null){
            errors.put("posError", "Не заполненно поле подразделение!");
            error = true;
        }

        if(!error) {
            if (position.getId() == null) {
                position.setActive(true);
                position.setDateStart(new Date());
                int maxNumber = findMaxNumberByInstitution(position.getInstitution());
                maxNumber += maxNumber;
                position.setNumber(maxNumber);

            }
            Position positionGeneral = findActiveByInstitutionAndGeneral(position.getInstitution());
            if (position.isGeneral()) {

                if (positionGeneral != null) {
                    positionGeneral.setGeneral(false);
                    positionRepo.save(positionGeneral);
                }
            } else if (positionGeneral == null) {
                position.setGeneral(true);
            }


            positionRepo.save(position);
        }
        return errors;
    }

    public Map<String,String> delete(Position position){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        position.setActive(false);
        position.setDateEnd(new Date());

        if(!error)
            errors = save(position);

        return errors;

    }



}
