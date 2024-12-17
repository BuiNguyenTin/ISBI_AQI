CREATE DATABASE METADB_ISBI	--Tao MetaDatabase
CREATE DATABASE STAGE_ISBI	--Tao Stage
GO
USE METADB_ISBI

GO
--Tao bang DataFlow
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
--Nap du lieu vao DataFlow
INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES ('AIR_QUALITY', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')
INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES('USCOUNTIES', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')
--DDS
INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES('DIM_STATES', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')
INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES('DIM_COUNTIES', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')
INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES('DIM_DATE', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')
--INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
--VALUES('DIM_PARAMETER', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')
INSERT INTO DATA_FLOW (NAME, STATUS, LSET, CET)
VALUES('FACT_AQI', 1, '2023-01-01 00:00:00','2024-01-01 00:00:00')

--delete from DATA_FLOW where Name = 'USCOUNTRIES'
GO
SELECT * FROM DATA_FLOW	--Xem DataFlow

GO
USE STAGE_ISBI

GO
--Tao cac bang trong STAGE
CREATE TABLE AIR_QUALITY_STAGE (
    [State Name] varchar(50),
    [county Name] varchar(255),
    [State Code] int,
    [County Code] int,
    [Date] datetime,
    [AQI] int,
    [Category] varchar(255),
    [Defining Parameter] varchar(255),
    [Defining Site] varchar(255),
    [Number of Sites Reporting] int,
    [Created] datetime,
    [Last Updated] datetime,
	[SourceID] int
)
GO

CREATE TABLE USCOUNTIES_STAGE (
	[county] varchar(50),
	[county_ascii] varchar(225),
	[county_full] varchar(225),
	[county_fips] int,
	[state_id] varchar(50),
	[state_name] varchar(225),
	[lat] float,
	[lng] float,
	[population] int,
	[Created] datetime,
    [Last Updated] datetime
)

GO

--Xem cac bang trong STAGE
SELECT * FROM AIR_QUALITY_STAGE where [State Name] = 'Florida'
SELECT * FROM USCOUNTIES_STAGE


