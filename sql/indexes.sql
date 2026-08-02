-- =====================================================
-- Query 1: Create Index on Customer ID
-- Business Purpose:
-- Improve the performance of joins between the customers and orders tables.
-- Concepts Used:
-- CREATE INDEX
-- =====================================================

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);



-- =====================================================
-- Query 2: Create Index on Order ID
-- Business Purpose:
-- Speed up joins between orders and order_items.
-- Concepts Used:
-- CREATE INDEX
-- =====================================================

CREATE INDEX idx_order_items_order_id
ON order_items(order_id);



-- =====================================================
-- Query 3: Create Index on Seller ID
-- Business Purpose:
-- Improve seller-based analysis and revenue calculations.
-- Concepts Used:
-- CREATE INDEX
-- =====================================================

CREATE INDEX idx_order_items_seller_id
ON order_items(seller_id);



-- =====================================================
-- Query 4: Create Index on Purchase Timestamp
-- Business Purpose:
-- Improve the performance of date-based queries such as monthly and yearly sales analysis.
-- Concepts Used:
-- CREATE INDEX
-- =====================================================

CREATE INDEX idx_orders_purchase_date
ON orders(order_purchase_timestamp);



-- =====================================================
-- Query 5: Create Index on Product ID
-- Business Purpose:
-- Improve joins between the products and order_items tables.
-- Concepts Used:
-- CREATE INDEX
-- =====================================================

CREATE INDEX idx_order_items_product_id
ON order_items(product_id);



-- =====================================================
-- Query 6: Display All Indexes
-- Business Purpose:
-- Verify the indexes created in the database schema.
-- Concepts Used:
-- System Catalog (pg_indexes)
-- =====================================================

SELECT *
FROM pg_indexes
WHERE schemaname = 'public';