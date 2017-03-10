-- Responses to lab exercises found at https://cs.calvin.edu/courses/cs/342/kvlinden/06sql/lab.html
-- To be used in conjunction with the database found at https://github.com/cs342/code/tree/master/databases/cpdb
-- Theodore Bigelow
-- CS 342 Spring 2017
-- lab06 part 2
-- 03/10/2017

DROP TABLE Request;
DROP TABLE PersonTeam;
DROP TABLE Person;
DROP TABLE HouseHold;
DROP TABLE HomeGroup;
DROP TABLE Team;
DROP SEQUENCE cpdb_sequence;

CREATE TABLE HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

CREATE TABLE HomeGroup(
	ID integer PRIMARY KEY,
	name varchar(20),
	meetingTime varchar(20),
	topic varchar(40)
	);

CREATE TABLE Team(
	name varchar(20) PRIMARY KEY,
	mandate varchar(128)
	);

CREATE TABLE Person (
	ID integer PRIMARY KEY,
	title varchar(4),
	firstName varchar(15),
	lastName varchar(15),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
    gender char(1),
    birthdate date,
	householdID integer REFERENCES HouseHold(ID),
	householdRole varchar(10),
	homeGroupID integer REFERENCES HomeGroup(ID),
	homeGroupRole varchar(15),
	CHECK ((title IS NOT NULL) OR (membershipStatus = 'c')) -- Null title => child
	);

CREATE TABLE PersonTeam(
	personID integer REFERENCES Person(ID),	
	teamName varchar(20) REFERENCES Team(name),
	role varchar(15),
	duration varchar(10),
	PRIMARY KEY (personId, teamName)
	);

CREATE TABLE Request(
	ID integer PRIMARY KEY,
	originatorHouseHoldID integer REFERENCES HouseHold(ID),
	requestDate date,
	responderID integer REFERENCES Person(ID),
	text varchar(256),
	infoAccess char(1),
	response varchar(256)
	);

CREATE SEQUENCE cpdb_sequence
	START WITH 100
	INCREMENT BY 1;
	
INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');
INSERT INTO Household VALUES (1,'100 Main St. SE','Zeeland','MI','49999','616-111-1111');
INSERT INTO Household VALUES (2,'200 Broadway St. SW','Grand Rapids','MI','49526','616-222-2222');
INSERT INTO Household VALUES (3,'300 Madison Ave. NE','Grand Rapids','MI','49536','616-333-3333');
INSERT INTO Household VALUES (4,'400 Lake Dr. SE','East Grand Rapids','MI','49546','616-444-4444');
INSERT INTO Household VALUES (5,'500 Gates St.','Seattle','WA','90000','300-555-5555');
INSERT INTO Household VALUES (6,'600 East Paris St.','Grand Rapids','MI','49000','616-666-6666');
INSERT INTO Household VALUES (7,'700 West Paris Ave.','Grand Rapids','MI','49011','616-777-7777');

INSERT INTO Homegroup VALUES (0,'Byl','sunday','The Jesus I Never Knew');
INSERT INTO Homegroup VALUES (1,'Jones','wednesday',NULL);
INSERT INTO Homegroup VALUES (2,'Nicole','sunday','Holiness');

INSERT INTO Team VALUES ('Elders','maintain the life of the church');
INSERT INTO Team VALUES ('Deacons','maintain the fabric of the church');
INSERT INTO Team VALUES ('Music','plan AND execute music in the church');
INSERT INTO Team VALUES ('Design','plan AND evaluate worship services');
INSERT INTO Team VALUES ('Side-door','plan AND run side-door ministeries');
INSERT INTO Team VALUES ('Staff','run the place');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m','m','07-FEB-1961',0,'husband',0,'member');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m','f','24-DEC-1960',0,'wife',0,'leader');
INSERT INTO Person VALUES (2,NULL,'Lukas','VanderLinden','c','m','16-MAR-1990',0,'child',0,'child');
INSERT INTO Person VALUES (3,NULL,'Christian','VanderLinden','c','m','24-JUL-1992',0,'child',0,'child');
INSERT INTO Person VALUES (4,'mr.','Doug','Jones','m','m',NULL,1,'husband',2,'leader');
INSERT INTO Person VALUES (5,'ms.','Gayle','Jones-Ray','m','f',NULL,'1','wife',2,'member');
INSERT INTO Person VALUES (6,NULL,'Kai','Jones','c','m',NULL,1,'child',2,'child');
INSERT INTO Person VALUES (7,'mr.','Tim','DeJong','a','m',NULL,2,'husband',2,'member');
INSERT INTO Person VALUES (8,'ms.','Jean','Vermeer','a','f',NULL,2,'wife',2,'member');
INSERT INTO Person VALUES (9,'mr.','Ralph','Vermeer','a','m','01-JAN-1975',3,'single',0,'member');
INSERT INTO Person VALUES (10,'ms.','Jean','Smith','m','f','02-FEB-1956',4,'single',2,'member');
INSERT INTO Person VALUES (11,'mr.','Allen','Nicole','m','m','01-FEB-1955',5,'husband',2,'member');
INSERT INTO Person VALUES (12,'ms.','Joanne','Nicole','m','f','1-NOV-1957',5,'wife',2,'leader');
INSERT INTO Person VALUES (13,'mr.','Ralph','Jansma','a','m','1-AUG-1975',6,'single',NULL,NULL);
INSERT INTO Person VALUES (14,'ms.','Judy','Heerema','a','f',NULL,7,'single',2,'member');
INSERT INTO Person VALUES (15,NULL,'Susan','Heerema','c','f','1-NOV-1997',7,'child',2,'child');

INSERT INTO PersonTeam VALUES (0,'Deacons','clerk','June-99');
INSERT INTO PersonTeam VALUES (0,'Music','member',NULL);
INSERT INTO PersonTeam VALUES (1,'Staff','administrator',NULL);
INSERT INTO PersonTeam VALUES (4,'Elders','chair','June-98');
INSERT INTO PersonTeam VALUES (5,'Design','chair',NULL);
INSERT INTO PersonTeam VALUES (9,'Music','chair',NULL);
INSERT INTO PersonTeam VALUES (10,'Elders','pastor','June-98');
INSERT INTO PersonTeam VALUES (10,'Staff','pastor','June-98');
INSERT INTO PersonTeam VALUES (11,'Music','member',NULL);

INSERT INTO Request VALUES (0, 0,'01-OCT-1997',9,'more hymns','p','we will sing amazing grace next week');
INSERT INTO Request VALUES (1, 0,'08-OCT-1997',9,'thanks for the hymn','p',NULL);
INSERT INTO Request VALUES (2, 6,'15-OCT-1997',9,'less hymns','p',NULL);
INSERT INTO Request VALUES (3, 6,'15-OCT-1997',9,'the sermons are boring but not as bad as college lectures','p','tuff its good for you');
INSERT INTO Request VALUES (4, 4,'22-OCT-1997',10,'the sermons are great','p','thanks!');

-- If possible, write SQL queries to do the following:
-- Compute the average age of all the people in the database. Note you can use the following Oracle features in this query.
--     MONTHS_BETWEEN(laterDate, earlierDate) computes the number of months between the earlier and later dates.
--     SYSDATE gives the current date.
--     TRUNC() rounds a number down to the nearest integer.

SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, P.birthdate)/12)) AS averageAge
FROM Person P;

-- This query uses an agregate function, but is it doing grouping? If so, what is the group? If not, what is it doing instead?

-- This query is doing grouping with from.  Since aggregate fuctions in select are applied to each row
--     the query is grouping by the select condition, not by an attribute.

-- Get the household id and count of members of all households in Grand Rapids HAVING at least 2 members.
-- Order the results by decreasing size.


SELECT H.ID, COUNT(P.ID) AS Members
 FROM Household H, Person P 
 WHERE H.ID = P.householdID
 AND H.city = 'Grand Rapids' 
 GROUP BY H.ID
 HAVING COUNT(P.householdID) > 1
 order by COUNT(P.householdID) DESC;

-- Modify the previous query to retrieve the phone number of the household as well.
SELECT H.ID, COUNT(P.householdID) AS Members, H.phoneNumber
 FROM Household H, Person P 
 WHERE H.ID = P.householdID
 AND H.city = 'Grand Rapids' 
 GROUP BY H.ID, H.phoneNumber
 HAVING COUNT(P.householdID) > 1
 order by COUNT(P.householdID) DESC;
