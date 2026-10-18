# SQL workflow

Run the scripts in numeric order. The numbered filenames indicate the intended sequence.

| Order | Script | Input | Output | Purpose |
|---:|---|---|---|---|
| 1 | `01_clean_telecom_billing.sql` | `telecom_dw.stg_telecom_billing` | `telecom_mart.clean_telecom_billing` | Casts IDs, trims/standardizes text, carries date attributes, applies financial-value rules, and adds `processed_at`. |
| 2 | `02_dim_customer.sql` | Clean table | `telecom_mart.dim_customer` | Selects distinct customer attributes and filters null customer IDs. |
| 3 | `03_dim_date.sql` | Clean table | `telecom_mart.dim_date` | Selects distinct billing date attributes and derives day of week. |
| 4 | `04_dim_location.sql` | Clean table | `telecom_mart.dim_location` | Selects distinct location ID, city, and state; filters null location IDs. |
| 5 | `05_dim_product.sql` | Clean table | `telecom_mart.dim_product` | Selects distinct product, plan, service, and monthly charge; filters null product IDs. |
| 6 | `06_fact_billing.sql` | Clean table | `telecom_mart.fact_billing` | Selects billing identifiers, dimension keys, payment status, and financial metrics. |

## Prerequisites

- The staging table already exists and contains the columns referenced in the cleaning query.
- The `telecom_mart` dataset exists.
- The executing identity has permission to read the source and create/replace destination tables.

## Checks to run after building the tables

Adapt the project/dataset names to your environment.

```sql
-- 1. Check the fact-table row count.
SELECT COUNT(*) AS fact_rows
FROM `telecom-revenue-analytics.telecom_mart.fact_billing`;

-- 2. Check for duplicate customer dimension keys.
SELECT customer_id, COUNT(*) AS rows_per_key
FROM `telecom-revenue-analytics.telecom_mart.dim_customer`
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 3. Check for duplicate product dimension keys.
SELECT product_id, COUNT(*) AS rows_per_key
FROM `telecom-revenue-analytics.telecom_mart.dim_product`
GROUP BY product_id
HAVING COUNT(*) > 1;

-- 4. Review totals and status distribution.
SELECT
  payment_status,
  COUNT(*) AS billing_rows,
  SUM(revenue_amount) AS revenue_amount,
  SUM(discount_amount) AS discount_amount,
  SUM(tax_amount) AS tax_amount,
  SUM(net_revenue) AS net_revenue
FROM `telecom-revenue-analytics.telecom_mart.fact_billing`
GROUP BY payment_status
ORDER BY payment_status;
```

These are suggested validation queries, not results already verified against the user's BigQuery environment.
