PGDMP                     
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
   TABLE DATA                 public          postgres    false    202   kU       m          0    16407    message 
   TABLE DATA                 public          postgres    false    204   /Z       }          0    33104 
   t_bid_rule 
   TABLE DATA                 public          postgres    false    223   �Z       w          0    32970 
   t_calendar 
   TABLE DATA                 public          postgres    false    217   �[       v          0    32965    t_calendar_enterprise 
   TABLE DATA                 public          postgres    false    216   /�       y          0    33078    t_deal_object 
   TABLE DATA                 public          postgres    false    219   ߉                 0    33315    t_deal_object_attr 
   TABLE DATA                 public          postgres    false    225   ��       p          0    16473    t_enterprise 
   TABLE DATA                 public          postgres    false    207   ��       q          0    16481    t_institution 
   TABLE DATA                 public          postgres    false    208   B�       t          0    32926 
   t_position 
   TABLE DATA                 public          postgres    false    214   ��       u          0    32931    t_post 
   TABLE DATA                 public          postgres    false    215   �       �          0    33335    t_presence_work 
   TABLE DATA                 public          postgres    false    226   ��       z          0    33083 
   t_protocol 
   TABLE DATA                 public          postgres    false    220   ��       r          0    16505 
   t_settings 
   TABLE DATA                 public          postgres    false    209   Ȓ       |          0    33096    t_state 
   TABLE DATA                 public          postgres    false    222   Z�       s          0    24726    t_subdivision 
   TABLE DATA                 public          postgres    false    213   z�       {          0    33088    t_transition 
   TABLE DATA                 public          postgres    false    221   w�       n          0    16415    t_user 
   TABLE DATA                 public          postgres    false    205   і       o          0    16423    t_user_role 
   TABLE DATA                 public          postgres    false    206   �       x          0    33004    t_work_schedule 
   TABLE DATA                 public          postgres    false    218   U�       ~          0    33310    t_work_schedule_correct 
   TABLE DATA                 public          postgres    false    224   ��       �           0    0    hibernate_sequence    SEQUENCE SET     C   SELECT pg_catalog.setval('public.hibernate_sequence', 2777, true);
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
       public          postgres    false    205    3012    206            k   �  x�՘Mo�F����9$bf��=�����q+7=4�Ƭ%�%�����]���R��[�!	ͣyg��ۻ��o������e��������5m�r��OU���k��Z�]�\�E�d��Y��lڪ^Ϣ�l�z�����EۅYďȟ��j��~|=���)�)�=����{��e�~��\|��f}�Yt����v]u����������ԯ�חq�������і�/u�}m��_I@81���	�X;G 9��fS~���v
D�'䳺(�(+V���)��ڳ�;�dQj�8�h-�':-6��>�r��Ey�����)�4w|P
�H����д�HNH�*�!{\��\d����1ҒQR�w@����+FL�dX���guST]H��Pu�C@*M�.���('@�7a	� Ɩ=+�X�O{�wtU/7��	V:�.��	��)V�K@'��P��
˫��mQv]����2{��ᾠ�(˳�	y���LB*&	`)�vZ�����J��jY�e�A����_�ӳ�(!O6t��H����rZ�Éy?�ݎ�b�XTߪ�H�.�:��т��a�����&�%�r{ܒ�X}���P��u[7,�����C� ڎW��]pWO$Ť�/Ca'֭0�യ�e�.�f���v��;D�p�2�9��0�B�����'��g����Q4�5GxР�<�ĸ{�s�~ȡb��B�b�� ��`�����?���%��>�����T��q��|,3L$1�r�v�|���`�/��,��C:�����j�$��F��=��,Y���RSk���ǽ��/0 �n^�5�3mƍ��S��6�*�TP���QK�n�2���PY�KzX%��A��w��<,I��XH'���`b�|{�೯�l���/&p�u��6{�Ѥ�VF[{��g�2����OH��KD�F��Bۓ0�[���}32$�3~pČx�2�a���n}v��шKt��4���YCg���C����D̳~۱�VH!��}Swu^/���E��v�x�+KZ�{�"��& bvMʅc��{���m���"�D�����~el����HN�Q8��7K��K�ˇ} ��DD��M)�Աd_�C	M�w6a���� �%��	��pM��C$0�1	n��+O��Q�.����{N�\祧2��=�>�()���ʎ*�+tS�)���=���nE      m   b   x���v
Q���W((M��L��M-.NLOU��L�QH��I��K�M�Q(IL�%:
�ũE�)�
a�>���
�F:
~�>>:
��P�LӚ�� ��      }   �   x���v
Q���W((M��L�+�O�L�/*�IU��L�Q�K�M�Q ��T Y�y%�EE�ũ� ���̲TM�0G�P�`#3KC��.6]�|���nu /���5���ȶ0�QHK�)Nմ���0��_l��xa��0Gg�O?��%E�4��� ���v�C�bÅ�^��qa+�>��a��A>��
ss\nQ0��h�pq ő�(      w      x�͝M�5�y\�����ƍ���WD��i�0"-xEH� ,�M�пw�{���:�q�A�;C.�Lwթ'+3�W���_����~���~�ݿ��?��?����������?�����_��~�ݷ��������?����������������}�����_�?>�����������?��?��ǟ}������O����������w�����J��컷��Ͼ�ͺ���'�컿���������W��������������o�۷?����_�� a� �x ��7� � p��?��J�ە@��#h� ���[�	�����=�:�o����S��������oo��qo7\�����۷�wg|\�����������ߴ  z�����~(�������_u���{Ļg��K�{��ߑE�uz�\J�þ�}���-�^C���ݳ@p��^��ْ�5��sz�lI��w��ݳ� ���P�{����}��G~���x-8 �`�^ -�O�ߐ>_%��`A�Z�_/`߅�9����V�+X����@[v, HO�-�q��3���Oğ?B����k\�Ώ-��ђ��Ư�s����st�_�/�_�	f���B  8��OK���g��G���=�ϒ������[�/�??>�� � X ���%���+��痖�;�oH���;��R��,\�/�u+A�%,\����`����'8u��6H̐������k���/a�:�&?. �x���I�� 3,�|	3�p Df�,15�a1�b/������� p���DKޣ��1r���|��|3���䇄$�|3���\-����`y�g7�� �|+GM���x�nA؀� !>J� � X0�͡�ש����W5�O�ߑ?��h!8n 8@�6t�  ' �cj�_5��ߧ~���>�<�8η �Â����W�8԰V�[��a���� XL���0�$��p�zbS���Ux+�?���������1�'v��u/_^�tb`����[__�ur`���UQx��	� ��׭����R�S\�����NV����[nZ^x�x�!��?��N+�oXj��3W5��@x]�0���XeVY���t<_l���]��}Mɞ��-��7f���'P��*�C��k���z��ju	��;t��P�9Tr{�C���@�c���Eaߢ�J]ɾ�/,oxay��n��87`�H�&Jn����#tزR������ T�o\�7\��7��#����v���O��^p(�h����>��_,�,���}-X_7�ןw���oK|L_���^X0]~hA���s��]�- Xb7�؟��&�Q��7��f��E�B���q}�6��_- ���zZ? ���N�˸a���t� �  sw<E郞Y�?�K�%܅Z��ȿ"��B-6l�.�p`�>*��������?�M�A@8�p��h �b�*~���A�!�%*�p�w@N~% h!Y���}-�	ܱ������y>��R��Gk �4g<�=��/�њ�x�3�䜫�k�,g<�9U� @ņ��g��5��Zx�	7��P��h�"~N��k��с��H]�5 ���FǼ���vT�<�����۷L_5ܒE~#��@VC��`�`��h�� ��&��@���0P�paBZ P���ؽ �a��܎J�GG�����@ 4 h@ah�Ћa�4�8� `w٣(���a��֎=Ə�����- ����a��;6�+%�G	�~5 x�0&<����	�A�/�,S��݀�!~Z� �BƳ��[�ܱ�`G�֣j�?t��8`�m�5�g�Ǿ���`ϥ$5 + ��Q�����ϥ$5; �R�� + �u]���Z�m�����%?���&.�c)I�@p� u�0 N �KIj�_5��6�9��R�xX�p,%����R���@��.x8���䇄	�3�5��`�X�R �*-�Ѭ���t��kUj�a����L <,x8��q�6-4k=�m}���1Z�6$��������t'7� x��p8�T64���R<lx8^���?ץ�~o�d���٫����!�|��� 6,�^� ��~.K��vK|hx@�#�A�z��/�Ƿ�o��n� l 0 ���(�h��f�w_6�.����n�*�~�b_����ϫ�O�����a�>��
�t�����Qᨀ�&� \��ի�&і����vî�[�zK�f�o���F��ٲ�	��݉{�Kvt�;⸿��7,D���<�A��]Cp�`AZ�.8�~q�__ ��5��;���� BZ�� 80_�G4w�����k�c|�GŅ�̏����] �|!�&>4,hXy!�<������C��Bt�p���<��ݒ$���B V\�n��;,D�ć���Bt<lxةì 6<�y���X�8P�sv�0��	v�0k!@w�aXةì 6<�y�YM|h�аs�Y<lxةì �𘿐k������B�&�U��}��������D[vq�o8 0 ����'�/��b�/A@}�y_� �q�@ � ���Snʳ���%~�[��?�?��-N�q�������@a�o�֋q�<�8η �Â����SnʳN��J�|I~lM9	+��-��`a�q� <�0ηć���8߂ V�[ �a���|�)��e��a�q�%?$lHرF�� 6,�C� 6<��і����ihعF�6<�T#Z �|����d|�~�4<�ЂZ�6$�\S��D[`����Zp�n����o���K����ߑ�̟�\k02�*��	�����Jǵ�-�����NZ  l�ҭ��@؉�>RC0@p�`�u������{i�zex��̠T�\C #�F����Rrl`��E#+tJ� @Ǣ�����{i|,�X���`��E#k^�]�B��܌]� #�FV�Ʈ!��E#kލ����ad��﻿��K[ �cSǎ��5��c�z��4����5�!dS���50�id����F6��yE�Rr����M#;td� @Ǧ�K�k�c��N-�50�i����{iK~yP�#�d�0�ȃF�Y���jd=V��A��U���Ғ��~��e��i�/����lx1��00�d��Y���a<+�~m�{�2�Z �wR=VK?(�g-����R�� 7S�f�0���?�0�����%��k!C�Z��a<��~�`d��J�Y t,�Xy<�@8\�7^ɷ�o>���_��������T�d���ƫ��m�F��Fⳑ����t��t$>)��-��pd>�Ũ��#���qTn!�ӑ�t�y�ұO���j�S�<[ �G#��ȱͳ60m�T�YC��#����>Ϛ�x82��=k`d��N��50�id�+=�����`�A#���YpձC�? ���� ���j@jN�{@Z�_ˬ��/̟�@j���	��� �H0�Y:���>���;�.�� bH�
������jd?�����&?�,
�EH�,9���Ȣ�C#�ڱe�0�h�T	R �:Ν 5���X
RC #�F� 5�!dQ�/jAj`d�ȱ�� F6��A֎-�瀑M#�f� ���q��A��M�n��F6��Aj�CȦ�_���0�Ȧ�c=H�l9�[��F6��
Bj �cSǹ!�>�q��!���<P��u�A��$�e����n뎝]���D��a�i���\�X>�/���!��wf>�ܟ�/��+'���_��ȟ^ה ��3C��Y� })(�i3��q�c=o 8@p$�����/��<i��K3K��_�q�v0�``IQ����j�����>t�*y|u��Ў�`�w&p,�r�    �`�
���U��|�����շľ�?	m>�w<P�����Bz�T   �_8��=jK?�_�>�nj�?E����`�����%���;��_4��ߐ�@�����`�	����%�q�����)�毘Z����_�L%�7�Wp��� �Wp��˥����`_�_-���|�*�Xj!�}�*�Vj��
�U(�/I�
�U�/��
��| �k�ױq�$?�k�סo�#��������װ�c�|I~�װ�C�|Iz�װoZ�j���͋�- p��^ǎ�����a_�������Rޥ��a��W�;������'/�l����c<���~zڡ� �?�?#����������hފr�ǟ�i��F��~���B|#~ޙ[`  �}�%��/�v喤_�~E�{rKVl �;rK�oȿ#�|�c'�y�H }X:i� ���q�����a�� JK'%�O�W���K'-�!_A��K'-��`_�������`_͗N:���}�*,��ćz�*.�� ���{��NZ�þ�}5_:iI�
�U��[`_þN�{E~�n��a_�'���?���9=��P���5���I� ��p���Z�þ�}=�_Kz�א���Z`_þN�zh�����K��~~�����~7�G\�l�"�?�{� �����ْ_ȿ �|ݳ%��~E����B0@�� �{��_�G����*���������5�7�?�?�|�\�;�7��q� �>k�����_,~� W?k  aA�a�S�.�!N�5��`��y�� ,W@k �a��a	�&>4,h��h<lx8.�� �Æ��*�*�^��������ڒ@��:h,lX8.�� �Æ��JhM|h������x��p\�����PU�x�v($��	Hxď����雷5 W/���`�R�U�!���8߂   �q�� X ���� oy⯈������oȟ���;�8��� @�[��"��q����E�+��8� V�+����E��8ߒ$�<η���� xX��8�4��|<,xXq�o��+������Â��������!a�q�� 6,�8Η ���sɸ*�zm�~�D��D[�a���e��M� 6<�\V/�L�[|x���sY}rm�	~��Oo�-��a��o�Ln�- ����zi;�[|hx@���ӛh����}Uz�@X�5sOn�% �'[o��7ђC�&[�kҗ�#�D[���_�M��`�`��n�-  6 l�hK��w���M�a��#�D[ v � 8�7ђ�h�Z�kҟ�+}��%?$,H��$�۲�Z�>�������M� <�\��zm�~�I�o�-�������M� <��W�\rV EY������_n�5�!aA��%���T����W�'_	h��{^vZ64�����e�����RU ��+U:{�v�LUM~Hؐ��w�j`a��N����{�����а�a�OU� �Æ��+�'7� xx��#|��� j��������Bm�v_S�>�o�k�ӛh�@`�q��  ���5��/�����+�8_�`@�;�
�Y�}Y�?��-�w�?�?��-N�q��������@a�/���Mа^��-��a�q� <�0�w�J�6��J�|K~HX���8�B V�[ �a��
�|K|hXа^��-��a�q� 6<�0�w�Z�6��N�|K~Hؐ��ק[`a���n��;|�%>4lh�/>@݂ v�u <lx��>Qw�Z�6��}�5�!aC}�5����G�m@��~_��? �T@R_�o��$5� B* � X 0/ q�Y�Ek�/�^����+�o�Hj6� H$5 ;  �Hj��"~. �A�zx�/�~F�$- h���w�Z�v�é��&?$,H8����cI <,x8��ć��( �A���� xX�p( q�Y�Ek<�
Hj�C�sIz�v�±�� 6<
Hj�CÆ�_�� �Æ�cI <lx8����B��nx8��䇄	��Xذp, �����������_�� �Gk��H$5 W�e���x_V�z�8+ �h�e�K�0����?�?��5�q�`�
��8_C���8_��aB�k   ���� Z�����%~�[�D븯�ί8������� xX���|M|hXа�8_� V�k �a��
�|�Y�h��������� a�q�� ,�8η �Â�����h�:��8߂ v�[ �a�Þ�����h�:;��䇄	;�������Dk �a�Þ���ć�;��� �Æ���Dk �a�Þ�����h�:<<B�hM~Hx@�#��\-|�����}Q}vm 0 �8�A���/����8��`@�K�
�E�/�_�q�%���;��q�����8�w EZ�}Y�����W��U����b�oA��+��- ��a�q�㬀Ѣu
V�[�C����XX���8� V�[�CÂ��b�oA��+��% h�:+��g�����8ߒ6$�<η����Dk �a�Þ���ć�;��� �Æ���Dk �a�Þ�����F��ixءO�&?$lHرO�� =Z�aa�>� xx��c�'Z��a����[~ݾ}+szma`0R�h��A�y���q\��"����N�� +b�h����U��� �N�y�hM���Ͻ�-�>�7���X��@W�ǜ��@�fѥ�Ԁ�,Y�Z� :u��-Z� �>V*�!��E#k�.Z�B��\/Z� #�FV��!��E#k^0�t���E#+4�� ,б�cŊ�����S�h�l��њ��)d���4�S�h�l��ѥ���4�C�h tl�رi�>6}�T5ZC #�F��k�%�
!�Bv.�a���<R�h�<h�1�'Y:��Z���)��_߶���� , 0�߂�a!��-��%���+��[0ld�3~�	��a��8Q�kז�_���O3~� p ��-W?�R�Aq�o!��E#+��-�!dQ�z1�0�Ȣ�g�Y4�_r�`��E#+��- б�c��>}�8��0�hd��%?�,
Y/f��4���B #�Fv��K��0�id�� ��Աci|l�ة��� F6��yiM~��si�l٩������M#{^E��38`d��]�5 ��G,#�A���y���%5L�yIM������R�I����
������Kϳ����ä��N�Xb҂p����<�!���'	�5&5��B~����E�I�,9���Ȣ�C��Zr����E#�*� �X�q�2�A��E�2�Y4rh3��!�B~QgR�0n0�h��gRC #�F�&k�Y�q��M#�F� ���q�4�A��M�N��4r(5��!�B~�jR� #�F��&50�i��k�v�57�4r*6itl�87�� �Ǧ�c�I�<h��mR�B���&5o�η�\��s�������>�Jn��a�` �'���;��?O��?�~A��4�Bp�`Az�(�c.�7�?I��~�3�%����9�%��@���0 p =C��_���u��k�ђ�����B �
�UjFk��
�ռ���0�+�W��%>�+�W��`���{��Z�þ�}5�CkI�
�UnCk!�}�*u���}�:4����}�:��.���u>!] ��u<]��5��p:�$=�k��/�Fw,��a_Ǔ�%�a_þ����8�8�װ�é��P��^�3�- p�{G:ݒ���nI��c��?�۫>_�/!�A`�ɽ%�����{��ñ�H� }��K�7�_?N�- ��4���7���?��[��?�>O�-N �  �ɽ%�վ������c�}����P����_� �
���-�a_�����$��
�}�\�B �
����-�a_��������`_�����%>�+�77�� ���{c_yK~�װoh+oI��}�U�B ���M�-�a_þ����H��a_þ���%>�k�7w�� ���{cCyK~�װo�'oI��}�N�Bp���X�� �Vn��=[�o�o䟟hV�)�}G����@sM����kN� HǙ[ � 6 �O3���3� �Y��� ��*��\-�8��9��I��p��`�CG-��`a�SG- ��a�cG-�aA�zq�<�x����k~�H%[�OxX��ѣ���� aųG5��`a��G5 ��a�O�ć�;ob�A��;�b���{��I%' Nx���>�����!aǍL%�6,촓� 6<��V���а�a�L5��a��L5 �����|7�:,7xx��#lg�����^>�/�:DZvq�o8 0 ����'�/��b�/A�+�8�  l �|�y�EF���8ߒ ���y�o!X@p� ��- W?.�� �L�&>4,h�E�H<,x8։� �Â�C��:�,(�z\җ�i�/ɏ2��}ɟ��XX�p�����N���а���"5����*R �"�8���qI_�q�%?$lH8����c�H <lx8T���G/�ゾ��'�j�a�ñ\� 6<�E�qH`A5�㒾���j�C�s�H,<`�X0Rp��z_�^? ��e�7і�;���A���R�	� �J�8+��!k��I_⇳J5������J5��tZ�` � ���RM��O���j�^�ҟ�?$9��� �Â����_�;�
,(�Z�o��r��	~.IO;�[`a���ғ�� �e������_[�[�CÂ���:�5�-����/HNz�[ �a���u�7ю���V���[���D[�C��K�ӛh,lX�}Uzrm��?����D[�CÆ��[;�7�x�����#'7� 4g������_o�g�f���߷z���䇄	?���7�Xذ�����&� ~.K���ć�4�\���D[����?Rp��v_V�> ��e��7ђ�h������i�o�"�@�<Η�Ak�/�_�8�  � �|K|#���/����q�oX p  ��%gP��ݗ�/��8ߒ�*�����9��8�B V�[ �a��
�|K|hXа^��%���+��- ��a�q�� Z�6��J�|K~HX���8�B V�[ �a��
�|K|h�а_��-��a�q� 6<�y��K�
�Ek3<��'ڒ%Z�!a�>�Xذ�S�h <lx��>њ�а�a�>�x��S�h <lx��>Q��@��6���Dk�_%�ߗ��������A* �80 0/ )���Ek��I_���aB* �0 6 �H�qV`E��~_���$5��?�?��� 8A�
Hj ����ҟBIM|hX����xX�p, ����w�XѢ�N$5�!aA¹��� ,Hj �a�á��&>4,h�EI<,x8�� �Æ�C��8+��Ek7<�
Hj�C�sI,lX8�� �Hk7<
Hj�CÆ�_�� �Æ�cI <lx8����+Z�v�é��&?$lH8�����$5 ����Ǽ��&�U��}����|�R��&ڂp�@H�| ����"�`>Ώ��+Z����%~�k��W��|� ��4�� , �0�k⯈ ~�k6 �@H�|����}��3��8�qV`E��!xXi�o�	V�KУuV�[ �a��
�|K|hXа^��-��a�q� <�0�w�XѢuV�[�C����Xذ��8� v�[�CÆ���D[Уuv����{�'::�
�h�:;��䇄	;�������Dk �a�Þ���ć�;��� ���O� ������+Z�������|_V��DK�D뼯�_��q��@  ��|��  ��-�⯈�b�oAX��!��- + v �q�� Z�����%~�[���"�[�>��	�� xX��8_-Z��a��[�a�Ê�| <,xXa�/9+��S��8ߒ$�<η���� xX��8�4��|<lx�q�o��;��%gТuv���	v��!��;��� �Æ�=���v��A��;��� �Æ�=�]J�
�E�4<��'Z����}�5�v_����Oݾ-K���\���L�y�hM~!�`�\)Z�`0,dH��5+	楢KɁ�k��[���C�h�
�� �V�a�A��+ZC���$��X�&�q��~ɯ�,Z� #�FV�-!�n0�hdͻE��s�F��P.Z �:Vl�A��E+Ջ��Ȣ�5���!�BV.�a��E#+5���Ȣ�5�]:�l7�4�C�h tl�رd�A��c����4��5�5�!dS��=�50�id����4��M�K�)�M0�id��� ��Աc�h|l�ةl�� F4򘷍�䇐�<r?IõfKz���A�:V&����$3~�a��Z���0��[  ��a�J�8�� �Hf�������b�oa��p�!��-N���L�vmے���+��% :u�<� �Ǣ�g�Y4�ߒB��3~�,Yq�o!��E#+��G�#�FV��[ �cQ��3~|,�Xq�o!��M#;��%���_��-0�id���4��-�K�	�m��M#;Ԑ� @Ǧ�{Hk�c��NE�50�idϛHk�CȦ���Hk`d��N]�50�Ǽ�t�8h�]+��(�F�G~��� ���%5� B*0�! XH0o0�ɿ ����¤�a�F��aRC��`'���d�8k�]�����ZLj  ��5&5W��f�!���l0�h�PdR�B���ɤ�F��Lj`d�ȡ�d-9k��Ȣ�S�I t,�8��� �Ǣ�c�I�,9���䇐E!�(4�a��M#�F��F6�*M֒�;�l9u�� @Ǧ�s�I|l�8����Ȧ�C�IM~��^��4r,6�!��M#�f����#�FN�&5 ��s�I��x�n�=f|=��n�ou���'�}���cݗ[�*��Xd��??�!�  �;)jvl � -���
x̖���?��Mڗ��������	W��~_l����L�9~�v��귟������@\`i��7�|&���&����پ��3��3H+D-?�������QI�����O��>� ~����ag���/�?x֗�      v   �   x����
�@��Oqw*\B'���!�DA��2�d�q|��"�ݝ��Yɋ
DV�0LM�ڝ�[ٓI[2�Q#��:���w�~va�e*mdkՓ|�%镗����!��{ϋ���"X3�r�6�c�!�C��v
�����3^$���y�(��      y   �   x���v
Q���W((M��L�+�OIM̉�O�JM.Q��L�QH�L�/*�I�q
��K��s���Ғ��"0�(�� ?�83	�.5� '�2��Ts�	uV�0274�Q0270�&:
�&:
~�>> ��5�'�dd�p���`pR����!9��A\\ �9��         	  x���v
Q���W((M��L�+�OIM̉�O�JM.�O,))R��L�Q@E�TŗT��(�%攦�4�}B]�4���t������������c�:�mhab��i��I/g�#������rE!��pW�x����FVt#C�;�0#Ő��0B8)&�f&tu�1�(�bL�H����)F�g "�b;v_�ta2��U��V��˕��BW7Z�݈et�2pX��aD��1]�a�p"���K�P"�!\\ 5�g      p   �   x���v
Q���W((M��L�+�O�+I-*(�,NU��L�Q�K�M�QH*�LM�Ts�	uV�04�QP7R��\��d4�XLPd��E恠�҅�6\�~a�ņ�.�Q����{a��:���&*�l�� ��]p      q   o  x��SKN�0��ޥ��*v��+]T��D[�Q>5�NH�;\�W@HH	��s#��Mi�Z���#�73�Ѹ>����E0gaWx�炉B���6�tP�4�*e������� fY��4Lx�6"_P/���eb���Ҍ�tU!�%�z�X4S�oS���j\���1hc@h�Y��W�%������brY>U>d"h��@DY�T�"�`�-dV	Y�M���Ikp�@Ł�7��Ѫ�7h��>�ՁS�{Q�~�\�}����Y��|�X��!�mhض��qB�G������w��8��6� ��W�v�����;L�c�4�F�ԭ~/�˻f�׶�ۮ�IVެ3�٫��|�䖃V��z��      t     x�Ք�k�0����fq��9=�Ѓ �vW�5���O�֖1�c
��}���_^�o��[H���ڲV�'[��FYu԰P�N٢o�6Vٶ�hӖ�:+3j�J���Z6�& �V�%�JXY+;�RWK�x�v�,��@�L�;	'@	|�����3�0�I@ѿU�_���Q� |d��i�X'���wY�7␝���l<q������.3ܕ� ������c��D��#u����п�ኃx�4<z@,�wv[� �)=���cL`      u   �   x���v
Q���W((M��L�+�/�/.Q��L�Q�K�M�Q ��sR�Rs��ʂTM�0G�P�`Cc��/l����6\�}���ދ�v*\��za�Ŧ�.6����e��X)�E��%@��5�'U�bq�n�#6A��{a?��.l�l�؈������y% �pq �=uf      �   �  x���Mk�0�"�N#�i��;�`n�J�n�N��}�%���x�s��R~�'Ͽ�ˇ�g4[<?�C�޹�m�:�eSV�r��U����UM�ڮu_�*\o�]Ym���u�r�.�]��7W���bӺ���ۯ��mW�S�z?yX��e����QƘ��J�3�V0�ߊ]�D1JM�&��w�K��Jѻ��'7��0­ȥ[���,���1�0�4QS+�A�,�޶�O�P�D��[d�WK�5����:����*R�Z�Q�D�-�٘�	���FuE}�~6!̻���yv���!`�cR��:.la���~O � ���dcf$r�M	íӂ�C���C�n�6����<le�uZ�����gʰ-aT�NKRE�D[�@����a�Ӛ4�O��%�LFn�0�[uҔã~�9�c�T�@r<�`�R']��h/�`݅�5}IN&�$f�      z   7  x���;o�0�Oq ���H�N��
tE<2E$
���qū)kɊ�����l��~�`�X}@y���^֛�*�b_�0���1�כf{���*����sVg�)T/�
�*=����������}��.a�%��22M0��D�0Q��X�����}�㳏��������C6-�b����7*j�5F����A�cT�3#���J��U;뛑�Ÿ{��V�̍cG�;�G��^�䙾���R$Mb������Q�N�����y�Frde��y�3�w'�������@���������I}      r   �   x���v
Q���W((M��L�+�/N-)��K/V��L�Q(�����y���:
e�9���
a�>���
��:
�:
����~@yu���%����G]Ӛ˓r� 6�T����+�����s@��L�� $R�      |     x���v
Q���W((M��L�+�/.I,IU��L�QH�L�/*�I�q�sS�BE��i:
`E�%�@���ܤ�"M�0G�P�`#3K# i���~a҅M�^��{ձ��v���:�� y��\��r�1�M�.l��paÅ�6\l��tц[��Ƌ��(� ^@���kp0؁��s���Ӂ���p��bӅ�XE�}�!n2���@in`8�"����&�#�<ݢ���A��`7��E%�M"t�^CC���H�!���葋�\\ �      s   �   x�����0��<�ފI�]�x����`��ՀԤ�")���Қ����v/_fv�r�� /[�^�M]��s���V�z����l�RwZ��l�]��fx�Z�+���K7Y5R��N���C�fR��<��NVA�gv�8vh4�n��cG�	0tt��/�w4ع���Q���{ļ��qLv'��$`�?e�c�U���{O��E�Esu#��ټ�����޺����
��      {   J  x�͓?K�@��|���B���18�xB �����&AjZ���������ghEQ:�3�}#/چ��p���߽�/��8�h�t���<�
��<]��`��0/giX'ż��4,p��Bםaݦ��-X���&ŭV�ᒷ��&w���֙XTx�d�![��Y�5��%Y�%}���?�atx�.�w.9�HX-	��x%_L�>���^Ŵ>2�;��"���)�2�G>��b*�I�[| oL`C+��÷�a /zC��uPf6`�޳�&����}8�F�O@�	4x�$��io�����x"�A���{�Tm/ I����$      n     x���Ϗ�0�g�m�P����UEQg/�RZe�������L��&{�ԗ��~�I�;�9�\q�s_��h����,D�<$q[a��T오�W���Q�bϒ][�XQ�Ҽ�y�9��xT�:3���q�ym嘗�n51kB�$A�
��9�9���my����6�,3w�ث�e�p5ʪ��i�i��,�'��㷆{���u�i�86M	��b�i� J�����Q�Z_��~y���}�1B��A��7N�bu�ֻ���%�n��A���t�6��GV\�}r5��g��I	6*�h��AdD1�D�S]����	�n:*&��c�6�3�5�ӭې��:,��[�{��'|^�s[M�xo!�C"ը�hhh��4� B�ƦP��p�[[�-â7�-�W�E��}�٣Co��ά`��7CG���10��a����D��j�@L���D��@R�����]RvCc�=Q�|{�E��Ŋ�cy�w���/�K�߾;�=9A���,g�������eL[      o   _   x���v
Q���W((M��L�+�/-N-�/��IU� 33St@\M�0G�P�`C�P�NuMk.O�0���.��~�aN�3,(7��.. AH|T      x   +  x����O�0 �;Ż�%�BK���<�@B0q�׆�N�ag��/L�هf�H8��~��~8�=.��ZŹLƚ�o�5/�L�U.` SQ��@ U�����(���H^��m,T]��E�X<K��+�d�!خ�T�J2"Z�%\�!<���d��(/�7(�8�oD<�(�έ�<ۘ�bn��Y���'��ce5�=Ɔ����p���:��¦���+����gCg��.*3�7��z�2k_��W��������+u{#%�H�+�?2��|��n�lY3       ~     x�ՑKj�0����avN@ˏ�����p!/�JؖҨ��Ԓ)=A�L�I�U6M]H.`I��?߯8YG����NMV��N�ת~�*?r���U]�\�X0B*-t�E%i�OZeOf��yZp�Һ3Z��f�Q�_}R����ʒK���&��N|��l�5�ݙ�@�}�F�}A�%��ݥ�g�bN�I�"�+��'�V<� _]�C�=��#���,���x��N���n��������,���,��`�^�[5_x} A�<��|�5t     