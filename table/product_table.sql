create table product
(
    product_id        serial
        primary key,
    shop_id           integer not null
        constraint fk_product_shop
            references client,
    name              text    not null,
    description       text,
    price             numeric(10, 2),
    is_active         boolean                  default true,
    created_at        timestamp with time zone default CURRENT_TIMESTAMP,
    category          text,
    stock_quantity    integer                  default 0,
    image_url         text,
    updated_at        timestamp with time zone default CURRENT_TIMESTAMP,
    min_stock_level   integer                  default 5,
    max_stock_level   integer                  default 50,
    unit_type         text                     default 'pieces'::text,
    last_restocked_at timestamp with time zone,
    stock_status      text generated always as (
        CASE
            WHEN (stock_quantity <= min_stock_level) THEN 'Low Stock'::text
            WHEN (stock_quantity >= max_stock_level) THEN 'Overstocked'::text
            ELSE 'Medium'::text
            END) stored
)
    using ???;

alter table product
    owner to root;

