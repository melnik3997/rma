package com.example.rma.repository.calendar;

import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.dto.Day;
import com.example.rma.domain.calendar.dto.Week;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;

public interface CalendarRepo extends JpaRepository<Calendar, Long> {

    List<Calendar> findByCalendarEnterprise(CalendarEnterprise calendarEnterprise, Sort sort);

    @Query("select new com.example.rma.domain.calendar.dto.Week(c.numberWeek) " +
            " from Calendar c" +
            " where c.calendarEnterprise = :calendarEnterprise " +
            " and c.monthInt = :monthInt " +
            " group by c.numberWeek" +
            " order by c.numberWeek")
    List<Week> findWeekByCalendarEnterpriseAndMonth(@Param("calendarEnterprise") CalendarEnterprise calendarEnterprise, @Param("monthInt") Integer monthInt );


    @Query("select new com.example.rma.domain.calendar.dto.Day(c.id, c.dateInt, c.dayWeek, c.dayType) " +
            " from Calendar c" +
            " where c.calendarEnterprise = :calendarEnterprise " +
            " and c.monthInt = :monthInt " +
            " and c.numberWeek = :numberWeek" +
            " order by c.dateInt")
    List<Day> findDayByCalendarEnterpriseAndMonth(@Param("calendarEnterprise") CalendarEnterprise calendarEnterprise,
                                                  @Param("monthInt") Integer monthInt ,
                                                  @Param("numberWeek") Integer numberWeek);




}
