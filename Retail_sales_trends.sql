Select *
from retail_sales_raw1;

/* Total Profit by Region*/
Select 
	Region, 
    Sum(Quantity) AS Total_quantity,
    Sum(Total_net_revenue) as total_profit
from retail_sales_raw1
group by Region;

/* Total sales by the state*/
select 
	State, 
    sum(Sales) as Total_sales
from retail_sales_raw1
group by State
order by Total_sales desc ;

/* No. Of. Days between the order date and ship date */
select 
Order_ID,
Order_Date,
Ship_Date,
datediff(Ship_Date , Order_Date ) as time_gape,
if(datediff(Ship_Date , Order_Date ) >5, 'Improve shipment','Good Work') as Review
from retail_sales_raw1;

/* Shipment percentage */
SELECT
    ROUND(
        AVG(IF(DATEDIFF(Ship_Date, Order_Date) > 5, 100, 0)),
        2
    ) AS Delayed_percentage,
    ROUND(
        AVG(IF(DATEDIFF(Ship_Date, Order_Date) <= 5, 100, 0)),
        2
    ) AS shipped_within_5_days_percentage
FROM retail_sales_raw1
WHERE Order_Date IS NOT NULL
  AND Ship_Date IS NOT NULL;


/* Monthly sales trends*/
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Date,
        SUM(Sales) AS Sales
    FROM retail_sales_raw1
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
sales_with_previous AS (
    SELECT
        Order_Date,
        Sales,
        LAG(Sales) OVER (
            ORDER BY Order_Date
        ) AS previous_month_sales
    FROM retail_sales_raw1
)
SELECT
    Order_Date,
    Sales,
    previous_month_sales,
    ROUND(
        (Sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS growth_percentage
FROM sales_with_previous
ORDER BY Order_Date;


select
	Region, Quantity, Discount
   FROM retail_sales_raw1
   where Discount > 10;
	
/*Discount impacts */
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 10 THEN '1-10%'
        WHEN Discount <= 20 THEN '11-20%'
        WHEN Discount <= 30 THEN '21-30%'
        ELSE 'Above 30%'
    END AS discount_range,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM retail_sales_raw1
GROUP BY discount_range
ORDER BY MIN(Discount);

/*Top 5 sales by month */

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS sales_month,
    SUM(Sales) AS total_sales
FROM retail_sales_raw1
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY total_sales DESC
LIMIT 5;

/*Sales peaked  and dropped in month */

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Date,
        SUM(Sales) AS total_sales
    FROM retail_sales_raw1
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
ranked_sales AS (
    SELECT
        Order_Date,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS highest_rank,
        RANK() OVER (ORDER BY total_sales ASC) AS lowest_rank
    FROM monthly_sales
)
SELECT
    Order_Date,
    total_sales,
    CASE
        WHEN highest_rank = 1 THEN 'Picked Month'
        WHEN lowest_rank = 1 THEN 'Dropped Month'
    END AS sales_status
FROM ranked_sales
WHERE highest_rank = 1 OR lowest_rank = 1
ORDER BY total_sales DESC;





