-- =====================================================
-- Query 1: Create Top Customers View
-- Business Question:
-- How can we create a reusable view to identify customers based on their total spending?
-- Concepts Used:
-- CREATE VIEW, JOIN, SUM(), GROUP BY
-- =====================================================

CREATE VIEW top_customers AS
SELECT
    c.customer_unique_id,
    SUM(op.payment_value) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id;

-- Display Top 10 Customers
SELECT *
FROM top_customers
ORDER BY total_spent DESC
LIMIT 10;



-- =====================================================
-- Query 2: Create Seller Revenue View
-- Business Question:
-- How can we create a reusable view to analyze seller revenue?
-- Concepts Used:
-- CREATE VIEW, SUM(), GROUP BY
-- =====================================================

CREATE VIEW seller_revenue AS
SELECT
    seller_id,
    SUM(price) AS total_revenue
FROM order_items
GROUP BY seller_id;

-- Display Seller Revenue
SELECT *
FROM seller_revenue
ORDER BY total_revenue DESC;



-- =====================================================
-- Query 3: Create Monthly Revenue View
-- Business Question:
-- How can we create a reusable view to monitor monthly revenue trends?
-- Concepts Used:
-- CREATE VIEW, DATE_TRUNC(), JOIN, SUM(), GROUP BY
-- =====================================================

CREATE VIEW monthly_revenue AS
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    SUM(op.payment_value) AS revenue
FROM orders o
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY month;

-- Display Monthly Revenue
SELECT *
FROM monthly_revenue
ORDER BY month;