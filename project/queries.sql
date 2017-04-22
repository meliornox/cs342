-- Theodore Bigelow
-- CS 342 Spring 2017 Calvin College
-- SQL Project Query file

-- This view provides a calendar in order to publicize Calvin's events.  This would be used by the general public to learn about events.
-- It implements the view and self-join requirements.
-- This view could be written as a materialized view, but I wrote it to serve as a read-only calendar for public use, not an administrator tool.

DROP VIEW Calendar;

CREATE VIEW Calendar AS
SELECT E.name, E.eventDate, R.building, R.num, E2.name
FROM Event E, Room R
WHERE E.roomID = R.id
LEFT OUTER JOIN Event E2 
ON E.conferenceID = E2.ID;

-- This query provides a way of emailing leaders and staff about events that are associated with their organization.
-- This query would be used by event planning services administrators.
-- It satisfies the four-table join requirement.
SELECT P.email, E.name, E.eventDate, E.organizerID, P2.firstName, P2.lastName
FROM Person P, PersonOrganization PO, Event E, Person P2
WHERE P.id = PO.personID
AND PO.organizationID = E.organizationID
AND P2.id = E.organizerID
AND (PO.role = 'leader' OR PO.role = 'staff advisor');

-- This query determines who is and who is not connected to a staff advisor through an organization.
-- This could be used by mentoring services to determine which students to market the mentoring program to.
-- This satisfies the inner and outer join requirement.
-- It is written with a left outer join so that people will appear who are not in organizations with advisors.
SELECT P.firstName, P.lastName, OP.name, OP.firstName, OP.lastName
FROM Person P
LEFT OUTER JOIN(
  SELECT PO1.personID, O.name, P2.firstName, P2.lastName
  FROM PersonOrganization PO1, Organization O, PersonOrganization PO2, Person P2
  WHERE PO1.organizationID = O.id
  AND PO2.organizationID = O.id
  AND P2.id = PO2.personID
  AND PO2.role = 'staff advisor'
) OP
ON P.id = OP.personID;

-- This query counts the number of meals needing to be prepared for today.
-- This would be used by catering to determine how many people they needed to have on-staff that day.
-- This satisfies the null comparison and statistics requirements.

SELECT SUM(E.attendance)
FROM Event E
WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
AND E.cateringID IS NOT NULL;

-- This query is used to determine what buildings aren't being used today.
-- This is used by building staff to know which buildings to lock today.
-- This satisfies the nested select requirement.
SELECT UNIQUE R.building
FROM Room R
WHERE NOT EXISTS(
	SELECT *
	FROM Event E
	WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
	AND E.roomID = R.id
);