# DROP database `northwind_dw`;
-- Deletes the databased named 'northwind_dw'
-- CREATE DATABASE `Northwind_DW` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
-- Could also do: CREATE SCHEMA 'Northwind_DW'
-- Creates an empty database named 'Northwind_DW'
USE northwind_dw2;

# DROP TABLE `dim_customers`;
CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;
-- Double-click the 'Northwind_DW' database to make it the default
-- database.
-- Primary key: each observation (row) in the table has a unique
-- primary key (which can be a null value).
-- Key: It's also known as an index. Create one for columns that will
-- be used in JOIN, WHERE, and GROUP BY clauses.

# DROP TABLE `dim_employees`;
CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  `web_page` longtext,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_products`;
CREATE TABLE `dim_products` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_shippers`;
CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_suppliers`;
CREATE TABLE `dim_suppliers` (
  `supplier_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`supplier_key`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;


-- ----------------------------------------------------------------------
-- TODO: JOIN the orders, order_details, order_details_status and 
--       orders_status tables to create a new Fact Table in Northwind_DW.
-- To keep things simple, don't include purchase order or inventory info
-- ----------------------------------------------------------------------
-- northwind.orders: A table of orders
SELECT * FROM northwind.orders;
-- northwind.orders_status: A table of the statuses in orders (e.g., New)
SELECT * FROM northwind.orders_status;
-- northwind.order_details: A table of additional information for each order
SELECT * FROM northwind.order_details;
-- northwind.order_details_status: A table of the statuses in order details (e.g., None)
SELECT * FROM northwind.order_details_status;

-- DROP TABLE `fact_orders`;
CREATE TABLE `fact_orders` (
	`fact_order_key` int NOT NULL AUTO_INCREMENT,
    `order_key` int DEFAULT NULL,
    `employee_key` int DEFAULT NULL,
    `customer_key` int DEFAULT NULL,
    `product_key` int DEFAULT NULL,
    `shipper_key` int DEFAULT NULL,
    `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
    `order_date` datetime DEFAULT NULL,
    `shipped_date` datetime DEFAULT NULL,
    `unit_price` decimal(19,4) DEFAULT '0.0000',
    `discount` double NOT NULL DEFAULT '0',
    `shipping_fee` decimal(19,4) DEFAULT '0.0000',
    `taxes` decimal(19,4) DEFAULT '0.0000',
    `payment_type` varchar(50) DEFAULT NULL,
    `paid_date` datetime DEFAULT NULL,
    `tax_rate` double DEFAULT '0',
    `order_status` varchar(50) NOT NULL,
    `order_details_status` varchar(50) NOT NULL,
    PRIMARY KEY (`fact_order_key`),
    KEY `order_key` (`order_key`),
    KEY `customer_key` (`customer_key`),
    KEY `employee_key` (`employee_key`),
    KEY `product_key` (`product_key`),
    KEY `shipper_key` (`shipper_key`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;

-- CREATE TABLE `fact_orders` (
--   `fact_order_key` int NOT NULL AUTO_INCREMENT,
--   `order_key` int(11) NOT NULL,
--   `employee_key` int DEFAULT NULL,
--   `customer_key` int DEFAULT NULL,
--   `product_key` int DEFAULT NULL,
--   `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
--   `unit_price` decimal(19,4) DEFAULT '0.0000',
--   `discount` double NOT NULL DEFAULT '0',
--   `date_allocated` datetime DEFAULT NULL,
--   `order_date` datetime DEFAULT NULL,
--   `shipped_date` datetime DEFAULT NULL,
--   `shipper_key` int DEFAULT NULL,
--   `ship_name` varchar(50) DEFAULT NULL,
--   `ship_address` longtext,
--   `ship_city` varchar(50) DEFAULT NULL,
--   `ship_state_province` varchar(50) DEFAULT NULL,
--   `ship_zip_postal_code` varchar(50) DEFAULT NULL,
--   `ship_country_region` varchar(50) DEFAULT NULL,
--   `shipping_fee` decimal(19,4) DEFAULT '0.0000',
--   `taxes` decimal(19,4) DEFAULT '0.0000',
--   `payment_type` varchar(50) DEFAULT NULL,
--   `paid_date` datetime DEFAULT NULL,
--   `tax_rate` double DEFAULT '0',
--   `order_status` varchar(50) NOT NULL,
--   `order_details_status` varchar(50) NOT NULL,
--   PRIMARY KEY (`fact_order_key`),
--   KEY `customer_key` (`customer_key`),
--   KEY `employee_key` (`employee_key`),
--   KEY `order_key` (`order_key`),
--   KEY `product_key` (`product_key`),
--   KEY `shipper_key` (`shipper_key`),
--   KEY `fk_orders_orders_status` (`order_status`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;