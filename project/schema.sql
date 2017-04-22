CREATE TABLE Person(
	ID integer PRIMARY KEY,
	firstName varchar(30),
	lastName varchar(30),
	status varchar(10) CHECK (status IN('freshman','sophomore','junior','senior','staff')),
	email varchar(50)
);

CREATE TABLE Organization(
	ID integer PRIMARY KEY,
	staffAdvisor integer REFERENCES Person(ID) ON DELETE SET NULL,
	name varchar(50),
	description varchar(200),
	budget float
);

CREATE TABLE PersonOrganization(
	personID integer REFERENCES Person(ID) ON DELETE CASCADE,
	organizationID integer REFERENCING Organization(ID) ON DELETE CASCADE,
	role varchar(20),
	PRIMARY KEY (personID, organizationID)
);

CREATE TABLE Room(
	ID integer PRIMARY KEY,
	building varchar(30),
	num integer,
	capacity integer,
	projectorBool char CHECK(projectorBool IN (0,1))
);

CREATE TABLE Arrangement(
	ID integer PRIMARY KEY,
	chair varchar(6) CHECK (chair IN ('swivel','static')),
	tablesBool char CHECK(tablesBool IN (0,1)),
	shape varchar(10) CHECK (shape IN ('circle','square','rows'))
);

CREATE TABLE CateringPlan(
	ID integer PRIMARY KEY,
	mealType varchar(10) CHECK (mealType IN ('breakfast','lunch','dinner','snack','dessert')),
	formality varchar(10) CHECK (formality IN ('casual','formal'))
);

CREATE TABLE Food(
	ID integer PRIMARY KEY,
	name varchar(30),
	calories integer,
	unitPrice float
);

CREATE TABLE PlanFood(
	planID integer REFERENCES CateringPlan(ID) ON DELETE CASCADE,
	foodID integer REFERENCES Food(ID) ON DELETE CASCADE,
	PRIMARY KEY (planID, foodID)
);

CREATE TABLE Event(
	ID integer PRIMARY KEY,
	roomID integer REFERENCES Room(ID) ON DELETE SET NULL,
	cateringID integer REFERENCES CateringPlan(ID) ON DELETE SET NULL,
	arrangementID integer REFERENCES Arrangement(ID) ON DELETE SET NULL,
	organizerID REFERENCES Person(ID) ON DELETE SET NULL,
	organizationID REFERENCES Organization(ID),
	name varchar(30),
	eventDate date,
	duration float,
	attendance integer
);