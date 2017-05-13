package models;

import javax.persistence.*;

/**
 * Created by jgb23 on 5/12/2017.
 */
@Entity
@Table(name = "EVENT", schema = "EVENTS")
public class EventEntity {
    private long id;
    private Long roomid;
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
    @Column(name = "ROOMID")
    public Long getRoomid() {
        return roomid;
    }

    public void setRoomid(Long roomid) {
        this.roomid = roomid;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Gets the room for a particular event.  Someone who wanted to write an app that would direct you to your next event would want to be able to access the room dynamically from the web in case it were to change.
    @ManyToOne
    @JoinColumn(name = "ROOMID", referencedColumnName = "ID")
    private RoomEntity room;

    public RoomEntity getRoom() { return room; }

    public void setRoom(RoomEntity r) { this.room = r; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        EventEntity that = (EventEntity) o;

        if (id != that.id) return false;
        if (roomid != null ? !roomid.equals(that.roomid) : that.roomid != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (roomid != null ? roomid.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }
}
