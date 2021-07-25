package com.example.rma.repository;

import com.example.rma.domain.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepo extends JpaRepository<Post, Long> {

    Post findByName(String name);
}
