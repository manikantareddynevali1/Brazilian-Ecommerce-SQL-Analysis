-- =====================================================
-- Query 1: Total Revenue
-- Business Question:
-- What is the total revenue generated from all customer payments?
-- =====================================================

SELECT
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM order_payments;



-- =====================================================
-- Query 2: Total Orders
-- Business Question:
-- How many orders have been placed on the e-commerce platform?
-- =====================================================

SELECT
    COUNT(*) AS total_orders
FROM orders;



-- =====================================================
-- Query 3: Total Customers
-- Business Question:
-- How many customers are registered in the e-commerce platform?
-- =====================================================

SELECT
    COUNT(*) AS total_customers
FROM customers;



-- =====================================================
-- Query 4: Average Order Value
-- Business Question:
-- What is the average payment value per transaction?
-- =====================================================

SELECT
    ROUND(AVG(payment_value), 2) AS average_order_value
FROM order_payments;



-- =====================================================
-- Query 5: Orders by Status
-- Business Question:
-- How are orders distributed across different order statuses?
-- =====================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;