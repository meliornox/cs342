-- This command file loads an experimental person relation.
-- File location: https://github.com/cs342/code/blob/master/04modeling/lab04_1.sql
-- The data conforms to the following assumptions:
--     * Person IDs and team names are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table AltPerson;

CREATE TABLE AltPerson (
	personId integer,
	name varchar(10),
	status char(1),
	mentorId integer,
	mentorName varchar(10),
	mentorStatus char(1),
    teamName varchar(10),
    teamRole varchar(10),
    teamTime varchar(10)
	);

INSERT INTO AltPerson VALUES (0, 'Ramez', 'v', 1, 'Shamkant', 'm', 'elders', 'trainee', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'elders', 'chair', 'Monday');
INSERT INTO AltPerson VALUES (1, 'Shamkant', 'm', NULL, NULL, NULL, 'executive', 'protem', 'Wednesday');
INSERT INTO AltPerson VALUES (2, 'Jennifer', 'v', 3, 'Jeff', 'm', 'deacons', 'treasurer', 'Tuesday');
INSERT INTO AltPerson VALUES (3, 'Jeff', 'm', NULL, NULL, NULL, 'deacons', 'chair', 'Tuesday');

-- Responses to lab exercises found at https://cs.calvin.edu/courses/cs/342/kvlinden/04modeling/lab.html
-- Theodore Bigelow
-- CS 342 Spring 2017
-- lab04 part 1
-- a. Explain, informally, why the relation is not well-designed and then prove your point formally.
--     Informally, there is a major flaw up front: There is no primary key.  There are no constraints at all that preserve the integrity of the data in the table, people can mentor themselves, teams can meet at different times for different people, mentors and people can have different names across the database for the same id, mentors can have different statuses for the same id.
--     Formally, this relation is technically in first normal form in the sense that there are no fields that contain lists of attributes.  All the data is in one table, so all the data is recoverable, and there are no spurious tuples created by joins since there are no joins.  In be in BCNF, we need to map nontrivial functional dependencies, those being:
--         personID -> name, status, mentorID
--         teamName, personName -> teamRole
--         teamName -> teamTime
--     By this functional dependency mapping, personID, personID and teamName, and teamName should be superkeys for the schema.  Since there are no keys, these are not superkeys and the table is not in BCNF.
-- b. Specify a properly normalized schema for this database.
--     Going off of the functional dependencies mapped earlier, we will need three tables as follows:
--         Person (_ID_, name, status, mentorID)
--         Team (_Name_, time)
--         PersonTeam(_personID_,_teamName_, role)
--
-- Implement an appropriately normalized version of the AltPerson relation by editing the existing command file, adding your own create-table commands below the ones already in the file and using different table names to avoid naming conflicts. Your commands should do the following.
--   Create your normalized sub-relations. For simplicity's sake, don't introduce new attributes; just use the ones in the original table (perhaps repeated as foreign keys).
--   Populate your new relations by querying the data from the existing AltPerson database. Note that you may need to use a DISTINCT query to get unique key values from the raw data.
--   Write queries to display the data in your new sub-relations.

CREATE TABLE Person(
	personID integer PRIMARY KEY,
	mentorID integer,
	name varchar(10,
	status char(1),
	FOREIGN KEY (mentorID) REFERENCES Person(personID) ON DELETE SET NULL
);

CREATE TABLE Team(
	teamName varchar(10) PRIMARY KEY,
	teamTime char(1)
);

CREATE TABLE PersonTeam(
	personID integer,
	teamName integer,
	teamRole varchar(10),	
	FOREIGN KEY (personID) REFERENCES Person(personID) ON DELETE CASCADE,
	FOREIGN KEY (teamName) REFERENCES Team(teamName) ON DELETE CASCADE,
	PRIMARY KEY (personID, teamName)
);

INSERT INTO Person SELECT DISTINCT personId, name, status, mentorId FROM AltPerson;
INSERT INTO Team SELECT DISTINCT teamName, teamTime FROM AltPerson;
INSERT INTO Person_Team SELECT DISTINCT personId, teamName, teamRole FROM AltPerson;

SELECT * FROM Person;
SELECT * FROM Team;
SELECT * FROM Person_Team;

-- Challenge: Write a query the reproduces the old data table from your new tables.
SELECT P.personID, P.name, P.status, M.id, M.name, M.status, T.teamName, T.teamRole, T.teamTime
FROM Person P, Person M, PersonTeam PT, Team T
WHERE P.mentorID = M.personID
AND P.personID = PT.personID
AND T.teamName = PT.teamName;