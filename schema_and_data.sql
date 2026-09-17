-- DBMS: Oracle Database 21c

-- 1. DROP TABLES (for clean execution)
DROP TABLE order_items CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE products CASCADE CONSTRAINTS;
DROP TABLE customers CASCADE CONSTRAINTS;

-- 2. CREATE TABLES
CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email VARCHAR2(100),
  city VARCHAR2(50)
);

CREATE TABLE products (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category VARCHAR2(50),
  price NUMBER(10,2)
);

CREATE TABLE orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id NUMBER REFERENCES orders(order_id),
  product_id NUMBER REFERENCES products(product_id),
  quantity NUMBER
);

-- 3. INSERT SAMPLE DATA
INSERT INTO customers VALUES (1, 'Alice Smith', 'alice@example.com', 'Kigali');
INSERT INTO customers VALUES (2, 'Bob Jones', 'bob@example.com', 'Musanze');
INSERT INTO customers VALUES (3, 'Charlie Brown', 'charlie@example.com', 'Kigali');
INSERT INTO customers VALUES (4, 'Diana Prince', 'diana@example.com', 'Huye');
INSERT INTO customers VALUES (5, 'Evan Wright', 'evan@example.com', 'Musanze');
INSERT INTO customers VALUES (6, 'Fiona Gallagher', 'fiona@example.com', 'Rubavu');

INSERT INTO products VALUES (101, 'Organic Milk 1L', 'Dairy', 4.50);
INSERT INTO products VALUES (102, 'Cheddar Cheese 250g', 'Dairy', 6.00);
INSERT INTO products VALUES (103, 'Whole Wheat Bread', 'Bakery', 3.20);
INSERT INTO products VALUES (104, 'Chocolate Chip Cookies', 'Bakery', 4.80);
INSERT INTO products VALUES (105, 'Apples 1kg', 'Produce', 3.00);
INSERT INTO products VALUES (106, 'Bananas 1kg', 'Produce', 1.80);
INSERT INTO products VALUES (107, 'Chicken Breast 1kg', 'Meat', 12.00);
INSERT INTO products VALUES (108, 'Ribeye Steak 500g', 'Meat', 22.50);

INSERT INTO orders VALUES (1, 1, DATE '2026-08-01');
INSERT INTO orders VALUES (2, 2, DATE '2026-08-02');
INSERT INTO orders VALUES (3, 1, DATE '2026-08-05');
INSERT INTO orders VALUES (4, 3, DATE '2026-08-06');
INSERT INTO orders VALUES (5, 4, DATE '2026-08-10');
INSERT INTO orders VALUES (6, 2, DATE '2026-08-12');
INSERT INTO orders VALUES (7, 5, DATE '2026-08-15');
INSERT INTO orders VALUES (8, 1, DATE '2026-08-18');
INSERT INTO orders VALUES (9, 3, DATE '2026-08-20');
INSERT INTO orders VALUES (10, 4, DATE '2026-08-22');
INSERT INTO orders VALUES (11, 2, DATE '2026-08-25');
INSERT INTO orders VALUES (12, 5, DATE '2026-08-27');
INSERT INTO orders VALUES (13, 1, DATE '2026-09-01');
INSERT INTO orders VALUES (14, 3, DATE '2026-09-05');
INSERT INTO orders VALUES (15, 4, DATE '2026-09-10');

INSERT INTO order_items VALUES (1001, 1, 101, 2);
INSERT INTO order_items VALUES (1002, 1, 103, 1);
INSERT INTO order_items VALUES (1003, 2, 105, 3);
INSERT INTO order_items VALUES (1004, 2, 107, 1);
INSERT INTO order_items VALUES (1005, 3, 102, 2);
INSERT INTO order_items VALUES (1006, 3, 108, 1);
INSERT INTO order_items VALUES (1007, 4, 104, 2);
INSERT INTO order_items VALUES (1008, 4, 106, 5);
INSERT INTO order_items VALUES (1009, 5, 107, 2);
INSERT INTO order_items VALUES (1010, 5, 101, 1);
INSERT INTO order_items VALUES (1011, 6, 108, 2);
INSERT INTO order_items VALUES (1012, 7, 103, 3);
INSERT INTO order_items VALUES (1013, 7, 105, 2);
INSERT INTO order_items VALUES (1014, 8, 102, 1);
INSERT INTO order_items VALUES (1015, 8, 104, 2);
INSERT INTO order_items VALUES (1016, 9, 101, 4);
INSERT INTO order_items VALUES (1017, 10, 107, 1);
INSERT INTO order_items VALUES (1018, 10, 108, 1);
INSERT INTO order_items VALUES (1019, 11, 106, 4);
INSERT INTO order_items VALUES (1020, 12, 105, 2);
INSERT INTO order_items VALUES (1021, 12, 103, 2);
INSERT INTO order_items VALUES (1022, 13, 108, 1);
INSERT INTO order_items VALUES (1023, 13, 102, 2);
INSERT INTO order_items VALUES (1024, 14, 107, 2);
INSERT INTO order_items VALUES (1025, 15, 104, 3);

COMMIT;
