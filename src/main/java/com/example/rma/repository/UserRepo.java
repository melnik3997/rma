package com.example.rma.repository;

import com.example.rma.domain.User;
import com.example.rma.domain.dto.UserDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String userName);

    User findByActivationCode(String code);

    @Query ("select new com.example.rma.domain.dto.UserDto(u, i, p) " +
              "from User u " +
              "left join Institution i " +
                     "on i.user = u.id "+
             " left join Position p" +
                    " on p.institution = i.id" +
                   " and p.active = true" +
                   " and p.general = true" )
    List<UserDto> findUserDto();

}
