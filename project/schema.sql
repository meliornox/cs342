-- CHANGED
CREATE TABLE Status(
	status varchar(10)
);

-- CHANGED
CREATE TABLE Person(
	ID integer PRIMARY KEY,
	firstName varchar(30),
	lastName varchar(30),
	status varchar(10) REFERENCES Status(status) ON DELETE SET NULL,
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
	organizationID integer REFERENCES Organization(ID) ON DELETE CASCADE,
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

-- CHANGED
CREATE TABLE Chair(
	chair varchar(6)
);

-- CHANGED
CREATE TABLE Shape(
	shape varchar(10)
);

-- CHANGED
CREATE TABLE Arrangement(
	ID integer PRIMARY KEY,
	chair varchar(6) REFERENCES Chair(chair) ON DELETE SET NULL,
	tablesBool char CHECK(tablesBool IN (0,1)),
	shape varchar(10) REFERENCES Shape(shape) ON DELETE SET NULL
);

-- CHANGED
CREATE TABLE MealType(
	mealType varchar(10)
);

-- CHANGED
CREATE TABLE Formality(
	formality varchar(10)
);

-- CHANGED
CREATE TABLE CateringPlan(
	ID integer PRIMARY KEY,
	mealType varchar(10) REFERENCES MealType(mealType) ON DELETE SET NULL,
	formality varchar(10) REFERENCES Formality(formality) ON DELETE SET NULL
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