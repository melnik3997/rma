package com.example.rma.repository;

import com.example.rma.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String userName);

    User findByActivationCode(String code);

}
