-- Create the Event user and database

-- Create the user.
DROP USER events CASCADE;
CREATE USER events 
	IDENTIFIED BY bjarne;
GRANT
	CONNECT, 
	CREATE TABLE, 
	CREATE SESSION, 
	CREATE ANY DIRECTORY,
	DROP ANY DIRECTORY,
	CREATE SEQUENCE, 
	CREATE VIEW, 
	CREATE MATERIALIZED VIEW, 
	CREATE PROCEDURE, 
	CREATE TRIGGER, 
	PLUSTRACE,
	UNLIMITED TABLESPACE
	TO events;

DROP DIRECTORY data__dump_dir;
CREATE DIRECTORY data__dump_dir AS 'C:\Users\jgb23\Documents\project';
GRANT READ,WRITE ON DIRECTORY data__dump_dir to events;

-- Connect to the user's account/schema.
CONNECT events/bjarne;

-- Create the database.
DEFINE database=s:\cs342\cs342\project
@load