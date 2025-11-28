create table shop_manager_access
(
    access_id       serial
        primary key,
    manager_user_id integer not null
        references manager_user
            on delete cascade,
    shop_id         integer not null
        references client
            on delete cascade,
    unique (manager_user_id, shop_id)
)
    using ???;

alter table shop_manager_access
    owner to root;

