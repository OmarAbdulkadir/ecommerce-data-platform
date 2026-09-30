-- Sample customers
INSERT INTO customers (first_name, last_name, email, country)
VALUES (
        'Omar',
        'Abdulkadir',
        'omar@email.com',
        'Somalia'
    ),
    ('Ali', 'Hassan', 'ali@email.com', 'Turkey'),
    ('Sara', 'Ahmed', 'sara@email.com', 'UK'),
    ('John', 'Smith', 'john@email.com', 'USA');
-- Sample products
INSERT INTO products (name, category, price, stock_quantity)
VALUES ('Laptop', 'Electronics', 999.99, 50),
    ('Phone', 'Electronics', 499.99, 100),
    ('Desk Chair', 'Furniture', 249.99, 30),
    ('Headphones', 'Electronics', 79.99, 200),
    ('Notebook', 'Stationery', 4.99, 500);
-- Sample orders
INSERT INTO orders (customer_id, status)
VALUES (1, 'completed'),
    (2, 'completed'),
    (3, 'pending'),
    (1, 'completed');
-- Sample order items
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (5, 1, 1, 999.99),
    (5, 4, 2, 79.99),
    (6, 2, 1, 499.99),
    (7, 3, 1, 249.99),
    (8, 5, 3, 4.99);
-- Sample payments
INSERT INTO payments (order_id, amount, method, status)
VALUES (5, 1159.97, 'credit_card', 'completed'),
    (6, 499.99, 'paypal', 'completed'),
    (8, 14.97, 'credit_card', 'completed');