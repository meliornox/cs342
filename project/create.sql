-- Create the Event user and database

-- Create the user.
DROP USER database CASCADE;
CREATE USER database
	IDENTIFIED BY meliornox
	QUOTA 5M ON System;
GRANT 
	CONNECT,
	CREATE TABLE,
	CREATE SESSION,
	CREATE SEQUENCE,
	CREATE VIEW,
	CREATE MATERIALIZED VIEW,
	CREATE PROCEDURE,
	CREATE TRIGGER,
	UNLIMITED TABLESPACE
	TO database;

-- Connect to the user's account/schema.
CONNECT database/meliornox;

-- Create the database.
DEFINE database=s:\github\cs342\cs342\project\database
@&database\load
