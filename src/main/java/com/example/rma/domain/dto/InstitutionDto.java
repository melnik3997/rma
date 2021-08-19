package com.example.rma.domain.dto;

import com.example.rma.domain.Enterprise;
import com.example.rma.domain.Institution;
import com.example.rma.domain.Position;
import com.example.rma.domain.User;

import java.util.Date;

public class InstitutionDto {
    private Long id;
    private User user;
    private String lastName;
    private String firstName;
    private String secondName;
    private Date dateOfBirth;
    private Enterprise enterprise;
    private String phoneNumber;
    private String skypeName;
    private String fileName;
    private Position position;


    public InstitutionDto(Institution institution, Position position) {
        this.id = institution.getId();
        this.user = institution.getUser();
        this.lastName = institution.getLastName();
        this.firstName = institution.getFirstName();
        this.secondName = institution.getSecondName();
        this.dateOfBirth = institution.getDateOfBirth();
        this.enterprise = institution.getEnterprise();
        this.phoneNumber = institution.getPhoneNumber();
        this.skypeName = institution.getSkypeName();
        this.fileName = institution.getFileName();
        this.position = position;
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

    public void setUser(User user) {
        this.user = user;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFullName() {
        return lastName + " " + firstName + " " + secondName;
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

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Position getPosition() {
        return position;
    }

    public void setPosition(Position position) {
        this.position = position;
    }
    public String getPositionName(){
        return this.position == null ? "" : this.position.getPostName();
    }

    public String getSubdivisionName(){
        return position == null ? "" : position.getSubdivisionName();
    }
    public String getEnterpriseBrief(){return enterprise.getBrief();}

    @Override
    public String toString() {
        return "InstitutionDto{" +
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
                ", position=" + position +
                '}';
    }
}
