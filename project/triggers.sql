-- The functionality of this trigger is difficult to implement with table constraints as every event should have a room, but occasionally rooms will become unavailable due to required maintenence.  If there is an event at that location, it should not be deleted but it does need a new room assignment.
CREATE OR REPLACE TRIGGER RoomRequirement
	BEFORE DELETE OR INSERT OR UPDATE ON Event
	FOR EACH ROW
WHEN (new.roomID IS NULL)
BEGIN
    dbms_output.put_line('Event ' || :new.ID || ' needs a new room assignment.');
END;
/

-- Testing trigger
BEGIN
	INSERT INTO Event VALUES (11, NULL, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
END;
/