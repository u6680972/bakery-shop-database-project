create table "order"
(
    order_id     serial
        primary key,
    shop_id      integer not null
        constraint fk_orders_shop
            references client,
    customer_id  integer,
    total_amount numeric(10, 2),
    status       text                     default 'pending'::text,
    created_at   timestamp with time zone default CURRENT_TIMESTAMP
)
    using ???;

alter table "order"
    owner to root;

