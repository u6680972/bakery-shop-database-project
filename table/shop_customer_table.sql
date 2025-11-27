CREATE TABLE shop_customer (
    customer_id SERIAL PRIMARY KEY,
    shop_id INT NOT NULL REFERENCES client(shop_id) ON DELETE RESTRICT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash TEXT NOT NULL,
    UNIQUE (shop_id, email)
);