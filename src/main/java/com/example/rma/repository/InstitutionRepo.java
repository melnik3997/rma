package com.example.rma.repository;

import com.example.rma.domain.*;
import com.example.rma.domain.dto.InstitutionDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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

    @Query("select new com.example.rma.domain.dto.InstitutionDto(i, p) from Institution i " +
            "left join Position p " +
            "on p.institution = i.id " +
            "and p.general = true " +
            "and p.active = true " +
            "where (i.enterprise.id = :enterpriseId or :enterpriseId = 0) " +
            "and ((upper(concat(i.lastName , ' ' , i.firstName , ' ' , i.secondName)) like upper(:fullName) or :fullName = '' ))")
    Page<InstitutionDto> findInstitutionDtoByParam(@Param("enterpriseId") Long enterpriseId, @Param("fullName") String fullName, Pageable pageable);

    @Query("select new com.example.rma.domain.dto.InstitutionDto(i, p) " +
            "from Institution i " +
            "left join Position p " +
            "on p.institution = i.id " +
            "and p.general = true " +
            "and p.active = true " +
            "where i.id = :institution")
    InstitutionDto findInstitutionDtoByInstitution(@Param("institution") Long institution);

    @Query("select new com.example.rma.domain.dto.InstitutionDto(i1, p1) " +
            "from Position p "+
            " inner join Position p1" +
            " on p1.subdivision = p.subdivision" +
            " and p1.active = true" +
            " and p1.institution != p.institution " +
            " inner join Institution i1 " +
            " on i1.id = p1.institution " +
            "where p.id = :position and p.institution = :institution")
    List<InstitutionDto> findInstitutionDtoColleaguesByInstitutionAndPosition(@Param("institution") Institution institution, @Param("position") Long position);

    @Query("select new com.example.rma.domain.dto.InstitutionDto(i1, p) " +
            "from Position p "+
            " inner join Institution i1 " +
            " on i1.id = p.institution " +
            "where p.subdivision = :subdivision " +
            "and p.active = true")
    Page<InstitutionDto> findInstitutionDtoBySubdivision(@Param("subdivision") Subdivision subdivision, Pageable pageable);

}
