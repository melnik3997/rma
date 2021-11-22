package com.example.rma.service;

import com.example.rma.domain.ActuallyWork;
import com.example.rma.domain.Institution;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.ActuallyWorkRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActuallyWorkService {

    @Autowired
    private ActuallyWorkRepo actuallyWorkRepo;

    private ActuallyWork save(ActuallyWork actuallyWork){
        return actuallyWorkRepo.save(actuallyWork);
    }

    public ActuallyWork create(ActuallyWork actuallyWork) throws BusinessException {

        double sum = getSumByInstitutionAndCalendar(actuallyWork.getInstitution(), actuallyWork.getCalendar());

        if((sum + actuallyWork.getTime()) > 12){
            throw new BusinessException("Суммарные списания за день не могут превышать 12 часов!");
        }

        actuallyWork = save(actuallyWork);

        return actuallyWork;
    }


    public List<ActuallyWork> findByInstitutionAndCalendar(Institution institution, com.example.rma.domain.calendar.Calendar calendar){

        return actuallyWorkRepo.findByInstitutionAndCalendar(institution, calendar);
    }

    public double getSumByInstitutionAndCalendar(Institution institution, Calendar calendar){
        List<ActuallyWork> byInstitutionAndCalendar = findByInstitutionAndCalendar(institution, calendar);
        return byInstitutionAndCalendar.stream().mapToDouble(ActuallyWork::getTime).sum();
    }



}
