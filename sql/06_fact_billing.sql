--Revenue Fact Table
CREATE OR REPLACE TABLE `telecom-revenue-analytics.telecom_mart.fact_billing` AS
SELECT
    revenue_id,
    invoice_id,
    subscription_id,
    
    -- Foreign Keys to Dimension Tables
    customer_id,
    product_id,
    location_id,
    billing_date AS date,

    -- Categorical Status
    payment_status,

    -- Financial Metrics
    revenue_amount,
    discount_amount,
    tax_amount,
    net_revenue
FROM `telecom-revenue-analytics.telecom_mart.clean_telecom_billing`;
