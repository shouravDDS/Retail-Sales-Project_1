select * from retail_sales;


---Data cleaning process

alter table retail_sales
alter column total_sale type numeric;

alter table retail_sales
rename column quantiy to quantity;



--To chack the null value of the total dataset
select * from retail_sales
where sale_time is null;

select * from retail_sales
where customer_id is null;


select * from retail_sales
where category is null;

--chack all column together
select * from retail_sales
where sale_time is null
		or
		customer_id is null
		or
		gender is null
		or
		age is null
		or
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null
		or
		date is null
		

select count(*) from
(select * from retail_sales
where sale_time is null
		or
		customer_id is null
		or
		gender is null
		or
		age is null
		or
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null
		or
		date is null
) as sub;


--To count, How many null value have in the datasate
select count(*) from
(select * from retail_sales
where quantity is null) as sub;



--To delete null value from the dataset
delete from retail_sales
where sale_time is null
		or
		customer_id is null
		or
		gender is null
		or
		age is null
		or
		category is null
		or
		quantity is null
		or
		price_per_unit is null
		or
		cogs is null
		or
		total_sale is null
		or
		date is null
		
--Explore Data

select * from retail_sales;


-- How many sales we have
select count(*) from retail_sales;

---How many unique coustomer we have?
select count(distinct(customer_id)) as total_customer
from retail_sales;

--Data Analysis Business related question

--1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from retail_sales
where date='2022-11-05'


--2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 3 in the month of nov-2022
select * from retail_sales
where category='Clothing' 
and quantity>3
and date between '2022-11-01' and '2022-11-30'

--3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as total
from retail_sales
group by category;



--4 Write a SQL query to find the average age of customers who purchased items the 'beauty' category.
select category,round((average),2) from
(select category,avg(age) as average
from retail_sales
group by category) as sub
where category='Beauty'

--5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales
where total_sale>1000

--6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender,count(*) as transactions
from retail_sales
group by category,gender
order by category asc;


--7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:


select * from 
(select year,month,average_sale,
					rank() over(partition by year order by average_sale desc) as ranks
				from
(select 
		extract(year from date) as year,
		extract(month from date) as month,
		avg(total_sale) as average_sale
	from retail_sales
group by year,month) as sub) as a
where ranks=1;



-- 8 Write a SQL query to find the top 5 customers based on the highest total sales

select customer_id,sum(total_sale) as total
from retail_sales
group by customer_id
order by total desc
limit 5;

--9 write a SQL query to find the number of unique customers who purchased items from each category
select category,count( distinct customer_id) as Unique_customers
from retail_sales
group by category


--10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

select sift,count(customer_id) as counts from
(select *,
		case
			when extract(hour from sale_time)<12 then 'Morning sift'
			when extract (hour from sale_time)between 12 and 17 then 'Afternoon sift'
			else 'Evining sift'
		end as sift
from retail_sales) as sub
group by sift;

