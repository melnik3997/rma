package com.example.rma.repository.calendar;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.calendar.CalendarEnterprise;
import com.example.rma.domain.calendar.CalendarType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CalendarEnterpriseRepo extends JpaRepository<CalendarEnterprise, Long> {

    CalendarEnterprise findByEnterpriseAndCalendarTypeAndYearInt (Enterprise enterprise, CalendarType calendarType, Integer yearInt);

    CalendarEnterprise findByEnterpriseAndCalendarTypeAndActive (Enterprise enterprise, CalendarType calendarType, boolean active);

    Page<CalendarEnterprise> findByEnterprise (Enterprise enterprise, Pageable pageable);

}
