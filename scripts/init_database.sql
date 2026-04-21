/*
=============================================================
Create Database (MySQL Version)
=============================================================
Script Purpose:
    Creates a new database named 'DataWarehouse'.
    If it already exists, it is dropped and recreated.

WARNING:
    Running this script will delete the entire 'DataWarehouse' database.
    All data will be permanently lost.
=============================================================
*/

-- Drop database if it exists
DROP DATABASE IF EXISTS DataWarehouse;

-- Create database
CREATE DATABASE DataWarehouse;

-- Use database
USE DataWarehouse;
