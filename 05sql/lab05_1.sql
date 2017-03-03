-- Responses to lab exercises found at https://cs.calvin.edu/courses/cs/342/kvlinden/05sql/lab.html
-- To be used in conjunction with the database found at https://github.com/cs342/code/tree/master/databases/cpdb
-- Theodore Bigelow
-- CS 342 Spring 2017
-- lab05 part 1
-- 03/03/2017

drop table Request;
drop table PersonTeam;
drop table Person;
drop table HouseHold;
drop table HomeGroup;
drop table Team;
drop sequence cpdb_sequence;

create table HouseHold(
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);

create table HomeGroup(
	ID integer PRIMARY KEY,
	name varchar(20),
	meetingTime varchar(20),
	topic varchar(40)
	);

create table Team(
	name varchar(20) PRIMARY KEY,
	mandate varchar(128)
	);

create table Person (
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

create table PersonTeam(
	personID integer REFERENCES Person(ID),	
	teamName varchar(20) REFERENCES Team(name),
	role varchar(15),
	duration varchar(10),
	PRIMARY KEY (personId, teamName)
	);

create table Request(
	ID integer PRIMARY KEY,
	originatorHouseHoldID integer REFERENCES HouseHold(ID),
	requestDate date,
	responderID integer REFERENCES Person(ID),
	text varchar(256),
	infoAccess char(1),
	response varchar(256)
	);

create sequence cpdb_sequence
	start with 100
	increment by 1;
	
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
INSERT INTO Team VALUES ('Music','plan and execute music in the church');
INSERT INTO Team VALUES ('Design','plan and evaluate worship services');
INSERT INTO Team VALUES ('Side-door','plan and run side-door ministeries');
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

-- If possible, write SQL queries that
--   Retrieve the cross-product of all person and all household records. How many records to you get and why? As an optional challenge, can you use SQL to compute this number?

SELECT H.ID, H.street, H.city, H.state, H.zipcode, H.phoneNumber, P.ID, P.title, P.firstName, P.lastName, P.membershipStatus, P.gender, P.birthdate, P.householdID, P.householdRole, P.homegroupID, P.homeGroupRole
FROM Household H CROSS JOIN Person P;
--     There will be 8 Households * 16 Persons = 128 records.  This is because every Household is joined with every Person.

--   Retrieve the people who have birthdays specified in the database, ordered by day-of-year (i.e., Jan 1 birthdays go before Jan 2 birthdays, regardless of the year). Note that you can compute the day of year value using the Oracle function: TO_CHAR(birthdate, 'DDD').
SELECT firstName, lastName, birthdate FROM Person WHERE birthdate IS NOT NULL ORDER BY TO_CHAR(birthdate, 'DDD') ASC;