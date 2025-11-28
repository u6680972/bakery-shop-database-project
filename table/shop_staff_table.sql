create table shop_staff
(
    staff_id     serial
        primary key,
    shop_id      integer not null
        constraint fk_shop_staff_shop
            references client
            on delete cascade,
    first_name   text    not null,
    last_name    text    not null,
    email        text,
    phone_number text,
    job_title    text,
    status       text                     default 'active'::text,
    hired_at     date                     default CURRENT_DATE,
    created_at   timestamp with time zone default CURRENT_TIMESTAMP
)
    using ???;

alter table shop_staff
    owner to root;


