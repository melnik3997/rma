create table t_work_schedule (id int8 not null,
                              active boolean not null,
                              institution_id int8 not null,
                              date_start date not null,
                              date_end date,
                              time_begin time without time zone not null,
                              time_finish time without time zone not null,
                              work_time float8 not null,
                              lunch_break float8 not null,
                              lunch_break_in boolean not null,
                              primary key (id)
                              );