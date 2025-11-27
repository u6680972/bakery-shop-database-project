CREATE TABLE product (
     product_id SERIAL PRIMARY KEY,
     shop_id INT NOT NULL,
     name TEXT NOT NULL,
     description TEXT,
     price DECIMAL(10, 2),
     is_active BOOLEAN DEFAULT TRUE,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

     CONSTRAINT fk_product_shop
         FOREIGN KEY(shop_id)
             REFERENCES client(shop_id)
);