package com.example.rma.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "user_id")
    private User author;

    @NotBlank(message = "Заполните поле сообщения")
    @Length(max=2048 , message = "Максимальная длина 2048 символов")
    private String text;
    private String tag;

    private String fileName;

    public String getAuthorName() {
        return author != null? author.getUsername() : "<none>";
    }


    public Message() {

    }

    public Message(String text, String tag, User author) {
        this.author = author;
        this.text = text;
        this.tag = tag;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
