ALTER TABLE t_work_schedule_correct
            ALTER   COLUMN  time_begin   DROP  NOT NULL,
            ALTER   COLUMN  time_finish   DROP  NOT NULL,
            add COLUMN  work_schedule_correct_type varchar(255) not null;