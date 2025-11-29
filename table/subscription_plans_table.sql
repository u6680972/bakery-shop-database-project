create table platform_plans
(
    plan_id       serial
        primary key,
    name          text           not null
        unique,
    price_monthly numeric(10, 2) not null,
    description   text,
    features      text[],
    is_popular    boolean default false,
    is_current    boolean default false
)
    using ???;

alter table platform_plans
    owner to root;


