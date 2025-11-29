create table shop_availability
(
    availability_id serial
        primary key,
    shop_id         integer not null
        constraint fk_availability_shop
            references client
            on delete cascade,
    day_of_week     text    not null,
    is_open         boolean                  default true,
    open_time       time,
    close_time      time,
    max_orders      integer                  default 10,
    created_at      timestamp with time zone default CURRENT_TIMESTAMP,
    updated_at      timestamp with time zone default CURRENT_TIMESTAMP,
    constraint uq_shop_day
        unique (shop_id, day_of_week)
)
    using ???;

alter table shop_availability
    owner to root;


