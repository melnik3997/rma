create table t_position (id int8 not null,
                         post_id int8 not null,
                         institution_id int8 not null ,
                         subdivision_id int8 not null,
                         number int4 not null,
                         general boolean not null,
                         active boolean not null,
                         date_start date,
                         date_end date,
                         primary key (id)
                         );

create table t_post (id int8 not null,
                     name varchar(255) not null,
                     post_level varchar(255) not null,
                     post_type varchar(255) not null,
                     primary key (id)
                     );