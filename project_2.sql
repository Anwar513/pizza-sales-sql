										-- INTERMEDIATE QUESTIONS
-- 1.JOIN THE NECESSARY TABLES TO FIND THE YHE QUANTITY OF EACH PIZZA CATEGORY ORDERED.
-- 2. DETERMINE THE DISTRIBUTION OF ORDERS BY HOUR OF THE DAY.
-- 3. JOIN THE RELEVANT TABLES TO FIND THE CATEGORY WISE DISTRIBUTION OF PIZZAS.
-- 4. GROUPS THE ORDER BY DATE AND CALCULATE THE AVERAGE NMBR OF PIZZAS ORDERED PER DAY.
-- 5. DETERMINE THE TOP 3 MOST RDERED PIZZAS TYPE BASED ON REVENUE.


-- 1.JOIN THE NECESSARY TABLES TO FIND THE YHE QUANTITY OF EACH PIZZA CATEGORY ORDERED.
use pizzahut;
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    piazzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC
LIMIT 5;

-- 2. DETERMINE THE DISTRIBUTION OF ORDERS BY HOUR OF THE DAY.

SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(order_time);

-- 3. JOIN THE RELEVANT TABLES TO FIND THE CATEGORY WISE DISTRIBUTION OF PIZZAS.

SELECT 
    COUNT(name) AS n, category
FROM
    pizza_types
GROUP BY category;

-- 4. GROUPS THE ORDER BY DATE AND CALCULATE THE AVERAGE NMBR OF PIZZAS ORDERED PER DAY.

SELECT 
    AVG(quantity)
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;

-- 5. DETERMINE THE TOP 3 MOST RDERED PIZZAS TYPE BASED ON REVENUE.

SELECT 
    pizza_types.name,
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;



















































