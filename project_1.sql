								-- BASIC QUESTION.
-- 1.RETRIEVE THE TOTAL NMBR OF ORDERS PLACED.
-- 2.CALCULATE THE TOTAL REVENUE GENERATED FROM PIZZA SALES.
-- 3.IDENTIFY THE HIGHEST-PRIZED PIZZA.
-- 4.IDENTIFY THE MOST COMMON PIZZA SIZE ORDERED.
-- 5.LIST THE TOP 5 MOST ORDERED PIZZAS TYPE ALONG WITH THEIR QUANTITIES.


use pizzahut;
-- 1.RETRIEVE THE TOTAL NMBR OF ORDERS PLACED.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
    
-- 2.CALCULATE THE TOTAL REVENUE GENERATED FROM PIZZA SALES. 
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
-- 3.IDENTIFY THE HIGHEST-PRIZED PIZZA.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
    
-- 4.IDENTIFY THE MOST COMMON PIZZA SIZE ORDERED.

SELECT 
    pizzas.size, COUNT(order_details.order_details_id) AS a
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY a DESC;

-- 5.LIST THE TOP 5 MOST ORDERED PIZZAS TYPE ALONG WITH THEIR QUANTITIES.

SELECT 
    pizzas.pizza_type_id, SUM(order_details.quantity) AS c
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.pizza_type_id
ORDER BY c DESC
LIMIT 5;





















    
    
    
    
    
    
    
    