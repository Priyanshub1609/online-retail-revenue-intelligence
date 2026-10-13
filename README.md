# Online Retail Revenue Intelligence

An end-to-end retail analytics portfolio project using **Python (Pandas), SQL Server, and Power BI** to investigate revenue trends, product performance, country-level sales, and customer repeat purchasing.

## Project Overview

The UCI Online Retail dataset contains 541,909 transaction-line records from 1 December 2010 to 9 December 2011. The workflow investigates data quality, prepares an analytical dataset, validates sales KPIs across Python and SQL Server, and defines a three-page Power BI report.

## Business Questions

- How does sales revenue change month to month?
- Which countries contribute the most revenue?
- Which products rank highest by revenue and units sold?
- How much revenue comes from repeat versus one-time identified customers?
- How should cancellations, negative quantities, zero-price rows, and accounting adjustments be handled?

## Tools

- Python: Pandas, Matplotlib, Google Colab
- SQL Server / SSMS
- Power BI Desktop, DAX, Power Query
- Git and GitHub

## Preliminary KPI Results

Using the project's current eligible-sales definition (positive quantity, positive unit price, and not a cancellation invoice):

| KPI | Result |
|---|---:|
| Eligible sales revenue | £10,642,110.80 |
| Eligible sales invoices | 19,960 |
| Identified customers | 4,338 |
| Units sold | 5,572,420 |
| Repeat customers | 2,845 |
| One-time customers | 1,493 |
| Repeat purchase rate among identified customers | 65.58% |

These are project-analysis results under the stated filter definition, not audited accounting figures. Returns and unusual transactions should be analyzed separately for net revenue/accounting treatment.

## Data Quality and Limitations

The initial dataset has missing CustomerID and Description values, duplicate rows, cancellation invoices, negative quantities, zero-price transactions, and two negative-price bad-debt adjustments. Exact duplicates were removed from the analytical copy; original records and return/cancellation signals were preserved for investigation. December 2011 is partial because records end on 9 December 2011.

## Repository Contents

- `README.md` — project introduction, metric definitions, findings, and limitations
- `sql/Online_retail.sql` — SQL script (if included in this repository upload)
- `python/Online_Retail_Revenue_Analytics.ipynb` — notebook (if included in this repository upload)
- `powerbi/` — Power BI theme, DAX measure reference, and layout notes
- `data/` — documentation for obtaining/using the prepared CSV

The prepared CSV is large (~67 MB). If it is not stored directly in this repository, download it from the project bundle or recreate it by running the notebook. Do not change the path in the report model without updating the Power Query source.

## How to Reproduce

1. Obtain the source dataset from the [UCI Online Retail dataset page](https://archive.ics.uci.edu/dataset/352/online+retail).
2. Run the notebook in Google Colab or Jupyter to inspect, clean, and export the analytical CSV.
3. Run the provided SQL queries against a SQL Server table populated from that CSV.
4. Open the Power BI project/report using the included theme and DAX reference; update the data source path to your local CSV if needed.
5. Validate all KPIs against the definitions in this README.

## License and Attribution

The source dataset is from the UCI Machine Learning Repository. Review the dataset page for the current license and citation details before redistributing the data.

## Author

Priyanshu — Data Analytics Portfolio Project
