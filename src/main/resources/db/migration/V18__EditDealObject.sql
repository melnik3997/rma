alter table if exists t_deal_object
          ALTER   COLUMN  protocol_id   DROP  NOT NULL,
          add COLUMN  author_id int8 not null,
          DROP COLUMN object_id,
          DROP COLUMN bid_type;
