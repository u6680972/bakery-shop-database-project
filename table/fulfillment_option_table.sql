create table fulfillment_option
(
    option_id serial
        primary key,
    shop_id   integer              not null
        constraint fk_shop
            references client
            on delete cascade,
    type      text                 not null,
    is_active boolean default true not null,
    constraint uq_shop_type
        unique (shop_id, type)
)
    using ???;

alter table fulfillment_option
    owner to root;

