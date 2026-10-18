--Create dim_customer
CREATE OR REPLACE TABLE `telecom-revenue-analytics.telecom_mart.dim_customer` AS
SELECT DISTINCT
    customer_id,
    customer_name,
    gender,
    age,
    customer_type
FROM `telecom-revenue-analytics.telecom_mart.clean_telecom_billing`
WHERE customer_id IS NOT NULL;
