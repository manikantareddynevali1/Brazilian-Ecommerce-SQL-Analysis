-- =====================================================
-- Query 1: Top 10 Customers by Spending
-- Business Question:
-- Which customers have spent the highest total amount on purchases?
-- Concepts Used:
-- JOIN, SUM(), GROUP BY, ORDER BY, LIMIT
-- =====================================================

SELECT
    c.customer_unique_id,
    ROUND(SUM(op.payment_value), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC
LIMIT 10;



-- =====================================================
-- Query 2: Top 10 Sellers by Revenue
-- Business Question:
-- Which sellers generated the highest revenue from product sales?
-- Concepts Used:
-- JOIN, SUM(), GROUP BY, ORDER BY, LIMIT
-- =====================================================

SELECT
    s.seller_id,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
ORDER BY total_revenue DESC
LIMIT 10;



-- =====================================================
-- Query 3: Top 10 Product Categories by Products Sold
-- Business Question:
-- Which product categories are the most popular based on the number of products sold?
-- Concepts Used:
-- JOIN, COUNT(), GROUP BY, ORDER BY, LIMIT
-- =====================================================

SELECT
    pct.product_category_name_english AS product_category,
    COUNT(oi.order_id) AS products_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN product_category_name_translation pct
    ON p.product_category_name = pct.product_category_name
GROUP BY pct.product_category_name_english
ORDER BY products_sold DESC
LIMIT 10;



-- =====================================================
-- Query 4: Revenue by Customer State
-- Business Question:
-- Which customer states generated the highest total revenue?
-- Concepts Used:
-- JOIN, SUM(), GROUP BY, ORDER BY
-- =====================================================

SELECT
    c.customer_state,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_state
ORDER BY total_revenue DESC;



-- =====================================================
-- Query 5: Most Used Payment Method
-- Business Question:
-- Which payment method is used most frequently by customers?
-- Concepts Used:
-- COUNT(), GROUP BY, ORDER BY
-- =====================================================

SELECT
    payment_type,
    COUNT(*) AS total_transactions
FROM order_payments
GROUP BY payment_type
ORDER BY total_transactions DESC;