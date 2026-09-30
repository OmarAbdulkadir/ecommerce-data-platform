# Architecture & Design Decisions

## Overview
A normalized relational database for an e-commerce platform,
designed to support both operational queries and business analytics.

## Schema Design

### Why 5 tables?
Data is split across 5 tables to avoid repetition and ensure
consistency — this is called normalization.

- `customers` — one row per customer, never repeated
- `products` — one row per product
- `orders` — one row per order placed
- `order_items` — one row per product line in an order
- `payments` — one row per payment transaction

### Why separate order_items from orders?
One order can contain multiple products. If we stored products
inside the orders table we'd have to repeat order information
for every product. Separating them keeps data clean.

### Why DECIMAL for price not FLOAT?
FLOAT has rounding errors. DECIMAL(10,2) stores exact values —
critical for money.

### Foreign Keys
Every order references a real customer. Every order_item
references a real order and product. PostgreSQL enforces this
automatically — you cannot insert an order for a customer
that doesn't exist.

## Current State
- PostgreSQL database with 5 normalized tables
- Sample data across all tables
- SQL analytics queries for business reporting

## Planned Extensions
- Python ETL scripts for automated data loading
- REST API ingestion layer
- Docker containerization
- dbt transformation layer
- Apache Airflow orchestration
- AWS cloud deployment