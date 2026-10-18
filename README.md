# Telecom Revenue Optimization | BigQuery + Power BI

A telecom billing analytics project that transforms billing records in **Google BigQuery** into a dimensional reporting model and presents revenue-related analysis in **Power BI**.

> **Project status:** SQL scripts and the Power BI report are included. Validate the queries against your BigQuery environment and review the report/data-source settings before publishing this repository publicly.

## Project overview

The SQL workflow starts from a staging table, cleans and standardizes billing data, creates dimension tables, and builds a billing fact table for analysis.

The supplied Power BI report contains these report pages:

- Executive Dashboard
- Revenue Performance
- Revenue Leakage
- Discount Impact
- Customer Details

The page names describe the report structure; specific business findings and numerical results should be added only after validating the dashboard and underlying data.

## Technology stack

- **Google BigQuery SQL** — data cleaning, transformation, and dimensional tables
- **Power BI** — dashboarding and business reporting
- **Dimensional modeling** — customer, date, location, and product dimensions linked to billing facts

## Repository structure

```text
telecom-revenue-optimization/
├── README.md
├── .gitignore
├── sql/
│   ├── 01_clean_telecom_billing.sql
│   ├── 02_dim_customer.sql
│   ├── 03_dim_date.sql
│   ├── 04_dim_location.sql
│   ├── 05_dim_product.sql
│   └── 06_fact_billing.sql
├── powerbi/
│   └── Telecom_revenue_optimization.pbix
└── docs/
    ├── data-model.md
    └── sql-workflow.md
```

## Data workflow

1. **Read staging data** from `telecom_dw.stg_telecom_billing`.
2. **Clean and standardize records** into `telecom_mart.clean_telecom_billing`.
3. **Create dimensions** for customer, date, location, and product.
4. **Create the billing fact table** with billing identifiers, dimension keys, payment status, and financial measures.
5. **Explore the report** in Power BI across the five supplied pages.

See [`docs/sql-workflow.md`](docs/sql-workflow.md) and [`docs/data-model.md`](docs/data-model.md) for details.

## BigQuery setup

The uploaded SQL references the following BigQuery objects:

- Source table: `telecom-revenue-analytics.telecom_dw.stg_telecom_billing`
- Clean table: `telecom-revenue-analytics.telecom_mart.clean_telecom_billing`
- Output dimensions: `dim_customer`, `dim_date`, `dim_location`, `dim_product`
- Output fact table: `fact_billing`

Before running the scripts:

1. Ensure the staging table exists and its columns match the fields used in `sql/01_clean_telecom_billing.sql`.
2. Ensure you have permission to create or replace tables in the target dataset.
3. Review the project and dataset names in each SQL file. Replace them with your own BigQuery project/dataset identifiers if needed.
4. Run the scripts in order, from `01` to `06`.
5. Run validation queries and confirm the model's keys and totals before connecting or refreshing Power BI.

**Important:** The scripts use `CREATE OR REPLACE TABLE`, which replaces the named output table each time they run. Do not run them against production tables without understanding the impact.

## Data-quality and modeling notes

The cleaning script trims and standardizes text, casts identifiers, and replaces null or negative revenue, discount, tax, and net-revenue values with zero. This is the behavior of the supplied SQL, not a guarantee that zero is the correct business treatment for every invalid value.

Before using the model for decision-making, validate:

- Whether replacing missing/negative financial values with zero is appropriate for the business rules.
- Whether each dimension has exactly one row per key.
- Whether `net_revenue` reconciles with the source definition of revenue, discount, and tax.
- Whether billing dates and date attributes are consistent.
- Whether Power BI relationships use the intended keys and cardinalities.
- Whether the fact table has the expected grain and does not double-count revenue.

## Power BI report

Open [`powerbi/Telecom_revenue_optimization.pbix`](powerbi/Telecom_revenue_optimization.pbix) in Power BI Desktop.

Before publishing, check the file for confidential data, personal/customer information, embedded credentials, and data-source details. If the file contains data that should not be public, publish screenshots and a sanitized sample instead of the PBIX.

## Suggested next steps

- Add screenshots of the report pages to `powerbi/screenshots/`.
- Document the dataset's origin, licensing, and any anonymization.
- Add validated SQL checks for row counts, duplicate dimension keys, null keys, and revenue reconciliation.
- Record actual dashboard findings and recommendations, supported by the report.
- Add a short demo or walkthrough if available.

## Limitations

This repository documents the supplied SQL scripts and report file. It does not include the original staging-data creation/loading script, source dataset documentation, verified KPI definitions, or independently validated business results. Add these only when the relevant details are available.
