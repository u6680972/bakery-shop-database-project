create table client
(
    shop_id                 serial
        primary key,
    owner_id                integer      not null
        unique
        references manager_user
            on delete restrict,
    shop_name               varchar(100) not null
        unique,
    phone_number            text,
    email                   text,
    address                 text,
    plan_name               text           default 'Starter'::text,
    plan_price              numeric(10, 2) default 29.99,
    billing_cycle           text           default 'Monthly'::text,
    next_billing_date       date,
    is_auto_renewal_enabled boolean        default true,
    subscription_status     text           default 'Active'::text
)
    using ???;

alter table client
    owner to root;

