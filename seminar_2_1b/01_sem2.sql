-- Active: 1790239338794@@127.0.0.1@5432@datacraftinglab_db
CREATE DATABASE datacraftinglab_db

create Table flourmills_sales(
    sales_id int PRIMARY KEY,
    sales_date date,
    region varchar(100),
    state_ varchar(100),
    product_category varchar(100),
    product_name varchar(150),
    customer_type varchar(100),
    customer_id INT,
    quantity_sold INT,
    unit_price decimal(10,2),
    discount_rate int,
    payment_method varchar(100),
    sales_rep VARCHAR(150),
    warehouse VARCHAR(100),
    delivery_status varchar(100),
    order_channel VARCHAR(100),
    batch_number INT,
    production_date date,
    total_amount decimal(10,2)
)