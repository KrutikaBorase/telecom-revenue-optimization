--Data Cleaning & Transformation
CREATE OR REPLACE TABLE `telecom-revenue-analytics.telecom_mart.clean_telecom_billing` AS
SELECT 
    -- Primary & Business Keys
    CAST(Revenue_ID AS INT64) AS revenue_id,
    CAST(Invoice_ID AS STRING) AS invoice_id,
    CAST(Customer_ID AS INT64) AS customer_id,
    CAST(Product_ID AS INT64) AS product_id,
    CAST(Location_ID AS INT64) AS location_id,
    CAST(Subscription_ID AS STRING) AS subscription_id,

    -- Customer Info
    TRIM(Customer_Name) AS customer_name,
    UPPER(TRIM(Gender)) AS gender,
    Age AS age,
    TRIM(City) AS city,
    TRIM(State) AS state,
    UPPER(TRIM(Customer_Type)) AS customer_type,

    -- Product & Plan Info
    TRIM(Plan_Name) AS plan_name,
    TRIM(Service_Type) AS service_type,
    UPPER(TRIM(Payment_Status)) AS payment_status,

    -- Financial Metrics (Safety Bounds & Rounding)
    CASE WHEN Revenue_Amount IS NULL OR Revenue_Amount < 0 THEN 0.00 ELSE ROUND(CAST(Revenue_Amount AS NUMERIC), 2) END AS revenue_amount,
    CASE WHEN Discount_Amount IS NULL OR Discount_Amount < 0 THEN 0.00 ELSE ROUND(CAST(Discount_Amount AS NUMERIC), 2) END AS discount_amount,
    CASE WHEN Tax_Amount IS NULL OR Tax_Amount < 0 THEN 0.00 ELSE ROUND(CAST(Tax_Amount AS NUMERIC), 2) END AS tax_amount,
    CASE WHEN Net_Revenue IS NULL OR Net_Revenue < 0 THEN 0.00 ELSE ROUND(CAST(Net_Revenue AS NUMERIC), 2) END AS net_revenue,
    Monthly_Charge AS monthly_charge,

    -- Date & Time Attributes
    Date AS billing_date,
    Month AS billing_month,
    Quarter AS billing_quarter,
    Year AS billing_year,

    -- Audit Metadata
    CURRENT_TIMESTAMP() AS processed_at

FROM `telecom-revenue-analytics.telecom_dw.stg_telecom_billing`
WHERE Invoice_ID IS NOT NULL 
  AND Customer_ID IS NOT NULL;