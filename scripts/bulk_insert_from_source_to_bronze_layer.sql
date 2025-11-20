TRUNCATE TABLE bronze.stg_crm_cust_info;

COPY bronze.stg_crm_cust_info
FROM 'D:\datasets\source_crm\cust_info.csv'
DELIMITER ','
CSV HEADER
;


TRUNCATE TABLE bronze.stg_crm_prd_info;
COPY bronze.stg_crm_prd_info
FROM 'D:\datasets\source_crm\prd_info.csv'
DELIMITER ','
CSV HEADER
;


TRUNCATE TABLE bronze.stg_crm_sales_details;
COPY bronze.stg_crm_sales_details
FROM 'D:\datasets\source_crm\sales_details.csv'
DELIMITER ','
CSV HEADER
;


TRUNCATE TABLE bronze.stg_erp_cust_az12;
COPY bronze.stg_erp_cust_az12
FROM 'D:\datasets\source_erp\cust_az12.csv'
DELIMITER ','
CSV HEADER
;


TRUNCATE TABLE bronze.stg_erp_loc_a101;
COPY bronze.stg_erp_loc_a101
FROM 'D:\datasets\source_erp\loc_a101.csv'
DELIMITER ','
CSV HEADER
;


TRUNCATE TABLE bronze.stg_erp_px_cat_g1v2;
COPY bronze.stg_erp_px_cat_g1v2
FROM 'D:\datasets\source_erp\px_cat_g1v2.csv'
DELIMITER ','
CSV HEADER
;
