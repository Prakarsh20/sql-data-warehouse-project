# SQL Data Warehouse and Analytics Project

A data warehouse project built using SQL Server. This project covers data loading, ETL processes, data cleaning, data modeling, and data analysis.

---

## Data Architecture

The project uses a three-layer architecture:

- **Bronze Layer** - Stores the raw data loaded from CSV files.
- **Silver Layer** - Contains cleaned and transformed data.
- **Gold Layer** - Contains the final data used for analysis and reporting.

![Data Architecture](docs/data_architecture.png)

---

## Project Overview

The main goal of this project is to build a data warehouse using SQL Server and prepare the data for analysis.

The project includes:

1. **Data Architecture** - Designing the warehouse using Bronze, Silver, and Gold layers.
2. **ETL Processes** - Loading data from CSV files, cleaning it, and transforming it.
3. **Data Modeling** - Creating fact and dimension tables using a star schema.
4. **Data Analysis** - Writing SQL queries to analyze customers, products, and sales.

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

### Analytics and Reporting

The data warehouse will be used to analyze:

- **Customer Behavior**
- **Product Performance**
- **Sales Trends**
- **Key Business Metrics**

The analysis will be performed using SQL queries on the data warehouse.

---

## Tools and Technologies

- **SQL Server** - Database and data warehouse
- **SQL Server Management Studio (SSMS)** - Database management and SQL development

 ---

## Repository Structure

```text
data-warehouse-project/
|
├── datasets/                    # Source CSV datasets
|
├── docs/                        # Project documentation
|   ├── data_catalog.md          # Dataset and column descriptions
|   └── naming-conventions.md    # Naming conventions used in the project
|
├── scripts/                     # SQL scripts
|   ├── bronze/                  # Raw data loading
|   ├── silver/                  # Data cleaning and transformation
|   └── gold/                    # Analytical data models
|
├── tests/                       # Data quality and validation scripts
|
├── README.md                    # Project documentation
└── .gitignore                   # Git ignore rules
