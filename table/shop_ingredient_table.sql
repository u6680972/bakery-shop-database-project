create table shop_ingredient
(
    ingredient_id       serial
        primary key,
    shop_id             integer        not null
        constraint fk_ingredient_shop
            references client
            on delete cascade,
    name                text           not null,
    cost                numeric(10, 2) not null,
    unit                text,
    last_purchased_date date,
    created_at          timestamp with time zone default CURRENT_TIMESTAMP
)
    using ???;

alter table shop_ingredient
    owner to root;


