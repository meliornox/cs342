-- Theodore Bigelow
-- cs342 Spring 2017 Calvin College

-- These commands are in response to the exercises at https://cs.calvin.edu/courses/cs/342/kvlinden/08programming/homework.html

-- Bacon Number — Implement a tool that loads a table (named BaconTable) with records that specify an actor ID and that actor’s Bacon number. An actor’s bacon number is the length of the shortest path between the actor and Kevin Bacon (KB) in the “co-acting” graph. That is, KB has bacon number 0; all actors who acted in the same movie as KB have bacon number 1; all actors who acted in the same movie as some actor with Bacon number 1 but have not acted with Bacon himself have Bacon number 2, etc. Actors who have never acted with anyone with a bacon number should not have a record in the table. Stronger solutions will be configured so that the number can be based on any actor, not just Kevin Bacon.

ALTER system SET open_cursors = 999;

DROP TABLE BaconTable;

CREATE TABLE BaconTable (
	actorId integer PRIMARY KEY,
	baconNumber integer
);

CREATE OR REPLACE PROCEDURE baconNumber (baconId IN INTEGER, recurse IN INTEGER) AS
CURSOR actor IS 
	R.actorId 
	FROM Role R 
	WHERE R.movieId IN(
		SELECT movieId 
		FROM Role 
		WHERE actorId = baconId);
isInTable int DEFAULT 0;
BEGIN
  FOR actor IN actors LOOP
    SELECT COUNT(*) INTO isInTable FROM BaconTable WHERE actorId = actor.actorID;
    IF isInTable = 0 AND recurse < 25 THEN
      INSERT INTO BaconTable VALUES (actor.actorId, recurse);
      baconNumber(actor.actorId, recurse + 1);
    ELSE
      UPDATE BaconTable SET baconNumber = recurse WHERE actorId = actor.actorID AND baconNumber > recurse;
    END IF;
  END LOOP;
END;
/

SHOW ERRORS;