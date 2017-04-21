-- Theodore Bigelow
-- cs342 Spring 2017 Calvin College

-- These commands are in response to the exercises at https://cs.calvin.edu/courses/cs/342/kvlinden/10programming/homework.html

-- Write a PL/SQL procedure that receives two movie IDs and an integer amount and “transfers” a given amount of rank value from a source movie to a destination movie. Note that this doesn’t make much sense in the context of the movie database, but it’s similar to money transfers in a banking database.

-- Your procedure should be designed in such a way that it can be run simultaneously by the following sample script to separate threads and still give a consistent result.

-- BEGIN
-- 	FOR i IN 1..10000 LOOP
-- 		transferRank(176712, 176711, 0.1);
-- 		COMMIT;
-- 		transferRank(176711, 176712, 0.1);
-- 		COMMIT;
--  	END LOOP;
-- END;
-- This script moves rank points between two movies (Kill Bill 1 and Kill Bill 2). Note the following.

-- Your procedure should check the values it receives, raising exceptions as appropriate.
-- Don’t allow the rank value to drop below 0.
-- To make your transaction logic explicit, please use declared exceptions as follows.
-- CREATE OR REPLACE PROCEDURE yourProcedure
-- 	my_exception EXCEPTION;
-- BEGIN
-- 	...some code...
-- 	RAISE my_exception;
-- 	...some more code...
-- EXCEPTION
-- 	WHEN my_exception THEN
-- 		...error handling code for your exception...
-- 	WHEN my_other_exception THEN
-- 		...error handling code for my_other_exception(s)...
-- END;

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE pointMove (
	fromId IN Movie.id%type,
	toId IN Movie.id%type,
	-- Check recieved value
	points IN FLOAT)
AS
	fromRank Movie.rank%type;
	toRank Movie.rank%type;
	-- Prevents ranks from dropping below zero
	fromBelowZero EXCEPTION;
	toBelowZero EXCEPTION;
BEGIN
	SELECT rank INTO fromRank FROM Movie WHERE id = fromId FOR UPDATE OF rank;
	SELECT rank INTO toRank FROM Movie WHERE id = toId FOR UPDATE OF rank;
	
	IF ((points > 0) AND (points > fromRank)) THEN
		RAISE fromBelowZero;
    END IF;
	IF ((points < 0) AND ( ABS(points) > toRank)) THEN
		RAISE toBelowZero;
    END IF;
	
	UPDATE Movie SET rank = (rank - points) WHERE id = fromId;
	COMMIT;
	UPDATE Movie SET rank = (rank + points) WHERE id = toId;
	COMMIT;
EXCEPTION
	WHEN fromBelowZero THEN
		RAISE_APPLICATION_ERROR(-20001, 'From movie rank would be below zero');
	WHEN toBelowZero THEN
		RAISE_APPLICATION_ERROR(-20002, 'To movie rank would be below zero');
END;
/

COMMIT;