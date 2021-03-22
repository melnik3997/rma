package com.example.rma.controller;

import com.example.rma.domain.Message;
import com.example.rma.domain.User;
import com.example.rma.repository.MessageRepository;
import com.example.rma.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Controller
public class MainController {
    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private FileService fileService;

    @Value("${upload.path}")
    private String pathFile;

    @GetMapping("/")
    public String greeting( String name, Map<String, Object> model) {
        return "greeting";
    }
    @GetMapping("/main")
    public String main(@RequestParam(required = false, defaultValue = "") String filter,
            Model model ){
        Iterable<Message> messageList;
        if(filter!= null && !filter.isEmpty()) {
            messageList = messageRepository.findByTag(filter);
        }else
        {
            messageList = messageRepository.findAll();
        }
        model.addAttribute("messages", messageList);
        model.addAttribute("filter", filter);
        return "main";
    }

    @PostMapping("/main")
    public String addMessage(@AuthenticationPrincipal User user,
                             @Valid Message message,
                             BindingResult bindingResult,
                             Model model,
                             @RequestParam("file") MultipartFile file) throws IOException {

        if(bindingResult.hasErrors()){
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            System.out.println(errorsMap);
            model.mergeAttributes(errorsMap);
            model.addAttribute("message", message);
        }else {
            message.setAuthor(user);

            if (file != null && !file.getOriginalFilename().isEmpty()) {
                String resultFileName = fileService.saveFile(file);

                message.setFileName(resultFileName);
            }
            messageRepository.save(message);
        }
        Iterable<Message> messages = messageRepository.findAll();
        model.addAttribute("messages", messages);
        return "main";
    }



}