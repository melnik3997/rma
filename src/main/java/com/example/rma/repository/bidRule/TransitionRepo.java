package com.example.rma.repository.bidRule;


import com.example.rma.domain.bidRule.Transition;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransitionRepo extends JpaRepository<Transition, Long> {
}
