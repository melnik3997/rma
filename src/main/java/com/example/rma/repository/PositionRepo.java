package com.example.rma.repository;


import com.example.rma.domain.Institution;
import com.example.rma.domain.Position;
import com.example.rma.domain.Post;
import com.example.rma.domain.Subdivision;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PositionRepo extends JpaRepository<Position, Long> {

    List<Position> findByInstitutionAndActive(Institution institution, boolean active, Sort sort);

    List<Position> findBySubdivisionAndActive(Subdivision subdivision, boolean active);

    List<Position> findByPost(Post post);

    @Query(value = "select COALESCE( max(p.Number), 0) from t_Position p where p.institution_Id = :institution", nativeQuery = true)
    int findMaxNumberByInstitutionId(@Param("institution")  Long institutionId);
}
