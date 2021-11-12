PGDMP     	                
    y            rsa    13.2    13.2 K    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    rsa    DATABASE     `   CREATE DATABASE rsa WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE rsa;
                postgres    false                        3079    16436    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            �           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2                        3079    16513 	   tablefunc 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;
    DROP EXTENSION tablefunc;
                   false            �           0    0    EXTENSION tablefunc    COMMENT     `   COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';
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
       public         heap    postgres    false            k          0    16395    flyway_schema_history 
   TABLE DATA           �   COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
    public          postgres    false    202   ^       m          0    16407    message 
   TABLE DATA           D   COPY public.message (id, file_name, tag, text, user_id) FROM stdin;
    public          postgres    false    204   �a       }          0    33104 
   t_bid_rule 
   TABLE DATA           O   COPY public.t_bid_rule (id, name, bid_type, enterprise_id, active) FROM stdin;
    public          postgres    false    223   b       w          0    32970 
   t_calendar 
   TABLE DATA           ~   COPY public.t_calendar (id, calendar_enterprise_id, date_int, month_int, date_d, day_week, day_type, number_week) FROM stdin;
    public          postgres    false    217   �b       v          0    32965    t_calendar_enterprise 
   TABLE DATA           c   COPY public.t_calendar_enterprise (id, enterprise_id, calendar_type, year_int, active) FROM stdin;
    public          postgres    false    216   ͋       y          0    33078    t_deal_object 
   TABLE DATA           m   COPY public.t_deal_object (id, bid_rule_id, protocol_id, author_id, responsible_id, employee_id) FROM stdin;
    public          postgres    false    219   �                 0    33315    t_deal_object_attr 
   TABLE DATA           c   COPY public.t_deal_object_attr (id, deal_object_id, deal_object_attr_type, value_attr) FROM stdin;
    public          postgres    false    225   b�       p          0    16473    t_enterprise 
   TABLE DATA           7   COPY public.t_enterprise (id, name, brief) FROM stdin;
    public          postgres    false    207   �       q          0    16481    t_institution 
   TABLE DATA           �   COPY public.t_institution (id, user_id, last_name, first_name, second_name, date_of_birth, enterprise_id, phone_number, skype_name, file_name) FROM stdin;
    public          postgres    false    208   n�       t          0    32926 
   t_position 
   TABLE DATA           �   COPY public.t_position (id, post_id, institution_id, subdivision_id, number, general, active, date_start, date_end) FROM stdin;
    public          postgres    false    214   N�       u          0    32931    t_post 
   TABLE DATA           A   COPY public.t_post (id, name, post_level, post_type) FROM stdin;
    public          postgres    false    215   �       �          0    33335    t_presence_work 
   TABLE DATA           }   COPY public.t_presence_work (id, institution_id, calendar_id, time_begin, time_finish, active, number, duration) FROM stdin;
    public          postgres    false    226   e�       z          0    33083 
   t_protocol 
   TABLE DATA           j   COPY public.t_protocol (id, object_id, date_protocol, transition_id, user_id, responsible_id) FROM stdin;
    public          postgres    false    220   w�       r          0    16505 
   t_settings 
   TABLE DATA           ?   COPY public.t_settings (id, s_id, sys_name, value) FROM stdin;
    public          postgres    false    209   @�       |          0    33096    t_state 
   TABLE DATA           S   COPY public.t_state (id, bid_rule_id, name, brief, state_type, number) FROM stdin;
    public          postgres    false    222   ��       s          0    24726    t_subdivision 
   TABLE DATA           ]   COPY public.t_subdivision (id, enterprise_id, parent_id, brief, name, leader_id) FROM stdin;
    public          postgres    false    213   K�       {          0    33088    t_transition 
   TABLE DATA           �   COPY public.t_transition (id, bid_rule_id, source_state_id, action_name, action_type, target_state_id, institution_id) FROM stdin;
    public          postgres    false    221   Ò       n          0    16415    t_user 
   TABLE DATA           X   COPY public.t_user (id, activation_code, active, email, password, username) FROM stdin;
    public          postgres    false    205   ��       o          0    16423    t_user_role 
   TABLE DATA           4   COPY public.t_user_role (user_id, role) FROM stdin;
    public          postgres    false    206   L�       x          0    33004    t_work_schedule 
   TABLE DATA           �   COPY public.t_work_schedule (id, active, institution_id, date_start, date_end, time_begin, time_finish, work_time, lunch_break, lunch_break_in) FROM stdin;
    public          postgres    false    218   ��       ~          0    33310    t_work_schedule_correct 
   TABLE DATA           �   COPY public.t_work_schedule_correct (id, institution_id, deal_object_id, calendar_id, time_begin, time_finish, comment, work_schedule_correct_type) FROM stdin;
    public          postgres    false    224   �       �           0    0    hibernate_sequence    SEQUENCE SET     C   SELECT pg_catalog.setval('public.hibernate_sequence', 2777, true);
          public          postgres    false    203            �           2606    16403 .   flyway_schema_history flyway_schema_history_pk 
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
       public          postgres    false    205    3012    206            k   �  x��V�n�F<��B? ����mm'�y8p�� d���,&��~zfHK2�05�*vuU�Р�x����y��'�	�&�n�o���{�B�`���4|>�'C@�^��jt5���H`��nȐ��ۭ6�����KM��&'�uG���G��9v�)86�a��ڇ���o�xn��r&@���=� �8Rxkl���7O�� ��ݹP ��Ŋ�>j�3�>Z��vݐQ>NC7�](�4K'��D'ﱱ���Eg(��t�/���/χ������H�����0��j�ִ{��ּ�=���>�
�?7=(-�����li�k�5IE �
�4��Ŧ~���/��qVa���BH<�%W�J�gmM���i��,ML�/O�����f̄�BA��"�[�F^a�9��#�55�:D0z&��Sw�Y��If����Y/!��������@�C��6e�6����GM�T)-h� �<:a��"�� T�
�H�:*�6�M��W�葝��g)
k��j(*R�������?~{�~iw/SBQ�Y��Sq1̂�a���	*��0X]�����~��n�sm�Pp!Z��V���T�nE
.z#y�bp���4�)�Z)��WPp~���̩��	�*0���KA����?��0R�kqƇ�͡��
<�����fIe��F��Q ����v����}�i����8��D@��H��+֥�P��')sIBQ�\/����g���J�Z|�g]�esa4z&����c��..$��ו�؜
��+�l{n�@_�,�~��~��pL�̠��@Nf��9u*U��+���gϒJ��R.J�`Qip�ď�m僤�D6�P
�B�Ԅ6��l�KD�]饯��&�3��>&.T�z�2�]O���K|J��%�S�6����A��m�ʵ� ���g%��ɗ?ՠ,QH�bџ�����V�      m      x�34���4B3�=... O|      }   y   x�32�4�0�bӅ��/����u��ws�0�L�22�4����|���.�0Gg�O?�|	���P��;�*v(\l����ދ=;.l��qus�wu򉄚en`�]��!���=... j�@V      w      x�u�ݮ�Hr]��~�L�u)`�òZ�� @���-���<{E��\t{�9U�d�q2�g������ˋ[��l���(����?��Ͽ��ۿ����������W;~{��C+ǯ��o��1>Z���a��ڰ"�����ȟ�?�O����qi�
?�ɟ� k������������i�c�w������q�]׷��������b�@��`����_�<(�R~^��?�7� �
�y?��8Ѩڨ�������O��4��}^��q�uE���f/غ�}^��y�u����Os��P�ϋ�i��J�y�Os��������~B�7�z�F�i�����S����/h\ڈ'���~�'yK���xǦ���:U�y�i�7mᘻ���4�Cb��~]߯�Cb4*��xH�<~}�_�y�����+x��z^��g4�[w�}F^?��<+<G5N�OOH�����W����
U5��#"�4��e�/�OM��e4n4.m���ް�~9���
޲�[N��(� �J,qf� h�О��������`<�x�o�y ���R{^��, �+�p��8��R{9kf�ʭ�xڌ�UP�h����^zZ���O�y�u��P�ϋ����R�Ϲ[W��9|��PQp-��c���_�Q9Q�ZI��(\(4-������u#~j<|���K���c4�ƭ�x2��G���q�\��ԟ���YgSΖN�Q gS�N������j����?�`f����<
�fJ���<�f
�^N��!pkzk�[���������=�;p�lz�l�Փj�%7�%7��K=�J��J���M%<-�>-���oh����?A����N\�\�T/�@�����&�����Kg�Kg	�`3��ӯW���ܸ�^u,�C��]��]w�>��LnY]oY�7^/4|���i������뿥�y/~���S�sw��o5�oM?��+M�+-^	�}n�j�/������xnp}n�7� i�C:������)�p ����N���������M�q��?�B1�B�t�1
�B1�B�p��\V�뷃��������z����;�8�\Ϯ>P���Q�7��7��"��Q�%�������!vaT]?��E|ӣ�O��S}^��k�smO��B�wW�m�JEŵ��m�BC���A�w���W���)���|�|K��h�h��8�4
.-\<�z���4���CC壕O�PG���]?/����
޶���3K��^�T����~mT^z^/��i���\gG�������u�q�y�Gǳ�c����8:��vE��Q���k�:�!�~H���hWОGӳ���Џ����Y��z��zp�������I���x��oȻ�=�p�q�qh��(\(T-T~�#~#�4�O�Y��rj%���T�K!�G�+�>���[:FL1X8FL)���0*�`������[�cY)���W�]߶��u�>\߇�o=�C����xC888\�,m�q`���^9*�VҟvFǒ���ǁ������C�|6���w�j\y�2��f�D��x��ʅJ�J��B�ߕ`2�o:$�,#��X��|�̆�qk#>Ẑ����,3���M�O�e�2+�l�9Yf�M9�!���L�.S�q�2�l
9?��(�RNc�Y gS�a,3☌��,��̬��)���3�l�9<�x��d�ߔ��=�Xg�]!�g�� eW���u�ٕsx��q`v���p5+���9=\�8�r~^����>��+��,6��
9?��(�RN�b� ·r~^�o�#̇b>�۬(����߫r��=��|N\<��~㉿�6�G�����y������������>�y���񸃻`ӻ`��3�G�G�7���wk�n�7�#��y�	r���Y�}��}���r�F�������=����~��l�P�X�r?_��O����Ѵ/Խpc�q?��R��z��K��B=+�ʭ�x�����x�>�Ǖ���?q���hz:Z�P��G����z�ٔ��B=��l���zV�ٔ���(`:r�r�p�>z�M9[�P�< �B�|�P6�l�B=
����Åzā���\�G�]9{���8�rv�؎������Ìm�����h`vt�R�8c�pv�윱�80�b�<c�pv��q�6�|(�_8G�qp>���pf^!���g�?��8~��q���H��(�(Z����9�{��sE�J:�G�P8�N����K�����[������G����y.g?����)f{9�G�M9[:�G�M9[8��gS�O��ǭ�����4@ٔ����ٔ���ā������Φ�-��� ή�=��w���+g�����+dOc�� eW��Pg�]9;�PG���b�<F�pv��q�:����y||z�]9{���< �B~^�u4@�P�G��΂p��oC�lX��m|�#!���I������Q�l|Шh�y�>S��,�|C��5Σ`(�(�i��8**�)�q�q�����|E��|�P�N�N��餵����Ƈ��N7�0Ӟ�6ප�tV�����|4.77�g��_�8����]���a�C�O��ǝ� ��y�ì���w��0 � �;�<�;���x�wO{F�q��?D� � ��=�p;p��|�v��{F�������?�� �w@����-�֬���?K�<�ƶ'��kB/���)�(��~�s�s��N�Ѩh�h�ӯ߽����*���o���~
y�ج�5|�i�l��5|�a����?�9���G�S6�QJ'�~�ah44��w�<���- � �ܖO���p�����[�9����w�'A��O��e8��ں��pt����e�qp9��E�����qt�}����qt�Uy��y|Ǝ�8.�á�8����Y���s6pt9����`�qp9������i��l���x�oP���ㆃYP��OI_���ʍ���,��A�@�s�����E��σ��1t:q�2�ƉG-�����a�2��4l�����8m�%��T�i�q����˼ev@�@<\f���ĥ=������e�ۀ;�\f����e6@�@<L]f��_�.���i�2 � /�z����e�ہ;�^f����e4*�;���������ev@�A<�_f�����yσ��x��p;p�	̬���i3 ~��a�^�7N�ɦ�B�x�>6`sm�͵�&w����ם?a�A_}ba@u��s�e�����)��腆#��dLTߛ�)L������.�F�`��x��)�dl�/���#t���'R���NE�;����p��N�tA���u.�:j�uԞac��n�\k{���8K�O�Sǟ���/��R�O�>���k%~�͂�ph!���iG�j:.�����&�*
�Ғ��o�_�+�{�D���˂�޸��h#����[�_�/�_�4���KSz�[S��\�ؚ�MKYFtM醕,#��p_����M;FtM醅AGO��)ݸMaā�m>�Gl]٦m#��tî��� ��˦�� ]W�iO�ȃ�+ݰ*�?�_��J7^�Fh]���(��+۴�b�Aוn�_їAa�O=��5��[�p[�Lw��3����\8z\�������9��I�7F�ϡ�ϑnU>�>���׍Mܧ��q�x���G��B�������p�����{��hh��Hw�="i���>�/�oM����s߈4�.%��l����I�S?�5����4���}�2�kJ7�y�5�%���tM�Z���8К��t)�5ek�R2�kJ�x)i�5����e4@וn��r�楀�+ݰf��i�u�7ʌ8к���'�Q [W�ic�ȃ�+ݰ�f���˶�� ]W�iW�ȃ�+ݰ����Jw��|�����ǟ�%�O��^��¡�x�yC�j��͑v����us44Nm����W�/��i����Ås�O�?�OW��P��5��5��>��,%��3¦�_.���`l�8]=g�M!�˧Y    ���)�x��y06e�/��ʦ��t�ٔs���80�b~���
8�rN�Y gW��*j�����9^FG� dW��::��J9]Hg�]9�+��+�K鬀�+�t-�pv�.�v�88�r�;g���w(�(J�x�@=弽Q��QA����_N�Q1T������p��?o����W�O���4�6��?
'
���?����������9ʿ樨�z2�l�9�Ͳ��1'��(_֨��z�l
9�̚P6��f�8�r�f�M1�,˚p6�Ve�8�r����qp6��d�< �B�K�f�])�Y���������fW�/�f�]9��X� ή��j,�O���*���B��<y@v���b�(�RNK�f�]9��X3̇b~Y�5+�y�h�룉r�灾��Z������v��r�D�̓w��tk44�6�7n*
��7n���_�q�r�rk%əF�Bᣅ g��
�p퍙�6fƝ�O�M!�}o��)מ���ӥ��O�M9�}o3̦�_���
8�rN��f�M9�}oޟ0�ڛc}m���'Ȧ��� eS�i��,��+��mƁ��˾�Q��k~�k����� ή�þ7��
�w�ʾ6(�?�=y@v�����(�RN��f�]9�}o3̮�_���
8�rN��f����yV��k�|醢?�c������ 7���qȗq(���0���!_¡�r��k�|�^�An�~m��C�������n�~���v�Gݐ�_[O�KO?�Ѹ��h#�������ȗ�(��0�>#_>�A��`�i�_�Q�a��F��Fa���`{O��=��PG�M!�5X�ʦ���Y gS�a֌�)�X�Φ����Y gW�a��?�
�)�6�2D���`[��K�?�� eW�i��,��+��jƁ���ʫYgW�i��,��+����gW�q����+��j6@�P�i��(`�Q�QA��)�6D�2D�(����rh%��F�@�j!82���7��e8#ߐ?5���Ɖƥ�d��[�8�7����FE9oK�-QQ��I�vD�rD��gS�q�2�l
9Tf�M)���,��)�0P�q`6���o��
8�r����(��)�0P�O���)�8P�y@v��*��9ؖD��D%��S gW�a�2����e�2+���9Tf�]9���Qz�]9ǁ���+�<P�Pv��*� ή��@eƁ�P�/�Q�l[��k��ʧ����#ʗ#*(���#������O��lT4�6��?����3~"~j<���r�ri%���p�pk!�c^�YS�����"!7��xȗx(���(�RN[�f�M9�v3̦�_6��
8�rN��f�M9��uGV�l{�|y��H���)伹n6@ٔr��6�l�9lwqL��wȗw�E$�T�ٕs��6���9�u;���`�;��;EBO�]!�n�ʮ��F�Y gW�a�ی�+�mn�ή��.�Y gW�a��џ0��!_ޡ(z�|(����̆R��!_�$z

��p��xE�����?*���t��B�B8����`�;��;EBO�F��|>�G�ƭ�t�?� l��|���H�S����z	=1p6�|�� Φ�����z�M9G����)��{�P6��|�� Φ���uƁ���uV�ٔs�&a�<��<DBm�/�P	�c��C��CY$�9�V�R%��;a�<��<DBm�/�ЋH�s���{(���1	��!_� r�l{�|y��H�C�-�%�"!w���zȗz(���1��!_��r�)�x�|y�^<B�:���C�#䮳01�2�����;��;=B�:�/�P���0L�C��C�#��01�2�����;��;��r�y������!w��yȗy(x��<���}B� ��y?ì���w�+4 n v�<�����7O;�f��Þ��=��q��(T�6����f���Ρ� q�wh���e��쀸�x�?4 � w=��i�( ���.�Qo／h4@�A<�$����o[}F�ϛ}F�?�G��+��/�P�=������	��P9PIׄ�8Ѩh�k��_�7�_�	�s�s���	��A�B#\�'
�Y�Ȑ|ɐ���)
�5aT���ɗ)ɍ������3��/+�g���R�� q񰖽�����b�Y n}V���;-g����z��p�����iE�l���xX�^�����qM�, �w^�>+����V���;��e�3��/��g�����ѸA�A<�l��1�q�}�� }V����ȗ�(	��FE��³�o�ȿ�F�D����g�q���³���s4�E��S��p���g���4q�r%���04>h	��+�A�/Aыp�逸�x������L��7���Y n�<���6�NÙ� q�0��y 7 ���Q@�@<�gf��À�Yσ��x���p;p�ͬ���w����;��!����˔fv@�A<�if��Ü�yσ��xԌ��w���
x;x�Q�l���aV3� ~ ��?�3;��=�O��H_ʒ�$g��~Zp-�E�=!h>������%ѽ�A�i#��~�}���O͇�=mH_��"{��5��C��Gi9d�W��/e_�L�O�
�m1do��)ݼ��Aהn�' ztM��ǁ���? ��5e���=��t��������7@הn���<��k kO��+ݸrā�m^9
`��6-�y�u��?�4��}Y��t]�Տ#��t�t��AוnR��8к�}����6��zt�{��{����%d�J��q���Hꮞ��?4�3����U��L��VoOg�(
��>���y��#} }k:��Q��h#��#�t���,%�&OtM�Ɖ���)�<��5e���#��t�,��O�5��2��5����#��t���i�5�g�#��h�~�֕m���<�����\W�/��� ]W�i�>��J7�ݟG��]W�q�>�@�6��Gl]٦��ȃ�+�0oi�u��2m��.e)\���N�]�a�h*�.��ǭ�##_5���������U��©��Ut��K�/[EG�Q�������Ga�h�翕򶸔��%*M��M�lP6�����8�r�[EG�M1�mp6圷����M9���]�q|�ٔs�*:�l
9o�P6�����8�r[Eg�]1�l�pv圶��8�r[E������+�Ut��r�*����+�Ut�ٕs�*:����e�謀�+�Ut��P�a�h�ut��ƕs�*:�
yK\ʒ��(M��D��t��¡�p�����ӿW��Ҵ�N�Q0N-�ӿ��#~i<��# k>���Q��h#������ť,�KT�TL��å,�˛Ҥb��=.ey\�Ҥb��E.e�\�Ҥb��-.�kq�J��a֖��%qyQ�T��ǥ,�KV�T���ť,�KT�T��å,�˛Ҥb��=.ey\�Ҥb��E.e�\�Ҥb��-.�kq�J���֖��%qyQ�T̵�ǥ,�KV�TL��ť,�KT�T̵�å,�˛Ҥb��=.ey\�Ҥb��E.e�\�Ҥb��-.�kq�J���֖��%qyQ�T���ǥ,�KV�T��ť,�KT�T���å,�˛Ҥbµ=.ey\�ҤbȵE.e�\�Ҥbµ-.�kq�J��	ז��%qyQ�TL��ǥ,�KV�T̹�ť,�KT�TL��å,�˛Ҥbе=.ey\�ҤbֵE.e�\�Ҥbе-.�kq�J��Aז��%qyQ�T��ǥ,�KV�T���ť,�KT�T��å,�˛Ҥb޵=.ey\�Ҥb�E.e�\�Ҥb޵-.�kq�J��yז��%qyQ�T̼�ǥ,�KV�TL��ť,�KT�T̼�å,�˛Ҥb�=.ey\�Ҥb�E.e�\�Ҥb�-.�kq�J���ז��%qyQ�T���ǥ,�KV�T��ť,�KT�T���å,�˛Ҥb��=.ey\�Ҥb �E.e�\�Ҥb��-.�kq�J���ז��%qy '	  Q�TL��ǥ,�KV�T���ť,�KT�TL��å,�˛Ҥb�=.ey\�Ҥb�E.e�\�Ҥb�-.�kq�J��!ؖ��%qyQ�T���ǥ,�KV�T¶ť,�KT�TL��å,�˛Ҥb�=.ey\�Ҥb�E.e�\�Ҥb
�-.�kq�J��!ؖ��%qyQ�T���ǥ,�KV�T¶ť,�KT�TL��å,�˛Ҥb�=.ey\�Ҥb�E.e�\�Ҥb
�-.�kq�J��!ؖ��%qyQ�T���ǥ,�KV�T¶ť,�KT�TL��å,�˛Ҥb�=.ey\�Ҥb�E.e�\�Ҥb
�-.�kq�J��!ؖ��%qyQ�T���ǥ,�KV�T¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ҥa�=.ey\�Ҥa�E.e�\�Ҥa
�-.�kq�J��!ؖ��%qyQ�4���ǥ,�KV�4¶ť,�KT�4L��å,�˛Ѥa�=.ey\�Фa�E.e�\�Ϥa
�-.�kq�:��!ؖ��%qy��4���ǥ,�K��4���ť,�K��4���å,�˛ͤ�(L<.ey\�ͤ�4LD.e�\�ͤ�(L,.�kq�6���0���%qy��4��ǥ,�K��4��ť,�K��4��å,�˛ͤ}@�@<��|gq�۳:���q��, ����꬀��w��9 n v{�<������7O�=g���n�n�8�;��ݞ� ��y��x;x�ݞ���a������n��q��s6@�A<��솎�@�A<����v�λ=g���n�� ���nϙ��_v{������R��%�LN���ȥ,�K���:&�K�Z\����1�H\ʒ���LN��ǥ,�K���:,�KY�h39uT&��.o6�S�e�q)��m&��D�R��%�LN���ť|-.�fr�m����
xx�����a)�����\F���b�� q񰚽:����r�Y n}V���;-h�w+�G���˒��q�}6@�A<,j����x\�>�������
x;x�u����aa��������q�}6@� 񰶽:N��ť|-.�fr�M$.eI\^l&�����R��%�LN��ť,�K���:F�KY�7�ɩ�4��q�6�S�i"r)K�m&�N���R��h39u�&��$./6�S�i�q)��m&�	��a03� n �2��7O��� q�0�醎�q�8���6��әYo�4��7�p��쀸�x�Ќ���aDӝ���qF3�����4���iJ3 � �43��/s��q�4��w��֟5.w���Y ���fTn�>�;���O��5��ܬ���Aek�\�Mh����[��`��K�_y��S�ߑ��C����mkwڳnW�_i/����..A���"�߅`����r�O��'���?��F��4��"m-��kG�ߪ�g\�3�?�4ކ�pk�������<]�z��?����h>�|��?�����(�      v   <   x�34�0�0����4202�,�2�4�@3�L�2264�����9�����1z\\\ ȥ�      y   9   x�3274�4270&��&�1~@����� &nj�"Woj�,nb7G���qqq uL         �   x�e��
!F��0���i7�� '�Y
m�e��C��e�'��(/^p"����.8i8iخ?�aߟ��Z���S�aٽ,ľ��å����� ���D�ɣ�ՈU�ͣȃ���<�����(������LS���:g��1�k�5�ڤѨ���S�=qjB�U�i�9�_P�      p   D   x�34�4�4�24�4�4�0�0�.L������/6\�wa��@�����̿0Q�+F��� C+!      q   �   x�UOKj1]�w�`�[�DN(i>�.Jr��@r��z�(���W�oTy&�2=�G�A����zѫ����s=Bȓ��BY9R ��C�45�ٌ2{�dЈ�@�0ʯ�����f$F�hĆ����I�S��s�K��E1���׏e%��^B�8�J잷O{(�����hWJ��o�u�|[&�r����2�V����l�9�� �Tu%      t   �   x���Q
�0�g�K��i��N��`�g��֒meH@ȇ?
Y2�L�$t�RQ$�$8ZeH	���v����o��� ����:
�B6��%̎�C�K��������DP3A!�l�����j��
g���B׉��`�A�      u   r   x�340�0���{/��paÅ�{.��}a�-`��v]l���bgqj^f~gJfQjrI~���	H�n��M=��u컰l� �q��/�,5'� 75��+F��� � Dd      �     x�]�ˑ� г�����6�Z5�3p�2� 7�J�ĵ9�t�nArW�����C��7�US��"j҂���4���`���=f@�����ɂb4}�IF	(����
1�����D�����qu^6t��qm��;�o�BӜ��j�]Sl�]���3H���<mL�`yL�+yÉ����*_!���(܏�՗�3�'t�h[�o�"X�b`�����?��K����]=a�6o�}W�>��G��??�q�O�      z   �   x�u�ۑ� ��g\�6�Αĭ�T���X�Ɖ�lfxa�F����X�J<�=?��X�@SN�sc��-��h����Ι��5vk���n��iY�U	���^���ӆ
j[��ޖ��.�um �������7���g1���},�D�����^{�v44�u�_z?Y�*��?V_/��(_��L��˶m�ھ^�      r   :   x�37�4��,�K�M�v�s��u���27
�T�rf�p�[ ya�9��\1z\\\ po�      |   �   x����
�0���a$I�!s�A#�n>L��Apq�R���;ܽ������w|�4���Wx�O�w6�C㪣�+&8��Èx�c�&��x��l�8[�-ђ+-D�oT���{�y�[  ��B.�Ӣ��2�ef���� �D2 i̬��П����f�i��V�����      s   h   x�=���0C�a%-�e	'p�9$�8$�'�
Y&�)�h�pi;ʉ�h���A�Z��?{[-'#��P����)$�:cPS��Y�*�Ћ4qP3��;(/�6U�� �      {   �   x�}��
�0���S��vssG�q�� �a�/z�śϰ���gH��t�!��������Ly�0I1h��J���J���q�$1
�����C�y��bO�ђ�EW:�N���$M"��?3_X��2;����8�E�����9��0�O��q����z��fX��(z__�q�q��r�u~#��}��8���      n   �  x�u��s�0�3�^�IHH�-T�*�Bm��/� E��"��������;����<b�-��G(��͆4��;�k<��E{������i�m5]�ޱ�����SX�C�K~5m�q�:�F�&)b�V�N��1W	�Ý�_��ä�|�1���;ֿC�U�cWe��-�iT�I���ZN�W��s����%7���HN���2A,�"N嚤Tڶ&�A�onf�rѬ��S�9������5��eQ����F͟N���YP{VI�C�4b���",FK��1�4�B��R����nAFmԌ׶+Ʒ���>�ۅ����A�u7���4�FCAɍ͂���,�1A�T1%�J:H˄;�D
��]�� �V�GR�_|���n��]x�~�����yv�A��?��y�I��ֳ�>40߆�i��Y�8      o   $   x�3�v�2�Q�.��~\�����P1z\\\ ��
      x   �   x���I
�0E��]R$Y���'�:'���Nq�����Ǽ�&Nư� #Ӏ6���p������k�dq�E�c��^�M�_my��O�����K�M��4�Z�e��j��hUTjj<E~O�����w�����7�����B���      ~   �   x�327��44�4274�4�01����44�20 "�B ��qus�wu��2275�(72 )7+7�*7153AWnU�d�T��v 쾰��d2�(&�8%�8�HIIA7�b�	���4h
5Ei� Ã<     