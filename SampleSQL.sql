/*
Let's create some Tables, relationships, and insert some data
*/
Use SampleDB;

-- DROP order is important wrt Foreign Keys
DROP TABLE IF EXISTS People;
DROP TABLE IF EXISTS Locations;

-- CREATE order is important wrt Foreign Keys
CREATE TABLE Locations(
Location_ID INT NOT NULL AUTO_INCREMENT Primary Key,
Street_Address varchar(40),
City_Address varchar(40),
Country varchar(40),
Postcode varchar(10)
);

INSERT INTO Locations (Street_Address, City_Address, Country, Postcode)
	VALUES ('Side Street', 'Dublin', 'Ireland', '24');
INSERT INTO Locations (Street_Address) VALUES ('Main Street');
SELECT * FROM Locations;

CREATE TABLE People(
People_ID INT NOT NULL AUTO_INCREMENT Primary Key,
First_Name VARCHAR(20),
Middle_Name VARCHAR(20),
Last_Name VARCHAR(20),
DOB DATE,
Location_ID INT NOT NULL,
FOREIGN KEY (Location_ID) REFERENCES Locations(Location_ID)
);
INSERT INTO People(First_Name, Last_Name, DOB, Location_ID)
	VALUES('Richard', 'Feynman', '1957-01-31', 1);
SELECT * FROM People;
