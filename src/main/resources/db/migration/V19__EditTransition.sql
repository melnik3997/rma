alter table if exists t_transition
          ALTER   COLUMN  source_state_id   DROP  NOT NULL;


alter table if exists t_deal_object
            add COLUMN  responsible_id int8;
