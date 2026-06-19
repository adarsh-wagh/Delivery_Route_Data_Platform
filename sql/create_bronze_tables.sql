/*
___________________________________________________________________
DDL Script: Creating Bronze Tables
___________________________________________________________________

Purpose:
    - Creates raw Bronze tables.
    - Stores source data exactly as received.
    - No cleansing or validation is performed.

Source Files:
    - roads.csv
    - traffic.csv
    - weather.csv
    - trips.csv

Schema:
    bronze
___________________________________________________________________
*/


IF OBJECT_ID ('bronze.roads' , 'U') IS NOT NULL
	DROP TABLE bronze.roads;
CREATE TABLE bronze.roads (
road_id		NVARCHAR(50),
road_type	NVARCHAR(50),
num_lanes	NVARCHAR(50),
num_signals NVARCHAR(50),
zone_type	NVARCHAR(50)
);

IF OBJECT_ID ('bronze.traffic' , 'U') IS NOT NULL
	DROP TABLE bronze.traffic;
CREATE TABLE bronze.traffic (
traffic_id		NVARCHAR(50),
hour			INT,
day_of_week		NVARCHAR(50),
zone_type		NVARCHAR(50),
traffic_level	NVARCHAR(50),
avg_speed_kmph	FLOAT
);

IF OBJECT_ID ('bronze.weather' , 'U') IS NOT NULL
	DROP TABLE bronze.weather;
CREATE TABLE bronze.weather (
weather_id		NVARCHAR(50),
timestamp		NVARCHAR(50),
weather_type	NVARCHAR(50),
temperature_c	FLOAT,
visibility_km	FLOAT
);


IF OBJECT_ID ('bronze.trips' , 'U') IS NOT NULL
	DROP TABLE bronze.trips;
CREATE TABLE bronze.trips (
trip_id			NVARCHAR(50),
start_lat		FLOAT,
start_lon		FLOAT,
end_lat			FLOAT,
end_lon			FLOAT,
distance_km		FLOAT,
timestamp		NVARCHAR(50),
road_id			NVARCHAR(50),
traffic_id		NVARCHAR(50),
weather_id		NVARCHAR(50),
travel_time_min	FLOAT
);
