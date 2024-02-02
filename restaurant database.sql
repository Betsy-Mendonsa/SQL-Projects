USE restaurant_db;

-- view menu itens in the table --
select * from menu_items;

-- count the number of items --
select count(*) from menu_items;

-- find the least and most expensive items --
select item_name, price from menu_items order by price limit 1;
select item_name, price from menu_items order by price desc limit 1;

-- count italian dishes on the menu --
select count(*) from menu_items where category='Italian';

-- least and most expensive italian dishes on the menu --
select item_name, price from menu_items where category='Italian' order by price limit 1;
select item_name, price from menu_items where category='Italian' order by price desc limit 1;

-- count dishes in each category --
select category, count(menu_item_id) as num_of_dishes from menu_items group by category;

-- find average dish price within each category --
select category, avg(price) as avg_price from menu_items group by category;

-- view order details table --
select * from order_details;

-- find the date range of the table --
select min(order_date), max(order_date) from order_details;

-- number of orders made within this date range --
select count(distinct order_id) from order_details;

-- number of items ordered within this date range --
select count(*) from order_details;

-- Orders with most number of items --
select order_id, count(item_id) as num_of_items from order_details group by order_id order by num_of_items desc;

-- orders with more than 12 items --
select count(*) from
(select order_id, count(item_id) as num_of_items from order_details group by order_id having num_of_items>12) as num_of_orders;

-- combine menu_items and order_details table into a single table --
select * from order_details as od left join menu_items as mi
on od.item_id = mi.menu_item_id;

-- what were the least and most ordered items and what category were they in --
select item_name, category, count(order_details_id) as num_of_purchases
from order_details as od left join menu_items as mi
on od.item_id = mi.menu_item_id
group by item_name, category
order by num_of_purchases;

select item_name, category, count(order_details_id) as num_of_purchases
from order_details as od left join menu_items as mi
on od.item_id = mi.menu_item_id
group by item_name, category
order by num_of_purchases desc;

-- what were the top 5 orders that spent the most money --
select order_id, sum(price) as total_spent
from order_details as od left join menu_items as mi
on od.item_id = mi.menu_item_id
group by order_id
order by total_spent desc limit 5;

-- details of the highest spent order --
select category, count(item_id) as num_of_items
from order_details as od left join menu_items as mi
on od.item_id = mi.menu_item_id
where order_id = 440
group by category;

-- details of top5 highest spent orders --
select order_id, category, count(item_id) as num_of_items
from order_details as od left join menu_items as mi
on od.item_id = mi.menu_item_id
where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category;