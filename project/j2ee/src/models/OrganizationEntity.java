package models;

import javax.persistence.*;
import java.util.List;

/**
 * Created by jgb23 on 5/12/2017.
 */
@Entity
@Table(name = "ORGANIZATION", schema = "EVENTS")
public class OrganizationEntity {
    private long id;
    private Long staffadvisor;
    private String name;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "STAFFADVISOR")
    public Long getStaffadvisor() {
        return staffadvisor;
    }

    public void setStaffadvisor(Long staffadvisor) {
        this.staffadvisor = staffadvisor;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Allows the accessing of the people that belong to an organization.  This is valuable when creating web applications for evaluating the attendance of student organizations in deciding which to keep and which to cut and replace.
    @ManyToMany
    @JoinTable(name = "PERSONORGANIZATION", schema = "EVENTS",
            joinColumns = @JoinColumn(name = "ORGANIZATIONID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "PERSONID", referencedColumnName = "ID", nullable = false))

    private List<PersonEntity> people;

    public List<PersonEntity> getPeople() { return people; }

    public void setPeople(List<PersonEntity> p) { this.people = p; }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        OrganizationEntity that = (OrganizationEntity) o;

        if (id != that.id) return false;
        if (staffadvisor != null ? !staffadvisor.equals(that.staffadvisor) : that.staffadvisor != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (staffadvisor != null ? staffadvisor.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
}
