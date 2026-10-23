-- ==========================================
-- DATABASE SYSTEM PROJECT
-- E-COMMERCE SALES & CUSTOMER ANALYTICS
-- ==========================================

CREATE DATABASE E_Commerce_db;
USE E_Commerce_db;

--  PRODUCTS TABLE
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop', 'Electronics', 120000, 10),
('Mobile Phone', 'Electronics', 60000, 20),
('Headphones', 'Accessories', 5000, 50),
('Smart Watch', 'Accessories', 15000, 15),
('Keyboard', 'Accessories', 3000, 30);



--  CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customers (customer_name, email, city) VALUES
('Ali Khan', 'ali@gmail.com', 'Karachi'),
('Sara Ahmed', 'sara@gmail.com', 'Lahore'),
('Ahmed Raza', 'ahmed@gmail.com', 'Islamabad'),
('Ayesha Noor', 'ayesha@gmail.com', 'Karachi');

-- SALES TABLE
CREATE TABLE sales (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    total_price DECIMAL(10,2),

    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sales data
INSERT INTO sales (product_id, customer_id, sale_date, quantity, total_price) VALUES
(1, 1, '2024-01-10', 1, 120000),
(2, 2, '2024-01-15', 1, 60000),
(3, 3, '2024-02-05', 2, 10000),
(4, 1, '2024-02-10', 1, 15000),
(5, 4, '2024-03-01', 2, 6000),
(2, 1, '2024-03-05', 1, 60000);


-- QUERIES


-- 1️. Top Selling Products (Most Sold)
SELECT
p.product_name, SUM(s.quantity) AS total_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;


-- 2️. Most Active Customers
SELECT 
c.customer_name, COUNT(s.sale_id) AS total_orders
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;


-- 3️. Total Revenue Generated
SELECT
SUM(total_price) AS total_revenue
FROM sales;

-- 4️. Monthly Revenue Analysis
SELECT 
     MONTH(sale_date) AS 
     month, SUM(total_price) AS monthly_revenue
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY month;


-- 5️. Revenue by Product Category
SELECT 
    p.category,
    SUM(s.total_price) AS category_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category;

-- 6️.Customers City-wise Analysis
SELECT 
     city,
     COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city;