package com.example.rma.repository;

import com.example.rma.domain.ActuallyWork;
import com.example.rma.domain.Institution;
import com.example.rma.domain.calendar.Calendar;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ActuallyWorkRepo extends JpaRepository<ActuallyWork, Long> {

    List<ActuallyWork> findByInstitutionAndCalendar(Institution institution, Calendar calendar);


}
