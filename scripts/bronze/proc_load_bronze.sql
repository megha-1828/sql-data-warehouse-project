📦 Data Warehouse - Bronze Layer Data Loading (MySQL)
📌 Overview

This script loads raw data from CSV files into the Bronze Layer of the Data Warehouse using MySQL.

The Bronze layer represents:

Raw, unprocessed data
Direct ingestion from source systems (CRM & ERP)
⚙️ Key Features
Uses LOAD DATA INFILE for fast bulk loading
Handles dirty data using:
TRIM() → removes extra spaces
REPLACE() → removes hidden characters (\r)
NULLIF() → converts empty values to NULL
Ensures clean ingestion into Bronze tables
⚠️ Prerequisites
All CSV files must be placed in:
C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
Ensure MySQL variable secure_file_priv points to this directory
🚀 Script
USE datawarehouse;

-- ================================
-- Loading CRM Tables
-- ================================

TRUNCATE TABLE bronze_crm_cust_info;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_info.csv'
INTO TABLE bronze_crm_cust_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@cst_id, @cst_key, @cst_firstname, @cst_lastname, @cst_marital_status, @cst_gndr, @cst_create_date)
SET
cst_id = NULLIF(TRIM(@cst_id), ''),
cst_key = TRIM(@cst_key),
cst_firstname = TRIM(@cst_firstname),
cst_lastname = TRIM(@cst_lastname),
cst_marital_status = TRIM(@cst_marital_status),
cst_gndr = TRIM(@cst_gndr),
cst_create_date = NULLIF(TRIM(REPLACE(@cst_create_date, '\r', '')), '');

TRUNCATE TABLE bronze_crm_prd_info;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/prd_info.csv'
INTO TABLE bronze_crm_prd_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@prd_id, @prd_key, @prd_nm, @prd_cost, @prd_line, @prd_start_dt, @prd_end_dt)
SET
prd_id = NULLIF(TRIM(@prd_id), ''),
prd_key = TRIM(@prd_key),
prd_nm = TRIM(@prd_nm),
prd_cost = NULLIF(TRIM(@prd_cost), ''),
prd_line = TRIM(@prd_line),
prd_start_dt = NULLIF(TRIM(REPLACE(@prd_start_dt, '\r', '')), ''),
prd_end_dt = NULLIF(TRIM(REPLACE(@prd_end_dt, '\r', '')), '');

TRUNCATE TABLE bronze_crm_sales_details;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_details.csv'
INTO TABLE bronze_crm_sales_details
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@sls_ord_num, @sls_prd_key, @sls_cust_id, @sls_order_dt, @sls_ship_dt, @sls_due_dt, @sls_sales, @sls_quantity, @sls_price)
SET
sls_ord_num = TRIM(@sls_ord_num),
sls_prd_key = TRIM(@sls_prd_key),
sls_cust_id = NULLIF(TRIM(@sls_cust_id), ''),
sls_order_dt = NULLIF(TRIM(REPLACE(@sls_order_dt, '\r', '')), ''),
sls_ship_dt = NULLIF(TRIM(REPLACE(@sls_ship_dt, '\r', '')), ''),
sls_due_dt = NULLIF(TRIM(REPLACE(@sls_due_dt, '\r', '')), ''),
sls_sales = NULLIF(TRIM(@sls_sales), ''),
sls_quantity = NULLIF(TRIM(@sls_quantity), ''),
sls_price = NULLIF(TRIM(REPLACE(@sls_price, '\r', '')), '');

-- ================================
-- Loading ERP Tables
-- ================================

TRUNCATE TABLE bronze_erp_loc_a101;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LOC_A101.csv'
INTO TABLE bronze_erp_loc_a101
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

TRUNCATE TABLE bronze_erp_cust_az12;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/CUST_AZ12.csv'
INTO TABLE bronze_erp_cust_az12
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@cid, @bdate, @gen)
SET
cid = TRIM(@cid),
bdate = NULLIF(TRIM(REPLACE(@bdate, '\r', '')), ''),
gen = NULLIF(TRIM(REPLACE(@gen, '\r', '')), '');

TRUNCATE TABLE bronze_erp_px_cat_g1v2;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/PX_CAT_G1V2.csv'
INTO TABLE bronze_erp_px_cat_g1v2
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- ================================
-- Verification
-- ================================

SELECT * FROM bronze_crm_cust_info;
SELECT * FROM bronze_crm_prd_info;
SELECT * FROM bronze_crm_sales_details;
SELECT * FROM bronze_erp_loc_a101;
SELECT * FROM bronze_erp_cust_az12;
SELECT * FROM bronze_erp_px_cat_g1v2;
