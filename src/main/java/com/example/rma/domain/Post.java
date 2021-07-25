package com.example.rma.domain;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "tPost")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Заполните поле наименование")
    private String name;

    @Column(name = "post_level")
    @Enumerated(EnumType.STRING)
    private PostLevel postLevel;

    @Column(name = "post_type")
    @Enumerated(EnumType.STRING)
    private PostType postType;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPostLevelName() {
        return postLevel.getName();
    }

    public PostLevel getPostLevel() {
        return postLevel;
    }

    public void setPostLevel(PostLevel postLevel) {
        this.postLevel = postLevel;
    }

    public String getPostTypeName() {
        return postType.getName();
    }

    public PostType getPostType() {
        return postType;
    }

    public void setPostType(PostType postType) {
        this.postType = postType;
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", postLevel=" + postLevel +
                ", postType=" + postType +
                '}';
    }
}
