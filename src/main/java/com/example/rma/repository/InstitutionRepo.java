package com.example.rma.repository;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

public interface InstitutionRepo extends JpaRepository<Institution, Long> {

    Institution findByUser(User user);

    List<Institution> findByLastName(String lastName);

    List<Institution> findByEnterprise(Enterprise enterprise);

    @Query(value = "select * from t_Institution p "+
                          " where (p.enterprise_id = :enterpriseId or :enterpriseId = 0) "+
                            " and ( upper(concat(last_Name , ' ' , first_Name , ' ' , second_Name)) like upper(:fullName) or :fullName = '' )", nativeQuery = true)
    List<Institution> findByParam(@Param("enterpriseId") Long enterpriseId, @Param("fullName") String fullName );



}
