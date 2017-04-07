-- Theodore Bigelow
-- cs342 Spring 2017 Calvin College

-- These commands are in response to the exercises at https://cs.calvin.edu/courses/cs/342/kvlinden/09programming/lab.html
-- For use in conjunction with the imdbLarge database which is not available on GitHub and is too large to copy here.

CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;

-- Set global variables for the index IDs for the Actor and ActorOrdinal ID indexes.
-- Get the index IDs using @getIndexes; they change for each installation.
DEFINE Actor_Index = SYS_C008140
DEFINE ActorOrdinal_Index = SYS_C008158
-- Compute the actual number of actors (select count(*) from actor (or actorordinal)).
DEFINE ActorCount = 1910

-- Build sample queries to test that:
-- There is a benefit to using either COUNT(1) , COUNT(*) or SUM(1) for simple counting queries.

-- Takes 12.33 seconds
-- DECLARE
-- 	amount integer DEFAULT 0;
-- BEGIN
-- 	FOR i IN 1..1000 LOOP
-- 		SELECT COUNT(*) 
-- 		INTO amount
-- 		FROM Actor;
-- 	END LOOP;
-- END;
-- /

-- Takes 12.39 seconds
-- DECLARE
-- 	amount integer DEFAULT 0;
-- BEGIN
-- 	FOR i IN 1..1000 LOOP
-- 		SELECT COUNT(1) 
-- 		INTO amount
-- 		FROM Actor;
-- 	END LOOP;
-- END;
-- /

-- Takes 25.32 seconds
-- DECLARE
-- 	amount integer DEFAULT 0;
-- BEGIN
-- 	FOR i IN 1..1000 LOOP
-- 		SELECT SUM(1) 
-- 		INTO amount
-- 		FROM Actor;
-- 	END LOOP;
-- END;
-- /

-- b. The order of the tables listed in the FROM clause affects the way Oracle executes a join query.

-- Executes the same
-- EXPLAIN PLAN FOR
-- 	SELECT *
-- 	FROM Movie M, MovieDirector MD
-- 	WHERE M.id = MD.movieId;
-- 	/
	
-- 	SELECT plan_table_output FROM TABLE(dbms_xplan.display('plan_table',NULL,'basic'));
	
-- 	EXPLAIN PLAN FOR
-- 	SELECT *
-- 	FROM MovieDirector MD, Movie M
-- 	WHERE M.id = MD.movieId;
-- 	/
	
-- 	SELECT plan_table_output FROM TABLE(dbms_xplan.display('plan_table',NULL,'basic'));

-- c. The use of arithmetic expressions in join conditions (e.g., FROM Table1 JOIN Table2 ON Table1.id+0=Table2.id+0 ) affects a query’s efficiency.

-- About  10 times longer than no operations
-- DECLARE
-- 	amount integer DEFAULT 0;
-- BEGIN
-- 	FOR i IN 1..1000 LOOP
-- 		SELECT SUM(1) 
-- 		INTO amount
-- 		FROM MovieDirector MD, Movie M
-- 		WHERE M.id+0 = MD.movieId+0;
-- 	END LOOP;
-- END;
-- /

-- DECLARE
-- 	amount integer DEFAULT 0;
-- BEGIN
-- 	FOR i IN 1..1000 LOOP
-- 		SELECT SUM(1) 
-- 		INTO amount
-- 		FROM MovieDirector MD, Movie M
-- 		WHERE M.id = MD.movieId;
-- 	END LOOP;
-- END;
-- /

-- d. Running the same query more than once affects its performance.


-- DECLARE
-- 	amount integer DEFAULT 0;
-- BEGIN
-- 	FOR i IN 1..1000 LOOP
-- 		SELECT SUM(1) 
-- 		INTO amount
-- 		FROM MovieDirector MD, Movie M
-- 		WHERE M.id = MD.movieId;
-- 	END LOOP;
-- END;
-- /

-- Running this multiple times does not affect its performance greatly

-- -SKIP- e. Adding a concatenated index on a join table improves performance (see the create index command described above).

SET AUTOTRACE OFF;
SET SERVEROUTPUT OFF;
SET TIMING OFF;
SET WRAP ON;