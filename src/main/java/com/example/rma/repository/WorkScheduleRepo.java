package com.example.rma.repository;

import com.example.rma.domain.Institution;
import com.example.rma.domain.WorkSchedule;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WorkScheduleRepo extends JpaRepository<WorkSchedule, Long> {

    List<WorkSchedule> findByInstitutionAndActive(Institution institution, boolean active);

    List<WorkSchedule> findByInstitution(Institution institution,  Sort sort);
}
