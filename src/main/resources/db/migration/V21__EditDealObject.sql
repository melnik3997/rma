alter table if exists t_deal_object
          add COLUMN  employee_id int8;

update t_deal_object
set employee_id = author_id;

alter table if exists t_deal_object
          ALTER   COLUMN  employee_id   set  NOT NULL;
