CLEAR SCREEN;
SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;
SET WRAP OFF;

-- Takes .74 seconds
DECLARE
	amount integer DEFAULT 0;
BEGIN
	FOR i IN 1..10000 LOOP
		SELECT COUNT(DISTINCT R.building)
		INTO amount
		FROM Room R
		WHERE NOT EXISTS(
			SELECT roomID
			FROM Event E
			WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
			AND E.roomID = R.id
		);
	END LOOP;
END;
/

EXPLAIN PLAN FOR
SELECT UNIQUE R.building
FROM Room R
WHERE NOT EXISTS(
	SELECT roomID
	FROM Event E
	WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
	AND E.roomID = R.id
);

SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', NULL,'BASIC'));

/* Returns  
-------------------------------------
| Id  | Operation           | Name  |
-------------------------------------
|   0 | SELECT STATEMENT    |       |
|   1 |  HASH UNIQUE        |       |
|   2 |   HASH JOIN ANTI    |       |
|   3 |    TABLE ACCESS FULL| ROOM  |
|   4 |    TABLE ACCESS FULL| EVENT |
-------------------------------------

The plan demonstrates that the query performs a full table access on Room and Event, which I have required in my statement, joins them, tests for uniqueness, and then selects.  This is exactly what the query specifies.

*/



CREATE INDEX RIndex ON Room (id, building);
CREATE INDEX EIndex ON Event (roomID, eventDate);

-- Takes .67 seconds
DECLARE
	amount integer DEFAULT 0;
BEGIN
	FOR i IN 1..10000 LOOP
		SELECT COUNT(DISTINCT R.building)
		INTO amount
		FROM Room R
		WHERE NOT EXISTS(
			SELECT roomID
			FROM Event E
			WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
			AND E.roomID = R.id
		);
	END LOOP;
END;
/

-- Unique consistently takes .01 seconds longer than Distinct
DECLARE
	amount integer DEFAULT 0;
BEGIN
	FOR i IN 1..10000 LOOP
		SELECT COUNT(UNIQUE R.building)
		INTO amount
		FROM Room R
		WHERE NOT EXISTS(
			SELECT roomID
			FROM Event E
			WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
			AND E.roomID = R.id
		);
	END LOOP;
END;
/

EXPLAIN PLAN FOR
SELECT UNIQUE R.building
FROM Room R
WHERE NOT EXISTS(
	SELECT roomID
	FROM Event E
	WHERE TRUNC(E.eventDate) = TRUNC(sysdate)
	AND E.roomID = R.id
);

/* Returns
------------------------------------
| Id  | Operation         | Name   |
------------------------------------
|   0 | SELECT STATEMENT  |        |
|   1 |  HASH UNIQUE      |        |
|   2 |   HASH JOIN ANTI  |        |
|   3 |    INDEX FULL SCAN| RINDEX |
|   4 |    INDEX FULL SCAN| EINDEX |
------------------------------------

Since the query only uses two columns of both Room and Event, creating indices allows the execution to only go over the full table once when creating the index, using a much smaller index whenever the query only uses the columns that are in one of the indices.
There isn't much room to play around with the ordering of the query and still fulfill the requirements of project 3, but I discovered that DISTINCT is more efficient than UNIQUE

*/

SELECT PLAN_TABLE_OUTPUT 
  FROM TABLE(DBMS_XPLAN.DISPLAY('plan_table', NULL,'BASIC'));

DROP INDEX RIndex;
DROP INDEX EIndex;