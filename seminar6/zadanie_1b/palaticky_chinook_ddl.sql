CREATE SCHEMA IF NOT EXISTS `chinook_dwh` DEFAULT CHARACTER SET utf8;
USE `chinook_dwh`;

CREATE TABLE IF NOT EXISTS `dim_customer` (
  `customer_key` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(40) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `company` VARCHAR(80) NULL,
  `address` VARCHAR(70) NULL,
  `city` VARCHAR(40) NULL,
  `state` VARCHAR(40) NULL,
  `country` VARCHAR(40) NULL,
  `postal_code` VARCHAR(10) NULL,
  `phone` VARCHAR(24) NULL,
  `email` VARCHAR(60) NOT NULL,
  `support_rep_name` VARCHAR(41) NULL,
  PRIMARY KEY (`customer_key`),
  UNIQUE INDEX `uq_dim_customer_customer_id` (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `dim_track` (
  `track_key` INT NOT NULL AUTO_INCREMENT,
  `track_id` INT NOT NULL,
  `track_name` VARCHAR(200) NOT NULL,
  `composer` VARCHAR(220) NULL,
  `milliseconds` INT NOT NULL,
  `bytes` INT NULL,
  `album_title` VARCHAR(160) NULL,
  `artist_name` VARCHAR(120) NULL,
  `genre_name` VARCHAR(120) NULL,
  `media_type_name` VARCHAR(120) NULL,
  PRIMARY KEY (`track_key`),
  UNIQUE INDEX `uq_dim_track_track_id` (`track_id`)
);

CREATE TABLE IF NOT EXISTS `dim_date` (
  `date_key` INT NOT NULL,
  `full_date` DATE NOT NULL,
  `day` SMALLINT NOT NULL,
  `month` SMALLINT NOT NULL,
  `month_name` VARCHAR(20) NOT NULL,
  `quarter` SMALLINT NOT NULL,
  `year` SMALLINT NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE INDEX `uq_dim_date_full_date` (`full_date`)
);

CREATE TABLE IF NOT EXISTS `fact_sales` (
  `sales_key` BIGINT NOT NULL AUTO_INCREMENT,
  `customer_key` INT NOT NULL,
  `track_key` INT NOT NULL,
  `date_key` INT NOT NULL,
  `invoice_id` INT NOT NULL,
  `invoice_line_id` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `quantity` INT NOT NULL,
  `line_total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`sales_key`),
  UNIQUE INDEX `uq_fact_sales_invoice_line_id` (`invoice_line_id`),
  INDEX `idx_fact_sales_customer` (`customer_key`),
  INDEX `idx_fact_sales_track` (`track_key`),
  INDEX `idx_fact_sales_date` (`date_key`),
  CONSTRAINT `fk_fact_sales_customer`
    FOREIGN KEY (`customer_key`) REFERENCES `dim_customer` (`customer_key`),
  CONSTRAINT `fk_fact_sales_track`
    FOREIGN KEY (`track_key`) REFERENCES `dim_track` (`track_key`),
  CONSTRAINT `fk_fact_sales_date`
    FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`)
);
