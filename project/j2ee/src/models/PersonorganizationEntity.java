package models;

import javax.persistence.*;

/**
 * Created by jgb23 on 5/12/2017.
 */
@Entity
@Table(name = "PERSONORGANIZATION", schema = "EVENTS")
@IdClass(PersonorganizationEntityPK.class)
public class PersonorganizationEntity {
    private long personid;
    private long organizationid;
    private String role;

    @Id
    @Column(name = "PERSONID")
    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    @Id
    @Column(name = "ORGANIZATIONID")
    public long getOrganizationid() {
        return organizationid;
    }

    public void setOrganizationid(long organizationid) {
        this.organizationid = organizationid;
    }

    @Basic
    @Column(name = "ROLE")
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonorganizationEntity that = (PersonorganizationEntity) o;

        if (personid != that.personid) return false;
        if (organizationid != that.organizationid) return false;
        if (role != null ? !role.equals(that.role) : that.role != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (personid ^ (personid >>> 32));
        result = 31 * result + (int) (organizationid ^ (organizationid >>> 32));
        result = 31 * result + (role != null ? role.hashCode() : 0);
        return result;
    }
}
