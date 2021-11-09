package com.example.rma.service;

import com.example.rma.domain.Institution;
import com.example.rma.domain.WorkSchedule;
import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.domain.dto.WorkScheduleDto;
import com.example.rma.repository.WorkScheduleRepo;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.Period;
import java.time.temporal.WeekFields;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class WorkScheduleService {

    @Autowired
    private WorkScheduleRepo workScheduleRepo;

    @Autowired
    private WorkScheduleCorrectService workScheduleCorrectService;

    @Autowired
    CalendarService calendarService;

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
        double  workTime = workSchedule.getWorkTime() - (workSchedule.isLunchBreakIn()?  workSchedule.getLunchBreak() : 0);


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

    public List<WorkScheduleDto> getSchedule(Institution institution, LocalDate date){
        WeekFields weekFields = WeekFields.ISO;

        CalendarEnterprise calendarEnterprise = calendarService.findByEnterpriseAndCalendarTypeAndYear(institution.getEnterprise(), CalendarType.getDefault(), date.getYear());

        int numberWeek = date.get(weekFields.weekOfWeekBasedYear());

        List<Calendar> calendarList = calendarService.findByCalendarEnterpriseAndNumberWeek(calendarEnterprise, numberWeek);

        WorkSchedule workSchedule = findActiveByInstitution(institution);

        List<WorkScheduleCorrect> workScheduleCorrectList = workScheduleCorrectService.findByCalendarList(calendarList);
        List<WorkScheduleDto> workScheduleDtoList = new ArrayList<>();

        for (Calendar calendar : calendarList) {
            //создали дто графика
            WorkScheduleDto workScheduleDto = getWorkScheduleDto(workSchedule, calendar, workScheduleCorrectList);
            workScheduleDtoList.add(workScheduleDto);
        }
        return workScheduleDtoList;
    }

    /**Суммирует данные по граффику работы
     *
     * @param workSchedule график сотрудника
     * @param calendar день
     * @param workScheduleCorrectList коррестировки
     * @return
     */

    private WorkScheduleDto getWorkScheduleDto(WorkSchedule workSchedule, Calendar calendar, List<WorkScheduleCorrect> workScheduleCorrectList) {
        List<WorkScheduleCorrect> workScheduleCorrectListC = getWorkScheduleCorrectByCalendar(calendar, workScheduleCorrectList);
        WorkScheduleDto workScheduleDto = new WorkScheduleDto(calendar, workSchedule);
        workScheduleDto.setWorkTime(workSchedule.getWorkTime() - (workSchedule.isLunchBreakIn()?  workSchedule.getLunchBreak() : 0));

        workScheduleDto.getDayType().correctTimeWork(workScheduleDto);

        //механиз корректировки графика по заявкам
        if (workScheduleCorrectListC != null && !workScheduleCorrectListC.isEmpty())
            for (WorkScheduleCorrect workScheduleCorrect : workScheduleCorrectListC) {
                workScheduleCorrect.getWorkScheduleCorrectType().correct(workScheduleDto, workScheduleCorrect);
            }
        return workScheduleDto;
    }


    public WorkScheduleDto getWorkScheduleDto( Calendar calendar, Institution institution) {
        WorkSchedule workSchedule = findActiveByInstitution(institution);
        List<Calendar> calendarList =  new ArrayList<>();
        calendarList.add(calendar);
        List<WorkScheduleCorrect> workScheduleCorrectList = workScheduleCorrectService.findByCalendarList(calendarList);
        return getWorkScheduleDto(workSchedule, calendar, workScheduleCorrectList);
    }



    public List<WorkScheduleCorrect> getWorkScheduleCorrectByCalendar(Calendar calendar, List<WorkScheduleCorrect> workScheduleCorrectList){
        return workScheduleCorrectList.stream().filter(w-> w.getCalendar().getId().equals(calendar.getId())).collect(Collectors.toList());
    }


}
