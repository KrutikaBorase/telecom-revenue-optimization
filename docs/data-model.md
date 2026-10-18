# Data model notes

The supplied SQL defines one billing fact table and four dimension tables. The scripts do not by themselves confirm the final Power BI relationship settings or the grain of each source record.

## Fact table: `fact_billing`

Selected fields from the supplied SQL:

- Identifiers: `revenue_id`, `invoice_id`, `subscription_id`
- Dimension keys: `customer_id`, `product_id`, `location_id`, `date`
- Status: `payment_status`
- Financial fields: `revenue_amount`, `discount_amount`, `tax_amount`, `net_revenue`

## Dimensions

### `dim_customer`

`customer_id`, `customer_name`, `gender`, `age`, `customer_type`

### `dim_date`

`date`, `month`, `quarter`, `year`, `day_of_week`

### `dim_location`

`location_id`, `city`, `state`

### `dim_product`

`product_id`, `plan_name`, `service_type`, `monthly_charge`

## Relationship checks

The intended model appears to be a star-schema-style model, with the billing fact connected to customer, product, location, and date dimensions. Verify this in Power BI before describing it as a confirmed star schema.

Recommended checks:

1. Confirm the fact table's grain (for example, one row per billing/revenue record) using the source's business definition.
2. Check uniqueness of dimension keys before establishing one-to-many relationships.
3. Check for fact rows whose foreign keys do not match a dimension row.
4. Verify the data type of the date key and all relationship columns.
5. Confirm that measures aggregate correctly without duplicate counting.

## Important modeling caveat

The dimension scripts use `SELECT DISTINCT` over multiple attributes. If a single ID appears with different attribute values, more than one row can remain for that ID. This should be tested rather than assumed away.
