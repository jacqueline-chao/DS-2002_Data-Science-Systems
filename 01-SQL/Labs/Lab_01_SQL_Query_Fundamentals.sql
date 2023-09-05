-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
SELECT COUNT(*) FROM northwind.products;

-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name, quantity_per_unit
FROM northwind.products;

-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
SELECT id as product_id, product_name -- Referred to as "aliasing" (SELECT id as product_id)
FROM northwind.products
WHERE discontinued = 0; -- 0: Product NOT discontinued, 1: Product discontinued

-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
SELECT id as product_id, product_name
FROM northwind.products
WHERE discontinued = 1;

-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
SELECT product_name, list_price
FROM northwind.products
WHERE list_price = (SELECT max(list_price) FROM northwind.products) OR list_price = (SELECT min(list_price) FROM northwind.products);

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
SELECT id as product_id, product_name, list_price
FROM northwind.products
WHERE list_price < 20;

-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
SELECT id as product_id, product_name, list_price
FROM northwind.products
WHERE 15 < list_price < 20;

-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
SELECT product_name, list_price
FROM northwind.products
WHERE list_price > (SELECT avg(list_price) FROM northwind.products);

-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name, list_price
FROM northwind.products
ORDER BY list_price DESC
LIMIT 10;

-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
SELECT COUNT(*)
FROM northwind.products
WHERE discontinued = 0 OR discontinued = 1;

-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
-- SELECT product_name, status_id
-- FROM northwind.products
-- JOIN northwind.order_details
-- ON northwind.products.id = northwind.order_details.product_id;
-- Records (rows) w/ a value that have a match (row w/ the same value)
-- in the other table will be included in the result set. Rows that
-- don't have a match row in the other table will not be included in
-- the result set.

-- SELECT product_name, reorder_level, target_level, quantity_per_unit
-- FROM northwind.products;

SELECT target_level as units_on_order, reorder_level as units_in_stock
FROM northwind.products
WHERE reorder_level < target_level;
-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------



-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------



-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
