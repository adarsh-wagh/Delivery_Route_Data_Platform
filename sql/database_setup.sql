/*
___________________________________________________________________
Database Setup Script
___________________________________________________________________

Purpose:
    - Creates the DeliveryAnalyticsDW database
    - Drops existing database if present
    - Creates Bronze, Silver, and Gold schemas

Schemas:
    bronze - Raw Source Data
    silver - Cleaned and Validated Data
    gold   - Business Ready Analytics Layer

Usage:
    Execute before running Bronze, Silver, and Gold scripts.
___________________________________________________________________
*/

USE MASTER;
GO

--Drop and Recreate the 'DeliveryAnalyticsDW' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DeliveryAnalyticsDW')
BEGIN 
	ALTER DATABASE DeliveryAnalyticsDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DeliveryAnalyticsDW;
END;
GO

--Creating the 'DeliveryAnalyticsDW' database
CREATE DATABASE DeliveryAnalyticsDW;
GO


USE DeliveryAnalyticsDW;
GO

--Creating schemas
CREATE SCHEMA bronze;
GO


CREATE SCHEMA silver;
GO


CREATE SCHEMA gold;
GO
