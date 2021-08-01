package com.example.rma.repository;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Subdivision;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SubdivisionRepo extends JpaRepository<Subdivision, Long> {

    List<Subdivision> findByParent(Subdivision parent);

    Subdivision findByBrief(String brief);

    List<Subdivision> findByEnterprise(Enterprise enterprise);

    List<Subdivision> findByEnterpriseAndParent(Enterprise enterprise, Subdivision parent);

    @Query(value = "select * from t_Subdivision p "+
            " where (p.enterprise_id = :enterpriseId or :enterpriseId = 0) "+
            " and ( upper(p.name) like upper(:name) or :name = '' )", nativeQuery = true)
    List<Subdivision> findByParam(@Param("enterpriseId") Long enterpriseId, @Param("name") String name );

    void deleteByParent(Subdivision parent);

}
