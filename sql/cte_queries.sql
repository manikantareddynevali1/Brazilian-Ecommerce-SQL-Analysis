-- =====================================================
-- Query 1: Customers Who Spent More Than Average
-- Business Question:
-- Which customers spent more than the average customer spending?
-- Concepts Used:
-- CTE, JOIN, SUM(), AVG(), GROUP BY
-- =====================================================

WITH customer_spent AS (
    SELECT
        c.customer_id,
        SUM(op.payment_value) AS customer_bought
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_id
)

SELECT
    customer_id
FROM customer_spent
WHERE customer_bought >
(
    SELECT AVG(customer_bought)
    FROM customer_spent
);



-- =====================================================
-- Query 2: Top 10 Sellers by Revenue
-- Business Question:
-- Which sellers generated the highest revenue?
-- Concepts Used:
-- CTE, JOIN, SUM(), GROUP BY, ORDER BY
-- =====================================================

WITH seller_report AS (
    SELECT
        s.seller_id,
        SUM(ot.price) AS total_value
    FROM sellers s
    JOIN order_items ot
        ON s.seller_id = ot.seller_id
    GROUP BY s.seller_id
)

SELECT
    seller_id,
    total_value
FROM seller_report
ORDER BY total_value DESC
LIMIT 10;



-- =====================================================
-- Query 3: Monthly Revenue Report
-- Business Question:
-- What is the monthly revenue trend?
-- Concepts Used:
-- CTE, DATE_TRUNC(), SUM(), JOIN, GROUP BY
-- =====================================================

WITH monthly_report AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        SUM(op.payment_value) AS total_paid
    FROM orders o
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY month
)

SELECT
    month,
    total_paid
FROM monthly_report;



-- =====================================================
-- Query 4: Product Categories Above Average Sales
-- Business Question:
-- Which product categories generated revenue above the average product price?
-- Concepts Used:
-- CTE, JOIN, SUM(), GROUP BY, HAVING
-- =====================================================

WITH above_avg AS (
    SELECT
        product_category_name AS product_category,
        SUM(price) AS total_sales
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY product_category_name
    HAVING SUM(price) >
    (
        SELECT AVG(price)
        FROM order_items
    )
)

SELECT
    product_category
FROM above_avg;



-- =====================================================
-- Query 5: Repeat Customers
-- Business Question:
-- Which customers placed more than one order?
-- Concepts Used:
-- CTE, JOIN, COUNT(), GROUP BY, HAVING
-- =====================================================

WITH repeat_customers AS (
    SELECT
        c.customer_unique_id AS customer,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
)

SELECT
    customer
FROM repeat_customers;