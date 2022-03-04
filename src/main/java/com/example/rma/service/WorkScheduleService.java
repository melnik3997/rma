package com.example.rma.service;

import com.example.rma.domain.*;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.CalendarType;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.domain.dto.InstitutionWorkScheduleDto;
import com.example.rma.domain.dto.WorkScheduleDto;
import com.example.rma.repository.WorkScheduleRepo;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
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
    private CalendarService calendarService;

    @Autowired
    private PresenceWorkService presenceWorkService;

    @Autowired
    private InstitutionService institutionService;

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

    public List<InstitutionWorkScheduleDto> getInstitutionListScheduleByWeek(List<Institution> institutionList, LocalDate date) {
        List<InstitutionWorkScheduleDto> institutionWorkScheduleDtoList = new ArrayList<>();

        for (Institution institution: institutionList) {
            List<WorkScheduleDto> workScheduleDtoList = getScheduleByWeek(institution, date);
            institutionWorkScheduleDtoList.add(new InstitutionWorkScheduleDto(institution.getId(), institution.getFIO(), workScheduleDtoList));

        }
        return institutionWorkScheduleDtoList;
    }

    public List<WorkScheduleDto> getScheduleByWeek(Institution institution, LocalDate date){
        WeekFields weekFields = WeekFields.ISO;
        List<WorkScheduleDto> workScheduleDtoList = new ArrayList<>();
        //находим рабочий календарь по дате
        CalendarEnterprise calendarEnterprise = calendarService.findByEnterpriseAndCalendarTypeAndYear(institution.getEnterprise(), CalendarType.getDefault(), date.getYear());
        //находим номер недели
        int numberWeek = date.get(weekFields.weekOfWeekBasedYear());
        //ноходим дни в календаре в текущей неделе
        List<Calendar> calendarList = calendarService.findByCalendarEnterpriseAndNumberWeek(calendarEnterprise, numberWeek);
        //находим график работы сотпрудников
        WorkSchedule workSchedule = findActiveByInstitution(institution);
        //находим корректровки по необходимым дням
        List<WorkScheduleCorrect> workScheduleCorrectList = workScheduleCorrectService.findByCalendarListAndInstitution(calendarList, institution);
        //обработка графика
        if(workSchedule != null) {
            for (Calendar calendar : calendarList) {
                //компиляция графика
                WorkScheduleDto workScheduleDto = getWorkScheduleDtoForToday(workSchedule, calendar, workScheduleCorrectList);
                workScheduleDtoList.add(workScheduleDto);
            }
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

    private WorkScheduleDto getWorkScheduleDtoForToday(WorkSchedule workSchedule, Calendar calendar, List<WorkScheduleCorrect> workScheduleCorrectList) {
        List<WorkScheduleCorrect> workScheduleCorrectListC = getWorkScheduleCorrectByCalendar(calendar, workScheduleCorrectList);
        WorkScheduleDto workScheduleDto = new WorkScheduleDto(calendar, workSchedule);
        workScheduleDto.setWorkTime(workSchedule.getWorkTime() - (workSchedule.isLunchBreakIn()?  workSchedule.getLunchBreak() : 0));

        //механиз корректировки графика по заявкам
        if (workScheduleCorrectListC != null && !workScheduleCorrectListC.isEmpty())
            for (WorkScheduleCorrect workScheduleCorrect : workScheduleCorrectListC) {
                workScheduleCorrect.getWorkScheduleCorrectType().correct(workScheduleDto, workScheduleCorrect);
            }

        long duration = Duration.between(workSchedule.getTimeBegin(), workSchedule.getTimeFinish()).getSeconds();
        double obligatoryWorkTime = duration / 60.0 /60.0 - ( workSchedule.getLunchBreak());
        workScheduleDto.setObligatoryWorkTime(obligatoryWorkTime);
        workScheduleDto.getDayType().correctTimeWork(workScheduleDto);
/*
        System.out.println("workSchedule.getTimeBegin(), workSchedule.getTimeFinish() " + workSchedule.getTimeBegin()+ " " +workSchedule.getTimeFinish());
        System.out.println("obligatoryWorkTime " + obligatoryWorkTime);

        workScheduleDto.setObligatoryWorkTime(obligatoryWorkTime < 0 ? 0 : obligatoryWorkTime);
*/
        workScheduleDto.setPresence(presenceWorkService.isActive(workSchedule.getInstitution(), calendar));

        return workScheduleDto;
    }


    public WorkScheduleDto getWorkScheduleDtoForToday(Calendar calendar, Institution institution) {
        WorkSchedule workSchedule = findActiveByInstitution(institution);
        if (workSchedule == null)
            return null;
        List<Calendar> calendarList =  new ArrayList<>();
        calendarList.add(calendar);
        List<WorkScheduleCorrect> workScheduleCorrectList = workScheduleCorrectService.findByCalendarListAndInstitution(calendarList, institution);
        return getWorkScheduleDtoForToday(workSchedule, calendar, workScheduleCorrectList);
    }

    public WorkScheduleDto getWorkScheduleDtoForToday(LocalDate date, Institution institution) {
        Calendar calendar = calendarService.findCalendarByDateAndInstitution(institution, date);
        return getWorkScheduleDtoForToday(calendar, institution);
    }

    public WorkScheduleDto getWorkScheduleDtoForToday(Institution institution) {
        LocalDate date = LocalDate.now();

        return getWorkScheduleDtoForToday(date, institution);
    }



    public List<WorkScheduleCorrect> getWorkScheduleCorrectByCalendar(Calendar calendar, List<WorkScheduleCorrect> workScheduleCorrectList){
        return workScheduleCorrectList.stream().filter(w-> w.getCalendar().getId().equals(calendar.getId())).collect(Collectors.toList());
    }

    public InstitutionDto setWorkScheduleToInstitutionDtoForToDay(InstitutionDto institutionDto){
        Institution institution = institutionService.findInstitutionByInstitutionDto(institutionDto);
        institutionDto.setWorkScheduleDto(getWorkScheduleDtoForToday(institution));
        return institutionDto;
    }

    public List<InstitutionDto> setWorkScheduleListToInstitutionDtoForToDay(List<InstitutionDto> institutionDtoList){
        return institutionDtoList.stream().map(i -> i = setWorkScheduleToInstitutionDtoForToDay(i) ).collect(Collectors.toList());
    }




}
