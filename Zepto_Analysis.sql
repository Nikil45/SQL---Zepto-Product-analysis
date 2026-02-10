Create database Zepto;

create table zepto(
sku_id Serial Primary key,
category varchar(130),
name varchar(150) not null,
mrp numeric(8,2),
discountpercent numeric(5,2),
availablequantity int,
discountedsellingprice numeric(8,2),
weightingms int,
outofstock boolean,
quantity int
);


# count of rows
select * from zepto_v1;

# null value
select * from zepto 
where category is null
or
name is null
or
mrp is null
or
discountPercent is null
or
availableQuantity  is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

select count(*) from zepto_v1;

select * from zepto_v1; 


#  different product categories

select distinct category
from zepto_v1
order by category;

select * from zepto_v1;

# products in stock vs out of stock

select outOfStock, count(*)
from zepto_v1
group by outOfStock;


select * from zepto_v1;

# product names present multiple times

select name, count(*)
from zepto_v1
group by name
having count(*) > 1
order by count(*) desc;

select * from zepto_v1;

#data cleaning
#products with price = 0

select * from zepto_v1
where mrp = 0 or discountedSellingPrice = 0;

delete from zepto_v1
where mrp = 0;

SET SQL_SAFE_UPDATES = 0;

# convert paise to rupees
update zepto_v1
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0; 

select mrp, discountedSellingPrice from zepto_v1;

select * from zepto_v1;

-- QI. Find the top 10 best-value products based on the discount percentage.
select distinct name, mrp, discountPercent
from zepto_v1
order by discountPercent desc
limit 10;

select * from zepto_v1;

-- Q2.What are the Products with High MRP but Out of Stock

select name, mrp
from zepto_v1
where outOfStock = "TRUE"
order by mrp desc
limit 1;

select * from zepto_v1;

-- Q3.Ca1cu1ate Estimated Revenue for each category
select category,
SUM(discountedSellingPrice * availablequantity) AS total_revenue
from zepto_V1
group by category
order by total_revenue;

-- Q4. Find all products where MRP is greater than *see and discount is less than 10%.
SELECT DISTINCT NAME, mrp, discountPercent
FROM zepto_V1
WHERE mrp > 500 and discountPercent < 10
order by mrp desc, discountPercent desc;


-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category, round(avg(discountpercent),2) as avg_discount
from zepto_v1
group by category
order by avg_discount desc
limit 5;

-- Q6. Find the price per gram for products above leeg and sort by best value.
select distinct name, weightInGms, discountedsellingprice,
round(discountedsellingprice/weightingms,2) as price_per_gram
from zepto_v1
where weightingms >= 100
order by price_per_gram;


-- Q7.Group the products into categories like Low, Medium, Bulk.
select distinct name, weightingms,
case when weightingms < 1000 then 'low'
when weightingms < 5000 then 'medium'
else 'bulk'
end as weight_category
from zepto_v1;

-- Q8 . What is the Total Inventory Weight Per Category
select category,
sum(weightingms*availablequantity) as total_weight
from zepto_v1
group by category
order by total_weight;