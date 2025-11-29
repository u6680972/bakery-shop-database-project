create table shop_special_date
(
    special_date_id serial
        primary key,
    shop_id         integer not null
        constraint fk_special_date_shop
            references client
            on delete cascade,
    date            date    not null,
    status          text    not null,
    note            text,
    created_at      timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at      timestamp with time zone default CURRENT_TIMESTAMP,
    constraint uq_shop_date
        unique (shop_id, date)
)
    using ???;

alter table shop_special_date
    owner to root;


