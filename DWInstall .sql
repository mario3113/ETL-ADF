/*As per the Microsoft Azure SDK EULA, the following assemblies can be redistributed: Microsoft.WindowsAzure.StorageClient.dll

Script Date: 10/4/2019 3:43:52 PM

User DWLoadUser    
Schema ADF 
Schema Staging 
Table ADF.DimAircraft
Table ADF.DimAirline 
Table ADF.DimAirport 
Table ADF.DimDate 
Table ADF.FactFlight 
Table dbo.DimAircraft 
Table dbo.DimAirline 
Table dbo.DimAirport
Table dbo.DimDate
Table dbo.FactFlight
Table Staging.DimAircraft 
Table Staging.DimAirline
Table Staging.DimAirport
Table Staging.FactFlight
Table Staging.Weather
StoredProcedure dbo.usp_LoadDimensions
StoredProcedure dbo.usp_LoadFact
StoredProcedure dbo.usp_TruncateStaging

*/


CREATE USER [DWLoadUser] FOR LOGIN [DWLoadUser] WITH DEFAULT_SCHEMA=[dbo]
GO
EXEC sp_addrolemember @rolename = N'largerc', @membername = N'DWLoadUser'
GO
EXEC sp_addrolemember @rolename = N'db_owner', @membername = N'DWLoadUser'
GO

CREATE SCHEMA [ADF]
GO

CREATE SCHEMA [Staging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ADF].[DimAircraft]
(
	[N-Number] [nvarchar](255) NULL,
	[Serial Number] [nvarchar](255) NULL,
	[Year MFR] [nvarchar](255) NULL,
	[MFR-NAME] [nvarchar](255) NULL,
	[MODEL-NAME] [nvarchar](255) NULL,
	[NUMBER-ENGINES] [nvarchar](255) NULL,
	[NUMBER-SEATS] [nvarchar](255) NULL,
	[Key] [int] IDENTITY(1,1) NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [N-Number] ), 
	CLUSTERED INDEX
	(
		[N-Number] ASC
	)
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ADF].[DimAirline]
(
	[Code] [int] NOT NULL,
	[Airline_Code] [varchar](100) NULL,
	[Key] [int] IDENTITY(1,1) NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [Code] ), 
	CLUSTERED INDEX
	(
		[Code] ASC
	)
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ADF].[DimAirport]
(
	[Code] [varchar](50) NULL,
	[City_Airport] [varchar](100) NULL,
	[Key] [int] IDENTITY(1,1) NOT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [Code] ), 
	CLUSTERED INDEX
	(
		[Code] ASC
	)
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ADF].[DimDate]
(
	[DateKey] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Day Number] [int] NOT NULL,
	[Day] [nvarchar](10) NOT NULL,
	[Month] [nvarchar](10) NOT NULL,
	[Short Month] [nvarchar](3) NOT NULL,
	[Calendar Month Number] [int] NOT NULL,
	[Calendar Month Label] [nvarchar](20) NOT NULL,
	[Calendar Year] [int] NOT NULL,
	[Calendar Year Label] [nvarchar](10) NOT NULL,
	[Fiscal Month Number] [int] NOT NULL,
	[Fiscal Month Label] [nvarchar](20) NOT NULL,
	[Fiscal Year] [int] NOT NULL,
	[Fiscal Year Label] [nvarchar](10) NOT NULL,
	[ISO Week Number] [int] NOT NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ADF].[FactFlight]
(
	[FlightDateKey] [int] NOT NULL,
	[AircraftKey] [int] NOT NULL,
	[UNIQUE_CARRIER] [varchar](50) NULL,
	[AirlineKey] [int] NOT NULL,
	[CARRIER] [varchar](50) NULL,
	[FL_NUM] [int] NOT NULL,
	[ORIGIN_AIRPORT_ID] [int] NOT NULL,
	[ORIGIN_AIRPORT_SEQ_ID] [int] NULL,
	[ORIGIN_CITY_MARKET_ID] [int] NULL,
	[DEST_AIRPORT_ID] [int] NOT NULL,
	[DEST_AIRPORT_SEQ_ID] [int] NULL,
	[DEST_CITY_MARKET_ID] [int] NULL,
	[DEP_TIME] [varchar](50) NULL,
	[DEP_DELAY] [float] NULL,
	[DEP_DELAY_NEW] [float] NULL,
	[TAXI_OUT] [float] NULL,
	[WHEELS_OFF] [varchar](50) NULL,
	[WHEELS_ON] [varchar](50) NULL,
	[TAXI_IN] [float] NULL,
	[ARR_TIME] [varchar](50) NULL,
	[ARR_DELAY] [float] NULL,
	[ARR_DELAY_NEW] [float] NULL,
	[CANCELLED] [bit] NULL,
	[CANCELLATION_CODE] [varchar](50) NULL,
	[ACTUAL_ELAPSED_TIME] [float] NULL,
	[AIR_TIME] [float] NULL,
	[FLIGHTS] [int] NULL,
	[DISTANCE] [int] NULL,
	[CARRIER_DELAY] [float] NULL,
	[WEATHER_DELAY] [float] NULL,
	[NAS_DELAY] [float] NULL,
	[SECURITY_DELAY] [float] NULL,
	[LATE_AIRCRAFT_DELAY] [float] NULL,
	[DestAirportKey] [int] NULL,
	[OriginAirportKey] [int] NULL,
	[DestAirportTempF] [int] NULL,
	[OriginAirportTempF] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimAircraft]
(
	[Key] [int] IDENTITY(1,1) NOT NULL,
	[N-Number] [nvarchar](255) NULL,
	[Serial Number] [nvarchar](255) NULL,
	[MFR MDL Code] [nvarchar](255) NULL,
	[Eng MFR Code] [nvarchar](255) NULL,
	[Year MFR] [nvarchar](255) NULL,
	[Type Registrant] [nvarchar](255) NULL,
	[Last Activity Date] [nvarchar](255) NULL,
	[Cert Issue Date] [nvarchar](255) NULL,
	[Type Aircraft] [nvarchar](255) NULL,
	[Type Engine] [nvarchar](255) NULL,
	[Status Code] [nvarchar](255) NULL,
	[Mode S Code] [nvarchar](255) NULL,
	[Airworthiness Date] [nvarchar](255) NULL,
	[Unique ID] [nvarchar](255) NULL,
	[Kit MFR Code] [nvarchar](255) NULL,
	[Kit Model] [nvarchar](255) NULL,
	[MFR-NAME] [nvarchar](255) NULL,
	[MODEL-NAME] [nvarchar](255) NULL,
	[TYPE-AIRCRAFT] [nvarchar](255) NULL,
	[TYPE-ENGINE] [nvarchar](255) NULL,
	[AC-CATEGORY] [nvarchar](255) NULL,
	[AMAT-TC-BUILT] [nvarchar](255) NULL,
	[NUMBER-ENGINES] [nvarchar](255) NULL,
	[NUMBER-SEATS] [nvarchar](255) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimAirline]
(
	[Key] [int] IDENTITY(1,1) NOT NULL,
	[Code] [int] NOT NULL,
	[Airline_Code] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimAirport]
(
	[Key] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NULL,
	[City_Airport] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDate]
(
	[DateKey] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Day Number] [int] NOT NULL,
	[Day] [nvarchar](10) NOT NULL,
	[Month] [nvarchar](10) NOT NULL,
	[Short Month] [nvarchar](3) NOT NULL,
	[Calendar Month Number] [int] NOT NULL,
	[Calendar Month Label] [nvarchar](20) NOT NULL,
	[Calendar Year] [int] NOT NULL,
	[Calendar Year Label] [nvarchar](10) NOT NULL,
	[Fiscal Month Number] [int] NOT NULL,
	[Fiscal Month Label] [nvarchar](20) NOT NULL,
	[Fiscal Year] [int] NOT NULL,
	[Fiscal Year Label] [nvarchar](10) NOT NULL,
	[ISO Week Number] [int] NOT NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactFlight]
(
	[FlightDateKey] [int] NOT NULL,
	[AircraftKey] [int] NOT NULL,
	[UNIQUE_CARRIER] [varchar](50) NULL,
	[AirlineKey] [int] NOT NULL,
	[CARRIER] [varchar](50) NULL,
	[FL_NUM] [int] NOT NULL,
	[ORIGIN_AIRPORT_ID] [int] NOT NULL,
	[ORIGIN_AIRPORT_SEQ_ID] [int] NULL,
	[ORIGIN_CITY_MARKET_ID] [int] NULL,
	[DEST_AIRPORT_ID] [int] NOT NULL,
	[DEST_AIRPORT_SEQ_ID] [int] NULL,
	[DEST_CITY_MARKET_ID] [int] NULL,
	[DEP_TIME] [varchar](50) NULL,
	[DEP_DELAY] [float] NULL,
	[DEP_DELAY_NEW] [float] NULL,
	[TAXI_OUT] [float] NULL,
	[WHEELS_OFF] [varchar](50) NULL,
	[WHEELS_ON] [varchar](50) NULL,
	[TAXI_IN] [float] NULL,
	[ARR_TIME] [varchar](50) NULL,
	[ARR_DELAY] [float] NULL,
	[ARR_DELAY_NEW] [float] NULL,
	[CANCELLED] [bit] NULL,
	[CANCELLATION_CODE] [varchar](50) NULL,
	[ACTUAL_ELAPSED_TIME] [float] NULL,
	[AIR_TIME] [float] NULL,
	[FLIGHTS] [int] NULL,
	[DISTANCE] [int] NULL,
	[CARRIER_DELAY] [float] NULL,
	[WEATHER_DELAY] [float] NULL,
	[NAS_DELAY] [float] NULL,
	[SECURITY_DELAY] [float] NULL,
	[LATE_AIRCRAFT_DELAY] [float] NULL,
	[DestAirportKey] [int] NULL,
	[OriginAirportKey] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[DimAircraft]
(
	[N-Number] [nvarchar](255) NULL,
	[Serial Number] [nvarchar](255) NULL,
	[Year MFR] [nvarchar](255) NULL,
	[MFR-NAME] [nvarchar](255) NULL,
	[MODEL-NAME] [nvarchar](255) NULL,
	[NUMBER-ENGINES] [nvarchar](255) NULL,
	[NUMBER-SEATS] [nvarchar](255) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[DimAirline]
(
	[Code] [int] NOT NULL,
	[Airline_Code] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[DimAirport]
(
	[Code] [varchar](50) NULL,
	[City_Airport] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[FactFlight]
(
	[YEAR] [smallint] NULL,
	[MONTH] [smallint] NULL,
	[FL_DATE] [datetime] NOT NULL,
	[UNIQUE_CARRIER] [varchar](50) NULL,
	[AIRLINE_ID] [int] NOT NULL,
	[CARRIER] [varchar](50) NULL,
	[TAIL_NUM] [varchar](50) NULL,
	[FL_NUM] [int] NOT NULL,
	[ORIGIN_AIRPORT_ID] [int] NOT NULL,
	[ORIGIN_AIRPORT_SEQ_ID] [int] NULL,
	[ORIGIN_CITY_MARKET_ID] [int] NULL,
	[DEST_AIRPORT_ID] [int] NOT NULL,
	[DEST_AIRPORT_SEQ_ID] [int] NULL,
	[DEST_CITY_MARKET_ID] [int] NULL,
	[DEP_TIME] [varchar](50) NULL,
	[DEP_DELAY] [float] NULL,
	[DEP_DELAY_NEW] [float] NULL,
	[TAXI_OUT] [float] NULL,
	[WHEELS_OFF] [varchar](50) NULL,
	[WHEELS_ON] [varchar](50) NULL,
	[TAXI_IN] [float] NULL,
	[ARR_TIME] [varchar](50) NULL,
	[ARR_DELAY] [float] NULL,
	[ARR_DELAY_NEW] [float] NULL,
	[CANCELLED] [bit] NULL,
	[CANCELLATION_CODE] [varchar](50) NULL,
	[ACTUAL_ELAPSED_TIME] [float] NULL,
	[AIR_TIME] [float] NULL,
	[FLIGHTS] [int] NULL,
	[DISTANCE] [int] NULL,
	[CARRIER_DELAY] [float] NULL,
	[WEATHER_DELAY] [float] NULL,
	[NAS_DELAY] [float] NULL,
	[SECURITY_DELAY] [float] NULL,
	[LATE_AIRCRAFT_DELAY] [float] NULL,
	[DEST_CODE] [varchar](50) NULL,
	[ORIGIN_CODE] [varchar](50) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[Weather]
(
	[_id] [varchar](255) NULL,
	[weatherDate] [varchar](100) NULL,
	[weatherDateInt] [int] NULL,
	[airportCode] [varchar](10) NULL,
	[temperatureF] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_LoadDimensions] AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	--UPSERT DimAircraft
	CREATE TABLE ADF.DimAircraft_Upsert
	WITH
	(
	DISTRIBUTION = HASH([N-Number]), CLUSTERED INDEX ([N-Number])
	)
	AS
	--incoming records
	SELECT 
	   S.[N-Number]
      ,S.[Serial Number]
      ,S.[Year MFR]
      ,S.[MFR-NAME]
      ,S.[MODEL-NAME]
      ,S.[NUMBER-ENGINES]
      ,S.[NUMBER-SEATS]
	FROM [Staging].[DimAircraft] as S
	UNION ALL
	--Keep existing rows not incoming
	SELECT 
	   T.[N-Number]
      ,T.[Serial Number]
      ,T.[Year MFR]
      ,T.[MFR-NAME]
      ,T.[MODEL-NAME]
      ,T.[NUMBER-ENGINES]
      ,T.[NUMBER-SEATS]
	FROM ADF.[DimAircraft] as T
	WHERE NOT EXISTS
	(
		SELECT *
		FROM [Staging].[DimAircraft] S
		WHERE S.[N-Number] = T.[N-Number]
	);

	RENAME OBJECT ADF.DimAircraft to DimAircraft_old;
	RENAME OBJECT ADF.DimAircraft_Upsert to DimAircraft;
	DROP TABLE ADF.DimAircraft_old;
	Alter Table ADF.DimAircraft ADD [Key] INT identity(1,1) NOT NULL;

	--UPSERT DimAirline
	CREATE TABLE ADF.DimAirline_Upsert
	WITH
	(
	DISTRIBUTION = HASH([Code]), CLUSTERED INDEX ([Code])
	)
	AS
	--incoming records
	SELECT 
	   S.[Code]
      ,S.[Airline_Code]
	FROM Staging.DimAirline as S
	UNION ALL
	--Keep existing rows not incoming
	SELECT 
	   T.[Code]
      ,T.[Airline_Code]
	FROM ADF.DimAirline as T
	WHERE NOT EXISTS
	(
		SELECT *
		FROM Staging.DimAirline S
		WHERE S.[Code] = T.[Code]
	);

	RENAME OBJECT ADF.DimAirline to DimAirline_old;
	RENAME OBJECT ADF.DimAirline_Upsert to DimAirline;
	DROP TABLE ADF.DimAirline_old;
	Alter Table ADF.DimAirline ADD [Key] INT identity(1,1) NOT NULL;

	--UPSERT DimAirport
	CREATE TABLE ADF.DimAirport_Upsert
	WITH
	(
	DISTRIBUTION = HASH([Code]), CLUSTERED INDEX ([Code])
	)
	AS
	--incoming records
	SELECT 
	   S.[Code]
      ,S.[City_Airport]
	FROM Staging.DimAirport as S
	UNION ALL
	--Keep existing rows not incoming
	SELECT 
	   T.[Code]
      ,T.[City_Airport]
	FROM ADF.DimAirport as T
	WHERE NOT EXISTS
	(
		SELECT *
		FROM Staging.DimAirport S
		WHERE S.[Code] = T.[Code]
	);

	RENAME OBJECT ADF.DimAirport to DimAirport_old;
	RENAME OBJECT ADF.DimAirport_Upsert to DimAirport;
	DROP TABLE ADF.DimAirport_old;
	Alter Table ADF.DimAirport ADD [Key] INT identity(1,1) NOT NULL;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_LoadFact] AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
	
	--TRUNCATE DimDate, Add date data. Assumes Module 2 was ran to load DBO.DimDate
	TRUNCATE TABLE ADF.DimDate
	
	INSERT INTO [ADF].[DimDate]
		   ([DateKey]
		   ,[Date]
		   ,[Day Number]
		   ,[Day]
		   ,[Month]
		   ,[Short Month]
		   ,[Calendar Month Number]
		   ,[Calendar Month Label]
		   ,[Calendar Year]
		   ,[Calendar Year Label]
		   ,[Fiscal Month Number]
		   ,[Fiscal Month Label]
		   ,[Fiscal Year]
		   ,[Fiscal Year Label]
		   ,[ISO Week Number])
	SELECT [DateKey]
		  ,[Date]
		  ,[Day Number]
		  ,[Day]
		  ,[Month]
		  ,[Short Month]
		  ,[Calendar Month Number]
		  ,[Calendar Month Label]
		  ,[Calendar Year]
		  ,[Calendar Year Label]
		  ,[Fiscal Month Number]
		  ,[Fiscal Month Label]
		  ,[Fiscal Year]
		  ,[Fiscal Year Label]
		  ,[ISO Week Number]
	  FROM [dbo].[DimDate]
	
	DECLARE @CurrentFactMaxDate datetime =
		(SELECT COALESCE(MAX(D.Date),'1/1/1901') 
		FROM
		ADF.FactFlight F INNER JOIN ADF.DimDate D
		ON F.FlightDateKey = D.DateKey);

	INSERT INTO [ADF].[FactFlight]
           ([FlightDateKey]
           ,[AircraftKey]
           ,[UNIQUE_CARRIER]
           ,[AirlineKey]
           ,[CARRIER]
           ,[FL_NUM]
           ,[ORIGIN_AIRPORT_ID]
           ,[ORIGIN_AIRPORT_SEQ_ID]
           ,[ORIGIN_CITY_MARKET_ID]
           ,[DEST_AIRPORT_ID]
           ,[DEST_AIRPORT_SEQ_ID]
           ,[DEST_CITY_MARKET_ID]
           ,[DEP_TIME]
           ,[DEP_DELAY]
           ,[DEP_DELAY_NEW]
           ,[TAXI_OUT]
           ,[WHEELS_OFF]
           ,[WHEELS_ON]
           ,[TAXI_IN]
           ,[ARR_TIME]
           ,[ARR_DELAY]
           ,[ARR_DELAY_NEW]
           ,[CANCELLED]
           ,[CANCELLATION_CODE]
           ,[ACTUAL_ELAPSED_TIME]
           ,[AIR_TIME]
           ,[FLIGHTS]
           ,[DISTANCE]
           ,[CARRIER_DELAY]
           ,[WEATHER_DELAY]
           ,[NAS_DELAY]
           ,[SECURITY_DELAY]
           ,[LATE_AIRCRAFT_DELAY]
           ,[DestAirportKey]
           ,[OriginAirportKey]
           ,[DestAirportTempF]
           ,[OriginAirportTempF])
     SELECT
			COALESCE(D.DateKey,-1)
		   ,COALESCE(A.[Key],-1)
		   ,S.[UNIQUE_CARRIER]
		   ,COALESCE(AL.[Key],-1)
           ,S.[CARRIER]
           ,S.[FL_NUM]
           ,S.[ORIGIN_AIRPORT_ID]
           ,S.[ORIGIN_AIRPORT_SEQ_ID]
           ,S.[ORIGIN_CITY_MARKET_ID]
           ,S.[DEST_AIRPORT_ID]
           ,S.[DEST_AIRPORT_SEQ_ID]
           ,S.[DEST_CITY_MARKET_ID]
           ,S.[DEP_TIME]
           ,S.[DEP_DELAY]
           ,S.[DEP_DELAY_NEW]
           ,S.[TAXI_OUT]
           ,S.[WHEELS_OFF]
           ,S.[WHEELS_ON]
           ,S.[TAXI_IN]
           ,S.[ARR_TIME]
           ,S.[ARR_DELAY]
           ,S.[ARR_DELAY_NEW]
           ,S.[CANCELLED]
           ,S.[CANCELLATION_CODE]
           ,S.[ACTUAL_ELAPSED_TIME]
           ,S.[AIR_TIME]
           ,S.[FLIGHTS]
           ,S.[DISTANCE]
           ,S.[CARRIER_DELAY]
           ,S.[WEATHER_DELAY]
           ,S.[NAS_DELAY]
           ,S.[SECURITY_DELAY]
           ,S.[LATE_AIRCRAFT_DELAY]
		   ,COALESCE(DestA.[Key],-1)
		   ,COALESCE(OriginA.[Key],-1)
		   ,DestW.temperatureF
		   ,OriginW.temperatureF
	 FROM Staging.FactFlight S
	 --Flight date lookup
	 LEFT OUTER JOIN ADF.DimDate D
	 ON S.FL_Date = D.[Date]
	 --Aircraft lookup
	 LEFT OUTER JOIN ADF.DimAircraft A
	 ON S.TAIL_NUM = 'N'+A.[N-Number]
	 --Airline Lookup
	 LEFT OUTER JOIN ADF.DimAirline AL
	 ON S.Airline_ID = AL.Code
	 --Dest airport lookup
	 LEFT OUTER JOIN ADF.DimAirport DestA
	 ON S.Dest_Code = DestA.Code
	 --Origin airport lookup
	 LEFT OUTER JOIN ADF.DimAirport OriginA
	 ON S.Origin_Code = OriginA.Code
	 --Dest weather lookup
	 LEFT OUTER JOIN Staging.Weather DestW
	 ON S.Dest_Code = DestW.airportCode 
		AND D.DateKey = DestW.weatherDateInt
	--Origin weather lookup
	 LEFT OUTER JOIN Staging.Weather OriginW
	 ON S.Origin_Code = OriginW.airportCode 
		AND D.DateKey = OriginW.weatherDateInt
	 WHERE S.FL_DATE > @CurrentFactMaxDate;

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_TruncateStaging] AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    TRUNCATE TABLE Staging.DimAircraft;
	TRUNCATE TABLE Staging.DimAirline;
	TRUNCATE TABLE Staging.DimAirport;
	TRUNCATE TABLE Staging.FactFlight;
	TRUNCATE TABLE Staging.Weather;
END
GO
