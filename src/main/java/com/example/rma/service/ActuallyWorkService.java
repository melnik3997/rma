package com.example.rma.service;

import com.example.rma.domain.ActuallyWork;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.ActuallyWorkRepo;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ActuallyWorkService {

    @Autowired
    private ActuallyWorkRepo actuallyWorkRepo;

    @Autowired
    private UserService userService;

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private CalendarService calendarService;

    private ActuallyWork save(ActuallyWork actuallyWork){
        return actuallyWorkRepo.save(actuallyWork);
    }

    public ActuallyWork create(ActuallyWork actuallyWork) throws BusinessException {

        double sum = getSumByInstitutionAndCalendar(actuallyWork.getInstitution(), actuallyWork.getCalendar());
        if(calendarService.checkCalendarClose(actuallyWork.getCalendar())){
            throw new BusinessException("День закрыт");
        }
        if(actuallyWork.getTime() <= 0)
            throw new BusinessException("Не корректное значение отработанных часов");

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

    public Double[] getSumByInstitutionAndCalendar(Institution institution, List<Calendar> calendarList){
        Double[] sumArr = new Double[calendarList.size()];

        for (int i = 0; i < calendarList.size(); i++) {
            sumArr[i] = getSumByInstitutionAndCalendar(institution, calendarList.get(i));
        }
        return sumArr;
    }

    public InstitutionDto setSumActToInstitutionDto(InstitutionDto institutionDto, Calendar calendar) {
        Institution institution = institutionService.findInstitutionByInstitutionDto(institutionDto);
        institutionDto.setSumActualluWork(getSumByInstitutionAndCalendar(institution, calendar ));
        return institutionDto;
    }

    public InstitutionDto setSumActToInstitutionDtoForToday(InstitutionDto institutionDto) {
        Institution institution = institutionService.findInstitutionByInstitutionDto(institutionDto);
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return setSumActToInstitutionDto(institutionDto, calendar);
    }

    public List<InstitutionDto> setSumActToListInstitutionDtoForToday(List<InstitutionDto> institutionDtoList) {
        return institutionDtoList.stream().map(i -> i = setSumActToInstitutionDtoForToday(i) ).collect(Collectors.toList());
    }

    public List<InstitutionDto> setSumActToListInstitutionDto(List<InstitutionDto> institutionDtoList, Calendar calendar) {
        return institutionDtoList.stream().map(i -> i = setSumActToInstitutionDto(i, calendar) ).collect(Collectors.toList());
    }


    public void delete(ActuallyWork actuallyWork, User user) throws BusinessException {
        Institution institution = userService.findInstitutionByUser(user);

        if(!actuallyWork.getInstitution().getId().equals(institution.getId())){
            throw new BusinessException("Только автор может удалять трудозараты!");
        }
        actuallyWorkRepo.delete(actuallyWork);

    }



}
