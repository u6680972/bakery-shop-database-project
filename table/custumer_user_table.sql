create table customer_user
(
    customer_id   serial
        constraint shop_customer_pkey
            primary key,
    shop_id       integer      not null
        constraint shop_customer_shop_id_fkey
            references client
            on delete restrict,
    first_name    varchar(100) not null,
    last_name     varchar(100) not null,
    email         varchar(100) not null,
    password_hash text         not null,
    phone_number  text,
    constraint shop_customer_shop_id_email_key
        unique (shop_id, email),
    constraint uq_shop_customer_phone
        unique (shop_id, phone_number)
)
    using ???;

alter table customer_user
    owner to root;

