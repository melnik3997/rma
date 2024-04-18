package com.example.rma.controller;

import com.example.rma.domain.Institution;
import com.example.rma.domain.Position;
import com.example.rma.domain.Subdivision;
import com.example.rma.domain.User;
import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.dto.Month;
import com.example.rma.domain.dto.ChartDto;
import com.example.rma.domain.dto.InstitutionDto;
import com.example.rma.service.ActuallyWorkService;
import com.example.rma.service.InstitutionService;
import com.example.rma.service.PositionService;
import com.example.rma.service.PresenceWorkService;
import com.example.rma.service.calendar.CalendarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/chartData")
public class ChartController {

    @Autowired
    private InstitutionService institutionService;

    @Autowired
    private CalendarService calendarService;

    @Autowired
    private PositionService positionService;

    @Autowired
    private ActuallyWorkService actuallyWorkService;

    @Autowired
    private PresenceWorkService presenceWorkService;



    @GetMapping("/getChartDataActuallyWork/{subdivision}")
    public ChartDto[] getChartDataActuallyWork(@PathVariable Subdivision subdivision){

        LocalDate date = LocalDate.now();
        CalendarEnterprise calendarEnterprise = calendarService.findCalendarEnterpriseByEnterprise(subdivision.getEnterprise());

        List<Calendar> calendarList = calendarService.getCalenderListWeekByDay(calendarEnterprise, date);

        List<Position> positionList = positionService.findActiveBySubdivision(subdivision);

        List<ChartDto> chartDtoList = positionList.stream().
                map(position ->
                        new ChartDto( position.getInstitution().getId(),
                                position.getInstitution().getFIO(),
                                actuallyWorkService.getSumByInstitutionAndCalendar(position.getInstitution(), calendarList)
                        )).collect(Collectors.toList());


        System.out.println("chartDtoList " + Arrays.toString(chartDtoList.toArray(new ChartDto[0])));
        return chartDtoList.toArray(new ChartDto[0]);
    }

    @GetMapping("/getChartDataPresenceWorkTime/{subdivision}")
    public ChartDto[] getChartDataPresenceWorkTime(@PathVariable Subdivision subdivision){

        LocalDate date = LocalDate.now();
        CalendarEnterprise calendarEnterprise = calendarService.findCalendarEnterpriseByEnterprise(subdivision.getEnterprise());

        List<Calendar> calendarList = calendarService.getCalenderListWeekByDay(calendarEnterprise, date);

        List<Position> positionList = positionService.findActiveBySubdivision(subdivision);

        List<ChartDto> chartDtoList = positionList.stream().
                map(position ->
                        new ChartDto( position.getInstitution().getId(),
                                position.getInstitution().getFIO(),
                                presenceWorkService.getPresenceWorkTimeSumByCalenderList(position.getInstitution(), calendarList)
                        )).collect(Collectors.toList());

        return chartDtoList.toArray(new ChartDto[0]);
    }
}
