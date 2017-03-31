-- Theodore Bigelow
-- CS 342 Spring 2017
-- 03/31/17
--
-- SQL file for lab 7.2 as per the assignment at 
-- https://cs.calvin.edu/courses/cs/342/kvlinden/07sql/lab.html

-- Repeat the previous exercise, but this time use a materialized view. Pay particular attention to what changes in the view and in the table respectively.

CREATE MATERIALIZED VIEW [Materialized Birthdays]AS 
SELECT firstName, lastName, TRUNC(MONTHS_BETWEEN(SYSDATE, birthdate)/12) age, birthdate
FROM Person;

SELECT firstName || ' ' || lastName name, age, birthdate
FROM [Materialized Birthdays]
WHERE birthdate >= '01-JAN-1961' AND birthdate <= '31-DEC-1975';

UPDATE Person SET birthdate = '03-MAR-1962' 
WHERE ID = 7;

SELECT firstName || ' ' || lastName name, age, birthdate
FROM [Materialized Birthdays]
WHERE birthdate >= '01-JAN-1961' AND birthdate <= '31-DEC-1975';
-- Materialized views are captures of the state of the database at the time they were created, so updates to the tables from which it was created don't affect it.

INSERT INTO [Materialized Birthdays] VALUES ('John', 'Smith', 20, '01-OCT-1996');
-- Materialized views are read-only

-- Materialized views are read-only captures of a state of the database, so dropping them has no side-effects for the tables it represents.