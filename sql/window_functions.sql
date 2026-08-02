-- =====================================================
-- Query 1: Rank Customers by Number of Orders
-- Business Question:
-- Which customers have placed the highest number of orders?
-- Concepts Used:
-- ROW_NUMBER(), COUNT(), GROUP BY, JOIN
-- =====================================================

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders,
    ROW_NUMBER() OVER (ORDER BY COUNT(o.order_id) DESC) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id;



-- =====================================================
-- Query 2: Rank Sellers by Revenue
-- Business Question:
-- Which sellers generated the highest revenue?
-- Concepts Used:
-- RANK(), SUM(), GROUP BY
-- =====================================================

SELECT
    seller_id,
    ROUND(SUM(price),2) AS total_revenue,
    RANK() OVER(ORDER BY SUM(price) DESC) AS seller_rank
FROM order_items
GROUP BY seller_id;



-- =====================================================
-- Query 3: Rank Product Categories by Products Sold
-- Business Question:
-- Which product categories are the most popular based on products sold?
-- Concepts Used:
-- DENSE_RANK(), COUNT(), JOIN, GROUP BY
-- =====================================================

SELECT
    pct.product_category_name_english,
    COUNT(ot.order_id) AS total_products_sold,
    DENSE_RANK() OVER(ORDER BY COUNT(ot.order_id) DESC) AS category_rank
FROM product_category_name_translation pct
JOIN products p
    ON pct.product_category_name = p.product_category_name
JOIN order_items ot
    ON p.product_id = ot.product_id
GROUP BY pct.product_category_name_english;



-- =====================================================
-- Query 4: Running Total of Monthly Revenue
-- Business Question:
-- How does cumulative monthly revenue grow over time?
-- Concepts Used:
-- SUM() OVER(), DATE_TRUNC(), JOIN, GROUP BY
-- =====================================================

SELECT
    DATE_TRUNC('month',o.order_purchase_timestamp) AS month,
    ROUND(SUM(op.payment_value),2) AS monthly_revenue,
    ROUND(
        SUM(SUM(op.payment_value))
        OVER(ORDER BY DATE_TRUNC('month',o.order_purchase_timestamp)),
        2
    ) AS running_total
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY DATE_TRUNC('month',o.order_purchase_timestamp)
ORDER BY month;



-- =====================================================
-- Query 5: Compare Monthly Orders with Previous Month
-- Business Question:
-- How did the number of orders change compared to the previous month?
-- Concepts Used:
-- LAG(), CTE, DATE_TRUNC(), GROUP BY
-- =====================================================

WITH monthly_orders AS
(
    SELECT
        DATE_TRUNC('month',order_purchase_timestamp) AS month,
        COUNT(*) AS total_orders
    FROM orders
    GROUP BY DATE_TRUNC('month',order_purchase_timestamp)
)

SELECT
    month,
    total_orders,
    LAG(total_orders)
    OVER(ORDER BY month) AS previous_month_orders,
    total_orders -
    LAG(total_orders)
    OVER(ORDER BY month) AS order_change
FROM monthly_orders
ORDER BY month;



-- =====================================================
-- Query 6: Running Average of Monthly Revenue
-- Business Question:
-- What is the running average of monthly revenue over time?
-- Concepts Used:
-- AVG() OVER(), CTE, DATE_TRUNC(), JOIN
-- =====================================================

WITH monthly_sales AS
(
    SELECT
        DATE_TRUNC('month',order_purchase_timestamp) AS month,
        SUM(payment_value) AS revenue
    FROM orders o
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY DATE_TRUNC('month',order_purchase_timestamp)
)

SELECT
    month,
    revenue,
    AVG(revenue)
    OVER(ORDER BY month) AS running_avg_revenue
FROM monthly_sales;



-- =====================================================
-- Query 7: Top 3 Sellers Using DENSE_RANK()
-- Business Question:
-- Who are the top three sellers based on total sales revenue?
-- Concepts Used:
-- DENSE_RANK(), SUM(), CTE, GROUP BY
-- =====================================================

WITH seller_sales AS
(
    SELECT
        seller_id,
        SUM(price) AS total_sales,
        DENSE_RANK()
        OVER(ORDER BY SUM(price) DESC) AS seller_rank
    FROM order_items
    GROUP BY seller_id
)

SELECT
    seller_id,
    total_sales,
    seller_rank
FROM seller_sales
WHERE seller_rank <= 3
ORDER BY seller_rank;