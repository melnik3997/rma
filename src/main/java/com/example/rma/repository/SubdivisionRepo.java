package com.example.rma.repository;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Subdivision;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubdivisionRepo extends JpaRepository<Subdivision, Long> {

    List<Subdivision> findByParent(Subdivision parent);

    Subdivision findByBrief(String brief);

    List<Subdivision> findByEnterprise(Enterprise enterprise);

    List<Subdivision> findByEnterpriseAndParent(Enterprise enterprise, Subdivision parent);

    void deleteByParent(Subdivision parent);

}
