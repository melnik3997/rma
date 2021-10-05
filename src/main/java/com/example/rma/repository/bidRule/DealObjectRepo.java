package com.example.rma.repository.bidRule;


import com.example.rma.domain.Institution;
import com.example.rma.domain.bidRule.DealObject;
import com.example.rma.domain.bidRule.State;
import com.example.rma.domain.bidRule.dto.DealObjectDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface DealObjectRepo extends JpaRepository<DealObject, Long> {

    List<DealObject> findByResponsible(Institution responsible);

    @Query("select new com.example.rma.domain.bidRule.dto.DealObjectDto(d) " +
            " from DealObject d " +
            " inner join Protocol p" +
            " on p.id = d.protocol " +
            " inner join Transition t " +
            " on t.id = p.transition " +
            " where (d.responsible = :responsible or :responsible = null)" +
            "   and (d.author      = :author      or :author      = null)" +
            "   and (t.targetState = :state       or :state       = null)" +
            "   and (d.employee    = :employee    or :employee    = null)")
    List<DealObjectDto> findDealObjectDtoByParam(@Param("responsible") Institution responsible,
                                                 @Param("author") Institution author,
                                                 @Param("state") State state,
                                                 @Param("employee") Institution employee);

}
