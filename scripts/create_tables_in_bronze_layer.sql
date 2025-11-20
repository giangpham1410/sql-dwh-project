DROP TABLE IF EXISTS bronze.stg_crm_cust_info;
CREATE TABLE bronze.stg_crm_cust_info (
	cst_id INT
	, cst_key VARCHAR(50)
	, cst_firstname VARCHAR(50)
	, cst_lastname VARCHAR(100)
	, cst_marital_status VARCHAR(1)
	, cst_gndr VARCHAR(1)
	, cst_create_date TIMESTAMP
);


DROP TABLE IF EXISTS bronze.stg_crm_prd_info;
CREATE TABLE bronze.stg_crm_prd_info (
	prd_id INT
	, prd_key VARCHAR(50)
	, prd_nm VARCHAR(100)
	, prd_cost NUMERIC
	, prd_line VARCHAR(1)
	, prd_start_dt TIMESTAMP
	, prd_end_dt TIMESTAMP
);


DROP TABLE IF EXISTS bronze.stg_crm_sales_details;
CREATE TABLE bronze.stg_crm_sales_details (
	sls_ord_num VARCHAR(50)
	, sls_prd_key VARCHAR(50)
	, sls_cust_id INT
	, sls_order_dt INT
	, sls_ship_dt INT
	, sls_due_dt INT
	, sls_sales NUMERIC
	, sls_quantity INT
	, sls_price NUMERIC
);


DROP TABLE IF EXISTS bronze.stg_erp_cust_az12;
CREATE TABLE bronze.stg_erp_cust_az12 (
	cid VARCHAR(50)
	, bdate TIMESTAMP
	, gen VARCHAR (10)
);


DROP TABLE IF EXISTS bronze.stg_erp_loc_a101;
CREATE TABLE bronze.stg_erp_loc_a101 (
	cid VARCHAR(50)
	, cntry VARCHAR(50)
);


DROP TABLE IF EXISTS bronze.stg_erp_px_cat_g1v2;
CREATE TABLE bronze.stg_erp_px_cat_g1v2 (
	id VARCHAR(10)
	, cat VARCHAR(50)
	, subcat VARCHAR(50)
	, maintenance VARCHAR(5)
);
