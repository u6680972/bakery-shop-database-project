create table shop_transaction
(
    transaction_id   serial
        primary key,
    shop_id          integer        not null
        constraint fk_transaction_shop
            references client
            on delete cascade,
    type             text           not null
        constraint shop_transaction_type_check
            check (type = ANY (ARRAY ['Income'::text, 'Expense'::text])),
    amount           numeric(10, 2) not null,
    category         text           not null,
    description      text,
    transaction_date date                     default CURRENT_DATE,
    created_at       timestamp with time zone default CURRENT_TIMESTAMP
)
    using ???;

alter table shop_transaction
    owner to root;


