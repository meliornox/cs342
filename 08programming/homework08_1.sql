-- Theodore Bigelow
-- cs342 Spring 2017 Calvin College

-- These commands are in response to the exercises at https://cs.calvin.edu/courses/cs/342/kvlinden/08programming/homework.html

-- Auditing — Implement a “shadow” log that records every update to the rank of any Movie record. Store your log in a separate table ( RankLog ) and include the ID of the user who made the change (accessed using the system constant user), the date of the change (accessed using sysdate) and both the original and the modified ranking values.
DROP TABLE RankLog;

CREATE TABLE RankLog (
	userId varchar(30),
	dateChanged date,
	oldRank number(10,2),
	newRank number(10,2)
);

CREATE OR REPLACE TRIGGER rankUpdate AFTER UPDATE OF rank ON Movie FOR EACH ROW
BEGIN
	INSERT INTO RankLog VALUES (USER, SYSDATE, :OLD.rank, :NEW.rank);
END;
/
SHOW ERRORS;