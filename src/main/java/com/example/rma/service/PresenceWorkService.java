package com.example.rma.service;

import com.example.rma.domain.Institution;
import com.example.rma.domain.PresenceWork;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.exception.BusinessException;
import com.example.rma.repository.PresenceWorkRepo;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PresenceWorkService {

    @Autowired
    private PresenceWorkRepo presenceWorkRepo;

    @Autowired
    private CalendarService calendarService;


    @Autowired
    private InstitutionService institutionService;


    private PresenceWork save(PresenceWork presenceWork){
        return presenceWorkRepo.save(presenceWork);
    }

    public PresenceWork create(  Institution institution, Calendar calendar, LocalTime timeBegin){
        PresenceWork presenceWork = new PresenceWork(institution, calendar, timeBegin);
        presenceWork.setNumber(getNumber(presenceWork.getInstitution(), presenceWork.getCalendar()));
        return save(presenceWork);
    }

    public PresenceWork close(PresenceWork presenceWork, LocalTime timeFinish) throws BusinessException {
        long duration = Duration.between(presenceWork.getTimeBegin(), timeFinish).getSeconds();
        if(duration < 0){
            throw new BusinessException("Дата начала меньше даты окончания");
        }
        presenceWork.setActive(false);
        presenceWork.setTimeFinish(timeFinish);
        presenceWork.setDuration(duration);
        save(presenceWork);
        return presenceWork;
    }

    /**
     * Производит начало/конец работы сотрудника
     * @param institution
     * @return
     */
    public PresenceWork action(Institution institution, LocalTime time) throws BusinessException {
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        if(calendarService.checkCalendarClose(calendar)){
            throw new BusinessException("День закрыт");
        }
        // ищем текущую запись
        PresenceWork presenceWork = getActiveNow(institution);
        if (presenceWork == null){
            //если не нашли создаем новую
            presenceWork = create(institution, calendar, time);
        }else {
            // если нашли закрываем работу
            presenceWork = close(presenceWork, time);
        }
        return presenceWork;
    }
    public List<PresenceWork> getByInstitutionAndCalendar(Institution institution, Calendar calendar){
        return presenceWorkRepo.findByInstitutionAndCalendar(institution, calendar, Sort.by(Sort.Direction.DESC,  "number"));
    }

    public PresenceWork getActiveNow(Institution institution){
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return getActive(institution, calendar);
    }

    public boolean isWorkNow(Institution institution){
        return getActiveNow(institution) != null;
    }

    public LocalTime getStartWork(Institution institution, Calendar calendar){
        List<PresenceWork> presenceWorkList =getByInstitutionAndCalendar(institution, calendar);
        PresenceWork presenceWork = presenceWorkList.stream().filter(p-> p.getNumber() == 1).findFirst().orElse(null);
        if(presenceWork == null)
            return null;

        return presenceWork.getTimeBegin();
    }

    public LocalTime getStartWorkNow(Institution institution){
        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return getStartWork(institution, calendar);
    }

    public InstitutionDto setPresenceInfoToInstitutionDtoForForToday (InstitutionDto institutionDto) {
        Institution institution = institutionService.findInstitutionByInstitutionDto(institutionDto);
        institutionDto.setStartWork(getStartWorkNow(institution));
        institutionDto.setWorkNow(isWorkNow(institution));
        return institutionDto;
    }

    public List<InstitutionDto> setPresenceInfoListToInstitutionDtoForForToday (List<InstitutionDto> institutionDtoList) {
        return institutionDtoList.stream().map(i -> i = setPresenceInfoToInstitutionDtoForForToday(i) ).collect(Collectors.toList());
    }

    public PresenceWork getActive(Institution institution, Calendar calendar){
        return presenceWorkRepo.findByInstitutionAndCalendarAndActive(institution, calendar, true);
    }

    public boolean isActive(Institution institution, Calendar calendar){
        return presenceWorkRepo.findByInstitutionAndCalendarAndActive(institution, calendar, true) != null;
    }

    public int getNumber(Institution institution, Calendar calendar){
        int i = 0;
        i = presenceWorkRepo.findMaxNumberByInstitutionAndCalendar(institution, calendar);
        i ++;
        return i;
    }

    public List<InstitutionDto> setPresenceWorkTimeSumListToInstitutionDtoForToday(List<InstitutionDto> institutionDtoList) {
        return institutionDtoList.stream().map(i -> i = setPresenceWorkTimeSumToInstitutionDtoForToday(i) ).collect(Collectors.toList());
    }

    public InstitutionDto setPresenceWorkTimeSumToInstitutionDtoForToday(InstitutionDto institutionDto) {
        Institution institution = institutionService.findInstitutionByInstitutionDto(institutionDto);
        institutionDto.setPresenceWorkTimeSum(getPresenceWorkTimeSumForToday(institution));
        return institutionDto;
    }

    public InstitutionDto setPresenceWorkTimeSumToInstitutionDto(InstitutionDto institutionDto, Calendar calendar) {
        Institution institution = institutionService.findInstitutionByInstitutionDto(institutionDto);
        institutionDto.setPresenceWorkTimeSum(getPresenceWorkTimeSum(institution, calendar));
        return institutionDto;
    }

    public List<InstitutionDto> setPresenceWorkTimeSumListToInstitutionDto(List<InstitutionDto> institutionDtoList, Calendar calendar) {
        return institutionDtoList.stream().map(i -> i = setPresenceWorkTimeSumToInstitutionDto(i, calendar) ).collect(Collectors.toList());
    }

    public double getPresenceWorkTimeSumForToday (Institution institution) {

        Calendar calendar = calendarService.findCalendarByNowDateAndInstitution(institution);
        return getPresenceWorkTimeSum(institution, calendar);
    }

    public double getPresenceWorkTimeSum (Institution institution, Calendar calendar) {
        double sumTime = 0D;
        List<PresenceWork> presenceWorkList =getByInstitutionAndCalendar(institution, calendar);
        boolean today = calendar.getDateD().equals(LocalDate.now());

        for (PresenceWork presenceWork: presenceWorkList) {
            long duration = Duration.between(presenceWork.getTimeBegin(), presenceWork.getTimeFinish() == null ?
                    today? LocalTime.now() : presenceWork.getTimeBegin()
                    : presenceWork.getTimeFinish()).getSeconds();
            sumTime = sumTime +  duration / 60.0 /60.0 ;
        }
        return sumTime;
    }

    public Double[] getPresenceWorkTimeSumByCalenderList(Institution institution, List<Calendar> calendarList){
        Double[] sums = new Double[calendarList.size()];
        for (int i = 0; i < calendarList.size(); i++) {
            sums[i] = getPresenceWorkTimeSum(institution, calendarList.get(i));
        }
        return sums;
    }

    public List<PresenceWork> findByCalendarAndTimeFinish(Calendar calendar, LocalTime timeFinish){
        return presenceWorkRepo.findByCalendarAndTimeFinish(calendar, timeFinish);
    }

    public List<PresenceWork> findNotCloseByCalendar(Calendar calendar){
        return findByCalendarAndTimeFinish(calendar, null);
    }


    public void closePresenceWorkByCalendar(Calendar calendar) throws BusinessException {
        List<PresenceWork> presenceWorkList = findNotCloseByCalendar(calendar);
        for (PresenceWork presenceWork: presenceWorkList) {
            close(presenceWork, presenceWork.getTimeBegin());
        }
        presenceWorkRepo.saveAll(presenceWorkList);
    }




}
