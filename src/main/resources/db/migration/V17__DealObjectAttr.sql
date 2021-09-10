create table t_deal_object_attr (id int8 not null,
                                 deal_object_id int8 not null,
                                 deal_object_attr_type varchar(255) not null,
                                 value_attr varchar(255) not null,
                                 primary key (id)
                                 );