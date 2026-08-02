-- =====================================================
-- Query 1: Customers Spending Above Average
-- Business Question:
-- Which customers have spent more than the average payment value?
-- Concepts Used:
-- Subquery, JOIN, SUM(), GROUP BY, HAVING
-- =====================================================

SELECT
    c.customer_id,
    SUM(op.payment_value) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_id
HAVING SUM(op.payment_value) >
(
    SELECT AVG(payment_value)
    FROM order_payments
);



-- =====================================================
-- Query 2: Sellers Whose Revenue Is Above Average
-- Business Question:
-- Which sellers generated above-average revenue?
-- Concepts Used:
-- Subquery, SUM(), GROUP BY, HAVING
-- =====================================================

SELECT
    s.seller_id,
    SUM(oi.price) AS total_revenue
FROM sellers s
JOIN order_items oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_id
HAVING SUM(oi.price) >
(
    SELECT AVG(seller_revenue)
    FROM
    (
        SELECT
            SUM(price) AS seller_revenue
        FROM order_items
        GROUP BY seller_id
    ) t
)
ORDER BY total_revenue DESC;



-- =====================================================
-- Query 3: Products With Revenue Above Average Product Price
-- Business Question:
-- Which products generated revenue greater than the average product price?
-- Concepts Used:
-- Subquery, SUM(), GROUP BY, HAVING
-- =====================================================

SELECT
    p.product_id,
    SUM(oi.price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id
HAVING SUM(oi.price) >
(
    SELECT AVG(price)
    FROM order_items
);



-- =====================================================
-- Query 4: States Generating Above Average Revenue
-- Business Question:
-- Which customer states generated revenue above the average state revenue?
-- Concepts Used:
-- Subquery, JOIN, SUM(), GROUP BY, HAVING
-- =====================================================

SELECT
    c.customer_state,
    SUM(op.payment_value) AS total_payments
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_state
HAVING SUM(op.payment_value) >
(
    SELECT AVG(state_value)
    FROM
    (
        SELECT
            SUM(op.payment_value) AS state_value
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        JOIN order_payments op
            ON o.order_id = op.order_id
        GROUP BY c.customer_state
    ) state_report
);



-- =====================================================
-- Query 5: Customers With Above Average Number of Orders
-- Business Question:
-- Which customers placed more orders than the average customer?
-- Concepts Used:
-- Subquery, COUNT(), GROUP BY, HAVING
-- =====================================================

SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) >
(
    SELECT AVG(order_count)
    FROM
    (
        SELECT
            COUNT(o.order_id) AS order_count
        FROM customers c
        JOIN orders o
            ON c.customer_id = o.customer_id
        GROUP BY c.customer_unique_id
    ) t
)
ORDER BY total_orders DESC;