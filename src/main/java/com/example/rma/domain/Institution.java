package com.example.rma.domain;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Date;

@Entity
@Table(name = "tInstitution")
public class Institution {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "user_id")
    private User user;

    @NotBlank(message = "Заполните поле фамилия")
    private String lastName;

    @NotBlank(message = "Заполните поле имя")
    private String firstName;

    private String secondName;

    @Column(name = "date_Of_Birth", columnDefinition = "DATE")
    private Date dateOfBirth;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "enterprise_id")
    private Enterprise enterprise;

    private String phoneNumber;

    private String skypeName;

    private String fileName;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getFullName() {
        return lastName + " " + firstName + " " + secondName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public String getUserName() {
        return user.getUsername();
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Long getUserId() {
        return user.getId();
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getSecondName() {
        return secondName;
    }

    public void setSecondName(String secondName) {
        this.secondName = secondName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public Long getEnterpriseID (){
        return enterprise.getId();
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getSkypeName() {
        return skypeName;
    }

    public void setSkypeName(String skypeName) {
        this.skypeName = skypeName;
    }

    public String getEnterpriseBrief(){return enterprise.getBrief();}


    @Override
    public String toString() {
        return "Institution{" +
                "id=" + id +
                ", user=" + user +
                ", lastName='" + lastName + '\'' +
                ", firstName='" + firstName + '\'' +
                ", secondName='" + secondName + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", enterprise=" + enterprise +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", skypeName='" + skypeName + '\'' +
                ", fileName='" + fileName + '\'' +
                '}';
    }
}
