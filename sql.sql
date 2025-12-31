select * from walmart


--------
---EDA--
--------

SELECT  payment_method, COUNT(*) FROM walmart	
GROUP BY payment_method
-- insight ---
/*
"Credit card"	4256
"Ewallet"	3881
"Cash"	1832
*/

SELECT COUNT(DISTINCT city) AS TOTAL_CITY  FROM walmart

-- insight --
/* WE HAVE TOTAL 98 CITY*/


SELECT COUNT(DISTINCT branch) AS TOTAL_BRANCH  FROM walmar
-- INSIGHT--
/*  WEW HAVE TOTAL 100 BRANCH */

---------------------
-- Analystic part --
---------------------
 
--1 Find Different payment method and number of Transactions ,number of qty sold---

SELECT 
	payment_method ,
	count(payment_method)  as Number_Transaction,
	sum(quantity) as Tota_quantity
FROM walmart
GROUP BY 1



-- 2 IDENTIFY THE HIGHEST RATED-CATEGORY IN EACH BRANCH ,DISPLAYING THE BRANCH ,CATEGORY AND AVE RATING --
SELECT * FROM (
SELECT 
	branch,
	category,
	AVG(rating) as AVG_RATING ,
	RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) as rank 
FROM WALMART
GROUP BY 1,2
)
WHERE RANK =1

-- IDENTIFY THE BUSIEST  DAY FOR EACH BRANCH BASED ON THE NUMBER OF TRANSACTION 
SELECT * FROM (
SELECT   
	BRANCH,
	TO_CHAR(TO_DATE(date ,'DD-MM-YYYY'),'DAY') as FORMATED,
	COUNT(*) AS NO_TRANSACTION ,
	RANK() OVER (PARTITION BY branch order by count(*) desc) as rank
	FROM WALMART
GROUP BY 1,2
)
WHERE RANK =1
-- calculate the total quantity of item sold per payment method list payment_method and total_quantity.

select
	payment_method,
	sum(quantity) as total_quantity
from walmart 
group by 1

-- Determine the average ,minimun and maximun rating of product for each city ,
--- list the city ,average_rating,min_rating and max_rating

select 
	city,
	category,
	max(rating) as max_rating,
	min(rating) as min_rating,
	avg(rating) as average_rating
from walmart
group by 1,2

-- calculate the total profit for each category by consider total_profit as 
---(unit_price *quantity * profit_margin)
--list the category and total_profit ,ordered from highest to lowest profit 


select
	category,
	sum(unit_price*quantity*profit_margin) as total_profit 
	
from walmart 
group by 1
order by 2 desc

-- determine the most common payment_method for each branch. display branch and prefered payment_method
with total_prefered as (
select 
	branch,
	payment_method,
	count(*) as total_trans,
	rank() over (partition by branch order by count(*)  desc)	as rank 
from walmart
group by 1,2
)
select * from total_prefered
where rank =1

--8 :-v categorize sale into three 3 groups morning ,afternoon ,evening 
-- find out each of the shift and number of invoice



select 
	branch,
	case 
		when extract(hour from(time :: time)) < 12 then  'morning'
		when extract (hour from(time:: time)) between 12 and 17 then 'evening'
		else 'evening'
		end as day_time, 
		count(*)
		
from walmart 
group by 1,2

--9:- identify 5 branch with highest decrease ratio in revevenue compare to last year (current year 2023 and last year 2022)


-- 2022 sales
WITH revenue_2022
AS
(
	SELECT 
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022 -- psql
	-- WHERE YEAR(TO_DATE(date, 'DD/MM/YY')) = 2022 -- mysql
	GROUP BY 1
),

revenue_2023
AS
(

	SELECT 
		branch,
		SUM(total) as revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
	GROUP BY 1
)

SELECT 
	ls.branch,
	ls.revenue as last_year_revenue,	
	cs.revenue as cr_year_revenue,
	ROUND(
		(ls.revenue - cs.revenue)::numeric/
		ls.revenue::numeric * 100, 
		2) as rev_dec_ratio
FROM revenue_2022 as ls
JOIN
revenue_2023 as cs
ON ls.branch = cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5

