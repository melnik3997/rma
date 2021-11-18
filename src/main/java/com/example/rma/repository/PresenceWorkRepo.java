package com.example.rma.repository;

import com.example.rma.domain.Institution;
import com.example.rma.domain.PresenceWork;
import com.example.rma.domain.calendar.Calendar;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PresenceWorkRepo extends JpaRepository<PresenceWork, Long> {

    @Query(value = "select COALESCE( max(p.number), 0) from PresenceWork p where p.institution = :institution and p.calendar = :calendar")
    int findMaxNumberByInstitutionAndCalendar(@Param("institution") Institution institution,@Param("calendar") Calendar calendar );

    PresenceWork findByInstitutionAndCalendarAndActive(Institution institution, Calendar calendar, boolean active);

    List<PresenceWork> findByInstitutionAndCalendar(Institution institution, Calendar calendar, Sort sort);

}
