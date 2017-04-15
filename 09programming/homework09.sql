-- Theodore Bigelow
-- cs342 Spring 2017 Calvin College

-- These commands are in response to the exercises at https://cs.calvin.edu/courses/cs/342/kvlinden/09programming/homework.html

-- I looked at the execution plans for a lot of different commands, but in an effort to not provide spurious code I have included my optimized solutions.

-- Implement the following SQL queries on the IMDBLarge, optimize them using physical database and SQL tuning.
-- 1. Get the movies directed by Clint Eastwood.
-- Indexes for tuning
CREATE INDEX DIndex ON Director (id, firstName, lastName);
CREATE INDEX MDIndex ON MovieDirector (directorID, movieId);

SELECT M.id, M.name, M.year FROM Director D, Movie M, MovieDirector MD
WHERE D.firstName = 'Clint'
AND D.lastName = 'Eastwood'
AND D.id = MD.directorID
AND MD.movieId = M.id;

-- Drop indexes
DROP INDEX DIndex;
DROP INDEX MDIndex;

-- 2. Get the number of movies directed by each director who’s directed more than 200 movies.
	
CREATE INDEX MDIndex ON MovieDirector(directorId, movieId);
CREATE INDEX DIndex ON Director(id, firstName, lastName);

SELECT D.firstName || ' ' || D.lastName AS Director, COUNT(*)
FROM Director D, MovieDirector MD
WHERE D.id = MD.directorId
GROUP BY D.firstName, D.lastName
HAVING COUNT(M.movieId) > 200;

DROP INDEX DIndex;
DROP INDEX MDIndex;

-- 3. Get the most popular actors, where actors are designated as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.

CREATE INDEX RIndex ON Role (actorId, movieID);

SELECT A.firstName || ' ' || A.lastName AS Actor, AVG(M.rank)
FROM Actor A, Role R, Movie M
WHERE A.id = R.actorId
AND R.movieId = M.id
GROUP BY A.firstName, A.lastName
HAVING AVG(M.rank) > 8.5
AND COUNT(M.id) >= 10;

DROP INDEX RIndex;

-- For each query, include a short (one-paragraph) discussion that includes the following.
--   the alternate implementation forms you could have used and why you chose the one you did

-- I discovered pretty early on that views were an incredibly inefficient way to make queries more efficient when just doing one of them.  Joining two tables with an inner join or on a WHERE clause didn't seem to make a whole ton of difference, and poking around online I found out that while they might make a difference in larger joins they don't vary much at this level.  Since I like WHERE conditions better I used WHEREs. COUNT(1) and COUNT(*) are equivalent in oracle, I like COUNT(*) better.  I found indexes were the most efficient of the ways I tried.

--   the indexes your queries use (or don’t use) and why they help
-- For the first query:
-- CREATE INDEX DIndex ON Director (id, firstName, lastName);
-- CREATE INDEX MDIndex ON MovieDirector (directorID, movieId);
-- For the second query:
-- CREATE INDEX MDIndex ON MovieDirector(directorId, movieId);
-- CREATE INDEX DIndex ON Director(id, firstName, lastName);
-- For the third query:
-- CREATE INDEX RIndex ON Role (actorId, movieID);

-- Indexes make query execution more efficient because the queries that utilize them only use parts of the tables they reference.  By separating the columnns they do need from the columns they don't we prevent them from looking through data they won't use and we don't need to see.

--   the general SQL tuning heuristics you’ve deployed
-- One heuristic I used was looping one command many times.  I did this to get an approximation of its runtime versus other commands to eliminate inefficient commands.  The other heuristic I used was having Oracle show me the execution plan it had for a query.  I did this to optimize at a theoretical level by rearranging commands.

-- Demonstrate what you’ve accomplished by reviewing the execution plans for each query.
-- I was able to learn how to optimize oracle sql queries by tuning using timing and EXPLAIN PLAN.
-- For testing purposes, it can be helpful to run these queries on the smaller IMDB; this works provided that you relax the requirements a bit (e.g., directors with more than 2 rather than 200 movies, etc.).