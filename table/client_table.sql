create table client
(
    shop_id      serial
        primary key,
    owner_id     integer      not null
        unique
        references manager_user
            on delete restrict,
    shop_name    varchar(100) not null
        unique,
    phone_number text,
    email        text
)
    using ???;

alter table client
    owner to root;

