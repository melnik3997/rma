create table t_actually_work (id int8 not null,
                      institution_id int8 not null,
                      calendar_id int8 not null,
                      time_D DOUBLE PRECISION not null,
                      theme varchar(255) not null ,
                      comment varchar(255) not null ,
                      primary key (id)
                      );
ALTER TABLE "t_actually_work" ADD FOREIGN KEY ("institution_id") REFERENCES "t_institution" ("id");
ALTER TABLE "t_actually_work" ADD FOREIGN KEY ("calendar_id") REFERENCES "t_calendar" ("id");

ALTER TABLE "message" ADD FOREIGN KEY ("user_id") REFERENCES "t_user" ("id");

ALTER TABLE "t_user_role" ADD FOREIGN KEY ("user_id") REFERENCES "t_user" ("id");

ALTER TABLE "t_position" ADD FOREIGN KEY ("post_id") REFERENCES "t_post" ("id");

ALTER TABLE "t_calendar" ADD FOREIGN KEY ("calendar_enterprise_id") REFERENCES "t_calendar_enterprise" ("id");

ALTER TABLE "t_calendar_enterprise" ADD FOREIGN KEY ("enterprise_id") REFERENCES "t_enterprise" ("id");

ALTER TABLE "t_institution" ADD FOREIGN KEY ("user_id") REFERENCES "t_user" ("id");

ALTER TABLE "t_position" ADD FOREIGN KEY ("institution_id") REFERENCES "t_institution" ("id");

ALTER TABLE "t_presence_work" ADD FOREIGN KEY ("institution_id") REFERENCES "t_institution" ("id");

ALTER TABLE "t_presence_work" ADD FOREIGN KEY ("calendar_id") REFERENCES "t_calendar" ("id");

ALTER TABLE "t_work_schedule_correct" ADD FOREIGN KEY ("calendar_id") REFERENCES "t_calendar" ("id");

ALTER TABLE "t_work_schedule_correct" ADD FOREIGN KEY ("institution_id") REFERENCES "t_institution" ("id");

ALTER TABLE "t_work_schedule_correct" ADD FOREIGN KEY ("deal_object_id") REFERENCES "t_deal_object" ("id");

ALTER TABLE "t_subdivision" ADD FOREIGN KEY ("parent_id") REFERENCES "t_subdivision" ("id");

ALTER TABLE "t_subdivision" ADD FOREIGN KEY ("enterprise_id") REFERENCES "t_enterprise" ("id");

ALTER TABLE "t_subdivision" ADD FOREIGN KEY ("leader_id") REFERENCES "t_user" ("id");

ALTER TABLE "t_institution" ADD FOREIGN KEY ("enterprise_id") REFERENCES "t_enterprise" ("id");

ALTER TABLE "t_work_schedule" ADD FOREIGN KEY ("institution_id") REFERENCES "t_institution" ("id");

