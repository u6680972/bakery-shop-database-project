create table shop_invitation
(
    invitation_code   varchar(32)             not null
        primary key,
    shop_id           integer                 not null
        references client
            on delete cascade,
    issued_by_user_id integer                 not null
        references manager_user
            on delete restrict,
    expires_at        timestamp               not null,
    used_by_user_id   integer
        unique
        references manager_user
            on delete restrict,
    created_at        timestamp default now() not null
)
    using ???;

alter table shop_invitation
    owner to root;

