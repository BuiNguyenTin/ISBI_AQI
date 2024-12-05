GO
CREATE DATABASE NDS_ISBI	--Tao NDS

GO
USE NDS_ISBI

GO
--DROP TABLE AQI_NDS
--Tao cac bang trong NDS
CREATE TABLE AQI_NDS (

	[AirDataSK] INT IDENTITY (1, 1),
	[Date] datetime,
	[AQI] INT,
	[Category] varchar(255),
	[Defining Parameter] varchar(255),
	[Defining Site] varchar(255),
	[Number of Sites Reporting] INT,
	[Created] datetime,
    [Last Updated] datetime,
	[sourceId] int,
	FOREIGN KEY (CountySK) REFERENCES COUNTIES_NDS(CountySK),
	[CountySK] INT NOT NULL,
	--UNIQUE (CountySK, Date)

	CONSTRAINT PK_AQI_NDS
	PRIMARY KEY CLUSTERED (AirDataSK)
)

GO
CREATE TABLE COUNTIES_NDS(
	[CountySK] INT IDENTITY (1, 1),
	[County Code] INT,
	[county Name] varchar(255),
	[county_ascii] varchar(225),
	[county_full] varchar(225),
	[county_flips] int,
	[lat] float,
	[lng] float,
	[population] int,
	[Created] datetime,
    [Last Updated] datetime,
	FOREIGN KEY (StateSK) REFERENCES STATES_NDS(StateSK),
	[StateSK] INT NOT NULL,
	[sourceId] int,

	CONSTRAINT PK_COUNTY_NDS
	PRIMARY KEY CLUSTERED (CountySK)
)

GO
--DROP TABLE STATES_NDS
CREATE TABLE [STATES_NDS](
	[StateSK] INT IDENTITY (1, 1),
	[state_id] varchar(50),
	[State Code] INT,
	[State Name] varchar(50),
	[Created] datetime,
    [Last Updated] datetime,
	[sourceId] int,

	CONSTRAINT PK_STARES_NDS
	PRIMARY KEY CLUSTERED (StateSK)
)

GO
--Xem cac bang trong NDS
SELECT * FROM AQI_NDS
SELECT * FROM COUNTIES_NDS
SELECT * FROM STATES_NDS

