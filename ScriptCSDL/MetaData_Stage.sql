CREATE DATABASE METADB
CREATE DATABASE STAGE 

USE METADB 

GO

CREATE TABLE DATA_FLOW
(
	ID INT NOT NULL IDENTITY(1,1),
	NAME VARCHAR(50) NOT NULL,
	STATUS INT,
	LSET DATETIME,
	CET DATETIME,
	CONSTRAINT PK_DATA_FLOW
	PRIMARY KEY CLUSTERED (ID)
)
GO

INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES ('AIR_QUALITY', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')

INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES('USCOUNTRIES', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')

SELECT * FROM DATA_FLOW

USE STAGE

CREATE TABLE AIR_QUALITY_STAGE (
    [State Name] varchar(50),
    [county Name] varchar(255),
    [State Code] INT,
    [County Code] INT,
    [Date] datetime,
    [AQI] INT,
    [Category] varchar(255),
    [Defining Parameter] varchar(255),
    [Defining Site] varchar(255),
    [Number of Sites Reporting] INT,
    [Created] datetime,
    [Last Updated] datetime
)

CREATE TABLE USCOUNTRIES_STAGE (
	county varchar(50),
	county_ascii varchar(225),
	county_full varchar(225),
	county_flips int,
	state_id varchar(50),
	state_name varchar(225),
	lat float,
	lng float,
	[population] int,
	[Created] datetime,
    [Last Updated] datetime
)

SELECT * FROM AIR_QUALITY_STAGE

SELECT * FROM USCOUNTRIES_STAGE


