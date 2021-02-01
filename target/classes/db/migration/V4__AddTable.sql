create table t_enterprise (id int8 not null,
                     name varchar(255) not null,
                     brief varchar(255) not null,
                     primary key (id)
                     );

create table t_institution (id int8 not null,
                            user_id int8 not null,
                            lastName varchar(255) not null,
                            firstName varchar(255) not null,
                            secondName varchar(255) ,
                            date_of_birth date,
                            enterprise_id int8 not null,
                            primary key (id)
                            );
