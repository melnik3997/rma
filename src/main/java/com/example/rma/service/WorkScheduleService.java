package com.example.rma.service;

import com.example.rma.domain.Institution;
import com.example.rma.domain.WorkSchedule;
import com.example.rma.repository.WorkScheduleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.Period;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WorkScheduleService {

    @Autowired

    private WorkScheduleRepo workScheduleRepo;

    private void save(WorkSchedule workSchedule){
        workScheduleRepo.save(workSchedule);
    }

    public WorkSchedule findActiveByInstitution(Institution institution){
        List<WorkSchedule> workSchedules = workScheduleRepo.findByInstitutionAndActive(institution, true);
        WorkSchedule result = null;
        if(workSchedules != null && !workSchedules.isEmpty()){
            result = workSchedules.get(0);
        }
        return result;
    }

    public List<WorkSchedule> findByInstitution(Institution institution){
        return workScheduleRepo.findByInstitution(institution,  Sort.by(Sort.Direction.DESC, "active","dateStart"));
    }

    public Map<String,String> create(WorkSchedule workSchedule){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;
        long duration = Duration.between(workSchedule.getTimeBegin(), workSchedule.getTimeFinish()).getSeconds();

        double durationD = duration / 60.0 /60.0;

        //обед входит в рабочее время ?
        double   workTime = workSchedule.getWorkTime() - (workSchedule.isLunchBreakIn()?  workSchedule.getLunchBreak() : 0);


        System.out.println("duration " + durationD);

        System.out.println("workTime " + workTime);

        if(workSchedule.getLunchBreak().compareTo(workSchedule.getWorkTime()) >= 0){
            errors.put("errorCreate", "Не корректное время обеда");
            error = true;
        }else if(durationD > workTime){
            errors.put("errorCreate", "Не корректное время работы");
            error = true;
        }
        if(!error) {
            if (workSchedule.isActive()) {
                if (checkActiveByInstitution(workSchedule.getInstitution())) {
                    WorkSchedule workScheduleDB = findActiveByInstitution(workSchedule.getInstitution());
                    workScheduleDB.setActive(false);
                    workScheduleDB.setDateEnd(LocalDate.now());
                    save(workScheduleDB);
                }
            }
            workSchedule.setDateStart(LocalDate.now());
            save(workSchedule);
        }
        return errors;
    }


    private boolean checkActiveByInstitution(Institution institution){

        return !(findActiveByInstitution(institution) == null);
    }


}
