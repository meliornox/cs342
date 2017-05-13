package models;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * Created by jgb23 on 5/12/2017.
 */
public class PersonorganizationEntityPK implements Serializable {
    private long personid;
    private long organizationid;

    @Column(name = "PERSONID")
    @Id
    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    @Column(name = "ORGANIZATIONID")
    @Id
    public long getOrganizationid() {
        return organizationid;
    }

    public void setOrganizationid(long organizationid) {
        this.organizationid = organizationid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonorganizationEntityPK that = (PersonorganizationEntityPK) o;

        if (personid != that.personid) return false;
        if (organizationid != that.organizationid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (personid ^ (personid >>> 32));
        result = 31 * result + (int) (organizationid ^ (organizationid >>> 32));
        return result;
    }
}
