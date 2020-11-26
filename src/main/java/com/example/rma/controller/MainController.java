package com.example.rma.controller;

import com.example.rma.domain.Message;
import com.example.rma.domain.User;
import com.example.rma.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private MessageRepository messageRepository;

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
                             @RequestParam String text,
                             @RequestParam String tag,
                             @RequestParam("file") MultipartFile file,
                             Map<String, Object> model) throws IOException {

        Message message =  new Message(text, tag, user );

        if(file != null && !file.getOriginalFilename().isEmpty()){
            File uploadDir = new File(pathFile);

            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile+ "."+ file.getOriginalFilename();

            file.transferTo(new File( pathFile +  "/" + resultFileName));
            message.setFileName(resultFileName);

        }


        messageRepository.save(message);
        Iterable<Message> messages = messageRepository.findAll();
        model.put("messages", messages);
        return "main";
    }



}