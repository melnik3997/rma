create table t_presence_work (id int8 not null,
                      institution_id int8 not null,
                      calendar_id int8 not null,
                      time_begin time without time zone not null,
                      time_finish time without time zone ,
                      active boolean not null,
                      number  int4 not null,
                      duration int8  ,
                      primary key (id)
                      );