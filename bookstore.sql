-- Active: 1742308965867@@127.0.0.1@5432@bookstore_db
-- Create books table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) CHECK (price >= 0),
    stock INT CHECK (stock >= 0),
    published_year INT
);

-- Create customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
   joined_date DATE DEFAULT CURRENT_DATE
);

-- Create orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    book_id INT REFERENCES books(id),
    quantity INT CHECK (quantity > 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data into books table
INSERT INTO books (title, author, price, stock, published_year) VALUES
('The Pragmatic Programmer', 'Andrew Hunt', 40.00, 10, 1999),
('Clean Code', 'Robert C. Martin', 35.00, 5, 2008),
('You Don''t Know JS', 'Kyle Simpson', 30.00, 8, 2014),
('Refactoring', 'Martin Fowler', 50.00, 3, 1999),
('Database Design Principles', 'Jane Smith', 20.00, 0, 2018);

-- Select all data from books table
SELECT * FROM books;

-- Insert data into customers table
INSERT INTO customers (name, email, joined_date) VALUES
('Alice', 'alice@email.com', '2023-01-10'),
('Bob', 'bob@email.com', '2022-05-15'),
('Charlie', 'charlie@email.com', '2023-06-20');

-- Select all data from customers table
SELECT * FROM customers;

-- Insert data into orders table
INSERT INTO orders (customer_id, book_id, quantity, order_date) VALUES
(1, 2, 1, '2024-03-10'),
(2, 1, 1, '2024-02-20'),
(1, 3, 2, '2024-03-05');

-- Select all data from orders table
SELECT * FROM orders;

-- 1. Find books that are out of stock
-- WHERE is used to filter rows based on a condition of a column such as stock = 0
SELECT title FROM books WHERE stock = 0;

-- 2. Retrieve the most expensive book in the store
-- ORDER BY is used to sort the result set in ascending or descending order 
-- LIMIT is used to limit the number of rows returned by a query. Here, we limit the result to 1 row.
-- DESC is used to sort the result set in descending order 
SELECT * FROM books ORDER BY price DESC LIMIT 1;

-- 3. Find the total number of orders placed by each customer
-- COUNT is used to count the number of rows such as orders.id. It is an aggregate function.
-- AS is used to give an alias name to the result column such as total_orders
-- JOIN is used to combine rows from two or more tables based on a related column such as customers.id = orders.customer_id
-- GROUP BY is used to group rows that have the same values such as customers.name
SELECT customers.name, COUNT(orders.id) AS total_orders
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;

-- 4. Calculate the total revenue generated from book sales
-- SUM is used to calculate the sum of a column such as books.price * orders.quantity
-- AS is used to give an alias name to the result column such as total_revenue
-- JOIN is used to combine rows from two or more tables based on a related column such as orders.book_id = books.id
SELECT SUM(books.price * orders.quantity) AS total_revenue
FROM orders
JOIN books ON orders.book_id = books.id;

-- 5. List all customers who have placed more than one order
-- HAVING is used to filter rows based on a condition of an aggregate function such as COUNT(orders.id) > 1
SELECT customers.name, COUNT(orders.id) AS orders_count
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name
HAVING COUNT(orders.id) > 1;

-- 6. Find the average price of books in the store 
-- AVG is used to calculate the average value of a column such as price
-- ROUND is used to round the result to a specified number of decimal places such as 2
SELECT ROUND(AVG(price), 2) AS avg_book_price FROM books;

-- 7. Increase the price of all books published before 2000 by 10%
-- UPDATE is used to modify existing records in a table based on a condition such as published_year < 2000
-- SET is used to set a new value for a column such as price = price * 1.10
UPDATE books 
SET price = price * 1.10 
WHERE published_year < 2000;

-- 8. Delete customers who haven't placed any orders
-- DELETE is used to remove rows from a table based on a condition 
-- NOT IN is used to filter rows that are not in a subquery result such as SELECT customer_id FROM orders
-- Here, we delete customers who do not have a corresponding entry in the orders table.
DELETE FROM customers WHERE id NOT IN (SELECT customer_id FROM orders);