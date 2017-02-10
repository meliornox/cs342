-- This command file is an addition to the file found at 
-- https://github.com/cs342/code/blob/master/02modeling/movies.sql
-- with DDL/DML commands along with explanations of how and why they work
-- for Lab Exercise 2.1 found at
-- https://cs.calvin.edu/courses/cs/342/kvlinden/02modeling/lab.html
--
-- CS 342 Spring 2017
-- meliornox

-- Try adding records to the movie relation that cause these intra-relation issues:
-- a repeated primary key value
INSERT INTO Movie VALUES (2,'Sharktopus',2010,4.6,1050);
-- ERROR at line 1:
-- ORA-00001: unique constraint (A.SYS_C007045) violated
-- There is a constraint built in that does not allow the addition of records with
-- existing primary keys.

-- a NULL primary key value
INSERT INTO Movie VALUES (NULL,'Piranhaconda',2012,3.8,137);
-- ERROR at line 1:
-- ORA-01400: cannot insert NULL into ("A"."MOVIE"."ID")
-- Primary keys cannot be NULL

-- a violation of a CHECK constraint
INSERT INTO Movie VALUES (4,'Sharktopus vs Pteracuda',1800,6.2,59);
-- ERROR at line 1:
-- ORA-02290: check constraint (A.SYS_C007044) violated
-- Won't allow a violation of check constraint

-- a violation of an SQL datatype constraint
INSERT INTO Movie VALUES ('L','Sharktopus vs Whalewolf',2015,5.2,24);
-- ERROR at line 1:
-- ORA-01722: invalid number
-- Type checks

-- a negative score value
INSERT INTO Movie VALUES (5,'Sharknado',2013,-4.8,5485);
-- 1 row created.
-- Allowed, no constraint defined

-- Try adding records that cause these inter-relation issues:
-- a new record with a NULL value for a foreign key value
INSERT INTO Casting VALUES (1,NULL,'costar');
-- 1 row created.
-- Having a NULL value for a foreign key does not compromise the integrity of the rest of the 
-- data.

-- a foreign key value in a referencing (aka child) table that doesn’t match any key value
-- in the referenced (aka parent) table
INSERT INTO Casting VALUES (6,3,'star');
-- ERROR at line 1:
-- ORA-02291: integrity constraint (A.SYS_C007048) violated - parent key not found
-- Maintains referential integrity

-- a key value in a referenced table with no related records in the referencing table
INSERT INTO Performer VALUES (5,'Shark');
-- 1 row created.
-- This is an essential part of creating a referential database,
-- I don't know how it could *not* be supported.

-- Try deleting/modifying records as follows: 
-- Delete a referenced record that is referenced by a referencing record.
DELETE FROM Performer WHERE id = 4;
-- 1 row deleted.
-- Deleting things is good, this also set any occurrence of a reference to 4 being set to NULL,
-- caused by the line in Casting 
-- FOREIGN KEY (performerId) REFERENCES Performer(Id) ON DELETE SET NULL

-- Delete a referencing record that references a referenced record.
DELETE FROM Casting WHERE performerId = 2 AND movieId = 2;
-- 1 row deleted.
-- This is good functionality?  Removing a movie leaves a floating Performer,
-- which isn't an issue for this database.

-- Modify the ID of a movie record that is referenced by a casting record.
UPDATE Movie SET id = 6 WHERE id = 1;
-- ERROR at line 1:
-- ORA-02292: integrity constraint (A.SYS_C007048) violated - child record found
-- Oracle may not support cascading updates, but it does warn and error out.  This is so 
-- referencing records do not reference the wrong record, since if this operation was performed
-- and a new Movie was put in the table with id = 1, Harrison Ford and The Mighty Chewbacca
-- would be listed as the star and extra(costar?), most likely mistakenly.

-- Note that though the text discusses it, Oracle doesn’t support ON UPDATE CASCADE. 
-- Would supporting such a feature be a good idea? See Ask Tom’s discussion of this.
-- https://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:5773459616034
-- I think it would only be a good idea in an instance where storing a separate 
-- primary key is a concern, and memory isn't that expensive now. There could be an
-- argument made for letting database administrators design things badly if they want,
-- but the tools I've been exposed to have with few exeptions focused on not letting
-- the user make mistakes. The other side of the issue is that there are edge cases
-- where update cascade is useful and even necessary.  I would argue for supporting it but
-- letting it be known that the primary key should not regularly change, using update
-- cascade should be an exeptional event.

-- Also I feel like the end of Tom's discussion devolved into passive-agressive name-calling, 
-- the YouTube rule seems to apply to Ask Xs as well.