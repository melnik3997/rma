create table t_work_schedule_correct (id int8 not null,
                                      institution_id int8 not null,
                                      deal_object_id int8 not null,
                                      calendar_id int8 not null,
                                      time_begin time without time zone not null,
                                      time_finish time without time zone not null,
                                      comment varchar(255) not null,
                                      primary key (id)
                                      );