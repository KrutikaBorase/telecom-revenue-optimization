--dim_date
CREATE OR REPLACE TABLE `telecom-revenue-analytics.telecom_mart.dim_date` AS
SELECT DISTINCT
    billing_date AS date,
    billing_month AS month,
    billing_quarter AS quarter,
    billing_year AS year,
    FORMAT_DATE('%A', billing_date) AS day_of_week
FROM `telecom-revenue-analytics.telecom_mart.clean_telecom_billing`
WHERE billing_date IS NOT NULL;

