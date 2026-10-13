CREATE DATABASE OnlineRetailAnalytics;
GO
USE OnlineRetailAnalytics;
GO

-- Run after importing online_retail_analytics.csv into dbo.RetailTransactions.

-- 1. Data and KPI validation
SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS MissingDescriptions,
    COUNT(DISTINCT InvoiceNo) AS UniqueInvoices,
    COUNT(DISTINCT StockCode) AS UniqueProducts,
    COUNT(DISTINCT CustomerID) AS IdentifiedCustomers
FROM dbo.RetailTransactions;

-- 2. Monthly gross sales revenue
SELECT YEAR(InvoiceDate) AS SalesYear, MONTH(InvoiceDate) AS SalesMonth,
       SUM(LineRevenue) AS GrossRevenueGBP,
       COUNT(DISTINCT InvoiceNo) AS EligibleSalesInvoices
FROM dbo.RetailTransactions
WHERE Quantity > 0 AND UnitPrice > 0 AND is_cancellation_invoice = 0
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY SalesYear, SalesMonth;
GO

-- 3. Top 10 countries by gross sales revenue
SELECT TOP (10) Country,
       SUM(LineRevenue) AS GrossRevenueGBP,
       COUNT(DISTINCT InvoiceNo) AS InvoiceCount
FROM dbo.RetailTransactions
WHERE Quantity > 0 AND UnitPrice > 0 AND is_cancellation_invoice = 0
GROUP BY Country
ORDER BY GrossRevenueGBP DESC;
GO

-- 4. Top 10 merchandise products by revenue
SELECT TOP (10) StockCode, MAX(Description) AS ProductDescription,
       SUM(LineRevenue) AS GrossRevenueGBP,
       SUM(Quantity) AS UnitsSold,
       COUNT(DISTINCT InvoiceNo) AS InvoiceCount
FROM dbo.RetailTransactions
WHERE Quantity > 0 AND UnitPrice > 0 AND is_cancellation_invoice = 0
  AND StockCode NOT IN ('DOT', 'POST', 'M')
GROUP BY StockCode
ORDER BY GrossRevenueGBP DESC;
GO

-- 5. Repeat vs one-time customers, based on eligible sales invoices
WITH CustomerOrders AS (
    SELECT CustomerID,
           COUNT(DISTINCT InvoiceNo) AS TotalOrders,
           SUM(LineRevenue) AS TotalRevenue
    FROM dbo.RetailTransactions
    WHERE CustomerID IS NOT NULL
      AND Quantity > 0 AND UnitPrice > 0
      AND is_cancellation_invoice = 0
    GROUP BY CustomerID
),
CustomerSegments AS (
    SELECT CustomerID, TotalOrders, TotalRevenue,
           CASE WHEN TotalOrders > 1 THEN 'Repeat' ELSE 'One-Time' END AS CustomerType
    FROM CustomerOrders
)
SELECT CustomerType, COUNT(*) AS Customers,
       SUM(TotalRevenue) AS RevenueGBP,
       SUM(TotalOrders) AS TotalOrders,
       AVG(TotalRevenue) AS AverageRevenuePerCustomer
FROM CustomerSegments
GROUP BY CustomerType
ORDER BY CustomerType;
GO

-- 6. Units sold validation
SELECT SUM(Quantity) AS UnitsSold, COUNT(*) AS EligibleRows
FROM dbo.RetailTransactions
WHERE Quantity > 0 AND UnitPrice > 0 AND is_cancellation_invoice = 0;
GO
