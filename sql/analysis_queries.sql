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
-- 5. Monthly revenue trend
SELECT DATE_TRUNC('month', paid_at) AS month,
    SUM(amount) AS monthly_revenue,
    COUNT(*) AS total_payments
FROM payments
WHERE status = 'completed'
GROUP BY DATE_TRUNC('month', paid_at)
ORDER BY month;
-- 6. Product category performance
SELECT pr.category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM products pr
    JOIN order_items oi ON pr.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
GROUP BY pr.category
ORDER BY revenue DESC;
-- 7. Average order value
SELECT ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
        SELECT order_id,
            SUM(unit_price * quantity) AS order_total
        FROM order_items
        GROUP BY order_id
    ) AS order_totals;
-- 8. Customer order frequency
SELECT c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders,
    SUM(p.amount) AS lifetime_value
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id,
    c.first_name,
    c.last_name
ORDER BY lifetime_value DESC NULLS LAST;
-- 9. Top customers by country
SELECT c.country,
    COUNT(DISTINCT c.customer_id) AS customers,
    SUM(p.amount) AS total_revenue
FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN payments p ON o.order_id = p.order_id
GROUP BY c.country
ORDER BY total_revenue DESC NULLS LAST;
-- 10. Products never ordered
SELECT p.name,
    p.category,
    p.stock_quantity
FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL;