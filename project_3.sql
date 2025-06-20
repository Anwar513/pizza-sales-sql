									-- ADVANCED QUESTIONS 
-- 1. CALCULATE THE PERCENTAGE CONTRIBUTION OF EACH PIZZA TYPE TO TOTAL REVENUE.
-- 2. ANALYZE THE COMULATIVE REVENUE GENERATED OVER TIME.
-- 3. DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE FOR EACH PIZZA CATEGORY.


-- 1. CALCULATE THE PERCENTAGE CONTRIBUTION OF EACH PIZZA TYPE TO TOTAL REVENUE.

use pizzahut;
SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_revenue DESC;

-- 2. ANALYZE THE COMULATIVE REVENUE GENERATED OVER TIME.



select order_date, sum(revenue) over (order by order_date) as comulative
from 
(select orders.order_date, SUM(order_details.quantity * pizzas.price) as revenue
from orders
join order_details
on orders.order_id= order_details.order_id
join pizzas
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY orders.order_date) as sales;

-- 3. DETERMINE THE TOP 3 MOST ORDERED PIZZA TYPES BASED ON REVENUE FOR EACH PIZZA CATEGORY.
select name, revenue
from
(select category, name, revenue,
rank() over(partition by category order by revenue desc ) as rn
from
(SELECT pizza_types.category, pizza_types.name, 
    SUM(order_details.quantity * pizzas.price)
           AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
    join pizza_types
    on  pizza_types.pizza_type_id=pizzas.pizza_type_id
    group by pizza_types.category, pizza_types.name) as a ) as b
    where rn <= 3 ;













