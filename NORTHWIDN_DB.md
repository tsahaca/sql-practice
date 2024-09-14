Here are the SQL statements you requested for the **Northwind Database**, covering various topics from subqueries to dynamic SQL:

### 1. **Subqueries**:
```sql
-- Subquery to find customers who placed more than 5 orders
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    GROUP BY CustomerID 
    HAVING COUNT(OrderID) > 5
);
```

### 2. **Joins**:
```sql
-- Inner Join to find customers and their respective orders
SELECT Customers.CustomerID, Customers.CompanyName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
```

### 3. **Aggregate Functions**:
```sql
-- Calculate total sales for each product
SELECT ProductID, SUM(UnitPrice * Quantity) AS TotalSales
FROM OrderDetails
GROUP BY ProductID;
```

### 4. **Window Functions**:
```sql
-- Calculate running total of sales for each employee
SELECT EmployeeID, OrderID, 
       SUM(Freight) OVER (PARTITION BY EmployeeID ORDER BY OrderID) AS RunningTotal
FROM Orders;
```

### 5. **Common Table Expressions (CTEs)**:
```sql
-- CTE to calculate total sales for each employee
WITH EmployeeSales AS (
    SELECT EmployeeID, SUM(Freight) AS TotalSales
    FROM Orders
    GROUP BY EmployeeID
)
SELECT * FROM EmployeeSales;
```

### 6. **Pivot Tables**:
```sql
-- Pivot table to summarize sales by employee and year
SELECT EmployeeID, 
       SUM(CASE WHEN YEAR(OrderDate) = 1996 THEN Freight ELSE 0 END) AS Sales1996,
       SUM(CASE WHEN YEAR(OrderDate) = 1997 THEN Freight ELSE 0 END) AS Sales1997
FROM Orders
GROUP BY EmployeeID;
```

### 7. **Unions and Intersections**:
```sql
-- Union of two queries
SELECT CustomerID FROM Orders
UNION
SELECT CustomerID FROM Customers;

-- Intersection using INNER JOIN to achieve similar behavior
SELECT CustomerID FROM Orders
INTERSECT
SELECT CustomerID FROM Customers;
```

### 8. **CASE Statements**:
```sql
-- Classify orders based on freight cost
SELECT OrderID, 
       CASE 
           WHEN Freight > 100 THEN 'High Freight'
           WHEN Freight > 50 THEN 'Medium Freight'
           ELSE 'Low Freight'
       END AS FreightCategory
FROM Orders;
```

### 9. **Recursive Queries**:
```sql
-- Example recursive query to traverse hierarchical data (like a category tree)
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT EmployeeID, ReportsTo, 1 AS Level
    FROM Employees
    WHERE ReportsTo IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.ReportsTo, eh.Level + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh ON e.ReportsTo = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;
```

### 10. **Ranking Functions**:
```sql
-- Rank employees based on total sales
SELECT EmployeeID, OrderID, 
       RANK() OVER (PARTITION BY EmployeeID ORDER BY OrderID DESC) AS Rank
FROM Orders;
```

### 11. **Data Modification Statements**:
```sql
-- Insert, Update, and Delete statements
INSERT INTO Products (ProductName, SupplierID, CategoryID, UnitPrice)
VALUES ('New Product', 1, 2, 10.00);

UPDATE Products
SET UnitPrice = UnitPrice * 1.10
WHERE CategoryID = 1;

DELETE FROM Products
WHERE ProductID = 99;
```

### 12. **Temporary Tables**:
```sql
-- Creating a temporary table to hold intermediate results
CREATE TEMPORARY TABLE TempOrderDetails AS
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails
GROUP BY ProductID;
```

### 13. **Grouping Sets**:
```sql
-- Use GROUPING SETS to generate subtotals
SELECT CustomerID, EmployeeID, SUM(Freight) AS TotalFreight
FROM Orders
GROUP BY GROUPING SETS (CustomerID, EmployeeID);
```

### 14. **Stored Procedures**:
```sql
-- Simple stored procedure to update product price
CREATE PROCEDURE UpdateProductPrice (IN productId INT, IN newPrice DECIMAL)
BEGIN
    UPDATE Products
    SET UnitPrice = newPrice
    WHERE ProductID = productId;
END;
```

### 15. **Indexing**:
```sql
-- Creating an index on the Customers table
CREATE INDEX idx_customer_name ON Customers (CompanyName);
```

### 16. **Materialized Views**:
```sql
-- Create a materialized view for frequently queried sales data
CREATE MATERIALIZED VIEW SalesSummary AS
SELECT ProductID, SUM(UnitPrice * Quantity) AS TotalSales
FROM OrderDetails
GROUP BY ProductID;
```

### 17. **Database Constraints**:
```sql
-- Adding a foreign key constraint
ALTER TABLE Orders
ADD CONSTRAINT fk_customer
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);
```

### 18. **Conditional Aggregation**:
```sql
-- Aggregate sales, but only include orders placed in 1997
SELECT ProductID, 
       SUM(CASE WHEN YEAR(OrderDate) = 1997 THEN UnitPrice * Quantity ELSE 0 END) AS SalesIn1997
FROM OrderDetails
GROUP BY ProductID;
```

### 19. **Window Frame Clauses**:
```sql
-- Calculate cumulative sum with window frame
SELECT OrderID, OrderDate,
       SUM(Freight) OVER (ORDER BY OrderDate ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS CumulativeFreight
FROM Orders;
```

### 20. **Dynamic SQL**:
```sql
-- Example of dynamic SQL using prepared statements
SET @sql = 'SELECT * FROM Products WHERE ProductID = ?';
PREPARE stmt FROM @sql;
SET @productId = 1;
EXECUTE stmt USING @productId;
```

These statements should help you explore and perform various database operations within the Northwind database. Let me know if you'd like further clarifications!