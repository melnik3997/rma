package com.example.rma.repository;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

public interface InstitutionRepo extends JpaRepository<Institution, Long> {

    Institution findByUser(User user);

    List<Institution> findByLastName(String lastName);

    List<Institution> findByEnterprise(Enterprise enterprise);

}
