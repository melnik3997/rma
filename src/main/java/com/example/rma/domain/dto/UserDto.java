package com.example.rma.domain.dto;

import com.example.rma.domain.*;

import java.util.Set;

public class UserDto {

    private Long id;
    private String username;
    private boolean active;
    private String email;
    private String activationCode;
    private Set<Role> role;
    private Institution institution;
    private Position position;
    private Enterprise enterprise;
    private Subdivision subdivision;


    public UserDto(User user, Institution institution, Position position) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.active = user.isActive();
        this.email = user.getEmail();
        this.activationCode = user.getActivationCode();
        this.role = user.getRole();
        this.institution = institution;
        this.position = position;
        this.enterprise = institution != null? institution.getEnterprise() : null ;
        this.subdivision = position != null ? position.getSubdivision() : null;

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }

    public Set<Role> getRole() {
        return role;
    }

    public void setRole(Set<Role> role) {
        this.role = role;
    }

    public Institution getInstitution() {
        return institution;
    }

    public Long getInstitutionID() {
        return this.institution == null ? 0L : institution.getId();
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }

    public Position getPosition() {
        return position;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public String getFullName(){
        return this.institution == null ? "" : this.institution.getFullName();
    }

    public String getPositionName(){
        return this.position == null ? "": this.position.getPostName();
    }

    public String getEnterpriseBrief(){return enterprise == null ? "" : enterprise.getBrief();}

    public Enterprise getEnterprise() {
        return enterprise;
    }

    public void setEnterprise(Enterprise enterprise) {
        this.enterprise = enterprise;
    }

    public Subdivision getSubdivision() {
        return subdivision;
    }

    public String getSubdivisionName() {
        return subdivision != null ? subdivision.getName() : "";
    }

    public void setSubdivision(Subdivision subdivision) {
        this.subdivision = subdivision;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", active=" + active +
                ", email='" + email + '\'' +
                ", activationCode='" + activationCode + '\'' +
                ", role=" + role +
                ", institution=" + institution +
                ", positions=" + position +
                '}';
    }
}
