DROP TABLE IF EXISTS users;

-- Create the table
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Copy data from the CSV file into the table
COPY users(id, name, age) 
FROM '/docker-entrypoint-initdb.d/data.csv' 
DELIMITER ',' 
CSV HEADER;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

COPY customers(customer_id, customer_name) 
FROM '/docker-entrypoint-initdb.d/customers_sample.csv' 
DELIMITER ',' 
CSV HEADER;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

COPY orders(order_id, customer_id, order_date, total_amount) 
FROM '/docker-entrypoint-initdb.d/orders_sample.csv' 
DELIMITER ',' 
CSV HEADER;
