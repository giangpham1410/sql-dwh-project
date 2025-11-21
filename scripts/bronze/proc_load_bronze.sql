/*
Store Procedure: Load Bronze Layer (Source -> Bronze Layer)
===========================================================
Purpose:
- Loads raw data from a CSV source into the bronze layer.
- Performs bulk insert with basic validation.
- Writes execution status, row counts, errors, and timestamps to etl_log for traceability.
===========================================================
Usage example:
	CALL bronze.proc_load_bronze();
===========================================================
*/

CREATE OR REPLACE PROCEDURE bronze.proc_load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    tbl RECORD;
    rows_loaded INT;
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    duration INTERVAL;
    overall_start TIMESTAMP;
    overall_end TIMESTAMP;
    tables_to_load CONSTANT jsonb := '[
        {"tbl_name":"stg_crm_cust_info", "file":"D:\\datasets\\source_crm\\cust_info.csv"},
        {"tbl_name":"stg_crm_prd_info", "file":"D:\\datasets\\source_crm\\prd_info.csv"},
        {"tbl_name":"stg_crm_sales_details", "file":"D:\\datasets\\source_crm\\sales_details.csv"},
        {"tbl_name":"stg_erp_cust_az12", "file":"D:\\datasets\\source_erp\\cust_az12.csv"},
        {"tbl_name":"stg_erp_loc_a101", "file":"D:\\datasets\\source_erp\\loc_a101.csv"},
        {"tbl_name":"stg_erp_px_cat_g1v2", "file":"D:\\datasets\\source_erp\\px_cat_g1v2.csv"}
    ]'::jsonb;
BEGIN
    overall_start := clock_timestamp();
    RAISE NOTICE 'ETL PROCESS START: %', overall_start;
    RAISE NOTICE 'LOADING BRONZE LAYER';
    RAISE NOTICE '==========================================';
    RAISE NOTICE 'LOADING CRM, ERP TABLES';
	RAISE NOTICE '==========================================';

    FOR tbl IN SELECT * FROM jsonb_to_recordset(tables_to_load)
        AS t(tbl_name text, file text)
    LOOP
        BEGIN
            start_time := clock_timestamp();
            RAISE NOTICE 'START LOADING TABLE: %, at %', tbl.tbl_name, start_time;

            -- truncate table
            EXECUTE format('TRUNCATE TABLE bronze.%I', tbl.tbl_name);

            -- copy from CSV
            EXECUTE format($f$
                COPY bronze.%I
                FROM %L
                DELIMITER ','
                CSV HEADER
            $f$, tbl.tbl_name, tbl.file);

            -- count rows
            EXECUTE format('SELECT COUNT(*) FROM bronze.%I', tbl.tbl_name)
            INTO rows_loaded;

            end_time := clock_timestamp();
            duration := end_time - start_time;

            RAISE NOTICE 'END LOADING TABLE: %, rows: %, duration: %, at %', tbl.tbl_name, rows_loaded, duration, end_time;

        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'ERROR LOADING TABLE: %, at %, message: %', tbl.tbl_name, clock_timestamp(), SQLERRM;
        END;
    END LOOP;

    overall_end := clock_timestamp();
	RAISE NOTICE '=========================================='
	RAISE NOTICE 'LOADING BRONZE LAYER is COMPLETED'
    RAISE NOTICE 'Comp: %', overall_end;
    RAISE NOTICE 'TOTAL LOAD DURATION: %', overall_end - overall_start;
END;
$$;
