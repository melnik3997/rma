package com.example.rma.controller;

import com.example.rma.domain.*;
import com.example.rma.service.PositionService;
import com.example.rma.service.PostService;
import com.example.rma.service.UserService;
import javafx.geometry.Pos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Arrays;
import java.util.Map;

@Controller
public class PositionController {

    @Autowired
    private PostService postService;

    @Autowired
    private PositionService positionService;

    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/post")
    public String getPostList(Model model){
        model.addAttribute("postList",postService.findAll());
        return "postList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/post/add")
    public String getAddPost(Model model){

        model.addAttribute("postLevelList", PostLevel.values());
        model.addAttribute("postTypeList", PostType.values());
        return "postForm";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/post/{post}")
    public String getEditPost(@PathVariable(name = "post") Post post,
                              Model model){

        model.addAttribute("postModel", post);
        model.addAttribute("postLevelList", PostLevel.values());
        model.addAttribute("postTypeList", PostType.values());
        return "postForm";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/post/{post}")
    public String saveEditPost(@PathVariable(name = "post") Long postId,
                               @Valid Post post,
                               BindingResult bindingResult,
                               Model model){
        boolean error = ControllerUtils.checkErrorBinding(bindingResult, model);
        post.setId(postId);

        if(error){
            getPostDataForError(post, model);
            return "postForm";
        }

        Map<String, String> result = postService.save(post);
        if (result.size() > 0){
            model.mergeAttributes(result);
            getPostDataForError(post, model);
            return "postForm";
        }
        return "redirect:/post";

    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/post/add")
    public String savePost(@Valid Post post,
                           BindingResult bindingResult,
                           Model model){
        boolean error = ControllerUtils.checkErrorBinding(bindingResult, model);

        if(error){
            getPostDataForError(post, model);
            return "postForm";
        }

        Map<String, String> result = postService.save(post);
        if (result.size() > 0){
            model.mergeAttributes(result);
            getPostDataForError(post, model);
            return "postForm";
        }
        return "redirect:/post";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/postDelete")
    public String deletePost(@RequestParam(name = "postId")  Post post,
                             Model model){


        Map<String, String> result = postService.delete(post);
        if (result.size() > 0){
            model.mergeAttributes(result);
            getPostDataForError(post, model);
            return "postForm";
        }
        return "redirect:/post";
    }

    private void getPostDataForError(Post post, Model model){
        model.addAttribute("postLevelList", PostLevel.values());
        model.addAttribute("postTypeList", PostType.values());
        model.addAllAttributes(ControllerUtils.parsersAttribute(post));
    }

    @GetMapping("/positionUser/{userId}")
    public String getPostByUser(@PathVariable(name = "userId") User user,
                                Model model){
        model.addAttribute("positionList", positionService.findActiveByUser(user));
        model.addAttribute("positionListDis", positionService.findDisActiveByUser(user));
        model.addAttribute("institution", userService.findInstitutionByUser(user));
        model.addAttribute("userId", user.getId());
        return "positionList";
    }

    @GetMapping("/positionUser/{userId}/add")
    public String getPostByUserAdd(@PathVariable(name = "userId") User user,
                                Model model){

        getDataPosition(user, model);

        return "positionForm";
    }

    private void getDataPosition(@PathVariable(name = "userId") User user, Model model) {
        model.addAttribute("postList", postService.findAll());
        model.addAttribute("institution", userService.findInstitutionByUser(user));
        model.addAttribute("userId", user.getId());
        model.addAttribute("enterprise", userService.findInstitutionByUser(user).getEnterprise());
    }


    @PostMapping("/positionUser/{userId}/add")
    public String savePosition(@PathVariable(name = "userId") User user,
                               @Valid Position position,
                               BindingResult bindingResult,
                               Model model){
        boolean error = ControllerUtils.checkErrorBinding(bindingResult, model);
        position.setInstitution(userService.findInstitutionByUser(user));
        Map<String, String> result = positionService.save(position);

        if (result.size() > 0){
            model.mergeAttributes(result);
            getDataPosition(user, model);
            model.addAllAttributes(ControllerUtils.parsersAttribute(position));

            return "positionForm";
        }
        return "redirect:/positionUser/" + user.getId();
    }

    @GetMapping("/positionUser/{userId}/deletePosition/{position}")
    public String deletePosition(@PathVariable(name = "userId") User user,
                                 @PathVariable(name = "position")  Position position,
                                 Model model){
        positionService.delete(position);
        return "redirect:/positionUser/" + user.getId();
    }




}
