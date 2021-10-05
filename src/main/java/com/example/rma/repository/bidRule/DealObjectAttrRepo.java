package com.example.rma.repository.bidRule;

import com.example.rma.domain.bidRule.DealObject;
import com.example.rma.domain.bidRule.DealObjectAttr;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DealObjectAttrRepo  extends JpaRepository<DealObjectAttr, Long> {

    List<DealObjectAttr> findByDealObject(DealObject dealObject);
}
