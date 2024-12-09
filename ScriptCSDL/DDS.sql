CREATE DATABASE DDS_ISBI
GO
USE DDS_ISBI
use master 

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
select * from [DIM_STATES]
--drop TABLE [DIM_STATES]
CREATE TABLE [DIM_STATES](
	[StateSK] INT,
	[State Code] INT,
	[State Name] VARCHAR(50) NULL,
	[Created] DATETIME NULL,
	[Last Updated] DATETIME NULL,
	[Status] bit NULL,

	CONSTRAINT [PK_DIM_States] primary key clustered([StateSK] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE DIM_COUNTIES (
	[CountySK] int,
	[county Name] varchar(255) NULL,
	[county_ascii] varchar(225) NULL,
	[county_full] varchar(225) NULL,
	[county_flips] int NULL,
	[population] int NULL,
	[Created] datetime NULL,
    [Last Updated] datetime NULL,
	[StateSK] INT,
	[Status] bit NULL,

	CONSTRAINT PK_DIM_COUNTIES PRIMARY KEY CLUSTERED (CountySK ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[DIM_COUNTIES] WITH CHECK ADD CONSTRAINT [FK_DIM_COUNTIES_DIM_STATES] FOREIGN KEY ([StateSK]) REFERENCES [dbo].[DIM_STATES] ([StateSK])

GO
--drop TABLE [dbo].[DIM_DATE]
CREATE TABLE [dbo].[DIM_DATE](
	[DateSK] int IDENTITY(1,1),
	[Day] int NULL,
	[Month] int NULL,
	[Quater] int NULL,
	[Year] int NULL,
	[Date] datetime NULL,
	CONSTRAINT [PK_DIM_DATE] PRIMARY KEY CLUSTERED ([DateSK] ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [dbo].[DIM_PARAMETER](
	[ParameterSK] int IDENTITY (1,1),
	[Defining Parameter] varchar(50),
	[Created] datetime NUll,
	[Last Updated] datetime NULL,

	CONSTRAINT [PK_DIM_PARAMETER] PRIMARY KEY CLUSTERED ([ParameterSK] ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];

GO
CREATE TABLE [FACT_AQI](
	[AirDataSK] int,
	[DateSK] int,
	[StateSK] int,
	[CountySK] int,
	[ParameterSK] int,
	[AQI] int NULL,
	[Category] varchar(50) NULL,
	[Defining Site] varchar(50) NULL,
	[Number Of Sites Reporting] int NULL,
	[Created] DATETIME NULL,
	[Last Updated] datetime NULL,
	CONSTRAINT [PK_FACT_AQI] PRIMARY KEY CLUSTERED ([AirDataSK] ASC)
	WITH(PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY];
GO


ALTER TABLE [dbo].[FACT_AQI] WITH CHECK ADD CONSTRAINT [FK_FACT_AIRQUALITY_DIM_DATE] FOREIGN KEY ([DateSK])
REFERENCES [dbo].[DIM_DATE] ([DateSK])


-- Xóa khóa ngoại từ bảng FACT_AQI
ALTER TABLE FACT_AQI
DROP CONSTRAINT [FK_FACT_AIRQUALITY_DIM_DATE];
GO

ALTER TABLE [dbo].[FACT_AQI] WITH CHECK ADD CONSTRAINT [FK_FACT_AIRQUALITY_DIM_STATES] FOREIGN KEY ([StateSK])
REFERENCES [dbo].[DIM_STATES] ([StateSK])
GO

ALTER TABLE [dbo].[FACT_AQI] WITH CHECK ADD CONSTRAINT [FK_FACT_AIRQUALITY_DIM_COUNTIES] FOREIGN KEY ([CountySK])
REFERENCES [dbo].[DIM_COUNTIES] ([CountySK])
GO

ALTER TABLE [dbo].[FACT_AQI] WITH CHECK ADD CONSTRAINT [FK_FACT_AIRQUALITY_DIM_PARAMETER] FOREIGN KEY ([ParameterSK])
REFERENCES [dbo].[DIM_PARAMETER] ([ParameterSK])
GO
--drop PROCEDURE AddDateTo_DIM_DATE
CREATE or ALTER PROCEDURE AddDateTo_DIM_DATE
AS
BEGIN
    DECLARE @reqStart_date datetime,
            @reqEnd_date datetime,
            @current_date datetime;

    SELECT @reqStart_date = MIN(Date), @reqEnd_date = MAX(Date)
    FROM [NDS_ISBI].[dbo].[AQI_NDS];

    SET @current_date = @reqStart_date;

    WHILE @current_date <= @reqEnd_date
    BEGIN
        INSERT INTO [dbo].[DIM_DATE] ([Day], [Month], [Quater], [Year], [Date])
        VALUES (
            DATEPART(DAY, @current_date), 
            DATEPART(MONTH, @current_date), 
            DATEPART(QUARTER, @current_date), 
            DATEPART(YEAR, @current_date), 
            CAST(@current_date AS DATE)
        );

        SET @current_date = DATEADD(DAY, 1, @current_date);
    END;
END;
GO


EXEC AddDateTo_DIM_DATE
GO

SELECT * FROM [dbo].[DIM_COUNTIES]
SELECT * FROM [dbo].[DIM_STATES]
SELECT * FROM [dbo].[DIM_DATE]
SELECT * FROM [dbo].[DIM_PARAMETER]
SELECT * FROM [dbo].[FACT_AQI]

SELECT * FROM [NDS_ISBI].[dbo].[AQI_NDS] 
ORDER BY Date
GO

SELECT MIN(DATE), MAX(DATE)
FROM [NDS_ISBI].[dbo].[AQI_NDS];

delete from [dbo].[DIM_Date]
where [Year] between 1906 and 2020;