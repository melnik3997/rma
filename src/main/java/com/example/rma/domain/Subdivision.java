package com.example.rma.domain;


import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "tSubdivision")
public class Subdivision {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    //@NotBlank(message = "Заполните поле организация")
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "enterprise_Id")
    private Enterprise enterprise;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "parent_Id")
    private Subdivision parent;

    @NotBlank(message = "Заполните поле сокращение")
    private String brief;

    @NotBlank(message = "Заполните поле наименование")
    private String name;

   // @NotBlank(message = "Заполните поле управляющий")
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "leader_Id")
    private User leader;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Subdivision getParent() {
        return parent;
    }

    public void setParent(Subdivision parent) {
        this.parent = parent;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public Long getEnterpriseId() {
        return enterprise == null ? 0L : enterprise.getId();
    }


    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public String getParentName(){
        return parent != null? parent.getName() : "";
    }
    public Long getParentId(){
        return parent == null ? 0 : parent.getId();
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getLeader() {
        return leader;
    }
    public Long getUserId() {
        return leader.getId();
    }

    public void setLeader(User leader) {
        this.leader = leader;
    }

    @Override
    public String toString() {
        return "Subdivision{" +
                "id=" + id +
                ", enterprise=" + enterprise +
                ", parent=" + parent +
                ", brief='" + brief + '\'' +
                ", name='" + name + '\'' +
                ", leader=" + leader +
                '}';
    }
}
