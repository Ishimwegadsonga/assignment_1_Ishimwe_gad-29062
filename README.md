PL/SQL Assignment One — Sunrise Supermarket

Instructor:** Eric Maniraguha  
TA: Afanyu Emmanuel  
Student Name:Ishimwe Gad  
Student ID: 29062  
DBMS Used: Oracle Database 21c (PL/SQL)

 1. Business Scenario Summary
Sunrise Supermarket is a retail store analyzing customer behavior, sales trends, and purchasing frequency. This repository contains SQL scripts that link customer data with orders, track overall revenue growth over time, identify high-value spenders, and analyze purchase frequency patterns.


 2. File Descriptions & Setup
- `schema_and_data.sql`: Script to drop/create tables (`customers`, `products`, `orders`, `order_items`) and insert test data.
- `queries.sql`: Contains solutions for all 8 queries (JOINs, CTE, and Window Functions).
- `README.md`: Project summary, query explanations, and business interpretations.
 3. Query Explanations & Business Interpretations

1. INNER JOIN (Orders + Customers)
- Explanation: Joins `orders` and `customers` to show order details alongside customer name and city.
- Business Value:** Provides a clear view of where active buyers are geographically located.

 2. JOIN (Order Items + Products)
- Explanation:** Links `order_items` with `products` to show individual product names, categories, and prices.
- Business Value:** Identifies which specific items drive store order volume.

3. LEFT JOIN (Customers + Orders)
- Explanation:** Displays all customers, including those with zero orders.
- Business Value:** Highlights inactive registered users (e.g., Fiona Gallagher) who can be targeted with promotional discounts to encourage first purchases.

4. CTE Query (Above-Average Spenders)
- Explanation:** Uses a CTE to calculate individual spending, then filters for customers who spent above the store average.
- **Business Value:** Pinpoints top revenue-generating customers for loyalty rewards.

5. DENSE_RANK() (Customer Spend Ranking)
- Explanation:** Ranks customers from highest total spend to lowest.
- Business Value:** Segments customers into distinct tier rankings.

 6. ROW_NUMBER() (Order Sequencing)
- Explanation: Numbers each customer's orders chronologically (1st purchase, 2nd purchase, etc.).
- Business Value: Tracks customer retention and purchasing cadence over time.

 7. SUM() OVER () (Running Total Revenue)
- Explanation:** Computes cumulative store revenue over time ordered by purchase date.
- Business Value:** Tracks sales trajectories and revenue milestones.

 8. LAG() (Days Between Orders)
- Explanation: Calculates the number of days elapsed between consecutive orders for repeat buyers.
- Business Value: Reveals repeat purchase timing (typically 4–7 days) to set optimal re-marketing intervals.

- 4. Challenges & Resolutions
- Handling NULLs on Inactive Users: Used `NVL(SUM(...), 0)` to ensure users without orders returned `0` spend rather than null values.
- Running Total Duplication:** Aggregated daily revenue prior to applying `SUM() OVER ()` to prevent duplicate values on multi-order dates.


## 4. Challenges & Resolutions
- **Handling NULLs on Inactive Users:** Used `NVL(SUM(...), 0)` to ensure users without orders returned `0` spend rather than null values.
- **Running Total Duplication:** Aggregated daily revenue prior to applying `SUM() OVER ()` to prevent duplicate values on multi-order dates.
