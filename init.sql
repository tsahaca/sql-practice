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