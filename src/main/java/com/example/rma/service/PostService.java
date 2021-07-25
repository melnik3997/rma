package com.example.rma.service;

import com.example.rma.domain.Post;
import com.example.rma.repository.PostRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PostService {

    @Autowired
    private PostRepo postRepo;

    @Autowired
    private PositionService positionService;

    public List<Post> findAll(){
        return postRepo.findAll();
    }

    public Map<String, String> save(Post post){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;

        if(checkPostName(post)){
            error = true;
            errors.put("nameError", "Данное название должности уже занято!");
        }

        if(!error)
            postRepo.save(post);

        return errors;
    }

    public Map<String, String> delete(Post post){
        Map<String, String> errors = new HashMap<>();
        boolean error = false;
        if(checkPostByPosition(post)){
            error = true;
            errors.put("deleteError", "Данная должность используется, удаление запрещено!");
        }
        if(!error)
            postRepo.delete(post);
        return errors;
    }

    public Post findByName(String post){
        return postRepo.findByName(post);
    }

    private boolean checkPostByPosition(Post post){
        return !positionService.findByPost(post).isEmpty();

    }

    private boolean checkPostName(Post post){
        Post postDB = findByName(post.getName());
        if (postDB == null)
            return false;
        return !postDB.getId().equals(post.getId());
    }
}
