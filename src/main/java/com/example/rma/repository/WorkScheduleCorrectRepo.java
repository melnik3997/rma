package com.example.rma.repository;

import com.example.rma.domain.WorkScheduleCorrect;
import com.example.rma.domain.calendar.Calendar;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WorkScheduleCorrectRepo extends JpaRepository<WorkScheduleCorrect, Long> {

    List<WorkScheduleCorrect> findByCalendarIn(List<Calendar> calendars);
}
