--dim_product
CREATE OR REPLACE TABLE `telecom-revenue-analytics.telecom_mart.dim_product` AS
SELECT DISTINCT
    product_id,
    plan_name,
    service_type,
    monthly_charge
FROM `telecom-revenue-analytics.telecom_mart.clean_telecom_billing`
WHERE product_id IS NOT NULL;
