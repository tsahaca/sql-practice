-- Create the table
CREATE TABLE persons (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Load the CSV into the table
LOAD DATA INFILE '/csv/data.csv'
INTO TABLE persons
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name, age);