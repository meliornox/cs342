-- This command file loads an experimental person database.
-- The data conforms to the following assumptions:
--     * People can have 0 or many team assignments.
--     * People can have 0 or many visit dates.
--     * Teams and visits don't affect one another.
--
-- CS 342, Spring, 2017
-- kvlinden

DROP TABLE PersonTeam;
DROP TABLE PersonVisit;

CREATE TABLE PersonTeam (
	personName varchar(10),
    teamName varchar(10)
	);

CREATE TABLE PersonVisit (
	personName varchar(10),
    personVisit date
	);

-- Load records for two team memberships and two visits for Shamkant.
INSERT INTO PersonTeam VALUES ('Shamkant', 'elders');
INSERT INTO PersonTeam VALUES ('Shamkant', 'executive');
INSERT INTO PersonVisit VALUES ('Shamkant', '22-FEB-2015');
INSERT INTO PersonVisit VALUES ('Shamkant', '1-MAR-2015');

-- Query a combined "view" of the data of the form View(name, team, visit).
SELECT pt.personName, pt.teamName, pv.personVisit
FROM PersonTeam pt, PersonVisit pv
WHERE pt.personName = pv.personName;


-- Responses to lab exercises found at https://cs.calvin.edu/courses/cs/342/kvlinden/04modeling/lab.html
-- Theodore Bigelow
-- CS 342 Spring 2017
-- lab04 part 2
-- Demonstrate, formally, whether the relations implemented by the tables PersonTeam and PersonVisit are in BCNF and/or 4NF (or not).
--   Although implied, the implementation defines no primary keys, so it would be impossible to be in BCNF or 4NF, since 4NF requires 3NF and 3NF requires dependency on keys.  If we assume all values are keys, then the relations are in BCNF since all functional dependencies would have their left side as candidate keys, all possible candidate keys being part of the primary key.  It is also in 4NF, since the multivalued dependencies personName ->> teamName | personVisit comprise separate tables.

-- Consider the output of the data queried by the combined “view” query at the end of the command file. Demonstrate, formally, whether this view, when considered as a (single) relation, is in BCNF and/or 4NF (or not).
-- It is in BCNF, since everything is a key it is still in BCNF for the reasons stated in the previous section.  
-- It is also in 4NF, since tuples with equal attributes on n-1 of the attributes can switch the nth attribute and still be part of the output. 

-- The view has the same number of records as the original tables. Does this mean that the original schema and the derived “view” schema are equally appropriate? If so, explain why; if not, explain why one of the schemata is better. Does your choice depend on context?
-- By the definitions of normal forms yes, but normal forms are not everything.  Team membership and visit dates are both multiple values dependent on the person's name, so they should both have their own tables.  I don't think it's particularly dependent on context, I can't think of a context where one big table for something of this nature would be the best solution.