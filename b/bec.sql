toc.dat                                                                                             0000600 0004000 0002000 00000050035 14113761513 0014444 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       
                     y            rsa    13.2    13.2 B    l           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         m           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         n           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         o           1262    16394    rsa    DATABASE     `   CREATE DATABASE rsa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE rsa;
                postgres    false                     3079    16436    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false         p           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2                     3079    16513 	   tablefunc 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
    DROP EXTENSION tablefunc;
                   false         q           0    0    EXTENSION tablefunc    COMMENT     `   COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
                        false    3         �            1259    16395    flyway_schema_history    TABLE     �  CREATE TABLE public.flyway_schema_history (
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
       public         heap    postgres    false         �            1259    16405    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false         �            1259    16407    message    TABLE     �   CREATE TABLE public.message (
    id bigint NOT NULL,
    file_name character varying(255),
    tag character varying(255),
    text character varying(2048) NOT NULL,
    user_id bigint
);
    DROP TABLE public.message;
       public         heap    postgres    false         �            1259    33104 
   t_bid_rule    TABLE     �   CREATE TABLE public.t_bid_rule (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    bid_type character varying(255) NOT NULL,
    enterprise_id bigint NOT NULL,
    active boolean NOT NULL
);
    DROP TABLE public.t_bid_rule;
       public         heap    postgres    false         �            1259    32970 
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
       public         heap    postgres    false         �            1259    32965    t_calendar_enterprise    TABLE     �   CREATE TABLE public.t_calendar_enterprise (
    id bigint NOT NULL,
    enterprise_id bigint NOT NULL,
    calendar_type character varying(255) NOT NULL,
    year_int integer NOT NULL,
    active boolean
);
 )   DROP TABLE public.t_calendar_enterprise;
       public         heap    postgres    false         �            1259    33078    t_deal_object    TABLE     �   CREATE TABLE public.t_deal_object (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    bid_type character varying(255) NOT NULL,
    bid_rule_id bigint NOT NULL,
    protocol_id bigint NOT NULL
);
 !   DROP TABLE public.t_deal_object;
       public         heap    postgres    false         �            1259    16473    t_enterprise    TABLE     �   CREATE TABLE public.t_enterprise (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brief character varying(255) NOT NULL
);
     DROP TABLE public.t_enterprise;
       public         heap    postgres    false         �            1259    16481    t_institution    TABLE     �  CREATE TABLE public.t_institution (
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
       public         heap    postgres    false         �            1259    32926 
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
       public         heap    postgres    false         �            1259    32931    t_post    TABLE     �   CREATE TABLE public.t_post (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    post_level character varying(255) NOT NULL,
    post_type character varying(255) NOT NULL
);
    DROP TABLE public.t_post;
       public         heap    postgres    false         �            1259    33083 
   t_protocol    TABLE     �   CREATE TABLE public.t_protocol (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    date_protocol date NOT NULL,
    transition_id bigint NOT NULL,
    user_id bigint NOT NULL
);
    DROP TABLE public.t_protocol;
       public         heap    postgres    false         �            1259    16505 
   t_settings    TABLE     �   CREATE TABLE public.t_settings (
    id bigint NOT NULL,
    s_id bigint NOT NULL,
    sys_name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);
    DROP TABLE public.t_settings;
       public         heap    postgres    false         �            1259    33096    t_state    TABLE     �   CREATE TABLE public.t_state (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brief character varying(255) NOT NULL,
    state_type character varying(255) NOT NULL,
    number integer NOT NULL
);
    DROP TABLE public.t_state;
       public         heap    postgres    false         �            1259    24726    t_subdivision    TABLE     �   CREATE TABLE public.t_subdivision (
    id bigint NOT NULL,
    enterprise_id bigint NOT NULL,
    parent_id bigint,
    brief character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    leader_id bigint NOT NULL
);
 !   DROP TABLE public.t_subdivision;
       public         heap    postgres    false         �            1259    33088    t_transition    TABLE     .  CREATE TABLE public.t_transition (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    source_state_id bigint NOT NULL,
    action_name character varying(255) NOT NULL,
    action_type character varying(255) NOT NULL,
    target_state_id bigint NOT NULL,
    institution_id bigint NOT NULL
);
     DROP TABLE public.t_transition;
       public         heap    postgres    false         �            1259    16415    t_user    TABLE     �   CREATE TABLE public.t_user (
    id bigint NOT NULL,
    activation_code character varying(255),
    active boolean NOT NULL,
    email character varying(255),
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);
    DROP TABLE public.t_user;
       public         heap    postgres    false         �            1259    16423    t_user_role    TABLE     b   CREATE TABLE public.t_user_role (
    user_id bigint NOT NULL,
    role character varying(255)
);
    DROP TABLE public.t_user_role;
       public         heap    postgres    false         �            1259    33004    t_work_schedule    TABLE     �  CREATE TABLE public.t_work_schedule (
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
       public         heap    postgres    false         W          0    16395    flyway_schema_history 
   TABLE DATA           �   COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
    public          postgres    false    202       3159.dat Y          0    16407    message 
   TABLE DATA           D   COPY public.message (id, file_name, tag, text, user_id) FROM stdin;
    public          postgres    false    204       3161.dat i          0    33104 
   t_bid_rule 
   TABLE DATA           O   COPY public.t_bid_rule (id, name, bid_type, enterprise_id, active) FROM stdin;
    public          postgres    false    223       3177.dat c          0    32970 
   t_calendar 
   TABLE DATA           ~   COPY public.t_calendar (id, calendar_enterprise_id, date_int, month_int, date_d, day_week, day_type, number_week) FROM stdin;
    public          postgres    false    217       3171.dat b          0    32965    t_calendar_enterprise 
   TABLE DATA           c   COPY public.t_calendar_enterprise (id, enterprise_id, calendar_type, year_int, active) FROM stdin;
    public          postgres    false    216       3170.dat e          0    33078    t_deal_object 
   TABLE DATA           Z   COPY public.t_deal_object (id, object_id, bid_type, bid_rule_id, protocol_id) FROM stdin;
    public          postgres    false    219       3173.dat \          0    16473    t_enterprise 
   TABLE DATA           7   COPY public.t_enterprise (id, name, brief) FROM stdin;
    public          postgres    false    207       3164.dat ]          0    16481    t_institution 
   TABLE DATA           �   COPY public.t_institution (id, user_id, last_name, first_name, second_name, date_of_birth, enterprise_id, phone_number, skype_name, file_name) FROM stdin;
    public          postgres    false    208       3165.dat `          0    32926 
   t_position 
   TABLE DATA           �   COPY public.t_position (id, post_id, institution_id, subdivision_id, number, general, active, date_start, date_end) FROM stdin;
    public          postgres    false    214       3168.dat a          0    32931    t_post 
   TABLE DATA           A   COPY public.t_post (id, name, post_level, post_type) FROM stdin;
    public          postgres    false    215       3169.dat f          0    33083 
   t_protocol 
   TABLE DATA           Z   COPY public.t_protocol (id, object_id, date_protocol, transition_id, user_id) FROM stdin;
    public          postgres    false    220       3174.dat ^          0    16505 
   t_settings 
   TABLE DATA           ?   COPY public.t_settings (id, s_id, sys_name, value) FROM stdin;
    public          postgres    false    209       3166.dat h          0    33096    t_state 
   TABLE DATA           S   COPY public.t_state (id, bid_rule_id, name, brief, state_type, number) FROM stdin;
    public          postgres    false    222       3176.dat _          0    24726    t_subdivision 
   TABLE DATA           ]   COPY public.t_subdivision (id, enterprise_id, parent_id, brief, name, leader_id) FROM stdin;
    public          postgres    false    213       3167.dat g          0    33088    t_transition 
   TABLE DATA           �   COPY public.t_transition (id, bid_rule_id, source_state_id, action_name, action_type, target_state_id, institution_id) FROM stdin;
    public          postgres    false    221       3175.dat Z          0    16415    t_user 
   TABLE DATA           X   COPY public.t_user (id, activation_code, active, email, password, username) FROM stdin;
    public          postgres    false    205       3162.dat [          0    16423    t_user_role 
   TABLE DATA           4   COPY public.t_user_role (user_id, role) FROM stdin;
    public          postgres    false    206       3163.dat d          0    33004    t_work_schedule 
   TABLE DATA           �   COPY public.t_work_schedule (id, active, institution_id, date_start, date_end, time_begin, time_finish, work_time, lunch_break, lunch_break_in) FROM stdin;
    public          postgres    false    218       3172.dat r           0    0    hibernate_sequence    SEQUENCE SET     C   SELECT pg_catalog.setval('public.hibernate_sequence', 2689, true);
          public          postgres    false    203         �           2606    16403 .   flyway_schema_history flyway_schema_history_pk 
   CONSTRAINT     x   ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);
 X   ALTER TABLE ONLY public.flyway_schema_history DROP CONSTRAINT flyway_schema_history_pk;
       public            postgres    false    202         �           2606    16414    message message_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.message DROP CONSTRAINT message_pkey;
       public            postgres    false    204         �           2606    33111    t_bid_rule t_bid_rule_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_bid_rule
    ADD CONSTRAINT t_bid_rule_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_bid_rule DROP CONSTRAINT t_bid_rule_pkey;
       public            postgres    false    223         �           2606    32969 0   t_calendar_enterprise t_calendar_enterprise_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.t_calendar_enterprise
    ADD CONSTRAINT t_calendar_enterprise_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.t_calendar_enterprise DROP CONSTRAINT t_calendar_enterprise_pkey;
       public            postgres    false    216         �           2606    32977    t_calendar t_calendar_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_calendar
    ADD CONSTRAINT t_calendar_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_calendar DROP CONSTRAINT t_calendar_pkey;
       public            postgres    false    217         �           2606    33082     t_deal_object t_deal_object_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.t_deal_object
    ADD CONSTRAINT t_deal_object_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.t_deal_object DROP CONSTRAINT t_deal_object_pkey;
       public            postgres    false    219         �           2606    16480    t_enterprise t_enterprise_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.t_enterprise
    ADD CONSTRAINT t_enterprise_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.t_enterprise DROP CONSTRAINT t_enterprise_pkey;
       public            postgres    false    207         �           2606    16488     t_institution t_institution_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.t_institution
    ADD CONSTRAINT t_institution_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.t_institution DROP CONSTRAINT t_institution_pkey;
       public            postgres    false    208         �           2606    32930    t_position t_position_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_position
    ADD CONSTRAINT t_position_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_position DROP CONSTRAINT t_position_pkey;
       public            postgres    false    214         �           2606    32938    t_post t_post_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.t_post
    ADD CONSTRAINT t_post_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.t_post DROP CONSTRAINT t_post_pkey;
       public            postgres    false    215         �           2606    33087    t_protocol t_protocol_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_protocol
    ADD CONSTRAINT t_protocol_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_protocol DROP CONSTRAINT t_protocol_pkey;
       public            postgres    false    220         �           2606    16512    t_settings t_settings_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.t_settings
    ADD CONSTRAINT t_settings_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.t_settings DROP CONSTRAINT t_settings_pkey;
       public            postgres    false    209         �           2606    33103    t_state t_state_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.t_state
    ADD CONSTRAINT t_state_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.t_state DROP CONSTRAINT t_state_pkey;
       public            postgres    false    222         �           2606    24733     t_subdivision t_subdivision_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.t_subdivision
    ADD CONSTRAINT t_subdivision_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.t_subdivision DROP CONSTRAINT t_subdivision_pkey;
       public            postgres    false    213         �           2606    33095    t_transition t_transition_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.t_transition
    ADD CONSTRAINT t_transition_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.t_transition DROP CONSTRAINT t_transition_pkey;
       public            postgres    false    221         �           2606    16422    t_user t_user_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.t_user DROP CONSTRAINT t_user_pkey;
       public            postgres    false    205         �           2606    33008 $   t_work_schedule t_work_schedule_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.t_work_schedule
    ADD CONSTRAINT t_work_schedule_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.t_work_schedule DROP CONSTRAINT t_work_schedule_pkey;
       public            postgres    false    218         �           1259    16404    flyway_schema_history_s_idx    INDEX     `   CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);
 /   DROP INDEX public.flyway_schema_history_s_idx;
       public            postgres    false    202         �           2606    16426    message message_user_fg    FK CONSTRAINT     w   ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_user_fg FOREIGN KEY (user_id) REFERENCES public.t_user(id);
 A   ALTER TABLE ONLY public.message DROP CONSTRAINT message_user_fg;
       public          postgres    false    2998    204    205         �           2606    16431    t_user_role role_user_fg    FK CONSTRAINT     x   ALTER TABLE ONLY public.t_user_role
    ADD CONSTRAINT role_user_fg FOREIGN KEY (user_id) REFERENCES public.t_user(id);
 B   ALTER TABLE ONLY public.t_user_role DROP CONSTRAINT role_user_fg;
       public          postgres    false    2998    206    205                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3159.dat                                                                                            0000600 0004000 0002000 00000002556 14113761513 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	Init DB	SQL	V1__Init_DB.sql	688404768	postgres	2021-03-01 22:16:19.699204	55	t
2	2	Add admin DB	SQL	V2__Add_admin_DB.sql	-906281469	postgres	2021-03-01 22:16:19.776636	6	t
3	3	encodePassword	SQL	V3__encodePassword.sql	1430812	postgres	2021-03-01 22:16:19.794809	62	t
4	4	AddTable	SQL	V4__AddTable.sql	1748275457	postgres	2021-03-01 22:16:19.879206	36	t
5	5	EditTableInstitution	SQL	V5__EditTableInstitution.sql	-907593065	postgres	2021-03-01 22:34:01.82026	22	t
6	6	AddColumnInstitution	SQL	V6__AddColumnInstitution.sql	1252313163	postgres	2021-03-02 19:06:59.854547	16	t
7	7	AddTableSettings	SQL	V7__AddTableSettings.sql	-1758476934	postgres	2021-03-02 23:27:25.240082	17	t
8	8	AddColumnInstitutionFileName	SQL	V8__AddColumnInstitutionFileName.sql	-825705342	postgres	2021-03-05 16:44:28.559667	115	t
9	9	AddSubdivision	SQL	V9__AddSubdivision.sql	-2118045590	postgres	2021-07-13 18:39:58.870704	37	t
10	10	AddTablePosition	SQL	V10__AddTablePosition.sql	911600682	postgres	2021-08-01 23:01:42.264902	386	t
11	11	Calendar	SQL	V11__Calendar.sql	-63608012	postgres	2021-08-15 21:21:10.080023	68	t
12	12	EditCalendar	SQL	V12__EditCalendar.sql	1713685437	postgres	2021-08-24 19:15:39.330733	22	t
13	13	WorkSchedule	SQL	V13__WorkSchedule.sql	2074856985	postgres	2021-08-28 17:50:20.705048	22	t
14	14	BidMachine	SQL	V14__BidMachine.sql	-886894228	postgres	2021-09-01 23:02:29.628697	57	t
\.


                                                                                                                                                  3161.dat                                                                                            0000600 0004000 0002000 00000000021 14113761513 0014237 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        12	\N	1	1	6
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3177.dat                                                                                            0000600 0004000 0002000 00000000005 14113761513 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3171.dat                                                                                            0000600 0004000 0002000 00000150564 14113761513 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1584	1582	20210102	1	2021-01-02	SATURDAY	OUTPUT	53
1585	1582	20210103	1	2021-01-03	SUNDAY	OUTPUT	53
1591	1582	20210109	1	2021-01-09	SATURDAY	OUTPUT	1
1592	1582	20210110	1	2021-01-10	SUNDAY	OUTPUT	1
1598	1582	20210116	1	2021-01-16	SATURDAY	OUTPUT	2
1599	1582	20210117	1	2021-01-17	SUNDAY	OUTPUT	2
1600	1582	20210118	1	2021-01-18	MONDAY	WORK	3
1601	1582	20210119	1	2021-01-19	TUESDAY	WORK	3
1602	1582	20210120	1	2021-01-20	WEDNESDAY	WORK	3
1603	1582	20210121	1	2021-01-21	THURSDAY	WORK	3
1604	1582	20210122	1	2021-01-22	FRIDAY	WORK	3
1605	1582	20210123	1	2021-01-23	SATURDAY	OUTPUT	3
1606	1582	20210124	1	2021-01-24	SUNDAY	OUTPUT	3
1607	1582	20210125	1	2021-01-25	MONDAY	WORK	4
1608	1582	20210126	1	2021-01-26	TUESDAY	WORK	4
1609	1582	20210127	1	2021-01-27	WEDNESDAY	WORK	4
1610	1582	20210128	1	2021-01-28	THURSDAY	WORK	4
1611	1582	20210129	1	2021-01-29	FRIDAY	WORK	4
1612	1582	20210130	1	2021-01-30	SATURDAY	OUTPUT	4
1613	1582	20210131	1	2021-01-31	SUNDAY	OUTPUT	4
1616	1582	20210203	2	2021-02-03	WEDNESDAY	WORK	5
1618	1582	20210205	2	2021-02-05	FRIDAY	WORK	5
1619	1582	20210206	2	2021-02-06	SATURDAY	OUTPUT	5
1620	1582	20210207	2	2021-02-07	SUNDAY	OUTPUT	5
1621	1582	20210208	2	2021-02-08	MONDAY	WORK	6
1623	1582	20210210	2	2021-02-10	WEDNESDAY	WORK	6
1626	1582	20210213	2	2021-02-13	SATURDAY	OUTPUT	6
1627	1582	20210214	2	2021-02-14	SUNDAY	OUTPUT	6
1628	1582	20210215	2	2021-02-15	MONDAY	WORK	7
1629	1582	20210216	2	2021-02-16	TUESDAY	WORK	7
1632	1582	20210219	2	2021-02-19	FRIDAY	WORK	7
1633	1582	20210220	2	2021-02-20	SATURDAY	OUTPUT	7
1634	1582	20210221	2	2021-02-21	SUNDAY	OUTPUT	7
1635	1582	20210222	2	2021-02-22	MONDAY	WORK	8
1636	1582	20210223	2	2021-02-23	TUESDAY	WORK	8
1639	1582	20210226	2	2021-02-26	FRIDAY	WORK	8
1640	1582	20210227	2	2021-02-27	SATURDAY	OUTPUT	8
1641	1582	20210228	2	2021-02-28	SUNDAY	OUTPUT	8
1642	1582	20210301	3	2021-03-01	MONDAY	WORK	9
1643	1582	20210302	3	2021-03-02	TUESDAY	WORK	9
1644	1582	20210303	3	2021-03-03	WEDNESDAY	WORK	9
1645	1582	20210304	3	2021-03-04	THURSDAY	WORK	9
1646	1582	20210305	3	2021-03-05	FRIDAY	WORK	9
1647	1582	20210306	3	2021-03-06	SATURDAY	OUTPUT	9
1648	1582	20210307	3	2021-03-07	SUNDAY	OUTPUT	9
1654	1582	20210313	3	2021-03-13	SATURDAY	OUTPUT	10
1655	1582	20210314	3	2021-03-14	SUNDAY	OUTPUT	10
1662	1582	20210321	3	2021-03-21	SUNDAY	OUTPUT	11
1663	1582	20210322	3	2021-03-22	MONDAY	WORK	12
1664	1582	20210323	3	2021-03-23	TUESDAY	WORK	12
1665	1582	20210324	3	2021-03-24	WEDNESDAY	WORK	12
1666	1582	20210325	3	2021-03-25	THURSDAY	WORK	12
1667	1582	20210326	3	2021-03-26	FRIDAY	WORK	12
1668	1582	20210327	3	2021-03-27	SATURDAY	OUTPUT	12
1669	1582	20210328	3	2021-03-28	SUNDAY	OUTPUT	12
1670	1582	20210329	3	2021-03-29	MONDAY	WORK	13
1671	1582	20210330	3	2021-03-30	TUESDAY	WORK	13
1672	1582	20210331	3	2021-03-31	WEDNESDAY	WORK	13
1673	1582	20210401	4	2021-04-01	THURSDAY	WORK	13
1674	1582	20210402	4	2021-04-02	FRIDAY	WORK	13
1675	1582	20210403	4	2021-04-03	SATURDAY	OUTPUT	13
1676	1582	20210404	4	2021-04-04	SUNDAY	OUTPUT	13
1677	1582	20210405	4	2021-04-05	MONDAY	WORK	14
1678	1582	20210406	4	2021-04-06	TUESDAY	WORK	14
1679	1582	20210407	4	2021-04-07	WEDNESDAY	WORK	14
1680	1582	20210408	4	2021-04-08	THURSDAY	WORK	14
1681	1582	20210409	4	2021-04-09	FRIDAY	WORK	14
1682	1582	20210410	4	2021-04-10	SATURDAY	OUTPUT	14
1683	1582	20210411	4	2021-04-11	SUNDAY	OUTPUT	14
1684	1582	20210412	4	2021-04-12	MONDAY	WORK	15
1685	1582	20210413	4	2021-04-13	TUESDAY	WORK	15
1687	1582	20210415	4	2021-04-15	THURSDAY	WORK	15
1688	1582	20210416	4	2021-04-16	FRIDAY	WORK	15
1689	1582	20210417	4	2021-04-17	SATURDAY	OUTPUT	15
1597	1582	20210115	1	2021-01-15	FRIDAY	PRE_HOLIDAY	2
1596	1582	20210114	1	2021-01-14	THURSDAY	PRE_HOLIDAY	2
1595	1582	20210113	1	2021-01-13	WEDNESDAY	PRE_HOLIDAY	2
1593	1582	20210111	1	2021-01-11	MONDAY	PRE_HOLIDAY	2
1594	1582	20210112	1	2021-01-12	TUESDAY	PRE_HOLIDAY	2
1625	1582	20210212	2	2021-02-12	FRIDAY	WORK	6
1630	1582	20210217	2	2021-02-17	WEDNESDAY	PRE_HOLIDAY	7
1617	1582	20210204	2	2021-02-04	THURSDAY	OUTPUT	5
1624	1582	20210211	2	2021-02-11	THURSDAY	OUTPUT	6
1631	1582	20210218	2	2021-02-18	THURSDAY	OUTPUT	7
1615	1582	20210202	2	2021-02-02	TUESDAY	HOLIDAY	5
1649	1582	20210308	3	2021-03-08	MONDAY	OUTPUT	10
1686	1582	20210414	4	2021-04-14	WEDNESDAY	OUTPUT	15
1650	1582	20210309	3	2021-03-09	TUESDAY	OUTPUT	10
1638	1582	20210225	2	2021-02-25	THURSDAY	WORK	8
1637	1582	20210224	2	2021-02-24	WEDNESDAY	WORK	8
1653	1582	20210312	3	2021-03-12	FRIDAY	OUTPUT	10
1656	1582	20210315	3	2021-03-15	MONDAY	OUTPUT	11
1651	1582	20210310	3	2021-03-10	WEDNESDAY	WORK	10
1652	1582	20210311	3	2021-03-11	THURSDAY	WORK	10
1661	1582	20210320	3	2021-03-20	SATURDAY	WORK	11
1690	1582	20210418	4	2021-04-18	SUNDAY	OUTPUT	15
1691	1582	20210419	4	2021-04-19	MONDAY	WORK	16
1693	1582	20210421	4	2021-04-21	WEDNESDAY	WORK	16
1695	1582	20210423	4	2021-04-23	FRIDAY	WORK	16
1696	1582	20210424	4	2021-04-24	SATURDAY	OUTPUT	16
1697	1582	20210425	4	2021-04-25	SUNDAY	OUTPUT	16
1699	1582	20210427	4	2021-04-27	TUESDAY	WORK	17
1700	1582	20210428	4	2021-04-28	WEDNESDAY	WORK	17
1701	1582	20210429	4	2021-04-29	THURSDAY	WORK	17
1703	1582	20210501	5	2021-05-01	SATURDAY	OUTPUT	17
1704	1582	20210502	5	2021-05-02	SUNDAY	OUTPUT	17
1705	1582	20210503	5	2021-05-03	MONDAY	WORK	18
1706	1582	20210504	5	2021-05-04	TUESDAY	WORK	18
1707	1582	20210505	5	2021-05-05	WEDNESDAY	WORK	18
1708	1582	20210506	5	2021-05-06	THURSDAY	WORK	18
1709	1582	20210507	5	2021-05-07	FRIDAY	WORK	18
1710	1582	20210508	5	2021-05-08	SATURDAY	OUTPUT	18
1711	1582	20210509	5	2021-05-09	SUNDAY	OUTPUT	18
1717	1582	20210515	5	2021-05-15	SATURDAY	OUTPUT	19
1718	1582	20210516	5	2021-05-16	SUNDAY	OUTPUT	19
1720	1582	20210518	5	2021-05-18	TUESDAY	WORK	20
1722	1582	20210520	5	2021-05-20	THURSDAY	WORK	20
1723	1582	20210521	5	2021-05-21	FRIDAY	WORK	20
1724	1582	20210522	5	2021-05-22	SATURDAY	OUTPUT	20
1725	1582	20210523	5	2021-05-23	SUNDAY	OUTPUT	20
1729	1582	20210527	5	2021-05-27	THURSDAY	WORK	21
1730	1582	20210528	5	2021-05-28	FRIDAY	WORK	21
1731	1582	20210529	5	2021-05-29	SATURDAY	OUTPUT	21
1732	1582	20210530	5	2021-05-30	SUNDAY	OUTPUT	21
1733	1582	20210531	5	2021-05-31	MONDAY	WORK	22
1734	1582	20210601	6	2021-06-01	TUESDAY	WORK	22
1735	1582	20210602	6	2021-06-02	WEDNESDAY	WORK	22
1736	1582	20210603	6	2021-06-03	THURSDAY	WORK	22
1737	1582	20210604	6	2021-06-04	FRIDAY	WORK	22
1738	1582	20210605	6	2021-06-05	SATURDAY	OUTPUT	22
1739	1582	20210606	6	2021-06-06	SUNDAY	OUTPUT	22
1741	1582	20210608	6	2021-06-08	TUESDAY	WORK	23
1743	1582	20210610	6	2021-06-10	THURSDAY	WORK	23
1744	1582	20210611	6	2021-06-11	FRIDAY	WORK	23
1745	1582	20210612	6	2021-06-12	SATURDAY	OUTPUT	23
1746	1582	20210613	6	2021-06-13	SUNDAY	OUTPUT	23
1752	1582	20210619	6	2021-06-19	SATURDAY	OUTPUT	24
1753	1582	20210620	6	2021-06-20	SUNDAY	OUTPUT	24
1755	1582	20210622	6	2021-06-22	TUESDAY	WORK	25
1757	1582	20210624	6	2021-06-24	THURSDAY	WORK	25
1758	1582	20210625	6	2021-06-25	FRIDAY	WORK	25
1759	1582	20210626	6	2021-06-26	SATURDAY	OUTPUT	25
1760	1582	20210627	6	2021-06-27	SUNDAY	OUTPUT	25
1761	1582	20210628	6	2021-06-28	MONDAY	WORK	26
1762	1582	20210629	6	2021-06-29	TUESDAY	WORK	26
1763	1582	20210630	6	2021-06-30	WEDNESDAY	WORK	26
1764	1582	20210701	7	2021-07-01	THURSDAY	WORK	26
1765	1582	20210702	7	2021-07-02	FRIDAY	WORK	26
1766	1582	20210703	7	2021-07-03	SATURDAY	OUTPUT	26
1767	1582	20210704	7	2021-07-04	SUNDAY	OUTPUT	26
1768	1582	20210705	7	2021-07-05	MONDAY	WORK	27
1769	1582	20210706	7	2021-07-06	TUESDAY	WORK	27
1770	1582	20210707	7	2021-07-07	WEDNESDAY	WORK	27
1771	1582	20210708	7	2021-07-08	THURSDAY	WORK	27
1772	1582	20210709	7	2021-07-09	FRIDAY	WORK	27
1773	1582	20210710	7	2021-07-10	SATURDAY	OUTPUT	27
1774	1582	20210711	7	2021-07-11	SUNDAY	OUTPUT	27
1775	1582	20210712	7	2021-07-12	MONDAY	WORK	28
1776	1582	20210713	7	2021-07-13	TUESDAY	WORK	28
1777	1582	20210714	7	2021-07-14	WEDNESDAY	WORK	28
1778	1582	20210715	7	2021-07-15	THURSDAY	WORK	28
1779	1582	20210716	7	2021-07-16	FRIDAY	WORK	28
1780	1582	20210717	7	2021-07-17	SATURDAY	OUTPUT	28
1781	1582	20210718	7	2021-07-18	SUNDAY	OUTPUT	28
1782	1582	20210719	7	2021-07-19	MONDAY	WORK	29
1783	1582	20210720	7	2021-07-20	TUESDAY	WORK	29
1784	1582	20210721	7	2021-07-21	WEDNESDAY	WORK	29
1785	1582	20210722	7	2021-07-22	THURSDAY	WORK	29
1786	1582	20210723	7	2021-07-23	FRIDAY	WORK	29
1787	1582	20210724	7	2021-07-24	SATURDAY	OUTPUT	29
1788	1582	20210725	7	2021-07-25	SUNDAY	OUTPUT	29
1789	1582	20210726	7	2021-07-26	MONDAY	WORK	30
1790	1582	20210727	7	2021-07-27	TUESDAY	WORK	30
1791	1582	20210728	7	2021-07-28	WEDNESDAY	WORK	30
1792	1582	20210729	7	2021-07-29	THURSDAY	WORK	30
1793	1582	20210730	7	2021-07-30	FRIDAY	WORK	30
1794	1582	20210731	7	2021-07-31	SATURDAY	OUTPUT	30
1795	1582	20210801	8	2021-08-01	SUNDAY	OUTPUT	30
1796	1582	20210802	8	2021-08-02	MONDAY	WORK	31
1712	1582	20210510	5	2021-05-10	MONDAY	OUTPUT	19
1713	1582	20210511	5	2021-05-11	TUESDAY	OUTPUT	19
1715	1582	20210513	5	2021-05-13	THURSDAY	OUTPUT	19
1716	1582	20210514	5	2021-05-14	FRIDAY	OUTPUT	19
1740	1582	20210607	6	2021-06-07	MONDAY	OUTPUT	23
1748	1582	20210615	6	2021-06-15	TUESDAY	OUTPUT	24
1756	1582	20210623	6	2021-06-23	WEDNESDAY	OUTPUT	25
1754	1582	20210621	6	2021-06-21	MONDAY	OUTPUT	25
1742	1582	20210609	6	2021-06-09	WEDNESDAY	OUTPUT	23
1726	1582	20210524	5	2021-05-24	MONDAY	WORK	21
1719	1582	20210517	5	2021-05-17	MONDAY	WORK	20
1747	1582	20210614	6	2021-06-14	MONDAY	OUTPUT	24
1749	1582	20210616	6	2021-06-16	WEDNESDAY	OUTPUT	24
1750	1582	20210617	6	2021-06-17	THURSDAY	OUTPUT	24
1797	1582	20210803	8	2021-08-03	TUESDAY	WORK	31
1798	1582	20210804	8	2021-08-04	WEDNESDAY	WORK	31
1799	1582	20210805	8	2021-08-05	THURSDAY	WORK	31
1800	1582	20210806	8	2021-08-06	FRIDAY	WORK	31
1801	1582	20210807	8	2021-08-07	SATURDAY	OUTPUT	31
1802	1582	20210808	8	2021-08-08	SUNDAY	OUTPUT	31
1803	1582	20210809	8	2021-08-09	MONDAY	WORK	32
1804	1582	20210810	8	2021-08-10	TUESDAY	WORK	32
1805	1582	20210811	8	2021-08-11	WEDNESDAY	WORK	32
1806	1582	20210812	8	2021-08-12	THURSDAY	WORK	32
1807	1582	20210813	8	2021-08-13	FRIDAY	WORK	32
1808	1582	20210814	8	2021-08-14	SATURDAY	OUTPUT	32
1809	1582	20210815	8	2021-08-15	SUNDAY	OUTPUT	32
1810	1582	20210816	8	2021-08-16	MONDAY	WORK	33
1811	1582	20210817	8	2021-08-17	TUESDAY	WORK	33
1812	1582	20210818	8	2021-08-18	WEDNESDAY	WORK	33
1813	1582	20210819	8	2021-08-19	THURSDAY	WORK	33
1814	1582	20210820	8	2021-08-20	FRIDAY	WORK	33
1815	1582	20210821	8	2021-08-21	SATURDAY	OUTPUT	33
1816	1582	20210822	8	2021-08-22	SUNDAY	OUTPUT	33
1817	1582	20210823	8	2021-08-23	MONDAY	WORK	34
1818	1582	20210824	8	2021-08-24	TUESDAY	WORK	34
1819	1582	20210825	8	2021-08-25	WEDNESDAY	WORK	34
1820	1582	20210826	8	2021-08-26	THURSDAY	WORK	34
1821	1582	20210827	8	2021-08-27	FRIDAY	WORK	34
1822	1582	20210828	8	2021-08-28	SATURDAY	OUTPUT	34
1823	1582	20210829	8	2021-08-29	SUNDAY	OUTPUT	34
1824	1582	20210830	8	2021-08-30	MONDAY	WORK	35
1825	1582	20210831	8	2021-08-31	TUESDAY	WORK	35
1826	1582	20210901	9	2021-09-01	WEDNESDAY	WORK	35
1827	1582	20210902	9	2021-09-02	THURSDAY	WORK	35
1828	1582	20210903	9	2021-09-03	FRIDAY	WORK	35
1829	1582	20210904	9	2021-09-04	SATURDAY	OUTPUT	35
1830	1582	20210905	9	2021-09-05	SUNDAY	OUTPUT	35
1831	1582	20210906	9	2021-09-06	MONDAY	WORK	36
1832	1582	20210907	9	2021-09-07	TUESDAY	WORK	36
1833	1582	20210908	9	2021-09-08	WEDNESDAY	WORK	36
1834	1582	20210909	9	2021-09-09	THURSDAY	WORK	36
1835	1582	20210910	9	2021-09-10	FRIDAY	WORK	36
1836	1582	20210911	9	2021-09-11	SATURDAY	OUTPUT	36
1837	1582	20210912	9	2021-09-12	SUNDAY	OUTPUT	36
1838	1582	20210913	9	2021-09-13	MONDAY	WORK	37
1839	1582	20210914	9	2021-09-14	TUESDAY	WORK	37
1840	1582	20210915	9	2021-09-15	WEDNESDAY	WORK	37
1841	1582	20210916	9	2021-09-16	THURSDAY	WORK	37
1842	1582	20210917	9	2021-09-17	FRIDAY	WORK	37
1843	1582	20210918	9	2021-09-18	SATURDAY	OUTPUT	37
1844	1582	20210919	9	2021-09-19	SUNDAY	OUTPUT	37
1845	1582	20210920	9	2021-09-20	MONDAY	WORK	38
1846	1582	20210921	9	2021-09-21	TUESDAY	WORK	38
1847	1582	20210922	9	2021-09-22	WEDNESDAY	WORK	38
1848	1582	20210923	9	2021-09-23	THURSDAY	WORK	38
1849	1582	20210924	9	2021-09-24	FRIDAY	WORK	38
1850	1582	20210925	9	2021-09-25	SATURDAY	OUTPUT	38
1851	1582	20210926	9	2021-09-26	SUNDAY	OUTPUT	38
1852	1582	20210927	9	2021-09-27	MONDAY	WORK	39
1853	1582	20210928	9	2021-09-28	TUESDAY	WORK	39
1854	1582	20210929	9	2021-09-29	WEDNESDAY	WORK	39
1855	1582	20210930	9	2021-09-30	THURSDAY	WORK	39
1856	1582	20211001	10	2021-10-01	FRIDAY	WORK	39
1857	1582	20211002	10	2021-10-02	SATURDAY	OUTPUT	39
1858	1582	20211003	10	2021-10-03	SUNDAY	OUTPUT	39
1859	1582	20211004	10	2021-10-04	MONDAY	WORK	40
1860	1582	20211005	10	2021-10-05	TUESDAY	WORK	40
1861	1582	20211006	10	2021-10-06	WEDNESDAY	WORK	40
1862	1582	20211007	10	2021-10-07	THURSDAY	WORK	40
1863	1582	20211008	10	2021-10-08	FRIDAY	WORK	40
1864	1582	20211009	10	2021-10-09	SATURDAY	OUTPUT	40
1865	1582	20211010	10	2021-10-10	SUNDAY	OUTPUT	40
1866	1582	20211011	10	2021-10-11	MONDAY	WORK	41
1867	1582	20211012	10	2021-10-12	TUESDAY	WORK	41
1868	1582	20211013	10	2021-10-13	WEDNESDAY	WORK	41
1869	1582	20211014	10	2021-10-14	THURSDAY	WORK	41
1870	1582	20211015	10	2021-10-15	FRIDAY	WORK	41
1871	1582	20211016	10	2021-10-16	SATURDAY	OUTPUT	41
1872	1582	20211017	10	2021-10-17	SUNDAY	OUTPUT	41
1873	1582	20211018	10	2021-10-18	MONDAY	WORK	42
1874	1582	20211019	10	2021-10-19	TUESDAY	WORK	42
1875	1582	20211020	10	2021-10-20	WEDNESDAY	WORK	42
1876	1582	20211021	10	2021-10-21	THURSDAY	WORK	42
1877	1582	20211022	10	2021-10-22	FRIDAY	WORK	42
1878	1582	20211023	10	2021-10-23	SATURDAY	OUTPUT	42
1879	1582	20211024	10	2021-10-24	SUNDAY	OUTPUT	42
1880	1582	20211025	10	2021-10-25	MONDAY	WORK	43
1881	1582	20211026	10	2021-10-26	TUESDAY	WORK	43
1882	1582	20211027	10	2021-10-27	WEDNESDAY	WORK	43
1883	1582	20211028	10	2021-10-28	THURSDAY	WORK	43
1884	1582	20211029	10	2021-10-29	FRIDAY	WORK	43
1885	1582	20211030	10	2021-10-30	SATURDAY	OUTPUT	43
1886	1582	20211031	10	2021-10-31	SUNDAY	OUTPUT	43
1887	1582	20211101	11	2021-11-01	MONDAY	WORK	44
1888	1582	20211102	11	2021-11-02	TUESDAY	WORK	44
1889	1582	20211103	11	2021-11-03	WEDNESDAY	WORK	44
1890	1582	20211104	11	2021-11-04	THURSDAY	WORK	44
1891	1582	20211105	11	2021-11-05	FRIDAY	WORK	44
1892	1582	20211106	11	2021-11-06	SATURDAY	OUTPUT	44
1893	1582	20211107	11	2021-11-07	SUNDAY	OUTPUT	44
1894	1582	20211108	11	2021-11-08	MONDAY	WORK	45
1895	1582	20211109	11	2021-11-09	TUESDAY	WORK	45
1896	1582	20211110	11	2021-11-10	WEDNESDAY	WORK	45
1897	1582	20211111	11	2021-11-11	THURSDAY	WORK	45
1898	1582	20211112	11	2021-11-12	FRIDAY	WORK	45
1899	1582	20211113	11	2021-11-13	SATURDAY	OUTPUT	45
1900	1582	20211114	11	2021-11-14	SUNDAY	OUTPUT	45
1901	1582	20211115	11	2021-11-15	MONDAY	WORK	46
1902	1582	20211116	11	2021-11-16	TUESDAY	WORK	46
1903	1582	20211117	11	2021-11-17	WEDNESDAY	WORK	46
1904	1582	20211118	11	2021-11-18	THURSDAY	WORK	46
1905	1582	20211119	11	2021-11-19	FRIDAY	WORK	46
1906	1582	20211120	11	2021-11-20	SATURDAY	OUTPUT	46
1907	1582	20211121	11	2021-11-21	SUNDAY	OUTPUT	46
1908	1582	20211122	11	2021-11-22	MONDAY	WORK	47
1909	1582	20211123	11	2021-11-23	TUESDAY	WORK	47
1910	1582	20211124	11	2021-11-24	WEDNESDAY	WORK	47
1911	1582	20211125	11	2021-11-25	THURSDAY	WORK	47
1912	1582	20211126	11	2021-11-26	FRIDAY	WORK	47
1913	1582	20211127	11	2021-11-27	SATURDAY	OUTPUT	47
1914	1582	20211128	11	2021-11-28	SUNDAY	OUTPUT	47
1915	1582	20211129	11	2021-11-29	MONDAY	WORK	48
1916	1582	20211130	11	2021-11-30	TUESDAY	WORK	48
1917	1582	20211201	12	2021-12-01	WEDNESDAY	WORK	48
1918	1582	20211202	12	2021-12-02	THURSDAY	WORK	48
1919	1582	20211203	12	2021-12-03	FRIDAY	WORK	48
1920	1582	20211204	12	2021-12-04	SATURDAY	OUTPUT	48
1921	1582	20211205	12	2021-12-05	SUNDAY	OUTPUT	48
1922	1582	20211206	12	2021-12-06	MONDAY	WORK	49
1923	1582	20211207	12	2021-12-07	TUESDAY	WORK	49
1924	1582	20211208	12	2021-12-08	WEDNESDAY	WORK	49
1925	1582	20211209	12	2021-12-09	THURSDAY	WORK	49
1926	1582	20211210	12	2021-12-10	FRIDAY	WORK	49
1927	1582	20211211	12	2021-12-11	SATURDAY	OUTPUT	49
1928	1582	20211212	12	2021-12-12	SUNDAY	OUTPUT	49
1929	1582	20211213	12	2021-12-13	MONDAY	WORK	50
1930	1582	20211214	12	2021-12-14	TUESDAY	WORK	50
1931	1582	20211215	12	2021-12-15	WEDNESDAY	WORK	50
1932	1582	20211216	12	2021-12-16	THURSDAY	WORK	50
1933	1582	20211217	12	2021-12-17	FRIDAY	WORK	50
1934	1582	20211218	12	2021-12-18	SATURDAY	OUTPUT	50
1935	1582	20211219	12	2021-12-19	SUNDAY	OUTPUT	50
1936	1582	20211220	12	2021-12-20	MONDAY	WORK	51
1937	1582	20211221	12	2021-12-21	TUESDAY	WORK	51
1938	1582	20211222	12	2021-12-22	WEDNESDAY	WORK	51
1939	1582	20211223	12	2021-12-23	THURSDAY	WORK	51
1940	1582	20211224	12	2021-12-24	FRIDAY	WORK	51
1941	1582	20211225	12	2021-12-25	SATURDAY	OUTPUT	51
1942	1582	20211226	12	2021-12-26	SUNDAY	OUTPUT	51
1943	1582	20211227	12	2021-12-27	MONDAY	WORK	52
1944	1582	20211228	12	2021-12-28	TUESDAY	WORK	52
1945	1582	20211229	12	2021-12-29	WEDNESDAY	WORK	52
1946	1582	20211230	12	2021-12-30	THURSDAY	WORK	52
1947	1582	20211231	12	2021-12-31	FRIDAY	WORK	52
1714	1582	20210512	5	2021-05-12	WEDNESDAY	OUTPUT	19
1583	1582	20210101	1	2021-01-01	FRIDAY	HOLIDAY	53
1590	1582	20210108	1	2021-01-08	FRIDAY	HOLIDAY	1
1589	1582	20210107	1	2021-01-07	THURSDAY	HOLIDAY	1
1588	1582	20210106	1	2021-01-06	WEDNESDAY	HOLIDAY	1
1587	1582	20210105	1	2021-01-05	TUESDAY	HOLIDAY	1
1586	1582	20210104	1	2021-01-04	MONDAY	HOLIDAY	1
1698	1582	20210426	4	2021-04-26	MONDAY	OUTPUT	17
1692	1582	20210420	4	2021-04-20	TUESDAY	OUTPUT	16
1694	1582	20210422	4	2021-04-22	THURSDAY	OUTPUT	16
1702	1582	20210430	4	2021-04-30	FRIDAY	OUTPUT	17
1721	1582	20210519	5	2021-05-19	WEDNESDAY	WORK	20
1728	1582	20210526	5	2021-05-26	WEDNESDAY	WORK	21
1727	1582	20210525	5	2021-05-25	TUESDAY	WORK	21
1614	1582	20210201	2	2021-02-01	MONDAY	PRE_HOLIDAY	5
1622	1582	20210209	2	2021-02-09	TUESDAY	PRE_HOLIDAY	6
1949	1948	20220101	1	2022-01-01	SATURDAY	OUTPUT	52
1950	1948	20220102	1	2022-01-02	SUNDAY	OUTPUT	52
1951	1948	20220103	1	2022-01-03	MONDAY	WORK	1
1952	1948	20220104	1	2022-01-04	TUESDAY	WORK	1
1953	1948	20220105	1	2022-01-05	WEDNESDAY	WORK	1
1954	1948	20220106	1	2022-01-06	THURSDAY	WORK	1
1955	1948	20220107	1	2022-01-07	FRIDAY	WORK	1
1956	1948	20220108	1	2022-01-08	SATURDAY	OUTPUT	1
1957	1948	20220109	1	2022-01-09	SUNDAY	OUTPUT	1
1958	1948	20220110	1	2022-01-10	MONDAY	WORK	2
1959	1948	20220111	1	2022-01-11	TUESDAY	WORK	2
1960	1948	20220112	1	2022-01-12	WEDNESDAY	WORK	2
1961	1948	20220113	1	2022-01-13	THURSDAY	WORK	2
1962	1948	20220114	1	2022-01-14	FRIDAY	WORK	2
1963	1948	20220115	1	2022-01-15	SATURDAY	OUTPUT	2
1964	1948	20220116	1	2022-01-16	SUNDAY	OUTPUT	2
1965	1948	20220117	1	2022-01-17	MONDAY	WORK	3
1966	1948	20220118	1	2022-01-18	TUESDAY	WORK	3
1967	1948	20220119	1	2022-01-19	WEDNESDAY	WORK	3
1968	1948	20220120	1	2022-01-20	THURSDAY	WORK	3
1969	1948	20220121	1	2022-01-21	FRIDAY	WORK	3
1970	1948	20220122	1	2022-01-22	SATURDAY	OUTPUT	3
1971	1948	20220123	1	2022-01-23	SUNDAY	OUTPUT	3
1972	1948	20220124	1	2022-01-24	MONDAY	WORK	4
1973	1948	20220125	1	2022-01-25	TUESDAY	WORK	4
1974	1948	20220126	1	2022-01-26	WEDNESDAY	WORK	4
1975	1948	20220127	1	2022-01-27	THURSDAY	WORK	4
1976	1948	20220128	1	2022-01-28	FRIDAY	WORK	4
1977	1948	20220129	1	2022-01-29	SATURDAY	OUTPUT	4
1978	1948	20220130	1	2022-01-30	SUNDAY	OUTPUT	4
1979	1948	20220131	1	2022-01-31	MONDAY	WORK	5
1980	1948	20220201	2	2022-02-01	TUESDAY	WORK	5
1981	1948	20220202	2	2022-02-02	WEDNESDAY	WORK	5
1982	1948	20220203	2	2022-02-03	THURSDAY	WORK	5
1983	1948	20220204	2	2022-02-04	FRIDAY	WORK	5
1984	1948	20220205	2	2022-02-05	SATURDAY	OUTPUT	5
1985	1948	20220206	2	2022-02-06	SUNDAY	OUTPUT	5
1986	1948	20220207	2	2022-02-07	MONDAY	WORK	6
1987	1948	20220208	2	2022-02-08	TUESDAY	WORK	6
1988	1948	20220209	2	2022-02-09	WEDNESDAY	WORK	6
1989	1948	20220210	2	2022-02-10	THURSDAY	WORK	6
1990	1948	20220211	2	2022-02-11	FRIDAY	WORK	6
1991	1948	20220212	2	2022-02-12	SATURDAY	OUTPUT	6
1992	1948	20220213	2	2022-02-13	SUNDAY	OUTPUT	6
1993	1948	20220214	2	2022-02-14	MONDAY	WORK	7
1994	1948	20220215	2	2022-02-15	TUESDAY	WORK	7
1995	1948	20220216	2	2022-02-16	WEDNESDAY	WORK	7
1996	1948	20220217	2	2022-02-17	THURSDAY	WORK	7
1997	1948	20220218	2	2022-02-18	FRIDAY	WORK	7
1998	1948	20220219	2	2022-02-19	SATURDAY	OUTPUT	7
1999	1948	20220220	2	2022-02-20	SUNDAY	OUTPUT	7
2000	1948	20220221	2	2022-02-21	MONDAY	WORK	8
2001	1948	20220222	2	2022-02-22	TUESDAY	WORK	8
2002	1948	20220223	2	2022-02-23	WEDNESDAY	WORK	8
2003	1948	20220224	2	2022-02-24	THURSDAY	WORK	8
2004	1948	20220225	2	2022-02-25	FRIDAY	WORK	8
2005	1948	20220226	2	2022-02-26	SATURDAY	OUTPUT	8
2006	1948	20220227	2	2022-02-27	SUNDAY	OUTPUT	8
2007	1948	20220228	2	2022-02-28	MONDAY	WORK	9
2008	1948	20220301	3	2022-03-01	TUESDAY	WORK	9
2009	1948	20220302	3	2022-03-02	WEDNESDAY	WORK	9
2010	1948	20220303	3	2022-03-03	THURSDAY	WORK	9
2011	1948	20220304	3	2022-03-04	FRIDAY	WORK	9
2012	1948	20220305	3	2022-03-05	SATURDAY	OUTPUT	9
2013	1948	20220306	3	2022-03-06	SUNDAY	OUTPUT	9
2014	1948	20220307	3	2022-03-07	MONDAY	WORK	10
2015	1948	20220308	3	2022-03-08	TUESDAY	WORK	10
2016	1948	20220309	3	2022-03-09	WEDNESDAY	WORK	10
2017	1948	20220310	3	2022-03-10	THURSDAY	WORK	10
2018	1948	20220311	3	2022-03-11	FRIDAY	WORK	10
2019	1948	20220312	3	2022-03-12	SATURDAY	OUTPUT	10
2020	1948	20220313	3	2022-03-13	SUNDAY	OUTPUT	10
2021	1948	20220314	3	2022-03-14	MONDAY	WORK	11
2022	1948	20220315	3	2022-03-15	TUESDAY	WORK	11
2023	1948	20220316	3	2022-03-16	WEDNESDAY	WORK	11
2024	1948	20220317	3	2022-03-17	THURSDAY	WORK	11
2025	1948	20220318	3	2022-03-18	FRIDAY	WORK	11
2026	1948	20220319	3	2022-03-19	SATURDAY	OUTPUT	11
2027	1948	20220320	3	2022-03-20	SUNDAY	OUTPUT	11
2028	1948	20220321	3	2022-03-21	MONDAY	WORK	12
2029	1948	20220322	3	2022-03-22	TUESDAY	WORK	12
2030	1948	20220323	3	2022-03-23	WEDNESDAY	WORK	12
2031	1948	20220324	3	2022-03-24	THURSDAY	WORK	12
2032	1948	20220325	3	2022-03-25	FRIDAY	WORK	12
2033	1948	20220326	3	2022-03-26	SATURDAY	OUTPUT	12
2034	1948	20220327	3	2022-03-27	SUNDAY	OUTPUT	12
2035	1948	20220328	3	2022-03-28	MONDAY	WORK	13
2036	1948	20220329	3	2022-03-29	TUESDAY	WORK	13
2037	1948	20220330	3	2022-03-30	WEDNESDAY	WORK	13
2038	1948	20220331	3	2022-03-31	THURSDAY	WORK	13
2039	1948	20220401	4	2022-04-01	FRIDAY	WORK	13
2040	1948	20220402	4	2022-04-02	SATURDAY	OUTPUT	13
2041	1948	20220403	4	2022-04-03	SUNDAY	OUTPUT	13
2042	1948	20220404	4	2022-04-04	MONDAY	WORK	14
2043	1948	20220405	4	2022-04-05	TUESDAY	WORK	14
2044	1948	20220406	4	2022-04-06	WEDNESDAY	WORK	14
2045	1948	20220407	4	2022-04-07	THURSDAY	WORK	14
2046	1948	20220408	4	2022-04-08	FRIDAY	WORK	14
2047	1948	20220409	4	2022-04-09	SATURDAY	OUTPUT	14
2048	1948	20220410	4	2022-04-10	SUNDAY	OUTPUT	14
2049	1948	20220411	4	2022-04-11	MONDAY	WORK	15
2050	1948	20220412	4	2022-04-12	TUESDAY	WORK	15
2051	1948	20220413	4	2022-04-13	WEDNESDAY	WORK	15
2052	1948	20220414	4	2022-04-14	THURSDAY	WORK	15
2053	1948	20220415	4	2022-04-15	FRIDAY	WORK	15
2054	1948	20220416	4	2022-04-16	SATURDAY	OUTPUT	15
2055	1948	20220417	4	2022-04-17	SUNDAY	OUTPUT	15
2056	1948	20220418	4	2022-04-18	MONDAY	WORK	16
2057	1948	20220419	4	2022-04-19	TUESDAY	WORK	16
2058	1948	20220420	4	2022-04-20	WEDNESDAY	WORK	16
2059	1948	20220421	4	2022-04-21	THURSDAY	WORK	16
2060	1948	20220422	4	2022-04-22	FRIDAY	WORK	16
2061	1948	20220423	4	2022-04-23	SATURDAY	OUTPUT	16
2062	1948	20220424	4	2022-04-24	SUNDAY	OUTPUT	16
2063	1948	20220425	4	2022-04-25	MONDAY	WORK	17
2064	1948	20220426	4	2022-04-26	TUESDAY	WORK	17
2065	1948	20220427	4	2022-04-27	WEDNESDAY	WORK	17
2066	1948	20220428	4	2022-04-28	THURSDAY	WORK	17
2067	1948	20220429	4	2022-04-29	FRIDAY	WORK	17
2068	1948	20220430	4	2022-04-30	SATURDAY	OUTPUT	17
2069	1948	20220501	5	2022-05-01	SUNDAY	OUTPUT	17
2070	1948	20220502	5	2022-05-02	MONDAY	WORK	18
2071	1948	20220503	5	2022-05-03	TUESDAY	WORK	18
2072	1948	20220504	5	2022-05-04	WEDNESDAY	WORK	18
2073	1948	20220505	5	2022-05-05	THURSDAY	WORK	18
2074	1948	20220506	5	2022-05-06	FRIDAY	WORK	18
2075	1948	20220507	5	2022-05-07	SATURDAY	OUTPUT	18
2076	1948	20220508	5	2022-05-08	SUNDAY	OUTPUT	18
2077	1948	20220509	5	2022-05-09	MONDAY	WORK	19
2078	1948	20220510	5	2022-05-10	TUESDAY	WORK	19
2079	1948	20220511	5	2022-05-11	WEDNESDAY	WORK	19
2080	1948	20220512	5	2022-05-12	THURSDAY	WORK	19
2081	1948	20220513	5	2022-05-13	FRIDAY	WORK	19
2082	1948	20220514	5	2022-05-14	SATURDAY	OUTPUT	19
2083	1948	20220515	5	2022-05-15	SUNDAY	OUTPUT	19
2084	1948	20220516	5	2022-05-16	MONDAY	WORK	20
2085	1948	20220517	5	2022-05-17	TUESDAY	WORK	20
2086	1948	20220518	5	2022-05-18	WEDNESDAY	WORK	20
2087	1948	20220519	5	2022-05-19	THURSDAY	WORK	20
2088	1948	20220520	5	2022-05-20	FRIDAY	WORK	20
2089	1948	20220521	5	2022-05-21	SATURDAY	OUTPUT	20
2090	1948	20220522	5	2022-05-22	SUNDAY	OUTPUT	20
2091	1948	20220523	5	2022-05-23	MONDAY	WORK	21
2092	1948	20220524	5	2022-05-24	TUESDAY	WORK	21
2093	1948	20220525	5	2022-05-25	WEDNESDAY	WORK	21
2094	1948	20220526	5	2022-05-26	THURSDAY	WORK	21
2095	1948	20220527	5	2022-05-27	FRIDAY	WORK	21
2096	1948	20220528	5	2022-05-28	SATURDAY	OUTPUT	21
2097	1948	20220529	5	2022-05-29	SUNDAY	OUTPUT	21
2098	1948	20220530	5	2022-05-30	MONDAY	WORK	22
2099	1948	20220531	5	2022-05-31	TUESDAY	WORK	22
2100	1948	20220601	6	2022-06-01	WEDNESDAY	WORK	22
2101	1948	20220602	6	2022-06-02	THURSDAY	WORK	22
2102	1948	20220603	6	2022-06-03	FRIDAY	WORK	22
2103	1948	20220604	6	2022-06-04	SATURDAY	OUTPUT	22
2104	1948	20220605	6	2022-06-05	SUNDAY	OUTPUT	22
2105	1948	20220606	6	2022-06-06	MONDAY	WORK	23
2106	1948	20220607	6	2022-06-07	TUESDAY	WORK	23
2107	1948	20220608	6	2022-06-08	WEDNESDAY	WORK	23
2108	1948	20220609	6	2022-06-09	THURSDAY	WORK	23
2109	1948	20220610	6	2022-06-10	FRIDAY	WORK	23
2110	1948	20220611	6	2022-06-11	SATURDAY	OUTPUT	23
2111	1948	20220612	6	2022-06-12	SUNDAY	OUTPUT	23
2112	1948	20220613	6	2022-06-13	MONDAY	WORK	24
2113	1948	20220614	6	2022-06-14	TUESDAY	WORK	24
2114	1948	20220615	6	2022-06-15	WEDNESDAY	WORK	24
2115	1948	20220616	6	2022-06-16	THURSDAY	WORK	24
2116	1948	20220617	6	2022-06-17	FRIDAY	WORK	24
2117	1948	20220618	6	2022-06-18	SATURDAY	OUTPUT	24
2118	1948	20220619	6	2022-06-19	SUNDAY	OUTPUT	24
2119	1948	20220620	6	2022-06-20	MONDAY	WORK	25
2120	1948	20220621	6	2022-06-21	TUESDAY	WORK	25
2121	1948	20220622	6	2022-06-22	WEDNESDAY	WORK	25
2122	1948	20220623	6	2022-06-23	THURSDAY	WORK	25
2123	1948	20220624	6	2022-06-24	FRIDAY	WORK	25
2124	1948	20220625	6	2022-06-25	SATURDAY	OUTPUT	25
2125	1948	20220626	6	2022-06-26	SUNDAY	OUTPUT	25
2126	1948	20220627	6	2022-06-27	MONDAY	WORK	26
2127	1948	20220628	6	2022-06-28	TUESDAY	WORK	26
2128	1948	20220629	6	2022-06-29	WEDNESDAY	WORK	26
2129	1948	20220630	6	2022-06-30	THURSDAY	WORK	26
2130	1948	20220701	7	2022-07-01	FRIDAY	WORK	26
2131	1948	20220702	7	2022-07-02	SATURDAY	OUTPUT	26
2132	1948	20220703	7	2022-07-03	SUNDAY	OUTPUT	26
2133	1948	20220704	7	2022-07-04	MONDAY	WORK	27
2134	1948	20220705	7	2022-07-05	TUESDAY	WORK	27
2135	1948	20220706	7	2022-07-06	WEDNESDAY	WORK	27
2136	1948	20220707	7	2022-07-07	THURSDAY	WORK	27
2137	1948	20220708	7	2022-07-08	FRIDAY	WORK	27
2138	1948	20220709	7	2022-07-09	SATURDAY	OUTPUT	27
2139	1948	20220710	7	2022-07-10	SUNDAY	OUTPUT	27
2140	1948	20220711	7	2022-07-11	MONDAY	WORK	28
2141	1948	20220712	7	2022-07-12	TUESDAY	WORK	28
2142	1948	20220713	7	2022-07-13	WEDNESDAY	WORK	28
2143	1948	20220714	7	2022-07-14	THURSDAY	WORK	28
2144	1948	20220715	7	2022-07-15	FRIDAY	WORK	28
2145	1948	20220716	7	2022-07-16	SATURDAY	OUTPUT	28
2146	1948	20220717	7	2022-07-17	SUNDAY	OUTPUT	28
2147	1948	20220718	7	2022-07-18	MONDAY	WORK	29
2148	1948	20220719	7	2022-07-19	TUESDAY	WORK	29
2149	1948	20220720	7	2022-07-20	WEDNESDAY	WORK	29
2150	1948	20220721	7	2022-07-21	THURSDAY	WORK	29
2151	1948	20220722	7	2022-07-22	FRIDAY	WORK	29
2152	1948	20220723	7	2022-07-23	SATURDAY	OUTPUT	29
2153	1948	20220724	7	2022-07-24	SUNDAY	OUTPUT	29
2154	1948	20220725	7	2022-07-25	MONDAY	WORK	30
2155	1948	20220726	7	2022-07-26	TUESDAY	WORK	30
2156	1948	20220727	7	2022-07-27	WEDNESDAY	WORK	30
2157	1948	20220728	7	2022-07-28	THURSDAY	WORK	30
2158	1948	20220729	7	2022-07-29	FRIDAY	WORK	30
2159	1948	20220730	7	2022-07-30	SATURDAY	OUTPUT	30
2160	1948	20220731	7	2022-07-31	SUNDAY	OUTPUT	30
2161	1948	20220801	8	2022-08-01	MONDAY	WORK	31
2162	1948	20220802	8	2022-08-02	TUESDAY	WORK	31
2163	1948	20220803	8	2022-08-03	WEDNESDAY	WORK	31
2164	1948	20220804	8	2022-08-04	THURSDAY	WORK	31
2165	1948	20220805	8	2022-08-05	FRIDAY	WORK	31
2166	1948	20220806	8	2022-08-06	SATURDAY	OUTPUT	31
2167	1948	20220807	8	2022-08-07	SUNDAY	OUTPUT	31
2168	1948	20220808	8	2022-08-08	MONDAY	WORK	32
2169	1948	20220809	8	2022-08-09	TUESDAY	WORK	32
2170	1948	20220810	8	2022-08-10	WEDNESDAY	WORK	32
2171	1948	20220811	8	2022-08-11	THURSDAY	WORK	32
2172	1948	20220812	8	2022-08-12	FRIDAY	WORK	32
2173	1948	20220813	8	2022-08-13	SATURDAY	OUTPUT	32
2174	1948	20220814	8	2022-08-14	SUNDAY	OUTPUT	32
2175	1948	20220815	8	2022-08-15	MONDAY	WORK	33
2176	1948	20220816	8	2022-08-16	TUESDAY	WORK	33
2177	1948	20220817	8	2022-08-17	WEDNESDAY	WORK	33
2178	1948	20220818	8	2022-08-18	THURSDAY	WORK	33
2179	1948	20220819	8	2022-08-19	FRIDAY	WORK	33
2180	1948	20220820	8	2022-08-20	SATURDAY	OUTPUT	33
2181	1948	20220821	8	2022-08-21	SUNDAY	OUTPUT	33
2182	1948	20220822	8	2022-08-22	MONDAY	WORK	34
2183	1948	20220823	8	2022-08-23	TUESDAY	WORK	34
2184	1948	20220824	8	2022-08-24	WEDNESDAY	WORK	34
2185	1948	20220825	8	2022-08-25	THURSDAY	WORK	34
2186	1948	20220826	8	2022-08-26	FRIDAY	WORK	34
2187	1948	20220827	8	2022-08-27	SATURDAY	OUTPUT	34
2188	1948	20220828	8	2022-08-28	SUNDAY	OUTPUT	34
2189	1948	20220829	8	2022-08-29	MONDAY	WORK	35
2190	1948	20220830	8	2022-08-30	TUESDAY	WORK	35
2191	1948	20220831	8	2022-08-31	WEDNESDAY	WORK	35
2192	1948	20220901	9	2022-09-01	THURSDAY	WORK	35
2193	1948	20220902	9	2022-09-02	FRIDAY	WORK	35
2194	1948	20220903	9	2022-09-03	SATURDAY	OUTPUT	35
2195	1948	20220904	9	2022-09-04	SUNDAY	OUTPUT	35
2196	1948	20220905	9	2022-09-05	MONDAY	WORK	36
2197	1948	20220906	9	2022-09-06	TUESDAY	WORK	36
2198	1948	20220907	9	2022-09-07	WEDNESDAY	WORK	36
2199	1948	20220908	9	2022-09-08	THURSDAY	WORK	36
2200	1948	20220909	9	2022-09-09	FRIDAY	WORK	36
2201	1948	20220910	9	2022-09-10	SATURDAY	OUTPUT	36
2202	1948	20220911	9	2022-09-11	SUNDAY	OUTPUT	36
2203	1948	20220912	9	2022-09-12	MONDAY	WORK	37
2204	1948	20220913	9	2022-09-13	TUESDAY	WORK	37
2205	1948	20220914	9	2022-09-14	WEDNESDAY	WORK	37
2206	1948	20220915	9	2022-09-15	THURSDAY	WORK	37
2207	1948	20220916	9	2022-09-16	FRIDAY	WORK	37
2208	1948	20220917	9	2022-09-17	SATURDAY	OUTPUT	37
2209	1948	20220918	9	2022-09-18	SUNDAY	OUTPUT	37
2210	1948	20220919	9	2022-09-19	MONDAY	WORK	38
2211	1948	20220920	9	2022-09-20	TUESDAY	WORK	38
2212	1948	20220921	9	2022-09-21	WEDNESDAY	WORK	38
2213	1948	20220922	9	2022-09-22	THURSDAY	WORK	38
2214	1948	20220923	9	2022-09-23	FRIDAY	WORK	38
2215	1948	20220924	9	2022-09-24	SATURDAY	OUTPUT	38
2216	1948	20220925	9	2022-09-25	SUNDAY	OUTPUT	38
2217	1948	20220926	9	2022-09-26	MONDAY	WORK	39
2218	1948	20220927	9	2022-09-27	TUESDAY	WORK	39
2219	1948	20220928	9	2022-09-28	WEDNESDAY	WORK	39
2220	1948	20220929	9	2022-09-29	THURSDAY	WORK	39
2221	1948	20220930	9	2022-09-30	FRIDAY	WORK	39
2222	1948	20221001	10	2022-10-01	SATURDAY	OUTPUT	39
2223	1948	20221002	10	2022-10-02	SUNDAY	OUTPUT	39
2224	1948	20221003	10	2022-10-03	MONDAY	WORK	40
2225	1948	20221004	10	2022-10-04	TUESDAY	WORK	40
2226	1948	20221005	10	2022-10-05	WEDNESDAY	WORK	40
2227	1948	20221006	10	2022-10-06	THURSDAY	WORK	40
2228	1948	20221007	10	2022-10-07	FRIDAY	WORK	40
2229	1948	20221008	10	2022-10-08	SATURDAY	OUTPUT	40
2230	1948	20221009	10	2022-10-09	SUNDAY	OUTPUT	40
2231	1948	20221010	10	2022-10-10	MONDAY	WORK	41
2232	1948	20221011	10	2022-10-11	TUESDAY	WORK	41
2233	1948	20221012	10	2022-10-12	WEDNESDAY	WORK	41
2234	1948	20221013	10	2022-10-13	THURSDAY	WORK	41
2235	1948	20221014	10	2022-10-14	FRIDAY	WORK	41
2236	1948	20221015	10	2022-10-15	SATURDAY	OUTPUT	41
2237	1948	20221016	10	2022-10-16	SUNDAY	OUTPUT	41
2238	1948	20221017	10	2022-10-17	MONDAY	WORK	42
2239	1948	20221018	10	2022-10-18	TUESDAY	WORK	42
2240	1948	20221019	10	2022-10-19	WEDNESDAY	WORK	42
2241	1948	20221020	10	2022-10-20	THURSDAY	WORK	42
2242	1948	20221021	10	2022-10-21	FRIDAY	WORK	42
2243	1948	20221022	10	2022-10-22	SATURDAY	OUTPUT	42
2244	1948	20221023	10	2022-10-23	SUNDAY	OUTPUT	42
2245	1948	20221024	10	2022-10-24	MONDAY	WORK	43
2246	1948	20221025	10	2022-10-25	TUESDAY	WORK	43
2247	1948	20221026	10	2022-10-26	WEDNESDAY	WORK	43
2248	1948	20221027	10	2022-10-27	THURSDAY	WORK	43
2249	1948	20221028	10	2022-10-28	FRIDAY	WORK	43
2250	1948	20221029	10	2022-10-29	SATURDAY	OUTPUT	43
2251	1948	20221030	10	2022-10-30	SUNDAY	OUTPUT	43
2252	1948	20221031	10	2022-10-31	MONDAY	WORK	44
2253	1948	20221101	11	2022-11-01	TUESDAY	WORK	44
2254	1948	20221102	11	2022-11-02	WEDNESDAY	WORK	44
2255	1948	20221103	11	2022-11-03	THURSDAY	WORK	44
2256	1948	20221104	11	2022-11-04	FRIDAY	WORK	44
2257	1948	20221105	11	2022-11-05	SATURDAY	OUTPUT	44
2258	1948	20221106	11	2022-11-06	SUNDAY	OUTPUT	44
2259	1948	20221107	11	2022-11-07	MONDAY	WORK	45
2260	1948	20221108	11	2022-11-08	TUESDAY	WORK	45
2261	1948	20221109	11	2022-11-09	WEDNESDAY	WORK	45
2262	1948	20221110	11	2022-11-10	THURSDAY	WORK	45
2263	1948	20221111	11	2022-11-11	FRIDAY	WORK	45
2264	1948	20221112	11	2022-11-12	SATURDAY	OUTPUT	45
2265	1948	20221113	11	2022-11-13	SUNDAY	OUTPUT	45
2266	1948	20221114	11	2022-11-14	MONDAY	WORK	46
2267	1948	20221115	11	2022-11-15	TUESDAY	WORK	46
2268	1948	20221116	11	2022-11-16	WEDNESDAY	WORK	46
2269	1948	20221117	11	2022-11-17	THURSDAY	WORK	46
2270	1948	20221118	11	2022-11-18	FRIDAY	WORK	46
2271	1948	20221119	11	2022-11-19	SATURDAY	OUTPUT	46
2272	1948	20221120	11	2022-11-20	SUNDAY	OUTPUT	46
2273	1948	20221121	11	2022-11-21	MONDAY	WORK	47
2274	1948	20221122	11	2022-11-22	TUESDAY	WORK	47
2275	1948	20221123	11	2022-11-23	WEDNESDAY	WORK	47
2276	1948	20221124	11	2022-11-24	THURSDAY	WORK	47
2277	1948	20221125	11	2022-11-25	FRIDAY	WORK	47
2278	1948	20221126	11	2022-11-26	SATURDAY	OUTPUT	47
2279	1948	20221127	11	2022-11-27	SUNDAY	OUTPUT	47
2280	1948	20221128	11	2022-11-28	MONDAY	WORK	48
2281	1948	20221129	11	2022-11-29	TUESDAY	WORK	48
2282	1948	20221130	11	2022-11-30	WEDNESDAY	WORK	48
2283	1948	20221201	12	2022-12-01	THURSDAY	WORK	48
2284	1948	20221202	12	2022-12-02	FRIDAY	WORK	48
2285	1948	20221203	12	2022-12-03	SATURDAY	OUTPUT	48
2286	1948	20221204	12	2022-12-04	SUNDAY	OUTPUT	48
2287	1948	20221205	12	2022-12-05	MONDAY	WORK	49
2288	1948	20221206	12	2022-12-06	TUESDAY	WORK	49
2289	1948	20221207	12	2022-12-07	WEDNESDAY	WORK	49
2290	1948	20221208	12	2022-12-08	THURSDAY	WORK	49
2291	1948	20221209	12	2022-12-09	FRIDAY	WORK	49
2292	1948	20221210	12	2022-12-10	SATURDAY	OUTPUT	49
2293	1948	20221211	12	2022-12-11	SUNDAY	OUTPUT	49
2294	1948	20221212	12	2022-12-12	MONDAY	WORK	50
2295	1948	20221213	12	2022-12-13	TUESDAY	WORK	50
2296	1948	20221214	12	2022-12-14	WEDNESDAY	WORK	50
2297	1948	20221215	12	2022-12-15	THURSDAY	WORK	50
2298	1948	20221216	12	2022-12-16	FRIDAY	WORK	50
2299	1948	20221217	12	2022-12-17	SATURDAY	OUTPUT	50
2300	1948	20221218	12	2022-12-18	SUNDAY	OUTPUT	50
2301	1948	20221219	12	2022-12-19	MONDAY	WORK	51
2302	1948	20221220	12	2022-12-20	TUESDAY	WORK	51
2303	1948	20221221	12	2022-12-21	WEDNESDAY	WORK	51
2304	1948	20221222	12	2022-12-22	THURSDAY	WORK	51
2305	1948	20221223	12	2022-12-23	FRIDAY	WORK	51
2306	1948	20221224	12	2022-12-24	SATURDAY	OUTPUT	51
2307	1948	20221225	12	2022-12-25	SUNDAY	OUTPUT	51
2308	1948	20221226	12	2022-12-26	MONDAY	WORK	52
2309	1948	20221227	12	2022-12-27	TUESDAY	WORK	52
2310	1948	20221228	12	2022-12-28	WEDNESDAY	WORK	52
2311	1948	20221229	12	2022-12-29	THURSDAY	WORK	52
2312	1948	20221230	12	2022-12-30	FRIDAY	WORK	52
2313	1948	20221231	12	2022-12-31	SATURDAY	OUTPUT	52
2315	2314	20200101	1	2020-01-01	WEDNESDAY	WORK	1
2316	2314	20200102	1	2020-01-02	THURSDAY	WORK	1
2317	2314	20200103	1	2020-01-03	FRIDAY	WORK	1
2318	2314	20200104	1	2020-01-04	SATURDAY	OUTPUT	1
2319	2314	20200105	1	2020-01-05	SUNDAY	OUTPUT	1
2320	2314	20200106	1	2020-01-06	MONDAY	WORK	2
2321	2314	20200107	1	2020-01-07	TUESDAY	WORK	2
2322	2314	20200108	1	2020-01-08	WEDNESDAY	WORK	2
2323	2314	20200109	1	2020-01-09	THURSDAY	WORK	2
2324	2314	20200110	1	2020-01-10	FRIDAY	WORK	2
2325	2314	20200111	1	2020-01-11	SATURDAY	OUTPUT	2
2326	2314	20200112	1	2020-01-12	SUNDAY	OUTPUT	2
2327	2314	20200113	1	2020-01-13	MONDAY	WORK	3
2328	2314	20200114	1	2020-01-14	TUESDAY	WORK	3
2329	2314	20200115	1	2020-01-15	WEDNESDAY	WORK	3
2330	2314	20200116	1	2020-01-16	THURSDAY	WORK	3
2331	2314	20200117	1	2020-01-17	FRIDAY	WORK	3
2332	2314	20200118	1	2020-01-18	SATURDAY	OUTPUT	3
2333	2314	20200119	1	2020-01-19	SUNDAY	OUTPUT	3
2334	2314	20200120	1	2020-01-20	MONDAY	WORK	4
2335	2314	20200121	1	2020-01-21	TUESDAY	WORK	4
2336	2314	20200122	1	2020-01-22	WEDNESDAY	WORK	4
2337	2314	20200123	1	2020-01-23	THURSDAY	WORK	4
2338	2314	20200124	1	2020-01-24	FRIDAY	WORK	4
2339	2314	20200125	1	2020-01-25	SATURDAY	OUTPUT	4
2340	2314	20200126	1	2020-01-26	SUNDAY	OUTPUT	4
2341	2314	20200127	1	2020-01-27	MONDAY	WORK	5
2342	2314	20200128	1	2020-01-28	TUESDAY	WORK	5
2343	2314	20200129	1	2020-01-29	WEDNESDAY	WORK	5
2344	2314	20200130	1	2020-01-30	THURSDAY	WORK	5
2345	2314	20200131	1	2020-01-31	FRIDAY	WORK	5
2346	2314	20200201	2	2020-02-01	SATURDAY	OUTPUT	5
2347	2314	20200202	2	2020-02-02	SUNDAY	OUTPUT	5
2348	2314	20200203	2	2020-02-03	MONDAY	WORK	6
2349	2314	20200204	2	2020-02-04	TUESDAY	WORK	6
2350	2314	20200205	2	2020-02-05	WEDNESDAY	WORK	6
2351	2314	20200206	2	2020-02-06	THURSDAY	WORK	6
2352	2314	20200207	2	2020-02-07	FRIDAY	WORK	6
2353	2314	20200208	2	2020-02-08	SATURDAY	OUTPUT	6
2354	2314	20200209	2	2020-02-09	SUNDAY	OUTPUT	6
2355	2314	20200210	2	2020-02-10	MONDAY	WORK	7
2356	2314	20200211	2	2020-02-11	TUESDAY	WORK	7
2357	2314	20200212	2	2020-02-12	WEDNESDAY	WORK	7
2358	2314	20200213	2	2020-02-13	THURSDAY	WORK	7
2359	2314	20200214	2	2020-02-14	FRIDAY	WORK	7
2360	2314	20200215	2	2020-02-15	SATURDAY	OUTPUT	7
2361	2314	20200216	2	2020-02-16	SUNDAY	OUTPUT	7
2362	2314	20200217	2	2020-02-17	MONDAY	WORK	8
2363	2314	20200218	2	2020-02-18	TUESDAY	WORK	8
2364	2314	20200219	2	2020-02-19	WEDNESDAY	WORK	8
2365	2314	20200220	2	2020-02-20	THURSDAY	WORK	8
2366	2314	20200221	2	2020-02-21	FRIDAY	WORK	8
2367	2314	20200222	2	2020-02-22	SATURDAY	OUTPUT	8
2368	2314	20200223	2	2020-02-23	SUNDAY	OUTPUT	8
2369	2314	20200224	2	2020-02-24	MONDAY	WORK	9
2370	2314	20200225	2	2020-02-25	TUESDAY	WORK	9
2371	2314	20200226	2	2020-02-26	WEDNESDAY	WORK	9
2372	2314	20200227	2	2020-02-27	THURSDAY	WORK	9
2373	2314	20200228	2	2020-02-28	FRIDAY	WORK	9
2374	2314	20200229	2	2020-02-29	SATURDAY	OUTPUT	9
2375	2314	20200301	3	2020-03-01	SUNDAY	OUTPUT	9
2376	2314	20200302	3	2020-03-02	MONDAY	WORK	10
2377	2314	20200303	3	2020-03-03	TUESDAY	WORK	10
2378	2314	20200304	3	2020-03-04	WEDNESDAY	WORK	10
2379	2314	20200305	3	2020-03-05	THURSDAY	WORK	10
2380	2314	20200306	3	2020-03-06	FRIDAY	WORK	10
2381	2314	20200307	3	2020-03-07	SATURDAY	OUTPUT	10
2382	2314	20200308	3	2020-03-08	SUNDAY	OUTPUT	10
2383	2314	20200309	3	2020-03-09	MONDAY	WORK	11
2384	2314	20200310	3	2020-03-10	TUESDAY	WORK	11
2385	2314	20200311	3	2020-03-11	WEDNESDAY	WORK	11
2386	2314	20200312	3	2020-03-12	THURSDAY	WORK	11
2387	2314	20200313	3	2020-03-13	FRIDAY	WORK	11
2388	2314	20200314	3	2020-03-14	SATURDAY	OUTPUT	11
2389	2314	20200315	3	2020-03-15	SUNDAY	OUTPUT	11
2390	2314	20200316	3	2020-03-16	MONDAY	WORK	12
2391	2314	20200317	3	2020-03-17	TUESDAY	WORK	12
2392	2314	20200318	3	2020-03-18	WEDNESDAY	WORK	12
2393	2314	20200319	3	2020-03-19	THURSDAY	WORK	12
2394	2314	20200320	3	2020-03-20	FRIDAY	WORK	12
2395	2314	20200321	3	2020-03-21	SATURDAY	OUTPUT	12
2396	2314	20200322	3	2020-03-22	SUNDAY	OUTPUT	12
2397	2314	20200323	3	2020-03-23	MONDAY	WORK	13
2398	2314	20200324	3	2020-03-24	TUESDAY	WORK	13
2399	2314	20200325	3	2020-03-25	WEDNESDAY	WORK	13
2400	2314	20200326	3	2020-03-26	THURSDAY	WORK	13
2401	2314	20200327	3	2020-03-27	FRIDAY	WORK	13
2402	2314	20200328	3	2020-03-28	SATURDAY	OUTPUT	13
2403	2314	20200329	3	2020-03-29	SUNDAY	OUTPUT	13
2404	2314	20200330	3	2020-03-30	MONDAY	WORK	14
2405	2314	20200331	3	2020-03-31	TUESDAY	WORK	14
2406	2314	20200401	4	2020-04-01	WEDNESDAY	WORK	14
2407	2314	20200402	4	2020-04-02	THURSDAY	WORK	14
2408	2314	20200403	4	2020-04-03	FRIDAY	WORK	14
2409	2314	20200404	4	2020-04-04	SATURDAY	OUTPUT	14
2410	2314	20200405	4	2020-04-05	SUNDAY	OUTPUT	14
2411	2314	20200406	4	2020-04-06	MONDAY	WORK	15
2412	2314	20200407	4	2020-04-07	TUESDAY	WORK	15
2413	2314	20200408	4	2020-04-08	WEDNESDAY	WORK	15
2414	2314	20200409	4	2020-04-09	THURSDAY	WORK	15
2415	2314	20200410	4	2020-04-10	FRIDAY	WORK	15
2416	2314	20200411	4	2020-04-11	SATURDAY	OUTPUT	15
2417	2314	20200412	4	2020-04-12	SUNDAY	OUTPUT	15
2418	2314	20200413	4	2020-04-13	MONDAY	WORK	16
2419	2314	20200414	4	2020-04-14	TUESDAY	WORK	16
2420	2314	20200415	4	2020-04-15	WEDNESDAY	WORK	16
2421	2314	20200416	4	2020-04-16	THURSDAY	WORK	16
2422	2314	20200417	4	2020-04-17	FRIDAY	WORK	16
2423	2314	20200418	4	2020-04-18	SATURDAY	OUTPUT	16
2424	2314	20200419	4	2020-04-19	SUNDAY	OUTPUT	16
2425	2314	20200420	4	2020-04-20	MONDAY	WORK	17
2426	2314	20200421	4	2020-04-21	TUESDAY	WORK	17
2427	2314	20200422	4	2020-04-22	WEDNESDAY	WORK	17
2428	2314	20200423	4	2020-04-23	THURSDAY	WORK	17
2429	2314	20200424	4	2020-04-24	FRIDAY	WORK	17
2430	2314	20200425	4	2020-04-25	SATURDAY	OUTPUT	17
2431	2314	20200426	4	2020-04-26	SUNDAY	OUTPUT	17
2432	2314	20200427	4	2020-04-27	MONDAY	WORK	18
2433	2314	20200428	4	2020-04-28	TUESDAY	WORK	18
2434	2314	20200429	4	2020-04-29	WEDNESDAY	WORK	18
2435	2314	20200430	4	2020-04-30	THURSDAY	WORK	18
2436	2314	20200501	5	2020-05-01	FRIDAY	WORK	18
2437	2314	20200502	5	2020-05-02	SATURDAY	OUTPUT	18
2438	2314	20200503	5	2020-05-03	SUNDAY	OUTPUT	18
2439	2314	20200504	5	2020-05-04	MONDAY	WORK	19
2440	2314	20200505	5	2020-05-05	TUESDAY	WORK	19
2441	2314	20200506	5	2020-05-06	WEDNESDAY	WORK	19
2442	2314	20200507	5	2020-05-07	THURSDAY	WORK	19
2443	2314	20200508	5	2020-05-08	FRIDAY	WORK	19
2444	2314	20200509	5	2020-05-09	SATURDAY	OUTPUT	19
2445	2314	20200510	5	2020-05-10	SUNDAY	OUTPUT	19
2446	2314	20200511	5	2020-05-11	MONDAY	WORK	20
2447	2314	20200512	5	2020-05-12	TUESDAY	WORK	20
2448	2314	20200513	5	2020-05-13	WEDNESDAY	WORK	20
2449	2314	20200514	5	2020-05-14	THURSDAY	WORK	20
2450	2314	20200515	5	2020-05-15	FRIDAY	WORK	20
2451	2314	20200516	5	2020-05-16	SATURDAY	OUTPUT	20
2452	2314	20200517	5	2020-05-17	SUNDAY	OUTPUT	20
2453	2314	20200518	5	2020-05-18	MONDAY	WORK	21
2454	2314	20200519	5	2020-05-19	TUESDAY	WORK	21
2455	2314	20200520	5	2020-05-20	WEDNESDAY	WORK	21
2456	2314	20200521	5	2020-05-21	THURSDAY	WORK	21
2457	2314	20200522	5	2020-05-22	FRIDAY	WORK	21
2458	2314	20200523	5	2020-05-23	SATURDAY	OUTPUT	21
2459	2314	20200524	5	2020-05-24	SUNDAY	OUTPUT	21
2460	2314	20200525	5	2020-05-25	MONDAY	WORK	22
2461	2314	20200526	5	2020-05-26	TUESDAY	WORK	22
2462	2314	20200527	5	2020-05-27	WEDNESDAY	WORK	22
2463	2314	20200528	5	2020-05-28	THURSDAY	WORK	22
2464	2314	20200529	5	2020-05-29	FRIDAY	WORK	22
2465	2314	20200530	5	2020-05-30	SATURDAY	OUTPUT	22
2466	2314	20200531	5	2020-05-31	SUNDAY	OUTPUT	22
2467	2314	20200601	6	2020-06-01	MONDAY	WORK	23
2468	2314	20200602	6	2020-06-02	TUESDAY	WORK	23
2469	2314	20200603	6	2020-06-03	WEDNESDAY	WORK	23
2470	2314	20200604	6	2020-06-04	THURSDAY	WORK	23
2471	2314	20200605	6	2020-06-05	FRIDAY	WORK	23
2472	2314	20200606	6	2020-06-06	SATURDAY	OUTPUT	23
2473	2314	20200607	6	2020-06-07	SUNDAY	OUTPUT	23
2474	2314	20200608	6	2020-06-08	MONDAY	WORK	24
2475	2314	20200609	6	2020-06-09	TUESDAY	WORK	24
2476	2314	20200610	6	2020-06-10	WEDNESDAY	WORK	24
2477	2314	20200611	6	2020-06-11	THURSDAY	WORK	24
2478	2314	20200612	6	2020-06-12	FRIDAY	WORK	24
2479	2314	20200613	6	2020-06-13	SATURDAY	OUTPUT	24
2480	2314	20200614	6	2020-06-14	SUNDAY	OUTPUT	24
2481	2314	20200615	6	2020-06-15	MONDAY	WORK	25
2482	2314	20200616	6	2020-06-16	TUESDAY	WORK	25
2483	2314	20200617	6	2020-06-17	WEDNESDAY	WORK	25
2484	2314	20200618	6	2020-06-18	THURSDAY	WORK	25
2485	2314	20200619	6	2020-06-19	FRIDAY	WORK	25
2486	2314	20200620	6	2020-06-20	SATURDAY	OUTPUT	25
2487	2314	20200621	6	2020-06-21	SUNDAY	OUTPUT	25
2488	2314	20200622	6	2020-06-22	MONDAY	WORK	26
2489	2314	20200623	6	2020-06-23	TUESDAY	WORK	26
2490	2314	20200624	6	2020-06-24	WEDNESDAY	WORK	26
2491	2314	20200625	6	2020-06-25	THURSDAY	WORK	26
2492	2314	20200626	6	2020-06-26	FRIDAY	WORK	26
2493	2314	20200627	6	2020-06-27	SATURDAY	OUTPUT	26
2494	2314	20200628	6	2020-06-28	SUNDAY	OUTPUT	26
2495	2314	20200629	6	2020-06-29	MONDAY	WORK	27
2496	2314	20200630	6	2020-06-30	TUESDAY	WORK	27
2497	2314	20200701	7	2020-07-01	WEDNESDAY	WORK	27
2498	2314	20200702	7	2020-07-02	THURSDAY	WORK	27
2499	2314	20200703	7	2020-07-03	FRIDAY	WORK	27
2500	2314	20200704	7	2020-07-04	SATURDAY	OUTPUT	27
2501	2314	20200705	7	2020-07-05	SUNDAY	OUTPUT	27
2502	2314	20200706	7	2020-07-06	MONDAY	WORK	28
2503	2314	20200707	7	2020-07-07	TUESDAY	WORK	28
2504	2314	20200708	7	2020-07-08	WEDNESDAY	WORK	28
2505	2314	20200709	7	2020-07-09	THURSDAY	WORK	28
2506	2314	20200710	7	2020-07-10	FRIDAY	WORK	28
2507	2314	20200711	7	2020-07-11	SATURDAY	OUTPUT	28
2508	2314	20200712	7	2020-07-12	SUNDAY	OUTPUT	28
2509	2314	20200713	7	2020-07-13	MONDAY	WORK	29
2510	2314	20200714	7	2020-07-14	TUESDAY	WORK	29
2511	2314	20200715	7	2020-07-15	WEDNESDAY	WORK	29
2512	2314	20200716	7	2020-07-16	THURSDAY	WORK	29
2513	2314	20200717	7	2020-07-17	FRIDAY	WORK	29
2514	2314	20200718	7	2020-07-18	SATURDAY	OUTPUT	29
2515	2314	20200719	7	2020-07-19	SUNDAY	OUTPUT	29
2516	2314	20200720	7	2020-07-20	MONDAY	WORK	30
2517	2314	20200721	7	2020-07-21	TUESDAY	WORK	30
2518	2314	20200722	7	2020-07-22	WEDNESDAY	WORK	30
2519	2314	20200723	7	2020-07-23	THURSDAY	WORK	30
2520	2314	20200724	7	2020-07-24	FRIDAY	WORK	30
2521	2314	20200725	7	2020-07-25	SATURDAY	OUTPUT	30
2522	2314	20200726	7	2020-07-26	SUNDAY	OUTPUT	30
2523	2314	20200727	7	2020-07-27	MONDAY	WORK	31
2524	2314	20200728	7	2020-07-28	TUESDAY	WORK	31
2525	2314	20200729	7	2020-07-29	WEDNESDAY	WORK	31
2526	2314	20200730	7	2020-07-30	THURSDAY	WORK	31
2527	2314	20200731	7	2020-07-31	FRIDAY	WORK	31
2528	2314	20200801	8	2020-08-01	SATURDAY	OUTPUT	31
2529	2314	20200802	8	2020-08-02	SUNDAY	OUTPUT	31
2530	2314	20200803	8	2020-08-03	MONDAY	WORK	32
2531	2314	20200804	8	2020-08-04	TUESDAY	WORK	32
2532	2314	20200805	8	2020-08-05	WEDNESDAY	WORK	32
2533	2314	20200806	8	2020-08-06	THURSDAY	WORK	32
2534	2314	20200807	8	2020-08-07	FRIDAY	WORK	32
2535	2314	20200808	8	2020-08-08	SATURDAY	OUTPUT	32
2536	2314	20200809	8	2020-08-09	SUNDAY	OUTPUT	32
2537	2314	20200810	8	2020-08-10	MONDAY	WORK	33
2538	2314	20200811	8	2020-08-11	TUESDAY	WORK	33
2539	2314	20200812	8	2020-08-12	WEDNESDAY	WORK	33
2540	2314	20200813	8	2020-08-13	THURSDAY	WORK	33
2541	2314	20200814	8	2020-08-14	FRIDAY	WORK	33
2542	2314	20200815	8	2020-08-15	SATURDAY	OUTPUT	33
2543	2314	20200816	8	2020-08-16	SUNDAY	OUTPUT	33
2544	2314	20200817	8	2020-08-17	MONDAY	WORK	34
2545	2314	20200818	8	2020-08-18	TUESDAY	WORK	34
2546	2314	20200819	8	2020-08-19	WEDNESDAY	WORK	34
2547	2314	20200820	8	2020-08-20	THURSDAY	WORK	34
2548	2314	20200821	8	2020-08-21	FRIDAY	WORK	34
2549	2314	20200822	8	2020-08-22	SATURDAY	OUTPUT	34
2550	2314	20200823	8	2020-08-23	SUNDAY	OUTPUT	34
2551	2314	20200824	8	2020-08-24	MONDAY	WORK	35
2552	2314	20200825	8	2020-08-25	TUESDAY	WORK	35
2553	2314	20200826	8	2020-08-26	WEDNESDAY	WORK	35
2554	2314	20200827	8	2020-08-27	THURSDAY	WORK	35
2555	2314	20200828	8	2020-08-28	FRIDAY	WORK	35
2556	2314	20200829	8	2020-08-29	SATURDAY	OUTPUT	35
2557	2314	20200830	8	2020-08-30	SUNDAY	OUTPUT	35
2558	2314	20200831	8	2020-08-31	MONDAY	WORK	36
2559	2314	20200901	9	2020-09-01	TUESDAY	WORK	36
2560	2314	20200902	9	2020-09-02	WEDNESDAY	WORK	36
2561	2314	20200903	9	2020-09-03	THURSDAY	WORK	36
2562	2314	20200904	9	2020-09-04	FRIDAY	WORK	36
2563	2314	20200905	9	2020-09-05	SATURDAY	OUTPUT	36
2564	2314	20200906	9	2020-09-06	SUNDAY	OUTPUT	36
2565	2314	20200907	9	2020-09-07	MONDAY	WORK	37
2566	2314	20200908	9	2020-09-08	TUESDAY	WORK	37
2567	2314	20200909	9	2020-09-09	WEDNESDAY	WORK	37
2568	2314	20200910	9	2020-09-10	THURSDAY	WORK	37
2569	2314	20200911	9	2020-09-11	FRIDAY	WORK	37
2570	2314	20200912	9	2020-09-12	SATURDAY	OUTPUT	37
2571	2314	20200913	9	2020-09-13	SUNDAY	OUTPUT	37
2572	2314	20200914	9	2020-09-14	MONDAY	WORK	38
2573	2314	20200915	9	2020-09-15	TUESDAY	WORK	38
2574	2314	20200916	9	2020-09-16	WEDNESDAY	WORK	38
2575	2314	20200917	9	2020-09-17	THURSDAY	WORK	38
2576	2314	20200918	9	2020-09-18	FRIDAY	WORK	38
2577	2314	20200919	9	2020-09-19	SATURDAY	OUTPUT	38
2578	2314	20200920	9	2020-09-20	SUNDAY	OUTPUT	38
2579	2314	20200921	9	2020-09-21	MONDAY	WORK	39
2580	2314	20200922	9	2020-09-22	TUESDAY	WORK	39
2581	2314	20200923	9	2020-09-23	WEDNESDAY	WORK	39
2582	2314	20200924	9	2020-09-24	THURSDAY	WORK	39
2583	2314	20200925	9	2020-09-25	FRIDAY	WORK	39
2584	2314	20200926	9	2020-09-26	SATURDAY	OUTPUT	39
2585	2314	20200927	9	2020-09-27	SUNDAY	OUTPUT	39
2586	2314	20200928	9	2020-09-28	MONDAY	WORK	40
2587	2314	20200929	9	2020-09-29	TUESDAY	WORK	40
2588	2314	20200930	9	2020-09-30	WEDNESDAY	WORK	40
2589	2314	20201001	10	2020-10-01	THURSDAY	WORK	40
2590	2314	20201002	10	2020-10-02	FRIDAY	WORK	40
2591	2314	20201003	10	2020-10-03	SATURDAY	OUTPUT	40
2592	2314	20201004	10	2020-10-04	SUNDAY	OUTPUT	40
2593	2314	20201005	10	2020-10-05	MONDAY	WORK	41
2594	2314	20201006	10	2020-10-06	TUESDAY	WORK	41
2595	2314	20201007	10	2020-10-07	WEDNESDAY	WORK	41
2596	2314	20201008	10	2020-10-08	THURSDAY	WORK	41
2597	2314	20201009	10	2020-10-09	FRIDAY	WORK	41
2598	2314	20201010	10	2020-10-10	SATURDAY	OUTPUT	41
2599	2314	20201011	10	2020-10-11	SUNDAY	OUTPUT	41
2600	2314	20201012	10	2020-10-12	MONDAY	WORK	42
2601	2314	20201013	10	2020-10-13	TUESDAY	WORK	42
2602	2314	20201014	10	2020-10-14	WEDNESDAY	WORK	42
2603	2314	20201015	10	2020-10-15	THURSDAY	WORK	42
2604	2314	20201016	10	2020-10-16	FRIDAY	WORK	42
2605	2314	20201017	10	2020-10-17	SATURDAY	OUTPUT	42
2606	2314	20201018	10	2020-10-18	SUNDAY	OUTPUT	42
2607	2314	20201019	10	2020-10-19	MONDAY	WORK	43
2608	2314	20201020	10	2020-10-20	TUESDAY	WORK	43
2609	2314	20201021	10	2020-10-21	WEDNESDAY	WORK	43
2610	2314	20201022	10	2020-10-22	THURSDAY	WORK	43
2611	2314	20201023	10	2020-10-23	FRIDAY	WORK	43
2612	2314	20201024	10	2020-10-24	SATURDAY	OUTPUT	43
2613	2314	20201025	10	2020-10-25	SUNDAY	OUTPUT	43
2614	2314	20201026	10	2020-10-26	MONDAY	WORK	44
2615	2314	20201027	10	2020-10-27	TUESDAY	WORK	44
2616	2314	20201028	10	2020-10-28	WEDNESDAY	WORK	44
2617	2314	20201029	10	2020-10-29	THURSDAY	WORK	44
2618	2314	20201030	10	2020-10-30	FRIDAY	WORK	44
2619	2314	20201031	10	2020-10-31	SATURDAY	OUTPUT	44
2620	2314	20201101	11	2020-11-01	SUNDAY	OUTPUT	44
2621	2314	20201102	11	2020-11-02	MONDAY	WORK	45
2622	2314	20201103	11	2020-11-03	TUESDAY	WORK	45
2623	2314	20201104	11	2020-11-04	WEDNESDAY	WORK	45
2624	2314	20201105	11	2020-11-05	THURSDAY	WORK	45
2625	2314	20201106	11	2020-11-06	FRIDAY	WORK	45
2626	2314	20201107	11	2020-11-07	SATURDAY	OUTPUT	45
2627	2314	20201108	11	2020-11-08	SUNDAY	OUTPUT	45
2628	2314	20201109	11	2020-11-09	MONDAY	WORK	46
2629	2314	20201110	11	2020-11-10	TUESDAY	WORK	46
2630	2314	20201111	11	2020-11-11	WEDNESDAY	WORK	46
2631	2314	20201112	11	2020-11-12	THURSDAY	WORK	46
2632	2314	20201113	11	2020-11-13	FRIDAY	WORK	46
2633	2314	20201114	11	2020-11-14	SATURDAY	OUTPUT	46
2634	2314	20201115	11	2020-11-15	SUNDAY	OUTPUT	46
2635	2314	20201116	11	2020-11-16	MONDAY	WORK	47
2636	2314	20201117	11	2020-11-17	TUESDAY	WORK	47
2637	2314	20201118	11	2020-11-18	WEDNESDAY	WORK	47
2638	2314	20201119	11	2020-11-19	THURSDAY	WORK	47
2639	2314	20201120	11	2020-11-20	FRIDAY	WORK	47
2640	2314	20201121	11	2020-11-21	SATURDAY	OUTPUT	47
2641	2314	20201122	11	2020-11-22	SUNDAY	OUTPUT	47
2642	2314	20201123	11	2020-11-23	MONDAY	WORK	48
2643	2314	20201124	11	2020-11-24	TUESDAY	WORK	48
2644	2314	20201125	11	2020-11-25	WEDNESDAY	WORK	48
2645	2314	20201126	11	2020-11-26	THURSDAY	WORK	48
2646	2314	20201127	11	2020-11-27	FRIDAY	WORK	48
2647	2314	20201128	11	2020-11-28	SATURDAY	OUTPUT	48
2648	2314	20201129	11	2020-11-29	SUNDAY	OUTPUT	48
2649	2314	20201130	11	2020-11-30	MONDAY	WORK	49
2650	2314	20201201	12	2020-12-01	TUESDAY	WORK	49
2651	2314	20201202	12	2020-12-02	WEDNESDAY	WORK	49
2652	2314	20201203	12	2020-12-03	THURSDAY	WORK	49
2653	2314	20201204	12	2020-12-04	FRIDAY	WORK	49
2654	2314	20201205	12	2020-12-05	SATURDAY	OUTPUT	49
2655	2314	20201206	12	2020-12-06	SUNDAY	OUTPUT	49
2656	2314	20201207	12	2020-12-07	MONDAY	WORK	50
2657	2314	20201208	12	2020-12-08	TUESDAY	WORK	50
2658	2314	20201209	12	2020-12-09	WEDNESDAY	WORK	50
2659	2314	20201210	12	2020-12-10	THURSDAY	WORK	50
2660	2314	20201211	12	2020-12-11	FRIDAY	WORK	50
2661	2314	20201212	12	2020-12-12	SATURDAY	OUTPUT	50
2662	2314	20201213	12	2020-12-13	SUNDAY	OUTPUT	50
2663	2314	20201214	12	2020-12-14	MONDAY	WORK	51
2664	2314	20201215	12	2020-12-15	TUESDAY	WORK	51
2665	2314	20201216	12	2020-12-16	WEDNESDAY	WORK	51
2666	2314	20201217	12	2020-12-17	THURSDAY	WORK	51
2667	2314	20201218	12	2020-12-18	FRIDAY	WORK	51
2668	2314	20201219	12	2020-12-19	SATURDAY	OUTPUT	51
2669	2314	20201220	12	2020-12-20	SUNDAY	OUTPUT	51
2670	2314	20201221	12	2020-12-21	MONDAY	WORK	52
2671	2314	20201222	12	2020-12-22	TUESDAY	WORK	52
2672	2314	20201223	12	2020-12-23	WEDNESDAY	WORK	52
2673	2314	20201224	12	2020-12-24	THURSDAY	WORK	52
2674	2314	20201225	12	2020-12-25	FRIDAY	WORK	52
2675	2314	20201226	12	2020-12-26	SATURDAY	OUTPUT	52
2676	2314	20201227	12	2020-12-27	SUNDAY	OUTPUT	52
2677	2314	20201228	12	2020-12-28	MONDAY	WORK	53
2678	2314	20201229	12	2020-12-29	TUESDAY	WORK	53
2679	2314	20201230	12	2020-12-30	WEDNESDAY	WORK	53
2680	2314	20201231	12	2020-12-31	THURSDAY	WORK	53
1657	1582	20210316	3	2021-03-16	TUESDAY	OUTPUT	11
1658	1582	20210317	3	2021-03-17	WEDNESDAY	OUTPUT	11
1659	1582	20210318	3	2021-03-18	THURSDAY	OUTPUT	11
1751	1582	20210618	6	2021-06-18	FRIDAY	OUTPUT	24
1660	1582	20210319	3	2021-03-19	FRIDAY	WORK	11
\.


                                                                                                                                            3170.dat                                                                                            0000600 0004000 0002000 00000000104 14113761513 0014241 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1582	80	WORK	2021	t
1948	80	WORK	2022	f
2314	80	GENERAL	2020	f
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                            3173.dat                                                                                            0000600 0004000 0002000 00000000005 14113761513 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3164.dat                                                                                            0000600 0004000 0002000 00000000107 14113761513 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10	2	2
11	3	3
80	ООО "Газпром банк"	ООО "ГПБ"
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                         3165.dat                                                                                            0000600 0004000 0002000 00000000503 14113761513 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        4	1	Иванов	Иван	Иванович	2021-02-28	80	89278414320	123	\N
14	6	Иванов	q	q	2021-01-04	80			\N
79	7	Попкин	1	1	2021-03-02	80	1	1	586c1f61-6639-477c-a2a9-04d8eeb9d82f.n07740461_183.jpg
15	9	1	1		2021-03-01	80			\N
114	8	Петров	Петр	Петрович	2008-01-08	80	456	йцуйц	\N
\.


                                                                                                                                                                                             3168.dat                                                                                            0000600 0004000 0002000 00000000534 14113761513 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        106	104	4	89	0	f	f	2021-08-01	2021-08-02
105	103	4	89	0	f	f	2021-08-01	2021-08-02
108	103	4	89	0	t	t	2021-08-03	\N
111	104	79	92	0	t	t	2021-08-08	\N
110	104	15	89	0	f	f	2021-08-08	2021-08-09
112	104	15	90	0	t	t	2021-08-09	\N
116	104	114	115	0	t	t	2021-08-10	\N
109	104	4	89	0	f	f	2021-08-03	2021-08-10
107	103	4	95	0	f	f	2021-08-03	2021-08-10
\.


                                                                                                                                                                    3169.dat                                                                                            0000600 0004000 0002000 00000000174 14113761513 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        103	Гениральный директор	senior	director
104	Главный-программис	senior	development
\.


                                                                                                                                                                                                                                                                                                                                                                                                    3174.dat                                                                                            0000600 0004000 0002000 00000000005 14113761513 0014245 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3166.dat                                                                                            0000600 0004000 0002000 00000000065 14113761513 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        77	1	SysName	SEND_MAIL
76	1	Type	int
78	1	Val	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3176.dat                                                                                            0000600 0004000 0002000 00000000005 14113761513 0014247 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3167.dat                                                                                            0000600 0004000 0002000 00000000310 14113761513 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        89	80	\N	1	1	1
95	80	94	2/1	2/1	1
94	80	89	1/1	1/1	1
96	80	91	3/1	3/1	9
90	80	89	2	2	9
91	80	89	21	21	7
100	80	\N	44	44	1
101	80	89	55	55	6
92	80	90	31	31	7
113	80	92	41	41	6
115	80	90	311	311	8
\.


                                                                                                                                                                                                                                                                                                                        3175.dat                                                                                            0000600 0004000 0002000 00000000005 14113761513 0014246 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3162.dat                                                                                            0000600 0004000 0002000 00000001037 14113761513 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	\N	t	\N	$2a$08$5RR1sB80T10r0DrNkunBkuKwaHhP5WupINEBXraphUXMpvWx2aQb.	admin
6	9992d99f-261d-446e-a0fc-e8b5ec46c1ba	t	a@mail.com	$2a$08$b1UAIj0fFO7wpVXwpglHAOdua2IUo5HGgZ5r8HjPhOyHEfvv0W2mi	a
7	39852710-358c-4b72-b7bd-25f1d2866f10	t	aa@mail.com	$2a$08$RJIoMsP58xdeg9cEP/x4A./RJI0au4gUsfLlWReLChfC2xgGrB3o2	aa
8	b503b358-0740-4085-a447-f0078d9ee030	t	aa@mail.com	$2a$08$VrAk1/uUsDQ6A7DvOspoxO6uMBMnDSGkSARTLThJEeeU/.721v4JG	aaa
9	a0a37501-d8ef-4e8a-be89-f8c216cac875	t	a@a	$2a$08$aiBP3tckxz5QMVX5TVNfwOlIyQ13Ye2lJW2GkqEXY6iw01isE3KfS	aaaa
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 3163.dat                                                                                            0000600 0004000 0002000 00000000060 14113761513 0014244 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	USER
6	USER
6	ADMIN
7	USER
8	USER
9	USER
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                3172.dat                                                                                            0000600 0004000 0002000 00000000734 14113761513 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2682	f	4	2021-08-28	2021-08-28	10:00:00	17:00:00	8	1	f
2683	f	4	2021-08-30	2021-08-30	10:30:00	17:00:00	1	1	f
2684	f	4	2021-08-30	\N	10:30:00	17:00:00	1	1	f
2685	f	4	2021-08-30	\N	10:30:00	17:00:00	1	1	f
2686	f	4	2021-08-30	2021-08-30	10:30:00	17:00:00	8	1	f
2687	f	4	2021-08-30	2021-08-30	10:30:00	17:00:00	7	1	f
2688	f	4	2021-08-30	2021-08-30	10:30:00	17:00:00	7	1	f
2681	f	4	2021-08-28	2021-08-30	10:30:00	17:00:00	8	1	t
2689	t	4	2021-08-30	\N	10:30:00	17:00:00	7	1	f
\.


                                    restore.sql                                                                                         0000600 0004000 0002000 00000043770 14113761513 0015401 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE rsa;
--
-- Name: rsa; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE rsa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';


ALTER DATABASE rsa OWNER TO postgres;

\connect rsa

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
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


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id bigint NOT NULL,
    file_name character varying(255),
    tag character varying(255),
    text character varying(2048) NOT NULL,
    user_id bigint
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: t_bid_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_bid_rule (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    bid_type character varying(255) NOT NULL,
    enterprise_id bigint NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.t_bid_rule OWNER TO postgres;

--
-- Name: t_calendar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_calendar (
    id bigint NOT NULL,
    calendar_enterprise_id bigint NOT NULL,
    date_int integer NOT NULL,
    month_int integer NOT NULL,
    date_d date,
    day_week character varying(255) NOT NULL,
    day_type character varying(255) NOT NULL,
    number_week integer NOT NULL
);


ALTER TABLE public.t_calendar OWNER TO postgres;

--
-- Name: t_calendar_enterprise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_calendar_enterprise (
    id bigint NOT NULL,
    enterprise_id bigint NOT NULL,
    calendar_type character varying(255) NOT NULL,
    year_int integer NOT NULL,
    active boolean
);


ALTER TABLE public.t_calendar_enterprise OWNER TO postgres;

--
-- Name: t_deal_object; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_deal_object (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    bid_type character varying(255) NOT NULL,
    bid_rule_id bigint NOT NULL,
    protocol_id bigint NOT NULL
);


ALTER TABLE public.t_deal_object OWNER TO postgres;

--
-- Name: t_enterprise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_enterprise (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brief character varying(255) NOT NULL
);


ALTER TABLE public.t_enterprise OWNER TO postgres;

--
-- Name: t_institution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_institution (
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


ALTER TABLE public.t_institution OWNER TO postgres;

--
-- Name: t_position; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_position (
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


ALTER TABLE public.t_position OWNER TO postgres;

--
-- Name: t_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_post (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    post_level character varying(255) NOT NULL,
    post_type character varying(255) NOT NULL
);


ALTER TABLE public.t_post OWNER TO postgres;

--
-- Name: t_protocol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_protocol (
    id bigint NOT NULL,
    object_id bigint NOT NULL,
    date_protocol date NOT NULL,
    transition_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.t_protocol OWNER TO postgres;

--
-- Name: t_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_settings (
    id bigint NOT NULL,
    s_id bigint NOT NULL,
    sys_name character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.t_settings OWNER TO postgres;

--
-- Name: t_state; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_state (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    brief character varying(255) NOT NULL,
    state_type character varying(255) NOT NULL,
    number integer NOT NULL
);


ALTER TABLE public.t_state OWNER TO postgres;

--
-- Name: t_subdivision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_subdivision (
    id bigint NOT NULL,
    enterprise_id bigint NOT NULL,
    parent_id bigint,
    brief character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    leader_id bigint NOT NULL
);


ALTER TABLE public.t_subdivision OWNER TO postgres;

--
-- Name: t_transition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_transition (
    id bigint NOT NULL,
    bid_rule_id bigint NOT NULL,
    source_state_id bigint NOT NULL,
    action_name character varying(255) NOT NULL,
    action_type character varying(255) NOT NULL,
    target_state_id bigint NOT NULL,
    institution_id bigint NOT NULL
);


ALTER TABLE public.t_transition OWNER TO postgres;

--
-- Name: t_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_user (
    id bigint NOT NULL,
    activation_code character varying(255),
    active boolean NOT NULL,
    email character varying(255),
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL
);


ALTER TABLE public.t_user OWNER TO postgres;

--
-- Name: t_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_user_role (
    user_id bigint NOT NULL,
    role character varying(255)
);


ALTER TABLE public.t_user_role OWNER TO postgres;

--
-- Name: t_work_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.t_work_schedule (
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


ALTER TABLE public.t_work_schedule OWNER TO postgres;

--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
\.
COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM '$$PATH$$/3159.dat';

--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, file_name, tag, text, user_id) FROM stdin;
\.
COPY public.message (id, file_name, tag, text, user_id) FROM '$$PATH$$/3161.dat';

--
-- Data for Name: t_bid_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_bid_rule (id, name, bid_type, enterprise_id, active) FROM stdin;
\.
COPY public.t_bid_rule (id, name, bid_type, enterprise_id, active) FROM '$$PATH$$/3177.dat';

--
-- Data for Name: t_calendar; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_calendar (id, calendar_enterprise_id, date_int, month_int, date_d, day_week, day_type, number_week) FROM stdin;
\.
COPY public.t_calendar (id, calendar_enterprise_id, date_int, month_int, date_d, day_week, day_type, number_week) FROM '$$PATH$$/3171.dat';

--
-- Data for Name: t_calendar_enterprise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_calendar_enterprise (id, enterprise_id, calendar_type, year_int, active) FROM stdin;
\.
COPY public.t_calendar_enterprise (id, enterprise_id, calendar_type, year_int, active) FROM '$$PATH$$/3170.dat';

--
-- Data for Name: t_deal_object; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_deal_object (id, object_id, bid_type, bid_rule_id, protocol_id) FROM stdin;
\.
COPY public.t_deal_object (id, object_id, bid_type, bid_rule_id, protocol_id) FROM '$$PATH$$/3173.dat';

--
-- Data for Name: t_enterprise; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_enterprise (id, name, brief) FROM stdin;
\.
COPY public.t_enterprise (id, name, brief) FROM '$$PATH$$/3164.dat';

--
-- Data for Name: t_institution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_institution (id, user_id, last_name, first_name, second_name, date_of_birth, enterprise_id, phone_number, skype_name, file_name) FROM stdin;
\.
COPY public.t_institution (id, user_id, last_name, first_name, second_name, date_of_birth, enterprise_id, phone_number, skype_name, file_name) FROM '$$PATH$$/3165.dat';

--
-- Data for Name: t_position; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_position (id, post_id, institution_id, subdivision_id, number, general, active, date_start, date_end) FROM stdin;
\.
COPY public.t_position (id, post_id, institution_id, subdivision_id, number, general, active, date_start, date_end) FROM '$$PATH$$/3168.dat';

--
-- Data for Name: t_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_post (id, name, post_level, post_type) FROM stdin;
\.
COPY public.t_post (id, name, post_level, post_type) FROM '$$PATH$$/3169.dat';

--
-- Data for Name: t_protocol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_protocol (id, object_id, date_protocol, transition_id, user_id) FROM stdin;
\.
COPY public.t_protocol (id, object_id, date_protocol, transition_id, user_id) FROM '$$PATH$$/3174.dat';

--
-- Data for Name: t_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_settings (id, s_id, sys_name, value) FROM stdin;
\.
COPY public.t_settings (id, s_id, sys_name, value) FROM '$$PATH$$/3166.dat';

--
-- Data for Name: t_state; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_state (id, bid_rule_id, name, brief, state_type, number) FROM stdin;
\.
COPY public.t_state (id, bid_rule_id, name, brief, state_type, number) FROM '$$PATH$$/3176.dat';

--
-- Data for Name: t_subdivision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_subdivision (id, enterprise_id, parent_id, brief, name, leader_id) FROM stdin;
\.
COPY public.t_subdivision (id, enterprise_id, parent_id, brief, name, leader_id) FROM '$$PATH$$/3167.dat';

--
-- Data for Name: t_transition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_transition (id, bid_rule_id, source_state_id, action_name, action_type, target_state_id, institution_id) FROM stdin;
\.
COPY public.t_transition (id, bid_rule_id, source_state_id, action_name, action_type, target_state_id, institution_id) FROM '$$PATH$$/3175.dat';

--
-- Data for Name: t_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_user (id, activation_code, active, email, password, username) FROM stdin;
\.
COPY public.t_user (id, activation_code, active, email, password, username) FROM '$$PATH$$/3162.dat';

--
-- Data for Name: t_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_user_role (user_id, role) FROM stdin;
\.
COPY public.t_user_role (user_id, role) FROM '$$PATH$$/3163.dat';

--
-- Data for Name: t_work_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.t_work_schedule (id, active, institution_id, date_start, date_end, time_begin, time_finish, work_time, lunch_break, lunch_break_in) FROM stdin;
\.
COPY public.t_work_schedule (id, active, institution_id, date_start, date_end, time_begin, time_finish, work_time, lunch_break, lunch_break_in) FROM '$$PATH$$/3172.dat';

--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 2689, true);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: t_bid_rule t_bid_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_bid_rule
    ADD CONSTRAINT t_bid_rule_pkey PRIMARY KEY (id);


--
-- Name: t_calendar_enterprise t_calendar_enterprise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_calendar_enterprise
    ADD CONSTRAINT t_calendar_enterprise_pkey PRIMARY KEY (id);


--
-- Name: t_calendar t_calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_calendar
    ADD CONSTRAINT t_calendar_pkey PRIMARY KEY (id);


--
-- Name: t_deal_object t_deal_object_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_deal_object
    ADD CONSTRAINT t_deal_object_pkey PRIMARY KEY (id);


--
-- Name: t_enterprise t_enterprise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_enterprise
    ADD CONSTRAINT t_enterprise_pkey PRIMARY KEY (id);


--
-- Name: t_institution t_institution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_institution
    ADD CONSTRAINT t_institution_pkey PRIMARY KEY (id);


--
-- Name: t_position t_position_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_position
    ADD CONSTRAINT t_position_pkey PRIMARY KEY (id);


--
-- Name: t_post t_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_post
    ADD CONSTRAINT t_post_pkey PRIMARY KEY (id);


--
-- Name: t_protocol t_protocol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_protocol
    ADD CONSTRAINT t_protocol_pkey PRIMARY KEY (id);


--
-- Name: t_settings t_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_settings
    ADD CONSTRAINT t_settings_pkey PRIMARY KEY (id);


--
-- Name: t_state t_state_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_state
    ADD CONSTRAINT t_state_pkey PRIMARY KEY (id);


--
-- Name: t_subdivision t_subdivision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_subdivision
    ADD CONSTRAINT t_subdivision_pkey PRIMARY KEY (id);


--
-- Name: t_transition t_transition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_transition
    ADD CONSTRAINT t_transition_pkey PRIMARY KEY (id);


--
-- Name: t_user t_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id);


--
-- Name: t_work_schedule t_work_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_work_schedule
    ADD CONSTRAINT t_work_schedule_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: message message_user_fg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_user_fg FOREIGN KEY (user_id) REFERENCES public.t_user(id);


--
-- Name: t_user_role role_user_fg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.t_user_role
    ADD CONSTRAINT role_user_fg FOREIGN KEY (user_id) REFERENCES public.t_user(id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        