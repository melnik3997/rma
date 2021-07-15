create table t_subdivision (id int8 not null,
                            enterprise_Id int8 not null,
                            parent_Id int8 ,
                            brief varchar(255) not null,
                            name varchar(255) not null,
                            leader_Id int8 not null,
                            primary key (id)
                            );