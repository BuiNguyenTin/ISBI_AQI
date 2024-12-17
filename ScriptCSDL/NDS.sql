GO
CREATE DATABASE NDS_ISBI	--Tao NDS

GO
USE NDS_ISBI

GO
DROP TABLE AQI_NDS
DROP TABLE COUNTIES_NDS
DROP TABLE STATES_NDS

--Tao cac bang trong NDS
CREATE TABLE [STATES_NDS](
	[StateSK] INT IDENTITY (1, 1),
	[state_id] varchar(50),
	[State Code] int,
	[State Name] varchar(255),
	[Created] datetime,
    [Last Updated] datetime,
	[SourceId] int,

	CONSTRAINT PK_STATES_NDS
	PRIMARY KEY CLUSTERED (StateSK)
)
GO

CREATE TABLE COUNTIES_NDS(
	[CountySK] INT IDENTITY (1, 1),
	[County Code] int,
	[county Name] varchar(255),
	[county_ascii] varchar(225),
	[county_full] varchar(225),
	[county_fips] int,
	[lat] float,
	[lng] float,
	[population] int,
	[Created] datetime,
    [Last Updated] datetime,
	[SourceId] int,

	FOREIGN KEY (StateSK) REFERENCES STATES_NDS(StateSK),
	[StateSK] INT NOT NULL,

	CONSTRAINT PK_COUNTIES_NDS
	PRIMARY KEY CLUSTERED (CountySK)
)
GO

CREATE TABLE AQI_NDS (
	[AirDataSK] INT IDENTITY (1, 1),
	[Date] datetime,
	[AQI] int,
	[Category] varchar(255),
	[Defining Parameter] varchar(255),
	[Defining Site] varchar(255),
	[Number of Sites Reporting] int,
	[Created] datetime,
    [Last Updated] datetime,
	[SourceId] int,

	FOREIGN KEY (CountySK) REFERENCES COUNTIES_NDS(CountySK),
	[CountySK] INT NOT NULL,
	FOREIGN KEY (StateSK) REFERENCES STATES_NDS(StateSK),
	[StateSK] INT NOT NULL,

	CONSTRAINT PK_AQI_NDS
	PRIMARY KEY CLUSTERED (AirDataSK)
)
GO

--Xem cac bang trong NDS
SELECT * FROM AQI_NDS
SELECT * FROM COUNTIES_NDS
SELECT * FROM STATES_NDS

