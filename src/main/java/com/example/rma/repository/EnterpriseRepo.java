package com.example.rma.repository;

import com.example.rma.domain.Enterprise;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnterpriseRepo extends JpaRepository<Enterprise, Long> {
}
