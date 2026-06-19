/*
___________________________________________________________________
Stored Procedure: bronze.load_bronze
___________________________________________________________________

Purpose:
    Loads raw CSV files into Bronze tables.

Source Files:
    - roads.csv
    - traffic.csv
    - weather.csv
    - trips.csv

Load Strategy:
    - Truncate existing Bronze tables
    - Perform full reload using BULK INSERT
    - Capture load duration
    - Handle errors using TRY/CATCH

Usage:
    EXEC bronze.load_bronze;
___________________________________________________________________
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time AS DATETIME,
			@end_time AS DATETIME;

	BEGIN TRY
		PRINT '====================================';
		PRINT '      Loading the Bronze Layer';
		PRINT '====================================';

		SET @start_time = GETDATE();
		PRINT('TRUNCATING TABLE: bronze.roads');
		TRUNCATE TABLE bronze.roads;

		PRINT('INSERTING INTO TABLE: bronze.roads');
		BULK INSERT bronze.roads
				FROM 'C:\Dataset\roads.csv'
				WITH (
					FORMAT = 'CSV',
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					ROWTERMINATOR = '0x0a');

		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------';


		SET @start_time = GETDATE();
		PRINT('TRUNCATING TABLE: bronze.traffic');
		TRUNCATE TABLE bronze.traffic;

		PRINT('INSERTING INTO TABLE: bronze.traffic');
		BULK INSERT bronze.traffic
				FROM 'C:\Dataset\traffic.csv'
				WITH (
						FORMAT = 'CSV',
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						ROWTERMINATOR = '0x0a');

		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------';
			
		SET @start_time = GETDATE();
		PRINT('TRUNCATING TABLE: bronze.weather');
		TRUNCATE TABLE bronze.weather;

		PRINT('INSERTING INTO TABLE: bronze.weather');
		BULK INSERT bronze.weather
				FROM 'C:\Dataset\weather.csv'
				WITH (
						FORMAT = 'CSV',
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						ROWTERMINATOR = '0x0a');

		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------';


		SET @start_time = GETDATE();
		PRINT('TRUNCATING TABLE: bronze.trips');
		TRUNCATE TABLE bronze.trips;

		PRINT('INSERTING INTO TABLE: bronze.trips');
		BULK INSERT bronze.trips
				FROM 'C:\Dataset\trips.csv'
				WITH (
						FORMAT = 'CSV',
						FIRSTROW = 2,
						FIELDTERMINATOR = ',',
						ROWTERMINATOR = '0x0a');

		SET @end_time = GETDATE();
		PRINT '>>LOAD DURATION: '+ CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------';

	PRINT '====================================';
	PRINT '  Bronze Layer Loaded Successfully';
	PRINT '====================================';

	END TRY
	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: '+ ERROR_MESSAGE();
		PRINT 'Error Number: '+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State: '+ CAST(ERROR_STATE() AS NVARCHAR);
	END CATCH
END;
