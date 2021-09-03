create table t_deal_object (id int8 not null,
                            object_id int8 not null,
                            bid_type varchar(255) not null,
                            bid_rule_id int8 not null,
                            protocol_id int8 not null,
                            primary key (id)
                            );

create table t_protocol (id int8 not null,
                         object_id int8 not null,
                         date_protocol date not null,
                         transition_id  int8 not null,
                         user_id int8 not null,
                         primary key (id)
                         );

create table t_transition (id int8 not null,
                           bid_rule_id int8 not null,
                           source_state_id  int8 not null,
                           action_name varchar(255) not null,
                           action_type varchar(255) not null,
                           target_state_id int8 not null,
                           institution_id int8 not null,
                           primary key (id)
                           );

create table t_state (id int8 not null,
                      bid_rule_id int8 not null,
                      name varchar(255) not null,
                      brief varchar(255) not null,
                      state_type varchar(255) not null,
                      number  int4 not null,
                      primary key (id)
                      );

create table t_bid_rule (id int8 not null,
                         name varchar(255) not null,
                         bid_type varchar(255) not null,
                         enterprise_id int8 not null,
                         active boolean not null,
                         primary key (id)
                         );



