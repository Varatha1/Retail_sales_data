# Retail Sales Analysis | Excel · MySQL · Power BI

An end-to-end analysis of retail sales data: cleaning raw data in Excel, analysing it with SQL, and building an interactive Power BI dashboard to track revenue, profit and discount impact.

## Business Questions
- Which regions and states generate the most sales and profit?
- How do sales change month over month?
- How do discount levels affect units sold, sales and profit?
- Are orders being shipped on time?

## Tools Used
| Tool | Purpose |
|------|---------|
| Microsoft Excel | Data cleaning and preparation |
| MySQL | Business analysis using SQL |
| Power BI (DAX) | Data modelling, KPIs and dashboard |
| GitHub | Version control and documentation |

## Dataset
- **File:** `retail_sales_raw1.csv`, about 1,850 order records
- **Columns (19):** Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, Region, State, City, Category, Sub-Category, Product_Name, Sales, Quantity, Total_revenue, Discount, Total_net_revenue, Profit

## Project Workflow

### 1. Data Cleaning (Excel)
- Cleaned a messy dataset of 1,850+ records
- Removed duplicate rows
- Identified unknown customers using Customer ID
- Replaced blank Discount values with 0

### 2. SQL Analysis (MySQL)
Queries are in [`Retail_sales_trends.sql`](Retail_sales_trends.sql):
- **Regional performance:** total quantity and profit by region
- **State performance:** total sales by state, ranked highest to lowest
- **Shipping efficiency:** days between order and ship date, flagging orders that take more than 5 days
- **Monthly sales trend:** month-over-month growth using CTEs and the `LAG()` window function
- **Discount impact:** orders, units, sales and profit grouped into discount bands (No Discount, 1-10%, 11-20%, 21-30%, above 30%)

### 3. Dashboard (Power BI)
File: [`sales_project.pbix`](sales_project.pbix)
- Loaded and transformed the data in Power Query
- Created DAX measures for **Total Revenue, Total Net Revenue, Profit and Average Discount**
- Built an interactive sales revenue dashboard

## Key Insights
> Replace these with your own findings.
- [Region] had the highest profit, while [Region] had the lowest.
- Orders with discounts above [X]% showed [lower/negative] profit.
- Sales peaked in [month] and dropped in [month].
- [X]% of orders took more than 5 days to ship.

## Dashboard Preview
> Add a screenshot: upload an image to the repo and link it, e.g. `![Dashboard](dashboard.png)`

## Repository Structure
```
Retail_sales_data/
├── retail_sales_raw1.csv       # Raw dataset
├── Retail_sales_trends.sql     # MySQL analysis queries
├── sales_project.pbix          # Power BI dashboard
└── README.md
```

## How to Run
1. Import `retail_sales_raw1.csv` into MySQL as the table `retail_sales_raw1`
2. Run the queries in `Retail_sales_trends.sql`
3. Open `sales_project.pbix` in Power BI Desktop

## Author
**Varatharaj S.**, Data Research Analyst
[LinkedIn](#) · [GitHub](https://github.com/Varatha1)
