from db import run_query


def main():
    print("\n── Total Revenue ──")
    results = run_query("""
        SELECT SUM(amount) AS total_revenue
        FROM payments WHERE status = 'completed'
    """)
    for row in results:
        print(f"  ${row['total_revenue']}")

    print("\n── Revenue by Customer ──")
    results = run_query("""
        SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN payments p ON o.order_id = p.order_id
        WHERE p.status = 'completed'
        GROUP BY c.customer_id, c.first_name, c.last_name
        ORDER BY total_spent DESC
    """)
    for row in results:
        print(f"  {row['first_name']} {row['last_name']}: ${row['total_spent']}")

    print("\n── Best Selling Products ──")
    results = run_query("""
        SELECT pr.name, SUM(oi.quantity) AS units_sold
        FROM products pr
        JOIN order_items oi ON pr.product_id = oi.product_id
        GROUP BY pr.product_id, pr.name
        ORDER BY units_sold DESC
    """)
    for row in results:
        print(f"  {row['name']}: {row['units_sold']} units")


if __name__ == "__main__":
    main()
