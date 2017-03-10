-- Responses to lab exercises found at https://cs.calvin.edu/courses/cs/342/kvlinden/05sql/lab.html
-- To be used in conjunction with the database found at https://github.com/cs342/code/tree/master/databases/cpdb
-- Theodore Bigelow
-- CS 342 Spring 2017
-- lab05 part 2
-- 03/10/2017

-- Write an SQL query that creates phonebook entries as follows.
-- Produce an appropriate phone-book entry for “traditional” family entries, e.g.:
-- VanderLinden, Keith AND Brenda - 111-222-3333 - 2347 Oxford St.

SELECT P1.lastName || ' , ' || P1.firstName || ' AND ' || P2.firstname || ' - ' || H1.phoneNumber || ' - ' || H1.street AS Entries
FROM Person P1, Person P2, Household H1
WHERE P1.householdId = P2.householdId
AND P1.id < P2.id
AND P1.householdID = H1.ID
AND ((P1.householdRole = 'husband' AND P2.householdRole = 'wife') 
OR (P1.householdRole = 'wife' AND P2.householdRole = 'wife')
OR (P1.householdRole = 'husband' AND P2.householdRole = 'husband');  

-- Extend your solution to handle families in which both spouses keep their own names, e.g.:
-- VanderLinden, Keith AND Brenda Roorda - 111-222-3333 - 2347 Oxford St.

SELECT P1.lastName || ' , ' || P1.firstName || ' AND ' || P2.firstname || ' ' || P2.lastName || ' - ' || H.phoneNumber || ' - ' || H.street AS Entries
FROM Person P1, Person P2, Household H
WHERE P1.householdId = P2.householdId
AND P1.id < P2.id
AND P1.householdID = H.ID
AND ((P1.householdRole = 'husband' AND P2.householdRole = 'wife') 
OR (P1.householdRole = 'wife' AND P2.householdRole = 'wife')
OR (P1.householdRole = 'husband' AND P2.householdRole = 'husband')); 

-- Finally, extend your solution to include single-adult families, e.g.:
-- Doe, Jane - 111-222-3333 - 2347 Main St.
-- List only the parents AND the singles, not the children.

SELECT  P1.lastName || ' , ' || P1.firstName || ' AND ' || P2.firstname || ' ' || P2.lastName || ' - ' || H1.phoneNumber || ' - ' || H1.street AS Entries
FROM Person P1, Person P2, Household H1
WHERE P1.householdId = P2.householdId
AND P1.id < P2.id
AND P1.householdID = H1.ID
AND ((P1.householdRole = 'husband' AND P2.householdRole = 'wife') 
OR (P1.householdRole = 'wife' AND P2.householdRole = 'wife')
OR (P1.householdRole = 'husband' AND P2.householdRole = 'husband'))
UNION
SELECT  P3.lastName || ' , ' || P3.firstName || ' - ' || H2.phoneNumber || ' - ' || H2.street
FROM Person P3, Household H2
WHERE P3.householdID = H2.ID
AND P3.householdRole = 'single';






