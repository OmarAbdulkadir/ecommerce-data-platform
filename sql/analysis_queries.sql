-- 1. Total revenue
SELECT SUM(amount) AS total_revenue
FROM payments
WHERE status = 'completed';
-- 2. Revenue by customer
SELECT c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'completed'
GROUP BY c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC;
-- 3. Best selling products
SELECT pr.name,
    SUM(oi.quantity) AS units_sold
FROM products pr
    JOIN order_items oi ON pr.product_id = oi.product_id
GROUP BY pr.product_id,
    pr.name
ORDER BY units_sold DESC;
-- 4. Orders with no payment yet
SELECT o.order_id,
    c.first_name,
    c.last_name,
    o.status
FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;