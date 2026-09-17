
SELECT 
  o.order_id, 
  c.customer_name, 
  c.city, 
  o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- Question 2: JOIN (order_items + products)
SELECT 
  oi.order_item_id, 
  oi.order_id, 
  p.product_name, 
  p.category, 
  p.price, 
  oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;

-- Question 3: LEFT JOIN (customers + orders)
SELECT 
  c.customer_id, 
  c.customer_name, 
  o.order_id, 
  o.order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;

-- Question 4: CTE for Above-Average Customer Spend
WITH customer_totals AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    NVL(SUM(oi.quantity * p.price), 0) AS total_spent
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  LEFT JOIN order_items oi ON o.order_id = oi.order_id
  LEFT JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT 
  customer_id, 
  customer_name, 
  total_spent
FROM customer_totals
WHERE total_spent > (SELECT AVG(total_spent) FROM customer_totals)
ORDER BY total_spent DESC;

-- Question 5: Window Function - Rank customers by total spent
WITH spend_summary AS (
  SELECT 
    c.customer_id,
    c.customer_name,
    NVL(SUM(oi.quantity * p.price), 0) AS total_spent
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id
  LEFT JOIN order_items oi ON o.order_id = oi.order_id
  LEFT JOIN products p ON oi.product_id = p.product_id
  GROUP BY c.customer_id, c.customer_name
)
SELECT 
  customer_id,
  customer_name,
  total_spent,
  DENSE_RANK() OVER (ORDER BY total_spent DESC) AS spend_rank
FROM spend_summary;

-- Question 6: Window Function - Number each customer's orders
SELECT 
  o.customer_id,
  c.customer_name,
  o.order_id,
  o.order_date,
  ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS order_sequence
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.customer_id, order_sequence;

-- Question 7: Window Function - Running total of revenue over time
WITH daily_sales AS (
  SELECT 
    o.order_date,
    SUM(oi.quantity * p.price) AS daily_revenue
  FROM orders o
  JOIN order_items oi ON o.order_id = oi.order_id
  JOIN products p ON oi.product_id = p.product_id
  GROUP BY o.order_date
)
SELECT 
  order_date,
  daily_revenue,
  SUM(daily_revenue) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_revenue
FROM daily_sales
ORDER BY order_date;

-- Question 8: Window Function - Days between consecutive orders per customer
WITH order_lags AS (
  SELECT 
    o.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS prev_order_date
  FROM orders o
  JOIN customers c ON o.customer_id = c.customer_id
)
SELECT 
  customer_id,
  customer_name,
  order_id,
  order_date,
  prev_order_date,
  (order_date - prev_order_date) AS days_between_orders
FROM order_lags
WHERE prev_order_date IS NOT NULL
ORDER BY customer_id, order_date;
