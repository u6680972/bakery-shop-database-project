create table manager_user
(
    user_id       integer default nextval('user_user_id_seq'::regclass) not null
        constraint user_pkey
            primary key,
    username      varchar(50)                                           not null
        constraint user_username_key
            unique,
    password_hash text                                                  not null,
    email         varchar(100)                                          not null
        constraint user_email_key
            unique,
    first_name    varchar(100),
    last_name     varchar(100),
    phone_number  text
)
    using ???;

alter table manager_user
    owner to root;

