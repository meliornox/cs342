-- This command file is an addition to the file found at 
-- https://github.com/cs342/code/blob/master/03modeling/lab03.sql
-- for Lab 3 found at
-- https://cs.calvin.edu/courses/cs/342/kvlinden/03modeling/lab.html
--
-- CS 342 Spring 2017
-- meliornox

drop table Person;
drop table HouseHold;

create table HouseHold (
	ID integer PRIMARY KEY,
	street varchar(30),
	city varchar(30),
	state varchar(2),
	zipcode char(5),
	phoneNumber char(12)
	);


create table Team (
	ID PRIMARY KEY,
	name varchar(100) NOT NULL --Team must have a name
);

create table Homegroup (
	ID PRIMARY KEY,
	name varchar(100)
);

create table Person (
	ID integer PRIMARY KEY,
	householdID integer NOT NULL, --Person must be part of a household as dictated by the ERD
	householdRole varchar(100) NOT NULL, --Person must have a role in their household
	mentorID integer,
	homegroupID integer,
	title varchar(4),
	firstName varchar(100),
	lastName varchar(100),
	gender varchar(100),
	sex varchar(100),
	membershipStatus char(1) CHECK (membershipStatus IN ('m', 'a', 'c')),
	FOREIGN KEY (householdID) REFERENCES Household(ID),
	FOREIGN KEY (mentorID) REFERENCES Person(ID),
	FOREIGN KEY (homegroupID) REFERENCES Homegroup(ID),
	CHECK (mentorID != ID) --Person cannot mentor themselves
	);
	
create table Request (
	ID integer PRIMARY KEY,
	householdID integer NOT NULL, --Request must have come from somewhere
	-- This lets a household make a request to a person in that household
	personID integer NOT NULL, --Request must be directed to a person
	text varchar(2000) NOT NULL --Request must have contents
	FOREIGN KEY (householdID) REFERENCES Household(ID),
	FOREIGN KEY (personID) REFERENCES Person(ID),
);

create table PersonTeam (
	personID integer,
	teamID integer,
	role varchar(100) NOT NULL, --Person must have a role in their team
	period varchar(100),
	FOREIGN KEY (personID) REFERENCES Person(ID) ON DELETE CASCADE, -- IF the person does not exist, don't have them in a team
	FOREIGN KEY (teamID) REFERENCES Team(ID) ON DELETE CASCADE, --If a team doesn't exist, don't have people in it
	PRIMARY KEY (personID, teamID)
);

INSERT INTO Household VALUES (0,'2347 Oxford Dr. SE','Grand Rapids','MI','49506','616-243-5680');

INSERT INTO Person VALUES (0,'mr.','Keith','VanderLinden','m');
INSERT INTO Person VALUES (1,'ms.','Brenda','VanderLinden','m');
