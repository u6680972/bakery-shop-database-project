create table product
(
    product_id  serial
        primary key,
    shop_id     integer not null
        constraint fk_product_shop
            references client,
    name        text    not null,
    description text,
    price       numeric(10, 2),
    is_active   boolean                  default true,
    created_at  timestamp with time zone default CURRENT_TIMESTAMP
)
    using ???;

alter table product
    owner to root;

