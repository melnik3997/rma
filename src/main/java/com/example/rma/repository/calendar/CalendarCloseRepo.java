package com.example.rma.repository.calendar;

import com.example.rma.domain.calendar.Calendar;
import com.example.rma.domain.calendar.CalendarClose;
import com.example.rma.domain.calendar.CalendarCloseDto;
import com.example.rma.domain.calendar.CalendarEnterprise;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;

public interface CalendarCloseRepo extends JpaRepository<CalendarClose, Long> {

    CalendarClose findByCalendar(Calendar calendar);


    @Query("select new com.example.rma.domain.calendar.CalendarCloseDto(cc, c) from Calendar c " +
            "inner join CalendarClose cc " +
            "on cc.calendar = c.id " +
            "where c.calendarEnterprise = :calendarEnterprise " +
            "and c.dateD between :dateBegin and :dateEnd")
    Page<CalendarCloseDto> findByCalendarEnterpriseAndDateBeginAndDateEnd(@Param("calendarEnterprise") CalendarEnterprise calendarEnterprise,
                                                                          @Param("dateBegin") LocalDate dateBegin,
                                                                          @Param("dateEnd")  LocalDate dateEnd,
                                                                          Pageable pageable);
}
