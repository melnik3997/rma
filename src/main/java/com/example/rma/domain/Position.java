package com.example.rma.domain;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "tPosition")
public class Position {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "institution_id")
    private Institution institution;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "post_id")
    private Post post;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name= "subdivision_id")
    private Subdivision subdivision;

    private int number;

    private boolean active;

    private boolean general;

    @Column(name = "date_start", columnDefinition = "DATE")
    private Date dateStart;

    @Column(name = "date_end", columnDefinition = "DATE")
    private Date dateEnd;

    public Position() {

    }

    public Post getPost() {
        return post;
    }
    public Long getPostId() {
        return post.getId();
    }

    public String getPostName() {
        return post.getName();
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Institution getInstitution() {
        return institution;
    }

    public void setInstitution(Institution institution) {
        this.institution = institution;
    }

    public Subdivision getSubdivision() {
        return subdivision;
    }

    public String getSubdivisionName() {
        return subdivision.getName();
    }

    public void setSubdivision(Subdivision subdivision) {
        this.subdivision = subdivision;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public boolean isGeneral() {
        return general;
    }

    public void setGeneral(boolean general) {
        this.general = general;
    }

    @Override
    public String toString() {
        return "Position{" +
                "id=" + id +
                ", institution=" + institution +
                ", post=" + post +
                ", subdivision=" + subdivision +
                ", number=" + number +
                ", active=" + active +
                ", general=" + general +
                ", dateStart=" + dateStart +
                ", dateEnd=" + dateEnd +
                '}';
    }
}

