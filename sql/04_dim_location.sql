
--dim_location
CREATE OR REPLACE TABLE `telecom-revenue-analytics.telecom_mart.dim_location` AS
SELECT DISTINCT
    location_id,
    city,
    state
FROM `telecom-revenue-analytics.telecom_mart.clean_telecom_billing`
WHERE location_id IS NOT NULL;

