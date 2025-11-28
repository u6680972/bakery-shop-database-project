create table order_item
(
    order_item_id       serial
        primary key,
    order_id            integer not null
        constraint fk_order_item_order
            references "order"
            on delete cascade,
    product_name        text    not null,
    quantity            integer                  default 1,
    price               numeric(10, 2),
    notes               text,
    created_at          timestamp with time zone default CURRENT_TIMESTAMP,
    reference_image_url text
)
    using ???;

alter table order_item
    owner to root;

