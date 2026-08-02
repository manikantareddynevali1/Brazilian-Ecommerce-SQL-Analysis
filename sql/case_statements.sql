-- =====================================================
-- Query 1: Classify Orders Based on Delivery Speed
-- Business Question:
-- How can completed orders be classified based on their delivery time?
-- Concepts Used:
-- CASE, Date Arithmetic, WHERE
-- =====================================================

SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,
    CASE
        WHEN (order_delivered_customer_date::date - order_purchase_timestamp::date) <= 3 THEN 'Fast Delivery'
        WHEN (order_delivered_customer_date::date - order_purchase_timestamp::date) <= 7 THEN 'Normal Delivery'
        ELSE 'Delayed Delivery'
    END AS delivery_status
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;



-- =====================================================
-- Query 2: Categorize Payments
-- Business Question:
-- How can customer payments be classified into Low, Medium, and High payment categories?
-- Concepts Used:
-- CASE, BETWEEN
-- =====================================================

SELECT
    order_id,
    payment_value,
    CASE
        WHEN payment_value < 100 THEN 'Low Payment'
        WHEN payment_value BETWEEN 100 AND 500 THEN 'Medium Payment'
        ELSE 'High Payment'
    END AS payment_category
FROM order_payments;



-- =====================================================
-- Query 3: Categorize Sellers by Revenue
-- Business Question:
-- How can sellers be classified based on the revenue they generated?
-- Concepts Used:
-- CASE, SUM(), GROUP BY
-- =====================================================

SELECT
    seller_id,
    SUM(price) AS total_revenue,
    CASE
        WHEN SUM(price) < 10000 THEN 'Low Performer'
        WHEN SUM(price) BETWEEN 10000 AND 50000 THEN 'Average Performer'
        ELSE 'Top Performer'
    END AS seller_category
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;



-- =====================================================
-- Query 4: Categorize Customers by Spending
-- Business Question:
-- How can customers be classified based on their total spending?
-- Concepts Used:
-- CASE, JOIN, SUM(), GROUP BY
-- =====================================================

SELECT
    c.customer_unique_id,
    SUM(op.payment_value) AS total_spent,
    CASE
        WHEN SUM(op.payment_value) < 500 THEN 'Low Value'
        WHEN SUM(op.payment_value) BETWEEN 500 AND 2000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS customer_category
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spent DESC;



-- =====================================================
-- Query 5: Categorize Products by Price
-- Business Question:
-- How can products be classified as Cheap, Moderate, or Expensive based on their selling price?
-- Concepts Used:
-- CASE
-- =====================================================

SELECT
    product_id,
    price,
    CASE
        WHEN price < 50 THEN 'Cheap'
        WHEN price BETWEEN 50 AND 200 THEN 'Moderate'
        ELSE 'Expensive'
    END AS price_category
FROM order_items;