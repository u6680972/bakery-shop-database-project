CREATE TABLE fulfillment_option (
    option_id SERIAL PRIMARY KEY,
    shop_id INT NOT NULL,
    type TEXT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_shop
        FOREIGN KEY(shop_id)
            REFERENCES client(shop_id)
            ON DELETE CASCADE,

    CONSTRAINT uq_shop_type UNIQUE (shop_id, type)
);