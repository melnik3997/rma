create table t_calendar_enterprise (id int8 not null,
                                   enterprise_id int8 not null,
                                   calendar_type varchar(255) not null ,
                                   year_int int4 not null,
                                   primary key (id)
                                   );

create table t_calendar (id int8 not null,
                         calendar_enterprise_id int8 not null,
                         date_int int4 not null,
                         month_int int4 not null,
                         date_d date,
                         day_week varchar(255) not null ,
                         day_type varchar(255) not null ,
                         number_week int4 not null,
                         primary key (id)
                         );