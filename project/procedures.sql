-- Stored procedure

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE moveProjector (
	fromId IN Room.id%type,
	toId IN Room.id%type)
AS
	fromBool Room.projectorBool%type;
	toBool Room.projectorBool%type;
	
	noProjector EXCEPTION;
	hasProjector EXCEPTION;
BEGIN
	SELECT projectorBool INTO fromBool FROM Room WHERE id = fromId FOR UPDATE OF projectorBool;
	SELECT projectorBool INTO toBool FROM Room WHERE id = toId FOR UPDATE OF projectorBool;
	
	IF (fromBool = 0) THEN
		RAISE noProjector;
    END IF;
	IF (toBool = 1) THEN
		RAISE hasProjector;
    END IF;
	
	UPDATE Room SET projectorBool = 0 WHERE id = fromId;
	COMMIT;
	UPDATE Room SET projectorBool = 1 WHERE id = toId;
	COMMIT;
EXCEPTION
	WHEN noProjector THEN
		RAISE_APPLICATION_ERROR(-20001, 'There is no projector to move');
	WHEN hasProjector THEN
		RAISE_APPLICATION_ERROR(-20002, 'Destination room already has a projector');
END;
/

-- Testing stored procedure
BEGIN
	moveProjector(3, 4);
	COMMIT;
	moveProjector(4, 3);
	COMMIT;
END;
/