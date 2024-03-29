PGDMP                     
    y            rsa    13.2    13.2 5    m           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            n           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            o           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            p           1262    16394    rsa    DATABASE     `   CREATE DATABASE rsa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE rsa;
                postgres    false                        3079    16436    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            q           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2                        3079    16513 	   tablefunc 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
    DROP EXTENSION tablefunc;
                   false            r           0    0    EXTENSION tablefunc    COMMENT     `   COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
                        false    3            �            1259    16395    flyway_schema_history    TABLE     �  CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);
 )   DROP TABLE public.flyway_schema_history;
       public         heap    postgres    false            �            1259    16405    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false            �            1259    16407    message    TABLE     �   CREATE TABLE public.message (
    id bigint NOT NULL,
    file_name character varying(255),
    tag character varying(255),
    text character varying(2048) NOT NULL,
    user_id bigint
);
    DROP TABLE public.message;
       public         heap    postgres    false            �            1259    33104 
   t_bid_rule    TABLE     �   CREATE TABLE public.t_bid_rule (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    bid_type character varying(255) NOT NULL,
    enterprise_id bigint NOT NULL,
    active boolean NOT NULL
);
    DROP TABLE public.t_bid_rule;
       public         heap    postgres    false            �            1259    32970 
   t_calendar    TABLE     5  CREATE TABLE public.t_calendar (
    id bigint NOT NULL,
    calendar_enterprise_id bigint NOT NULL,
    date_int integer NOT NULL,
    month_int integer NOT NULL,
    date_d date,
    day_week character varying(255) NOT NULL,
    day_type character varying(255) NOT NULL,
    number_week integer NOT NULL
);
    DROP TABLE public.t_calendar;
       public         heap    postgres    false            �            1259    32965    t_calendar_enterprise    TABLE     �   CREATE TABLE public.t_calendar_enterprise (
    id bigint NOT NULL,
    enterprise_id bigint NOT NULL,
    calendar_type character varying(255) NOT NULL,
    year_int integer NOT NULL,
    active boolean
);
 )   DROP TABLE public.t_calendar_enterprise;
       public         heap    postgres    false            �            1259    33078    t_deal_object    TABLE     �   CREATE TABLE public.t_deal_object (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    protocol_id bigint,
    author_id bigint NOT NULL,
    responsible_id bigint,
    employee_id bigint NOT NULL
);
 !   DROP TABLE public.t_deal_object;
       public         heap    postgres    false            �            1259    33315    t_deal_object_attr    TABLE     �   CREATE TABLE public.t_deal_object_attr (
    id bigint NOT NULL,
    deal_object_id bigint NOT NULL,
    deal_object_attr_type character varying(255) NOT NULL,
    value_attr character varying(255) NOT NULL
);
 &   DROP TABLE public.t_deal_object_attr;
       public         heap    postgres    false            �            1259    16473    t_enterprise    TABLE     �   CREATE TABLE public.t_enterprise (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brief character varying(255) NOT NULL
);
     DROP TABLE public.t_enterprise;
       public         heap    postgres    false            �            1259    16481    t_institution    TABLE     �  CREATE TABLE public.t_institution (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    last_name character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    second_name character varying(255),
    date_of_birth date,
    enterprise_id bigint NOT NULL,
    phone_number character varying(255),
    skype_name character varying(255),
    file_name character varying(255)
);
 !   DROP TABLE public.t_institution;
       public         heap    postgres    false            �            1259    32926 
   t_position    TABLE        CREATE TABLE public.t_position (
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    institution_id bigint NOT NULL,
    subdivision_id bigint NOT NULL,
    number integer NOT NULL,
    general boolean NOT NULL,
    active boolean NOT NULL,
    date_start date,
    date_end date
);
    DROP TABLE public.t_position;
       public         heap    postgres    false            �            1259    32931    t_post    TABLE     �   CREATE TABLE public.t_post (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    post_level character varying(255) NOT NULL,
    post_type character varying(255) NOT NULL
);
    DROP TABLE public.t_post;
       public         heap    postgres    false            �            1259    33335    t_presence_work    TABLE     ,  CREATE TABLE public.t_presence_work (
    id bigint NOT NULL,
    institution_id bigint NOT NULL,
    calendar_id bigint NOT NULL,
    time_begin time without time zone NOT NULL,
    time_finish time without time zone,
    active boolean NOT NULL,
    number integer NOT NULL,
    duration bigint
);
 #   DROP TABLE public.t_presence_work;
       public         heap    postgres    false            �            1259    33083 
   t_protocol    TABLE     �   CREATE TABLE public.t_protocol (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    date_protocol timestamp without time zone NOT NULL,
    transition_id bigint NOT NULL,
    user_id bigint NOT NULL,
    responsible_id bigint
);
    DROP TABLE public.t_protocol;
       public         heap    postgres    false            �            1259    16505 
   t_settings    TABLE     �   CREATE TABLE public.t_settings (
    id bigint NOT NULL,
    s_id bigint NOT NULL,
    sys_name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);
    DROP TABLE public.t_settings;
       public         heap    postgres    false            �            1259    33096    t_state    TABLE     �   CREATE TABLE public.t_state (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brief character varying(255) NOT NULL,
    state_type character varying(255) NOT NULL,
    number integer NOT NULL
);
    DROP TABLE public.t_state;
       public         heap    postgres    false            �            1259    24726    t_subdivision    TABLE     �   CREATE TABLE public.t_subdivision (
    id bigint NOT NULL,
    enterprise_id bigint NOT NULL,
    parent_id bigint,
    brief character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    leader_id bigint NOT NULL
);
 !   DROP TABLE public.t_subdivision;
       public         heap    postgres    false            �            1259    33088    t_transition    TABLE       CREATE TABLE public.t_transition (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    source_state_id bigint,
    action_name character varying(255) NOT NULL,
    action_type character varying(255) NOT NULL,
    target_state_id bigint NOT NULL,
    institution_id bigint
);
     DROP TABLE public.t_transition;
       public         heap    postgres    false            �            1259    16415    t_user    TABLE     �   CREATE TABLE public.t_user (
    id bigint NOT NULL,
    activation_code character varying(255),
    active boolean NOT NULL,
    email character varying(255),
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);
    DROP TABLE public.t_user;
       public         heap    postgres    false            �            1259    16423    t_user_role    TABLE     b   CREATE TABLE public.t_user_role (
    user_id bigint NOT NULL,
    role character varying(255)
);
    DROP TABLE public.t_user_role;
       public         heap    postgres    false            �            1259    33004    t_work_schedule    TABLE     �  CREATE TABLE public.t_work_schedule (
    id bigint NOT NULL,
    active boolean NOT NULL,
    institution_id bigint NOT NULL,
    date_start date NOT NULL,
    date_end date,
    time_begin time without time zone NOT NULL,
    time_finish time without time zone NOT NULL,
    work_time double precision NOT NULL,
    lunch_break double precision NOT NULL,
    lunch_break_in boolean NOT NULL
);
 #   DROP TABLE public.t_work_schedule;
       public         heap    postgres    false            �            1259    33310    t_work_schedule_correct    TABLE     m  CREATE TABLE public.t_work_schedule_correct (
    id bigint NOT NULL,
    institution_id bigint NOT NULL,
    deal_object_id bigint NOT NULL,
    calendar_id bigint NOT NULL,
    time_begin time without time zone,
    time_finish time without time zone,
    comment character varying(255) NOT NULL,
    work_schedule_correct_type character varying(255) NOT NULL
);
 +   DROP TABLE public.t_work_schedule_correct;
       public         heap    postgres    false            �           2606    16403 .   flyway_schema_history flyway_schema_history_pk 
   CONSTRAINT     x   ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);
 X   ALTER TABLE ONLY public.flyway_schema_history DROP CONSTRAINT flyway_schema_history_pk;
       public            postgres    false    202            �           2606    16414    message message_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
       public            postgres    false    204            �           2606    33111    t_bid_rule t_bid_rule_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_bid_rule
    ADD CONSTRAINT t_bid_rule_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_bid_rule DROP CONSTRAINT t_bid_rule_pkey;
       public            postgres    false    223            �           2606    32969 0   t_calendar_enterprise t_calendar_enterprise_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.t_calendar_enterprise
    ADD CONSTRAINT t_calendar_enterprise_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.t_calendar_enterprise DROP CONSTRAINT t_calendar_enterprise_pkey;
       public            postgres    false    216            �           2606    32977    t_calendar t_calendar_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_calendar
    ADD CONSTRAINT t_calendar_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_calendar DROP CONSTRAINT t_calendar_pkey;
       public            postgres    false    217            �           2606    33322 *   t_deal_object_attr t_deal_object_attr_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.t_deal_object_attr
    ADD CONSTRAINT t_deal_object_attr_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.t_deal_object_attr DROP CONSTRAINT t_deal_object_attr_pkey;
       public            postgres    false    225            �           2606    33082     t_deal_object t_deal_object_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.t_deal_object
    ADD CONSTRAINT t_deal_object_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.t_deal_object DROP CONSTRAINT t_deal_object_pkey;
       public            postgres    false    219            �           2606    16480    t_enterprise t_enterprise_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.t_enterprise
    ADD CONSTRAINT t_enterprise_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.t_enterprise DROP CONSTRAINT t_enterprise_pkey;
       public            postgres    false    207            �           2606    16488     t_institution t_institution_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.t_institution
    ADD CONSTRAINT t_institution_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.t_institution DROP CONSTRAINT t_institution_pkey;
       public            postgres    false    208            �           2606    32930    t_position t_position_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_position
    ADD CONSTRAINT t_position_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_position DROP CONSTRAINT t_position_pkey;
       public            postgres    false    214            �           2606    32938    t_post t_post_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.t_post
    ADD CONSTRAINT t_post_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.t_post DROP CONSTRAINT t_post_pkey;
       public            postgres    false    215            �           2606    33339 $   t_presence_work t_presence_work_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.t_presence_work
    ADD CONSTRAINT t_presence_work_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.t_presence_work DROP CONSTRAINT t_presence_work_pkey;
       public            postgres    false    226            �           2606    33087    t_protocol t_protocol_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_protocol
    ADD CONSTRAINT t_protocol_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_protocol DROP CONSTRAINT t_protocol_pkey;
       public            postgres    false    220            �           2606    16512    t_settings t_settings_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_settings
    ADD CONSTRAINT t_settings_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_settings DROP CONSTRAINT t_settings_pkey;
       public            postgres    false    209            �           2606    33103    t_state t_state_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.t_state
    ADD CONSTRAINT t_state_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.t_state DROP CONSTRAINT t_state_pkey;
       public            postgres    false    222            �           2606    24733     t_subdivision t_subdivision_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.t_subdivision
    ADD CONSTRAINT t_subdivision_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.t_subdivision DROP CONSTRAINT t_subdivision_pkey;
       public            postgres    false    213            �           2606    33095    t_transition t_transition_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.t_transition
    ADD CONSTRAINT t_transition_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.t_transition DROP CONSTRAINT t_transition_pkey;
       public            postgres    false    221            �           2606    16422    t_user t_user_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.t_user DROP CONSTRAINT t_user_pkey;
       public            postgres    false    205            �           2606    33314 4   t_work_schedule_correct t_work_schedule_correct_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.t_work_schedule_correct
    ADD CONSTRAINT t_work_schedule_correct_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.t_work_schedule_correct DROP CONSTRAINT t_work_schedule_correct_pkey;
       public            postgres    false    224            �           2606    33008 $   t_work_schedule t_work_schedule_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.t_work_schedule
    ADD CONSTRAINT t_work_schedule_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.t_work_schedule DROP CONSTRAINT t_work_schedule_pkey;
       public            postgres    false    218            �           1259    16404    flyway_schema_history_s_idx    INDEX     `   CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);
 /   DROP INDEX public.flyway_schema_history_s_idx;
       public            postgres    false    202            �           2606    16426    message message_user_fg    FK CONSTRAINT     w   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_user_fg FOREIGN KEY (user_id) REFERENCES public.t_user(id);
 A   ALTER TABLE ONLY public.message DROP CONSTRAINT message_user_fg;
       public          postgres    false    205    204    3012            �           2606    16431    t_user_role role_user_fg    FK CONSTRAINT     x   ALTER TABLE ONLY public.t_user_role
    ADD CONSTRAINT role_user_fg FOREIGN KEY (user_id) REFERENCES public.t_user(id);
 B   ALTER TABLE ONLY public.t_user_role DROP CONSTRAINT role_user_fg;
       public          postgres    false    205    3012    206           