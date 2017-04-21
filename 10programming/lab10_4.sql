-- Theodore Bigelow
-- 04/21/17 CS 342 at Calvin College
-- In response to the lab exercise 10.1 at https://cs.calvin.edu/courses/cs/342/kvlinden/10programming/lab.html

-- Consider the following stored procedure.

CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/
-- Restart your two SQL*Plus sessions, run the given stored procedure simultaneously in each of them using:

EXECUTE incrementRank2(176712, .01);

-- Now, determine if it ran correctly. If it does, explain how. If it doesn’t, identify the problem and modify the code so that it does.

-- The given stored procedure did not run correctly, the output values indicate lost updates because the given procedure does not implement Isolation.  

CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn;
		FOR UPDATE OF rank;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/

EXECUTE incrementRank2(176712, .01);

-- Adding FOR UPDATE OF column locks that column, ensuring isolation while it is being updated so that other threads don't read the old value.