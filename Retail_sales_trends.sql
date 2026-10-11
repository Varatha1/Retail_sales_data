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





