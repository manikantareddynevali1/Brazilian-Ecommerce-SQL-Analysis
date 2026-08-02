-- =====================================================
-- Query 1: Monthly Sales Revenue
-- Business Question:
-- How has the company's monthly revenue changed over time?
-- Concepts Used:
-- DATE_TRUNC(), JOIN, SUM(), GROUP BY, ORDER BY
-- =====================================================

SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(op.payment_value), 2) AS monthly_revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY month
ORDER BY month;



-- =====================================================
-- Query 2: Monthly Order Count
-- Business Question:
-- How many orders were placed each month?
-- Concepts Used:
-- DATE_TRUNC(), COUNT(), GROUP BY, ORDER BY
-- =====================================================

SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;



-- =====================================================
-- Query 3: Average Delivery Time
-- Business Question:
-- What is the average number of days taken to deliver an order?
-- Concepts Used:
-- AVG(), ROUND(), Date Arithmetic, WHERE
-- =====================================================

SELECT
    ROUND(
        AVG(order_delivered_customer_date::date - order_purchase_timestamp::date),
        2
    ) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



-- =====================================================
-- Query 4: Orders by Day of the Week
-- Business Question:
-- On which day of the week do customers place the highest number of orders?
-- Concepts Used:
-- TO_CHAR(), COUNT(), GROUP BY, ORDER BY
-- =====================================================

SELECT
    TO_CHAR(order_purchase_timestamp, 'DAY') AS weekday,
    COUNT(*) AS total_orders
FROM orders
GROUP BY weekday
ORDER BY total_orders DESC;



-- =====================================================
-- Query 5: Orders by Year
-- Business Question:
-- How many orders were placed each year?
-- Concepts Used:
-- EXTRACT(), COUNT(), GROUP BY, ORDER BY
-- =====================================================

SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    COUNT(*) AS total_orders
FROM orders
GROUP BY year
ORDER BY total_orders;