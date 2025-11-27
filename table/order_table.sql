CREATE TABLE "order" (
    order_id SERIAL PRIMARY KEY,
    shop_id INT NOT NULL,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_orders_shop
        FOREIGN KEY(shop_id)
            REFERENCES client(shop_id)
);