package com.example.rma.service;

import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.WorkScheduleCorrectRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WorkScheduleCorrectService {

    @Autowired
    public WorkScheduleCorrectRepo workScheduleCorrectRepo;

    public WorkScheduleCorrect create(WorkScheduleCorrect workScheduleCorrect) throws BusinessException {
        if(workScheduleCorrect.getCalendar() == null){
            throw new BusinessException("Календарь не может быть пустым");
        }else if(workScheduleCorrect.getInstitution() == null){
            throw new BusinessException("Пользователь не может быть пустым");
        }else if(workScheduleCorrect.getDealObject() == null){
            throw new BusinessException("Заявка не может быть пустой");
        }

        return save(workScheduleCorrect);
    }

    public WorkScheduleCorrect save(WorkScheduleCorrect workScheduleCorrect){
        return workScheduleCorrectRepo.save(workScheduleCorrect);
    }
}