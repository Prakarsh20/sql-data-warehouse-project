/*
===============================================================================
Quality Checks - Silver Layer
===============================================================================
Purpose:
    Validates data quality, consistency, accuracy, and standardization
    across Silver layer tables.

Checks:
    - NULLs and duplicate keys
    - Unwanted spaces
    - Data standardization
    - Invalid dates and ranges
    - Consistency between related fields
===============================================================================
*/
-- check for nulls and duplicates in primary key
-- Expectation: No Result
select cst_id, count(*) from bronze.crm_cust_info 
group by cst_id
having count(*)>1 or cst_id is Null;

-- check for unwanted spaces
-- Expectations: No Result
select cst_firstname
from bronze.crm_cust_info
where cst_firstname !=Trim(cst_firstname)
-- this confirms that it has even spaces in firstname and lastname

-- data standardization and consistency:
select distinct cst_gndr from bronze.crm_cust_info;
------------------------------------------------------------------------------------------------------------------
-- data cleansing and transformation
/* from the below query , we get that if we put,flag_last =1, then we get the exact 1 primary key values,as in 
latest creation date as the one,which gets selected from the duplicate ones
*/

/* 
select * from(
select *,
row_number() over(partition by cst_id order by cst_create_date DESC) as flag_last
from bronze.crm_cust_info ) t 
where flag_last!=1; 
*/
-- where cst_id=29466; 
-- it is one of those duplicate values having multiple results and we can take it  acc to the most Latest creation_Date
-- in results we get flag_last as 1,means that those primary key only existed once
select * from (
select *,
ROW_NUMBER() over(partition by cst_id order by cst_create_date) as flag_last
from bronze.crm_cust_info
) t 
where flag_last=1;
------------------------------------------------------------------------------------------------------------------
SELECT 
	prd_id,      
	prd_key,         
	prd_nm,      
	prd_cost,       
	prd_line,
	prd_start_dt,
	prd_end_dt  
FROM bronze.crm_prd_info;
--------------------------------------------
-- FOR PRD_INFO

SELECT prd_id,
COUNT(*) FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*)>1 OR prd_id IS NULL;
-- it was perfect,no duplicates

-- check for unwanted spaces
select prd_nm from silver.crm_prd_info
where prd_nm!=trim(prd_nm);
-- it is also perfect

-- check for nulls and negative numbers
select prd_cost from silver.crm_prd_info
where prd_cost IS NULL or prd_cost<0;
-- we can replace the nUll with 0,in the another main query
select distinct prd_line from silver.crm_prd_info;
-- we can rename them using case-when in main query

-- check for invalid date orders
select * from 
silver.crm_prd_info 
where prd_start_dt < prd_end_dt;
-----
select * from silver.crm_prd_info;
------------------------------------------------------------------------------------------------------
-- FOR SALES TABLE:

SELECT
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
FROM bronze.crm_sales_details
/*WHERE sls_ord_num!= TRIM(sls_ord_num);
WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);
WHERE sls_cust_id NOT IN(SELECT cst_id from silver.crm_cust_info)*/
-- we have exected all 3 above to check the data quality and they're perfect
-- --- ------- --------- ----------- --------- ---------- ----------- ------------ -----------
-- check for invalid dates in sales_details:
select
nullif(sls_order_dt,0) -- lots of values are 0,so it changes 0 to Null
from bronze.crm_sales_details
where sls_order_dt<=0
or len(sls_order_dt) !=8  -- if we checl dates,they're like 20100101 means length should be 8,not more or less than 8
or (sls_order_dt) >20500101
or (sls_order_dt) <19000101
;
-- FOR SHIPPING DATES CHECK and DUE_DT check: Both Perfect
select
nullif(sls_ship_dt,0) -- lots of values are 0,so it changes 0 to Null
from bronze.crm_sales_details
where sls_ship_dt<=0
or len(sls_ship_dt) !=8  -- if we checl dates,they're like 20100101 means length should be 8,not more or less than 8
or (sls_ship_dt) >20500101
or (sls_ship_dt) <19000101
-- Both are perfect,but maybe in future it causes any prb.,so we apply CASE WHEN in main query

-- Check for invalid order dates: IT IS ALSO PERFECT
select * from bronze.crm_sales_details
where sls_order_dt>sls_ship_dt or sls_order_dt > sls_due_dt;
--------------
/* CHECK Data Consistency:Between sales,quantity and price
sales= quantity * price*/

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL
OR sls_quantity IS NULL
OR sls_price IS NULL
OR sls_sales <= 0
OR sls_quantity <= 0
OR sls_price <= 0;
-- from abovw we found it's a Bad data,even values are 0,-ve 
-- correcting data:
SELECT DISTINCT
sls_sales as old_sls_sales,
sls_quantity,
sls_price as old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales<=0 OR sls_sales!=sls_quantity* ABS(sls_price) 
     THEN sls_quantity* ABS(sls_price) 
     ELSE sls_sales 
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price<=0 
     THEN sls_sales/ NULLIF(sls_quantity,0) -- makes 0 in denominator as null
     ELSE sls_price
END AS sls_price 
FROM silver.crm_sales_details -- we are changing it to silver,previosly we're checking on bronze.crm,but after inserting values,we chamge it for Quality check
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales,sls_quantity,sls_price;

select * from silver.crm_sales_details;
----------------------------------------------------------------------------------------------
-- for erp_cust_az12 Table:
select cid,
case when cid like 'NAS%' then substring(cid,4,len(cid))
     else cid
END AS cid,
bdate,gen 
from bronze.erp_cust_az12;
-- for birthdate: it's bad data,as it has future values like 2050
select
case when cid like 'NAS%' then substring(cid,4,len(cid))
     else cid
END AS cid,
CASE WHEN bdate> GETDATE() THEN NULL
     ELSE bdate
END AS bdate,
bdate,gen 
from bronze.erp_cust_az12;
-- for gender :
select distinct gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'FEMALE'
     WHEN UPPER(TRIM(gen)) IN ('M','MALE') THEN 'MALE'
     ELSE 'n/a'
END AS gen
from bronze.erp_cust_az12;
-------------------------------------------------------------------------
-- FOR erp_px_cat_g1v2: IT'S CLEANED already
-- check for unwanted spaces
select * from bronze.erp_px_cat_g1v2 
where cat != trim(cat) OR subcat!= trim(subcat) OR maintenance!=trim(maintenance);
-- DATA STANDARIZATION AND CONSISTENCY: great data quality,all are well organized
select distinct
cat
from bronze.erp_px_cat_g1v2;
select distinct 
subcat
from bronze.erp_px_cat_g1v2;
select distinct 
maintenance
from bronze.erp_px_cat_g1v2;
-- after adding it to Silver layer,final checking this table:
SELECT * FROM silver.erp_px_cat_g1v2;
