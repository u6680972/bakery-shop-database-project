CREATE TABLE shop_manager_access (
     access_id SERIAL PRIMARY KEY,
     manager_user_id INT NOT NULL REFERENCES "user"(user_id) ON DELETE CASCADE,
     shop_id INT NOT NULL REFERENCES client(shop_id) ON DELETE CASCADE,
     first_name VARCHAR(100),
     last_name VARCHAR(100),
     UNIQUE (manager_user_id, shop_id)
);