package com.example.rma.repository.bidRule;

import com.example.rma.domain.bidRule.Protocol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProtocolRepo extends JpaRepository<Protocol, Long> {
    @Query("select p from Protocol p where p.dealObject.id = :dealObjectId ")
    List<Protocol> findByDealObjectId(@Param("dealObjectId") Long dealObjectId);
}
