
#Advance;
#1. List the Top 3 Products by Revenue Contribution Percentage

SELECT p.product_name, 
       SUM(s.total_price) AS total_revenue, 
       (SUM(s.total_price) / (SELECT SUM(total_price) FROM Sales)) * 100 AS revenue_percentage 
FROM Sales s 
JOIN Products p ON s.product_id = p.product_id 
GROUP BY p.product_name 
ORDER BY revenue_percentage DESC 
LIMIT 3;

#2. Write a query to create a view named Total_Sales that displays the total sales amount for each product along with their names and categories.

CREATE VIEW Total_Sales AS
SELECT p.product_name, p.category, SUM(s.total_price) AS total_sales_amount
FROM Products p
JOIN Sales s ON p.product_id = s.product_id
GROUP BY p.product_name, p.category;
SELECT * FROM Total_Sales;

#3. Retrieve the product details (name, category, unit price) for products that have a quantity sold greater than the average quantity sold across all products.


SELECT product_name, category, unit_price
FROM Products
WHERE product_id IN (
    SELECT product_id
    FROM Sales
    GROUP BY product_id
    HAVING SUM(quantity_sold) > (SELECT AVG(quantity_sold) FROM Sales)
);

#4. Explain the significance of indexing in SQL databases and provide an example scenario where indexing could significantly improve query performance in the given schema.

-- Create an index on the sale_date column
CREATE INDEX idx_sale_date ON Sales (sale_date);

-- Query with indexing
SELECT *
FROM Sales
WHERE sale_date = '2024-01-03';

#5. Add a foreign key constraint to the Sales table that references the product_id column in the Products table.

ALTER TABLE Sales
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id)
REFERENCES Products(product_id);

#6. Create a view named Top_Products that lists the top 3 products based on the total quantity sold.


CREATE VIEW Top_Products AS
SELECT p.product_name, SUM(s.quantity_sold) AS total_quantity_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

