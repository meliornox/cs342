-- CHANGED
-- This trigger keeps a log of when the room was changed on the Events table and what the old and new values are.

DROP TABLE EventRoomLog;
CREATE TABLE EventRoomLog (
	EventID integer,
	dateChanged date,
	oldRoom integer,
	newRoom integer,
);


CREATE OR REPLACE TRIGGER roomUpdate AFTER UPDATE UPDATE OF roomID ON Event
BEGIN
    INSERT INTO EventRoomLog VALUES (ID, SYSDATE, :OLD.roomID, :NEW.roomID);
END;
/
SHOW ERRORS;

-- Testing trigger
BEGIN
	INSERT INTO Event VALUES (11, NULL, 1, 1, 5, 1, 'Weekly SAGA meeting', TO_DATE('2017-03-01 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1.5, 50);
END;
/