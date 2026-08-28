# SQL Data Warehouse and Analytics Project
A data warehouse and analytics project built using SQL Server. This project covers data loading, ETL processes, data cleaning, data modeling, data quality validation, and business-focused data analysis.

---
## Data Architecture

The project uses a three-layer architecture:

- **Bronze Layer** - Stores the raw data loaded from CSV files.
- **Silver Layer** - Contains cleaned and transformed data.
- **Gold Layer** - Contains the final business-ready data used for analysis and reporting.

---

## Project Overview

The main goal of this project is to build a SQL Server data warehouse that integrates data from different source systems and prepares it for reliable analysis.

The project includes:

1. **Data Architecture** - Designing the warehouse using Bronze, Silver, and Gold layers.
2. **ETL Processes** - Loading data from CSV files, cleaning it, and transforming it into structured datasets.
3. **Data Modeling** - Creating fact and dimension tables using a star schema.
4. **Data Quality** - Validating the data and checking for common data quality issues.
5. **Data Analysis** - Using SQL to analyze customers, products, sales trends, and key business metrics.
6. **Reporting** - Creating customer and product reports with useful business KPIs.

---

## Project Requirements

### Data Warehouse

#### Objective

Build a SQL Server data warehouse that combines sales data from different source systems and prepares it for analysis.

#### Requirements

- **Data Sources:** Import ERP and CRM data from CSV files.
- **Data Quality:** Clean the data and fix data quality issues before using it for analysis.
- **Integration:** Combine data from both sources into a single data model.
- **Scope:** Use the latest available data without maintaining historical versions.
- **Documentation:** Document the data model and data flow.

---

## Analytics and Reporting

The Gold layer provides business-ready data that can be used to analyze sales performance, customer behavior, and product performance.

The analytics layer uses SQL queries to answer common business questions and identify useful patterns in the data.

### Analysis Areas

- **Change Over Time Analysis** - Analyze sales, customers, and quantities over different time periods to identify trends and changes.
- **Cumulative Analysis** - Calculate running totals and moving averages to understand performance over time.
- **Performance Analysis** - Compare product performance with previous periods and average performance using year-over-year analysis.
- **Data Segmentation** - Group products and customers into meaningful segments based on cost, spending, and customer lifespan.
- **Part-to-Whole Analysis** - Calculate how much each product category contributes to overall sales.

### Customer and Product Reports

The project also includes customer and product reports that combine multiple business metrics into structured analytical views.

**Customer Report** includes:

- Customer information and age groups
- Customer segments such as VIP, Regular, and New
- Total orders and sales
- Total quantity and products purchased
- Customer lifespan and recency
- Average order value
- Average monthly spending

**Product Report** includes:

- Product and category information
- Product performance segments
- Total orders and customers
- Total sales and quantity sold
- Product lifespan and recency
- Average selling price
- Average order revenue
- Average monthly revenue

These reports make the Gold layer easier to use for further analysis, reporting, and business decision-making.

---

## Tools and Technologies

- **SQL Server** - Database and data warehouse
- **SQL Server Management Studio (SSMS)** - Database management and SQL development
- **SQL** - Data transformation, analysis, reporting, and validation

---

## Repository Structure

```text
sql-data-warehouse-project/
|
├── datasets/                    # Source CSV datasets
|
├── docs/                        # Project documentation
|   └── data_catalog.md          # Dataset and column descriptions
|
├── scripts/                     # SQL scripts
|   ├── bronze/                  # Raw data loading
|   ├── silver/                  # Data cleaning and transformation
|   ├── gold/                    # Analytical data models
|   └── analytics/               # Business analysis and reporting
|
├── tests/                       # Data quality and validation scripts
|
├── README.md                    # Project documentation
