create table "order"
(
    order_id           serial
        primary key,
    shop_id            integer not null
        constraint fk_orders_shop
            references client,
    customer_id        integer,
    total_amount       numeric(10, 2),
    status             text                     default 'pending'::text
        constraint chk_orders_status
            check (status = ANY
                   (ARRAY ['Awaiting Quote'::text, 'Awaiting Payment'::text, 'Awaiting Confirmation'::text, 'Confirmed'::text, 'In Process'::text, 'Ready for Pickup'::text, 'Ready for Delivery'::text, 'Finished'::text, 'Cancelled'::text])),
    created_at         timestamp with time zone default CURRENT_TIMESTAMP,
    deadline           timestamp with time zone,
    deposit_amount     numeric(10, 2)           default 0.00,
    deposit_status     text                     default 'Pending'::text,
    notes              text,
    fulfillment_method text
        constraint order_fulfillment_method_check
            check (fulfillment_method = ANY (ARRAY ['Pick Up'::text, 'Delivery'::text])),
    delivery_address   text,
    payment_slip_url   text
)
    using ???;

alter table "order"
    owner to root;

