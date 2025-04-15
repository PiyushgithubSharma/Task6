use task6;
select * from sales_data_sample;


		-- dataype of orderdate columns  
SELECT 
  column_name, 
  data_type
FROM 
  information_schema.columns
WHERE 
  table_name = 'sales_data_sample' 
  AND column_name = 'orderdate';


	-- converted datatype

SELECT 
  STR_TO_DATE(orderdate, '%m/%d/%Y %H:%i') AS converted_date
FROM 
  sales_data_sample;




-- add col in table for date
ALTER TABLE sales_data_sample
ADD COLUMN converted_date DATE;


-- set values in converted column
UPDATE sales_data_sample
SET converted_date = STR_TO_DATE(orderdate, '%m/%d/%Y %H:%i');
 

-- print updated col
select converted_date from sales_data_sample; 


-- add a column for month 
ALTER TABLE sales_data_sample
ADD COLUMN order_month int;


-- drop column month 
ALTER TABLE sales_data_sample
DROP COLUMN month;


-- fill value in month
UPDATE sales_data_sample
SET order_month = EXTRACT(MONTH FROM converted_date);

select * from sales_data_sample;

-- creta another col for years
Alter Table sales_data_sample
add column order_year int; 

-- fill year in order_year 
update sales_data_sample
set order_year = extract(Year from converted_date);

select order_year from sales_data_sample;



--  find total sale on the month bases

create view total_sale_month as 
select order_month 
,sum(Sales) from sales_data_sample group by order_month order by order_month;



-- find total sale on the year vise

create view total_sale_year as 
select order_year 
,sum(Sales) from sales_data_sample group by order_year order by order_year; 


-- find total distint order id

SELECT COUNT(DISTINCT ordernumber) AS Volume
FROM sales_data_sample;


-- find total sales by Country

create view total_sale_country as 
select country,sum(Sales) As Sale_country
from sales_data_sample group by country order by sale_country desc;


-- find total sales by teritory

create view total_sale_territory as 
select territory,sum(sales) as sale_teritory
from sales_data_sample group by territory order by sale_teritory;

select * from total_sale_territory;

-- sales on base of city alter
create view total_sale_city as
select city,sum(sales) as sale_city
from sales_data_sample group by city order by sale_city;



-- sale on the base of size
create view total_sale_size as
select dealsize,sum(sales) as sale_size
from sales_data_sample group by dealsize order by sale_size; 


select * from total_sale_size;








