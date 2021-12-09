--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_account (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    phone_number character varying(50) NOT NULL,
    address text NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superadmin boolean NOT NULL,
    referral_code character varying(50),
    wallet integer
);


ALTER TABLE public.accounts_account OWNER TO postgres;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_account_id_seq OWNER TO postgres;

--
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts_account.id;


--
-- Name: accounts_useraddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_useraddress (
    id bigint NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    street_address character varying(300) NOT NULL,
    apartment character varying(150) NOT NULL,
    town character varying(150) NOT NULL,
    postcode integer NOT NULL,
    phone_number character varying(15) NOT NULL,
    email character varying(50) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.accounts_useraddress OWNER TO postgres;

--
-- Name: accounts_useraddress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_useraddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_useraddress_id_seq OWNER TO postgres;

--
-- Name: accounts_useraddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_useraddress_id_seq OWNED BY public.accounts_useraddress.id;


--
-- Name: adminBluemoon_offer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."adminBluemoon_offer" (
    id bigint NOT NULL,
    offer_name character varying(150) NOT NULL,
    percentage double precision NOT NULL,
    expiry_date date NOT NULL,
    expiry_time time without time zone NOT NULL
);


ALTER TABLE public."adminBluemoon_offer" OWNER TO postgres;

--
-- Name: adminBluemoon_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."adminBluemoon_offer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."adminBluemoon_offer_id_seq" OWNER TO postgres;

--
-- Name: adminBluemoon_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."adminBluemoon_offer_id_seq" OWNED BY public."adminBluemoon_offer".id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: carts_cartitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts_cartitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    is_active boolean NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    variation character varying(20) NOT NULL
);


ALTER TABLE public.carts_cartitem OWNER TO postgres;

--
-- Name: carts_cartitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_cartitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_cartitem_id_seq OWNER TO postgres;

--
-- Name: carts_cartitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_cartitem_id_seq OWNED BY public.carts_cartitem.id;


--
-- Name: carts_carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts_carts (
    id bigint NOT NULL,
    cart_id character varying(250) NOT NULL,
    date_added timestamp with time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.carts_carts OWNER TO postgres;

--
-- Name: carts_carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_carts_id_seq OWNER TO postgres;

--
-- Name: carts_carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_carts_id_seq OWNED BY public.carts_carts.id;


--
-- Name: carts_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts_order (
    id bigint NOT NULL,
    address character varying(2500) NOT NULL,
    payment_method character varying(250) NOT NULL,
    total integer,
    date timestamp with time zone NOT NULL,
    order_number character varying(250) NOT NULL,
    product_id bigint,
    user_id bigint,
    order_status character varying(50) NOT NULL,
    quantity integer,
    sub_total integer,
    variation character varying(20) NOT NULL,
    CONSTRAINT carts_order_quantity_check CHECK ((quantity >= 0)),
    CONSTRAINT carts_order_sub_total_check CHECK ((sub_total >= 0)),
    CONSTRAINT carts_order_total_check CHECK ((total >= 0))
);


ALTER TABLE public.carts_order OWNER TO postgres;

--
-- Name: carts_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_order_id_seq OWNER TO postgres;

--
-- Name: carts_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_order_id_seq OWNED BY public.carts_order.id;


--
-- Name: category_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_category (
    id bigint NOT NULL,
    category_name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    descrption text,
    category_image character varying(100)
);


ALTER TABLE public.category_category OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_category_id_seq OWNER TO postgres;

--
-- Name: category_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_category_id_seq OWNED BY public.category_category.id;


--
-- Name: category_subcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_subcategory (
    id bigint NOT NULL,
    category_name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    descrption text,
    category_image character varying(100),
    category_id_id bigint NOT NULL,
    subcategory_offer_id bigint
);


ALTER TABLE public.category_subcategory OWNER TO postgres;

--
-- Name: category_subcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.category_subcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.category_subcategory_id_seq OWNER TO postgres;

--
-- Name: category_subcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.category_subcategory_id_seq OWNED BY public.category_subcategory.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id bigint NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: store_banner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_banner (
    id bigint NOT NULL,
    banner_image character varying(100) NOT NULL,
    tag_line character varying(250),
    heading character varying(250),
    offer_percentage character varying(250),
    starting_price integer,
    button_url character varying(250)
);


ALTER TABLE public.store_banner OWNER TO postgres;

--
-- Name: store_banner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_banner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_banner_id_seq OWNER TO postgres;

--
-- Name: store_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_banner_id_seq OWNED BY public.store_banner.id;


--
-- Name: store_coupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_coupon (
    id bigint NOT NULL,
    coupon_code uuid NOT NULL,
    minimum_rate integer NOT NULL,
    percentage integer NOT NULL,
    expiry_date date NOT NULL,
    expiry_time time without time zone NOT NULL,
    CONSTRAINT store_coupon_percentage_check CHECK ((percentage >= 0))
);


ALTER TABLE public.store_coupon OWNER TO postgres;

--
-- Name: store_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_coupon_id_seq OWNER TO postgres;

--
-- Name: store_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_coupon_id_seq OWNED BY public.store_coupon.id;


--
-- Name: store_productimages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_productimages (
    id bigint NOT NULL,
    image character varying(100) NOT NULL,
    product_id bigint NOT NULL
);


ALTER TABLE public.store_productimages OWNER TO postgres;

--
-- Name: store_productimages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_productimages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_productimages_id_seq OWNER TO postgres;

--
-- Name: store_productimages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_productimages_id_seq OWNED BY public.store_productimages.id;


--
-- Name: store_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_products (
    id bigint NOT NULL,
    product_name character varying(200) NOT NULL,
    slug character varying(250) NOT NULL,
    description text,
    mrp double precision NOT NULL,
    sale_price double precision NOT NULL,
    image character varying(100) NOT NULL,
    stock integer NOT NULL,
    size character varying(20) NOT NULL,
    is_available boolean,
    created_date timestamp with time zone NOT NULL,
    modified_date timestamp with time zone NOT NULL,
    category_id bigint NOT NULL,
    size_l boolean,
    size_m boolean,
    size_s boolean,
    size_xl boolean,
    offer_type character varying(200),
    product_offer_id bigint,
    product_offer_price integer
);


ALTER TABLE public.store_products OWNER TO postgres;

--
-- Name: store_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_products_id_seq OWNER TO postgres;

--
-- Name: store_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_products_id_seq OWNED BY public.store_products.id;


--
-- Name: store_usedcoupon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_usedcoupon (
    id bigint NOT NULL,
    coupon_code character varying(100) NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.store_usedcoupon OWNER TO postgres;

--
-- Name: store_usedcoupon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_usedcoupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_usedcoupon_id_seq OWNER TO postgres;

--
-- Name: store_usedcoupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_usedcoupon_id_seq OWNED BY public.store_usedcoupon.id;


--
-- Name: store_wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_wishlist (
    id bigint NOT NULL,
    wishlist_id character varying(250) NOT NULL,
    date_added timestamp with time zone NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.store_wishlist OWNER TO postgres;

--
-- Name: store_wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_wishlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_wishlist_id_seq OWNER TO postgres;

--
-- Name: store_wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_wishlist_id_seq OWNED BY public.store_wishlist.id;


--
-- Name: store_wishlistitem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.store_wishlistitem (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    is_active boolean NOT NULL,
    variation character varying(6) NOT NULL,
    product_id bigint NOT NULL,
    wishlist_id bigint NOT NULL
);


ALTER TABLE public.store_wishlistitem OWNER TO postgres;

--
-- Name: store_wishlistitem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.store_wishlistitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.store_wishlistitem_id_seq OWNER TO postgres;

--
-- Name: store_wishlistitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.store_wishlistitem_id_seq OWNED BY public.store_wishlistitem.id;


--
-- Name: accounts_account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_account ALTER COLUMN id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- Name: accounts_useraddress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_useraddress ALTER COLUMN id SET DEFAULT nextval('public.accounts_useraddress_id_seq'::regclass);


--
-- Name: adminBluemoon_offer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."adminBluemoon_offer" ALTER COLUMN id SET DEFAULT nextval('public."adminBluemoon_offer_id_seq"'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: carts_cartitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_cartitem ALTER COLUMN id SET DEFAULT nextval('public.carts_cartitem_id_seq'::regclass);


--
-- Name: carts_carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_carts ALTER COLUMN id SET DEFAULT nextval('public.carts_carts_id_seq'::regclass);


--
-- Name: carts_order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_order ALTER COLUMN id SET DEFAULT nextval('public.carts_order_id_seq'::regclass);


--
-- Name: category_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_category ALTER COLUMN id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


--
-- Name: category_subcategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_subcategory ALTER COLUMN id SET DEFAULT nextval('public.category_subcategory_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: store_banner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_banner ALTER COLUMN id SET DEFAULT nextval('public.store_banner_id_seq'::regclass);


--
-- Name: store_coupon id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon ALTER COLUMN id SET DEFAULT nextval('public.store_coupon_id_seq'::regclass);


--
-- Name: store_productimages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productimages ALTER COLUMN id SET DEFAULT nextval('public.store_productimages_id_seq'::regclass);


--
-- Name: store_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_products ALTER COLUMN id SET DEFAULT nextval('public.store_products_id_seq'::regclass);


--
-- Name: store_usedcoupon id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_usedcoupon ALTER COLUMN id SET DEFAULT nextval('public.store_usedcoupon_id_seq'::regclass);


--
-- Name: store_wishlist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist ALTER COLUMN id SET DEFAULT nextval('public.store_wishlist_id_seq'::regclass);


--
-- Name: store_wishlistitem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlistitem ALTER COLUMN id SET DEFAULT nextval('public.store_wishlistitem_id_seq'::regclass);


--
-- Data for Name: accounts_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_account (id, password, first_name, last_name, username, email, phone_number, address, date_joined, last_login, is_admin, is_staff, is_active, is_superadmin, referral_code, wallet) FROM stdin;
9	pbkdf2_sha256$260000$RnNkR4QXlPI0ajYCXFu90g$opf227xxHVD0/7MqsP1wmBNpv1MIMppVzdOjuIATYE4=	abin	p anil	abin	abi@gmail.com	9874562130	jhkfjhsflkhsf	2021-11-13 11:00:20.440922+05:30	2021-11-13 11:00:20.881119+05:30	f	f	t	f	1f81b844	0
10	pbkdf2_sha256$260000$9FV448P27F1Xwtp3Pba2YS$AqYPP0bd7D3NMmUAOqjyp20vpWpBIqbvm53njyUQEzQ=	ajas	aug	ajas	ajas@gmail.com	9497745709	afjhkajsdfhlashfh	2021-11-15 09:43:38.347334+05:30	2021-11-15 09:44:28.421886+05:30	f	f	f	f	2b4e3835	0
15	pbkdf2_sha256$260000$JTWtWUkeJ0YkMewCFhisq5$xCnpSzj3FImh6Gt9Z5OaDbmhDnJQpiZDEO7JmATKJDw=	vyshak	kannan	vyshak01	vyshak@gmail.com	9400973003	gdasgdafs	2021-11-20 14:21:15.133751+05:30	2021-11-20 14:31:31.575699+05:30	f	f	t	f	c0eea885	0
16	pbkdf2_sha256$260000$dZxULAp0aPqyeY1Tns4uPn$lWrvpbmph4UF1tFZomQBIKXTysvPGiC14A7Jed3vmsc=	arjun	kurupp	arjunk	arjun@gmail.com	7356502642	fhasjklfklasfh	2021-11-20 14:39:04.691373+05:30	2021-11-20 14:39:39.478124+05:30	f	f	t	f	d4a1770d	0
17	pbkdf2_sha256$260000$1bKm9JZxEgqFbljJr1ioDZ$PGMhSUs4P31jbx+xS5cm7SKZ1AFx3l9+t2815Y2DrMk=	fazil	mohammed	fazil	fazifazil160160@gmail.com	9947061662	kohdsajiju	2021-11-28 18:16:40.188627+05:30	2021-11-28 18:17:38.068927+05:30	f	f	t	f	5fad70c4	0
21	pbkdf2_sha256$260000$GGsk02qrpZCuo6Ea02lp0u$DIS9klfNO2dPL+GwiXLwaPieilcF8KJ2wT0pnGBYl4U=	alan	jcob	alan	alan@gmail.com	9562127610		2021-12-05 18:18:26.219452+05:30	2021-12-05 18:18:26.238429+05:30	f	f	t	f	2d55c986	10
3	pbkdf2_sha256$260000$Duh3A1AHTle1nFzdE1Uz6j$BbICczjLbAiOW+Pyel0AZ4dG52eXNR1K58JH/ex3Trs=	niyas	tkt	niyas	niyastk9562@gmail.com	9562127608	fdasfasfa	2021-11-06 21:44:54.003356+05:30	2021-12-07 12:42:23.010024+05:30	f	f	t	f	fd978c34	0
8	pbkdf2_sha256$260000$fZklxcIG6S5ybor2SP8lko$GecU5ogTjN0+9F5gcFqtWXQfRVES37IKFzq/Um1T5DU=	shebin	sps	shebin	shebin1@gmail.com	9876543210		2021-11-09 11:17:28.575497+05:30	2021-12-07 19:05:39.20243+05:30	f	f	t	f	ba77dbd4	0
7	pbkdf2_sha256$260000$pKE2U9HblsHTZB94SsC7eT$95JHhQtLJVhNR+kY3t8HfvSDHK/ad9Hj4phQcTuryWc=	admin	admin	admin	niyas@gmail.com			2021-11-08 11:23:35.645789+05:30	2021-12-09 10:04:10.826542+05:30	t	t	t	t	230c9f1a	0
6	pbkdf2_sha256$260000$fODAO7oU0IedjUhF6ZQxyD$muq0gfTyldJnJ3Dj50OJpzEh54B9EYIafG0eP3su8H4=	nzx	nz	nzx	nzx@gmail.com	8848524410	gdfgdfghdfh	2021-11-07 22:14:48.490704+05:30	2021-12-09 12:04:00.980229+05:30	f	f	t	f	68b603ae	0
\.


--
-- Data for Name: accounts_useraddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_useraddress (id, first_name, last_name, country, street_address, apartment, town, postcode, phone_number, email, user_id) FROM stdin;
7	shebin	dfgsdgds	india	kakkanad, infopark	near carnival info park	eranakulam	676305	9562127608	abinpanil@gmail.com	6
8	Niyas	tk	india	kakkanad, infopark	near carnival info park	eranakulam	676305	9562127608	niyastk@gmail.com	6
11	shebin	pr	india	kakkanad, infopark	sggfsgs	gsgdsfg	686015	8848524410	abinpanil@gmail.com	8
\.


--
-- Data for Name: adminBluemoon_offer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."adminBluemoon_offer" (id, offer_name, percentage, expiry_date, expiry_time) FROM stdin;
5	Sunday offer	25	2021-12-11	14:52:00
8	Summer offer	40	2021-12-11	17:00:00
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add category	6	add_category
22	Can change category	6	change_category
23	Can delete category	6	delete_category
24	Can view category	6	view_category
25	Can add account	7	add_account
26	Can change account	7	change_account
27	Can delete account	7	delete_account
28	Can view account	7	view_account
29	Can add sub category	8	add_subcategory
30	Can change sub category	8	change_subcategory
31	Can delete sub category	8	delete_subcategory
32	Can view sub category	8	view_subcategory
33	Can add products	9	add_products
34	Can change products	9	change_products
35	Can delete products	9	delete_products
36	Can view products	9	view_products
37	Can add product images	10	add_productimages
38	Can change product images	10	change_productimages
39	Can delete product images	10	delete_productimages
40	Can view product images	10	view_productimages
41	Can add cart item	11	add_cartitem
42	Can change cart item	11	change_cartitem
43	Can delete cart item	11	delete_cartitem
44	Can view cart item	11	view_cartitem
45	Can add carts	12	add_carts
46	Can change carts	12	change_carts
47	Can delete carts	12	delete_carts
48	Can view carts	12	view_carts
49	Can add user address	13	add_useraddress
50	Can change user address	13	change_useraddress
51	Can delete user address	13	delete_useraddress
52	Can view user address	13	view_useraddress
53	Can add order	14	add_order
54	Can change order	14	change_order
55	Can delete order	14	delete_order
56	Can view order	14	view_order
57	Can add offer	15	add_offer
58	Can change offer	15	change_offer
59	Can delete offer	15	delete_offer
60	Can view offer	15	view_offer
61	Can add wish list item	16	add_wishlistitem
62	Can change wish list item	16	change_wishlistitem
63	Can delete wish list item	16	delete_wishlistitem
64	Can view wish list item	16	view_wishlistitem
65	Can add wishlist	17	add_wishlist
66	Can change wishlist	17	change_wishlist
67	Can delete wishlist	17	delete_wishlist
68	Can view wishlist	17	view_wishlist
69	Can add coupon	18	add_coupon
70	Can change coupon	18	change_coupon
71	Can delete coupon	18	delete_coupon
72	Can view coupon	18	view_coupon
73	Can add used coupon	19	add_usedcoupon
74	Can change used coupon	19	change_usedcoupon
75	Can delete used coupon	19	delete_usedcoupon
76	Can view used coupon	19	view_usedcoupon
77	Can add banner	20	add_banner
78	Can change banner	20	change_banner
79	Can delete banner	20	delete_banner
80	Can view banner	20	view_banner
\.


--
-- Data for Name: carts_cartitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts_cartitem (id, quantity, is_active, cart_id, product_id, variation) FROM stdin;
239	3	t	53	16	size_m
235	1	t	50	16	size_m
253	1	t	12	14	size_m
\.


--
-- Data for Name: carts_carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts_carts (id, cart_id, date_added, user_id) FROM stdin;
38	6nbd9t7pfj47t2altkxsvu99pjp9kugi	2021-11-23 10:31:12.033557+05:30	\N
2	725kmxhtpthbhr45yhmtxelz9izexutf	2021-11-15 15:17:42.926403+05:30	3
3	ld8u4if0qijjap0dp12gotztm1njeaie	2021-11-15 15:46:08.450781+05:30	3
4	oznzacpjpctuh0furic28ddj62mwwo24	2021-11-15 15:52:37.617043+05:30	3
5	p9irxr5qtax8iepevoh7l151f0q99zc7	2021-11-15 16:07:21.575607+05:30	3
19	2063911a-1610-4484-bad8-315e510f1bd9	2021-11-19 15:02:33.105673+05:30	\N
6	uau919li2pluwelvgdrcarc5hyxy59xk	2021-11-15 16:08:46.957719+05:30	3
20	2ddpmwerlzwfjdem19xiroghoi6vzceq	2021-11-19 15:02:39.684513+05:30	\N
25	lp7d1l80rzhuik06zl7gjw92dgot44x4	2021-11-20 10:04:31.613952+05:30	\N
21	zpa44i2bjcav19alp3bjbhxm7u0u505e	2021-11-19 15:08:56.892034+05:30	\N
39	4y31hqrpe2nvbx1679wmcc6wekjzrt03	2021-11-23 10:34:42.811335+05:30	\N
22	4evvldb1wcqoasddddrw53ohuthhizb4	2021-11-19 16:41:19.755743+05:30	\N
40	nxuhjbfdiqmf3e5vqlji55b84oey5mld	2021-11-23 10:40:49.297666+05:30	\N
7	er2tk9qfgcimf2hv3awb70amo9359znz	2021-11-15 18:59:10.065371+05:30	3
8	1ycdcu14944gk8etvcdwj5i4idv9r8tq	2021-11-16 17:48:11.114491+05:30	3
9	158j2utl4hgbik8lq4ht5o98i91pwzhk	2021-11-16 17:50:10.832251+05:30	3
41	rqlsh5ediuom59wkya4nl0y8mmg1pk5j	2021-11-23 10:42:06.512898+05:30	\N
42	q96606cf53494g2s9wv9r1drflotpkpp	2021-11-23 11:25:56.509866+05:30	\N
16	c96vdvev4z3d0wgosdgpb85g46xzeqkj	2021-11-16 23:14:26.235447+05:30	\N
26		2021-11-20 14:39:56.609079+05:30	16
45	vi5wgdwuq2229mpkdzew8l36x8qti21p	2021-11-26 12:25:06.85422+05:30	\N
27	rkwc4jl5hu76spwr4rp5ksm8swi8j28o	2021-11-20 14:41:26.33759+05:30	\N
53	btoub009s7kko2wywnoxc4lccfy9flmo	2021-12-07 17:23:44.954434+05:30	\N
17	01bf7d9f-3ee8-431f-bfb6-79cba9e4374b	2021-11-18 22:19:43.758158+05:30	\N
18	1c18wg25kyz725i78ytw0l87mvjkceg6	2021-11-18 22:19:54.482652+05:30	\N
30		2021-11-20 19:51:39.234057+05:30	8
28	a767918jb7fa65i2v2eb0c3ilk9c0avz	2021-11-20 15:13:07.70513+05:30	\N
12		2021-11-16 20:33:26.61853+05:30	6
29	htrlf6k62yazjrs2j2c7864orq93ccrv	2021-11-20 19:50:22.028487+05:30	\N
23	71p7dn5d95ay35aennkhhpoubzb4i66a	2021-11-19 22:32:09.154401+05:30	\N
31	sha1ykog8qouhbszgm087s714h78rkan	2021-11-21 09:38:55.147054+05:30	\N
32	3rapj8w1j9d4p4c16g9hul6bm24p1fon	2021-11-23 09:33:07.994555+05:30	\N
33	swuw2pe68k19uj1209hapjtqn9r4plgl	2021-11-23 10:00:11.025686+05:30	\N
34	1quyyoi31k4xp5v8ugi7b2onax98gcxj	2021-11-23 10:07:17.102398+05:30	\N
35	csjb2pen6fzcs1g26wctst5vaps5wank	2021-11-23 10:08:40.610026+05:30	\N
36	7siwduebqxuvrx7km72coe8983e6nkyg	2021-11-23 10:15:29.552183+05:30	\N
37	8eyxd6e25wj5cm9nuljk3s8psvss21sz	2021-11-23 10:29:52.011996+05:30	\N
46	uauetbftvueeghm49fpxcvoupunphgv8	2021-11-29 16:20:56.13861+05:30	\N
49	nb4ogg00nx5lwvn6kpoh9vccud9qepsj	2021-12-06 12:39:58.149543+05:30	\N
24		2021-11-19 23:12:05.409621+05:30	7
50	6g3pon8h5qy1kt7xagrmcxu04m231tqh	2021-12-07 12:20:34.486382+05:30	\N
43	1iu8ah5yptbj6j6wvirne9hhephlc3wb	2021-11-24 10:23:05.115101+05:30	\N
51	7wmr6xmevhctdj2b29w1rmw6hixs1ppa	2021-12-07 12:37:31.214041+05:30	\N
44	mp0885ya21f364mfu2u8ih3w37joq57y	2021-11-24 10:23:49.453521+05:30	\N
47	umxh7lf3e619r0zwudwa7ol4i4j14w4g	2021-12-01 17:40:18.172669+05:30	\N
52	7ucsv69sh9v78s7m0i4fzmbb6kkpaqtu	2021-12-07 12:44:14.055362+05:30	\N
48	e4ksvkyolnnzpd808ggars4k44tusdyr	2021-12-02 23:38:14.700361+05:30	\N
\.


--
-- Data for Name: carts_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts_order (id, address, payment_method, total, date, order_number, product_id, user_id, order_status, quantity, sub_total, variation) FROM stdin;
100	Nzx, makavu calicut,near ir Ventures,calicut,676305,8848524410	razorpay	2499	2021-12-01 11:40:33.672278+05:30	2e8cd9f8-d5bf-4c43-83c8-fc2bcb4e1f3f	14	6	Order Placed	1	2499	size_m
132	shebin, kakkanad, infopark,near carnival info park,eranakulam,676305,9562127608	cash_on_delivery	2499	2021-12-07 12:48:31.947854+05:30	1cc23551-a1e9-4d11-a322-1b20d6284384	16	6	Order Placed	1	2499	size_m
97	Nzx, makavu calicut,near ir Ventures,calicut,676305,8848524410	paypal	4972	2021-11-29 23:11:55.043593+05:30	b321c67b-8d23-4d2d-b736-7f66d8292cd3	137	6	Order Completed	1	599	size_l
98	Nzx, makavu calicut,near ir Ventures,calicut,676305,8848524410	paypal	4972	2021-11-29 23:11:55.052561+05:30	b321c67b-8d23-4d2d-b736-7f66d8292cd3	14	6	Order Completed	1	2499	size_m
99	Nzx, makavu calicut,near ir Ventures,calicut,676305,8848524410	paypal	4972	2021-11-29 23:11:55.065527+05:30	b321c67b-8d23-4d2d-b736-7f66d8292cd3	16	6	Order Completed	1	1874	size_m
133	shebin, kakkanad, infopark,sggfsgs,gsgdsfg,686015,8848524410	cash_on_delivery	1749	2021-12-07 19:53:02.499158+05:30	52db77bc-c8ec-4baf-818b-da72a63bb29e	16	8	Order Placed	1	2499	size_m
101	Nzx, makavu calicut,near ir Ventures,calicut,676305,8848524410	razorpay	1874	2021-12-01 11:57:21.199401+05:30	18b19303-dee1-4933-9579-2e0d6e909487	16	6	Order Canceled	1	1874	size_m
140	Niyas, kakkanad, infopark,near carnival info park,eranakulam,676305,9562127608	razorpay	3499	2021-12-08 15:46:39.105861+05:30	e79e008e-ad43-44ef-9650-5d35273a1150	168	6	Order Placed	1	3499	size_m
53	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	18992	2021-11-23 12:23:40.591081+05:30	298141a4-6105-438f-8a4e-a252befd622a	16	6	Order Shipped	1	2499	size_m
49	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	32984	2021-11-21 09:40:58.652886+05:30	89d40df0-778b-456d-91ee-aa24c831c881	16	6	Order Canceled	3	7497	size_m
50	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	32984	2021-11-21 09:40:58.656878+05:30	89d40df0-778b-456d-91ee-aa24c831c881	15	6	Order Canceled	10	19990	size_m
51	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	32984	2021-11-21 09:40:58.659871+05:30	89d40df0-778b-456d-91ee-aa24c831c881	14	6	Order Canceled	1	2499	size_m
52	shebin, eranakulam, kakkanad ,near carnival info park,eranakulam,686015,9562127608	cash_on_delivery	7497	2021-11-22 14:11:30.67973+05:30	ca7a2ea3-f81c-49f5-b771-844a8985364b	14	8	Order Placed	3	7497	size_m
45	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	24489	2021-11-20 18:04:00.131742+05:30	f2dcae9b-74dd-4406-909e-6182c6c4ff50	14	6	Order Completed	2	4998	size_m
46	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	24489	2021-11-20 18:04:00.147744+05:30	f2dcae9b-74dd-4406-909e-6182c6c4ff50	15	6	Order Completed	6	11994	size_m
47	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	24489	2021-11-20 18:04:00.147744+05:30	f2dcae9b-74dd-4406-909e-6182c6c4ff50	16	6	Order Completed	3	7497	size_m
91	Nzx, makavu calicut,near ir Ventures,calicut,676305,8848524410	razorpay	2499	2021-11-27 19:36:38.289431+05:30	4c849a8a-1967-40fb-a594-33c56cf9a55d	16	6	Order Placed	1	2499	size_m
54	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	18992	2021-11-23 12:23:40.665882+05:30	298141a4-6105-438f-8a4e-a252befd622a	15	6	Order Shipped	2	3998	size_m
55	Niyas, Kakkanad,carnival infopark,near carnival info park,Eranakulam,676305,9562127608	cash_on_delivery	18992	2021-11-23 12:23:40.667875+05:30	298141a4-6105-438f-8a4e-a252befd622a	14	6	Order Shipped	5	12495	size_m
123	niyass, kaakkanad,near carnival info park,kochin,686015,884852441	paypal	1999	2021-12-05 15:17:03.05198+05:30	cc94e320-a5ba-40a4-85c0-7833badc599d	14	6	Order Placed	1	2499	size_m
126	niyass, kaakkanad,near carnival info park,kochin,686015,884852441	razorpay	1999	2021-12-05 15:38:51.001249+05:30	1e8b74ae-4186-47fe-8095-72f2b93a78eb	14	6	Order Placed	1	2499	size_m
\.


--
-- Data for Name: category_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_category (id, category_name, slug, descrption, category_image) FROM stdin;
2	Women cloths	Women-cloths	Different Women clothing 	
3	Seasonal dress	Seasonal-dress	Different Seasonal clothing 	
6	Casual Dress	Casual-Dress	Different Casual clothing 	
1	Men cloths	Men-cloths	Different men clothing 	
\.


--
-- Data for Name: category_subcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_subcategory (id, category_name, slug, descrption, category_image, category_id_id, subcategory_offer_id) FROM stdin;
1	Men's Shirt	Mens-Shirt	Different Shirts		3	\N
13	women's pants	womens-pants	gfdsgsdg		2	\N
14	Full Sleeve T shirt	Full-Sleeve-T-shirt	Full Sleeve T shirt		6	\N
4	Men T shirt	Men-T-shirt	Different T shirts for men		1	\N
12	Men's Pants	Mens-Pants	Different Pants		1	\N
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	category	category
7	accounts	account
8	category	subcategory
9	store	products
10	store	productimages
11	carts	cartitem
12	carts	carts
13	accounts	useraddress
14	carts	order
15	adminBluemoon	offer
16	store	wishlistitem
17	store	wishlist
18	store	coupon
19	store	usedcoupon
20	store	banner
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	accounts	0001_initial	2021-11-06 16:54:16.052424+05:30
2	contenttypes	0001_initial	2021-11-06 16:54:16.227269+05:30
3	admin	0001_initial	2021-11-06 16:54:16.459641+05:30
4	admin	0002_logentry_remove_auto_add	2021-11-06 16:54:16.46606+05:30
5	admin	0003_logentry_add_action_flag_choices	2021-11-06 16:54:16.472042+05:30
6	contenttypes	0002_remove_content_type_name	2021-11-06 16:54:16.565487+05:30
7	auth	0001_initial	2021-11-06 16:54:17.132296+05:30
8	auth	0002_alter_permission_name_max_length	2021-11-06 16:54:17.141763+05:30
9	auth	0003_alter_user_email_max_length	2021-11-06 16:54:17.147736+05:30
10	auth	0004_alter_user_username_opts	2021-11-06 16:54:17.155231+05:30
11	auth	0005_alter_user_last_login_null	2021-11-06 16:54:17.162695+05:30
12	auth	0006_require_contenttypes_0002	2021-11-06 16:54:17.16699+05:30
13	auth	0007_alter_validators_add_error_messages	2021-11-06 16:54:17.173616+05:30
14	auth	0008_alter_user_username_max_length	2021-11-06 16:54:17.182592+05:30
15	auth	0009_alter_user_last_name_max_length	2021-11-06 16:54:17.189949+05:30
16	auth	0010_alter_group_name_max_length	2021-11-06 16:54:17.235449+05:30
17	auth	0011_update_proxy_permissions	2021-11-06 16:54:17.244146+05:30
18	auth	0012_alter_user_first_name_max_length	2021-11-06 16:54:17.252496+05:30
19	category	0001_initial	2021-11-06 16:54:17.469732+05:30
20	sessions	0001_initial	2021-11-06 16:54:17.673737+05:30
21	accounts	0002_auto_20211108_1050	2021-11-08 10:51:03.79376+05:30
22	accounts	0002_auto_20211108_1122	2021-11-08 11:22:48.401929+05:30
23	category	0002_subcategory	2021-11-09 09:42:20.75603+05:30
24	category	0003_alter_subcategory_category_id	2021-11-10 11:14:34.2221+05:30
25	store	0001_initial	2021-11-10 11:14:34.676551+05:30
26	store	0002_auto_20211110_1725	2021-11-10 17:25:40.378797+05:30
27	store	0003_auto_20211111_1451	2021-11-11 14:53:03.233055+05:30
28	store	0004_auto_20211115_1409	2021-11-15 14:11:44.910573+05:30
29	carts	0001_initial	2021-11-15 14:11:45.905661+05:30
30	carts	0002_carts_user	2021-11-16 18:32:14.88854+05:30
31	store	0005_auto_20211116_1829	2021-11-16 18:32:14.912818+05:30
32	store	0006_auto_20211116_1940	2021-11-16 19:42:40.22074+05:30
33	accounts	0003_auto_20211117_2208	2021-11-17 22:10:13.850694+05:30
34	carts	0003_order	2021-11-18 19:48:59.210286+05:30
35	carts	0004_order_order_status	2021-11-20 10:35:44.559118+05:30
36	carts	0005_auto_20211120_1757	2021-11-20 17:57:50.789043+05:30
37	store	0007_auto_20211120_2314	2021-11-20 23:14:50.183959+05:30
38	carts	0006_auto_20211123_1458	2021-11-23 14:59:06.517015+05:30
39	carts	0007_alter_order_variation	2021-11-23 17:25:33.441382+05:30
40	carts	0008_alter_order_variation	2021-11-23 17:44:33.517149+05:30
41	carts	0009_alter_order_variation	2021-11-27 19:29:12.816099+05:30
42	carts	0010_alter_cartitem_variation	2021-11-27 19:36:04.633835+05:30
43	adminBluemoon	0001_initial	2021-11-29 11:23:57.762382+05:30
44	category	0004_subcategory_subcategory_offer	2021-11-29 13:39:42.301013+05:30
45	store	0008_auto_20211129_1339	2021-11-29 13:39:42.576294+05:30
46	category	0005_alter_subcategory_subcategory_offer	2021-11-29 19:08:25.320567+05:30
47	store	0009_alter_products_product_offer	2021-11-29 19:08:25.335527+05:30
48	store	0010_wishlist_wishlistitem	2021-12-03 20:50:18.573173+05:30
49	store	0011_coupon	2021-12-04 14:49:29.43242+05:30
50	store	0012_usedcoupon	2021-12-05 14:13:03.906196+05:30
51	accounts	0004_account_referral_code	2021-12-05 16:16:47.280817+05:30
52	accounts	0005_account_wallet	2021-12-05 16:36:24.900342+05:30
53	accounts	0006_alter_account_wallet	2021-12-05 16:36:54.954454+05:30
54	accounts	0007_alter_account_referral_code	2021-12-05 17:26:44.092453+05:30
55	store	0013_banner	2021-12-06 00:06:13.118795+05:30
56	store	0014_auto_20211206_0005	2021-12-06 00:06:13.191971+05:30
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
b0z4en9h3el2jzj87f7zcydpjt0sm64n	eyJkYjk4OTk1MC0yMDRmLTQ4MTEtODc2Yy0wMGVjMzMxMDVjYjMiOnRydWV9:1moRG2:7hw-iLzTBhUqBKITlzIMFpWKXEeG-BVFbhVdTJibsw4	2021-12-04 19:52:22.707743+05:30
goyabwfh2cw2qfhs47ip5vnj4k7sp3pb	.eJxFkksOVUEIRPfyxpJAQ39wN9DAAoyOjHsXjfc67VQXpwp-fvgOLKaELDSQwAWOKCCHI52Ri_Tz9fu3H_nlk2d6TWaoGre1NMDXIhh2qcb0VJFHK3z8ahrskA2yBeHM6jHImWfJpY2Pdk1NKjqwdLbvWtYM2mMWSh1VzX0fbdMuUzcoXQiSo7WNCBVDWIfS4df3dIKoFNho2Yk2gntDY4pPuneu_9rVAWKUgszbDOJ_sx2IuzVM8U4_j3aLUxYLDGo3sTlBK6hpmOKuLMPxaCOPcna1Q6x7cE84QQ5UGEhUEfT6OpG5aULtthTSAapM0BVMHbZZM99-6R5DLbDVIDKdmzcmXMJ9hvJAezvrsok3XQhd8w9vgJ4RkBRys_ofz5fhcA9vt9MJQaq3fQp7ecWX_GROe7NZHWTnAs_VWssBdveCCM9dQ_TKy8D90ik2GFP3cFaBTr6QaXea7IG-3r3tvp0hAUz9QbR3YWEF1bcalmsgxsvgXaGoAAW3NtrS4iAQp45DvbZ4GXK62mGFOTmaQSbY8Qm-7zyxl8_8d-u_fgPiXtfG:1mn287:ZSrQR6jy9Z6jzvB5dXlSJm0Va3CvCnph0Xsd2wGvPbc	2021-11-30 22:50:23.420359+05:30
l8ao4e1z7g51aunjxb7n5ohqlpqvk9da	e30:1mmYXH:hMsfxeC6AP1eTK4bxr4IxZuHkDjJzyeSOmfXjNVgcCw	2021-11-29 15:14:23.938088+05:30
725kmxhtpthbhr45yhmtxelz9izexutf	e30:1mmYaU:R2axEqCPLs6OzrxUVu4nUfz8OVc4G8W_-GbZplcsvT8	2021-11-29 15:17:42.922377+05:30
ld8u4if0qijjap0dp12gotztm1njeaie	e30:1mmZ20:vEUcgWEWE767zspbpjpL-OTpqV113nlvTRSQvRkq9iE	2021-11-29 15:46:08.444493+05:30
oznzacpjpctuh0furic28ddj62mwwo24	e30:1mmZ8H:qmnivADEqAxtIlhAfCV3GY0aWneWxW5p8UjfR7T0R7c	2021-11-29 15:52:37.611436+05:30
p9irxr5qtax8iepevoh7l151f0q99zc7	e30:1mmZMX:R3-81OCMDjYaloD5x8Bo0nXxCVnodaYjn-frj28Gwt8	2021-11-29 16:07:21.570771+05:30
uk0rdp5zpmuwn30y8c5g76d0rmxyswd3	eyI0Mjg3YzBlMC04ODhmLTQ3OTgtYmU0Zi1hNTZhMzMxOTk1MGQiOnRydWV9:1mpUV0:T_F5ZTPHkscEDZ__DN6c86srGVUXZ6DZR4Swb4AdqCY	2021-12-07 17:32:10.568185+05:30
3tm23nzcmgxrdf3vlj64eaf2i4m274os	eyJ1c2VyX2xvZ2luIjp0cnVlfQ:1mjlC1:K0nCRdxKzHVPoZpQiUA-XXfImi9-lZGH3o_TIV6xmlM	2021-11-21 22:08:53.477459+05:30
v93sanr9idw0pilb774wen6eyvrs6sxn	eyJ1c2VyX2xvZ2luIjp0cnVlfQ:1mjmD4:jJrqi8vrPxQt1WAK78O9U8XHL08uZrV4DjHU9hWhNQU	2021-11-21 23:14:02.982695+05:30
regubgstx9advy8w0epvfjfd64rc49td	eyJ1c2VyX2xvZ2luIjp0cnVlfQ:1mjmDa:bWnSF8vv2TgaGeA74pLNiTzAHW0HukYDMO1AUVqeG2E	2021-11-21 23:14:34.241475+05:30
u5xne0i759zwubdndpik74lz40f6l3k9	.eJxVjksOwjAMRO-SNa1CauKUJXvOUNmxTcsnlfpZIe5OEWzYzrx5mqdLcR8QDCtjgQpIUkVosUrMDUevCbK54zKtunMdrUvfrbNO3SDu6ND9ZUz5puVTyJXKZazzWJZp4PqD1L92rs-j6P30Y_8EPc39traD-ETcBjMwCeKjIuSQohBvtzQDcoPApGpsCdp9S40Pychjc8C4SUkeQ-nu42Uo3_OvN8AYTAo:1moeCj:JIbJ6RebTPliufibSSgGCHgVs0zx_dXR2cqtGTZ4yzU	2021-12-05 09:41:49.240315+05:30
0ud8l0540xeod6ix1hvjl3rznchhwkjm	.eJwty7kNgDAMAMBdUmPJwQ522MZPMgCCCrE7FPR3d2mYjtonqBsCtxRwF4U0MiJWM13Lfh7XWMrEPrZqDJyVgEP8W0EQOTWlh-v47fMCSTYZTQ:1mn2Du:nTQj0D-BGhRNTeVFU65ulQ_RTGykJlC5h82cLkx-nN0	2021-11-30 22:56:22.529385+05:30
f9b24qraktkujpmzgvd569qla8ve9e8o	e30:1mmc2G:5V0ZIxn5Y9oTtbsqeT8PnyQjQsDIBrQtuDwpEagjIWY	2021-11-29 18:58:36.570545+05:30
rtrsucgagxce99k3n53iloqsjhe9gda8	eyIwMTk0NGZiYS1iYjM0LTQxZTktYWY2OS00NzllZGUwYjE2ZjYiOnRydWV9:1mn2E5:BSTxdqaneofezBBc7SNgKEkKS3QF9dLDU71yxxRytxw	2021-11-30 22:56:33.22073+05:30
c96vdvev4z3d0wgosdgpb85g46xzeqkj	eyI3YzZiN2VjZi1jNWQ1LTQ4ZjktYjA5NC01Njk3NzY0ZDE5Y2QiOnRydWV9:1mn2Jj:S5rF3pRdmbIhfYtyUQ0nQVs5th8X1PJhnV2OeF8xUz8	2021-11-30 23:02:23.896504+05:30
57zt8veqtn80de13xptz4r0bcszqzdcn	e30:1mk2oq:mHm_m1BUO1g8ybzDaeNuuTOZhnFxiws6jMeFLN-Uw5U	2021-11-22 16:58:08.529285+05:30
0vamfpnzinzh79r946k2oehgxofhyi8f	.eJxVjEEOgyAQRe_CuiEUUdBl9z0DmWEGpbWQoK6a3r2auGi3_73_3sLDtk5-W7j6RGIQVlx-N4Tw5HwAekAeiwwlrzWhPBR50kXeC_F8O92_wATLtL9jS8oB9jpGE0mT6tiaoF1HgA6Rg7HYWIPAHDE60197aJR2EZRtWtvtUaBXyn4uY8piWOvGny-SWD-9:1mmrpO:DJWvEKoR30JXu0CwNp7OwExf5s3oBKpnuiBa8iYEZ5E	2021-11-30 11:50:22.51206+05:30
9g76vbpm4zqqtlm0159cwlemha9i8i2w	.eJxVjMsOgyAQRf-FdUNGxAFcdu83GAYGtTWQ-Fg1_fdq46Ld3nPueYne79vY7ysv_RRFK1Dcfjfy4cn5BPHh81BkKHlbJpKnIi-6yq5Enu-X-xcY_ToebyAL2hkblEFFQD4mZAadLFYBNJBq0DlVR4OVSTo5ZptqQmwQkm7CEf3m5jJMWbTbsvP7A-5IPfo:1moL6f:8A3l8k_PzJATj9uxk4QXNTMJRWMTkQaEnKl5B0WYK_4	2021-12-04 13:18:17.078263+05:30
k7r2ckt8al2j193rmgomeyh5xoc6zyvv	eyIwNDJiMWJiZC0yYmZhLTQxMjMtYWI2Zi00ZDZhMGFlZTM0OGQiOnRydWV9:1mok3k:EAwMSLnZt6-InwhbGQsdiLzivhO_u0TEpeGTgPz8D_o	2021-12-05 15:56:56.321321+05:30
ex9ky3x1y70nqvc6sk5q3x1l7vmoiu9u	eyJiMDI1OWM5Zi1lYjg4LTRjOTQtYTAxZi1mMTQ0ZTJiY2I1MTYiOnRydWV9:1mnDOj:uGn0dNeqAnL5TKx8FbFzOjBqYqT-gC9QEqtiw_2zOMU	2021-12-01 10:52:17.136133+05:30
1c18wg25kyz725i78ytw0l87mvjkceg6	.eJwlysENgDAIBdBdepaEBiqt2_AtDGD0ZNxdE9_53aWZG2IqtS4rqTDIOZVqOtsISJ9etvO4YilckTZHkkT079YkJFayscNHqJjiv88LS3kZUw:1mnkbX:95dY8lx3obbXhYgBXNZeaE8uljKVSepemsrxPYMrZ1Q	2021-12-02 22:19:43.799626+05:30
7b5g205f111z8vuaw5lh7nwuwjrrvf8w	.eJxVjEEOgyAQRe_CuiEUUdBl9z0DmWEGpbWQoK6a3r2auGi3_73_3sLDtk5-W7j6RGIQVlx-N4Tw5HwAekAeiwwlrzWhPBR50kXeC_F8O92_wATLtL9jS8oB9jpGE0mT6tiaoF1HgA6Rg7HYWIPAHDE60197aJR2EZRtWtvtUaBXyn4uY8piWOvGny-SWD-9:1mnxci:IeYd4y0QjyD8zRiZ9ZQJgAWjujMc7CsLfOJ4bDwJg5I	2021-12-03 12:13:48.976008+05:30
2ddpmwerlzwfjdem19xiroghoi6vzceq	.eJwlyrENhTAMBcBdUmPJD9tJzDYxiQdAUCF2_8W_-t4y1qmoYiStOamPRu4ihD7TMpQRWY77etZWdq7iwCBUMKl2pRizk8CWgRMx_X-_H_rkF2U:1mo0G1:sqCqZ8j4MwWwwB_G6LHmXuVO8F5iAOTMvZZ-iUnmg6I	2021-12-03 15:02:33.162428+05:30
zpa44i2bjcav19alp3bjbhxm7u0u505e	eyI4NjM4NTMxNy1kYWIzLTQ5MzAtODExZS1iMWJlZWFlNzI0YzgiOnRydWV9:1mo0Lw:MlJUolE3qGIhSTPy4GKpCOZ4ShOW1Z2_ByYGuRJoRMo	2021-12-03 15:08:40.571839+05:30
4evvldb1wcqoasddddrw53ohuthhizb4	eyJhZGUwZTMzMS1jMTdhLTQ2YmEtYmM0NS02NTljYzMxMjI1Y2MiOnRydWV9:1mo0YH:-37lGBsugPfCbsrF5tetP2G1s7BPg9w6uazHqcjyYqw	2021-12-03 15:21:25.300963+05:30
gy9scp4c2o3qun4b4q4nlrrv2rbmi9f7	.eJxVjEEOgyAQRe_CuiEUUdBl9z0DmWEGpbWQoK6a3r2auGi3_73_3sLDtk5-W7j6RGIQVlx-N4Tw5HwAekAeiwwlrzWhPBR50kXeC_F8O92_wATLtL9jS8oB9jpGE0mT6tiaoF1HgA6Rg7HYWIPAHDE60197aJR2EZRtWtvtUaBXyn4uY8piWOvGny-SWD-9:1ml33P:ASexZJwuCB4dQy9u9D0AKTNNIsW1y1uBeLstk1L3oTM	2021-11-25 11:25:19.046625+05:30
fz1qy8yobzv6o8n6ffiuzgtp66i3e231	eyJlZjE0NTZmNy1kZGRlLTQ1MDMtYjc3Yi1jNDE2YTM3NjRmYzkiOnRydWV9:1mo7EE:msBxEsVPlLBchLTc1ml7TImuY4HTYABH6Xmgcehqk9g	2021-12-03 22:29:10.322895+05:30
dircxth2tjeu4hq5v3og33kjy1a541bc	eyIyZDU4Yzk2OC1hNTJkLTRmMDEtOGE2YS1jNTgwNWI0ZmNjYWUiOnRydWV9:1mo7EP:7vNhFWEF52FKjWq-VNC96KzimLFk2EOEMkV1zneKZVg	2021-12-03 22:29:21.398042+05:30
6qxvgjza3ti0ai7v8e71dj0r9vm18nxh	.eJw1yksOQjEIBdC9dOxNCv2BuwFaFvCiI-PeNTGe8XkVFRWuVGEsiS6U8KMVbmRV7UTELvfH9Ty3skYK-WTMPgN9bYHz2Ag7GYtCNdv_NknWEYwl39G3NXhzgucYphE0Jv_u-wN7JiUH:1mn1cX:J15XLm8CSO3K1wpJbkAK4GZgyGw4CfEcia-GaDk7uOU	2021-11-30 22:17:45.419178+05:30
5bs2ntcp5fafgk7u3vsdkhnkphzbc41g	eyJkNWY2OTFhZS05MTkzLTQyNzYtODBiYS1lMjQ1MTMzODE4MmUiOnRydWV9:1mo7Oi:vl1J9KrTOPDKoLb_wYHEboaTQ5-dpozLqCogAOkIuLo	2021-12-03 22:40:00.618582+05:30
rkwc4jl5hu76spwr4rp5ksm8swi8j28o	eyIxMDZjMDE5YS0wYmIzLTRjMzAtYTE2OC04NWNmZGQ2Mjk4MmQiOnRydWV9:1moMOJ:ZIUzhl1cJ-SqasO_dARAbQPV6OGFIN8hLaX-UZq0AYQ	2021-12-04 14:40:35.571261+05:30
0ibxzbx0zs7z2p74ifjtsuv45d4xsrzc	.eJxVjjsOgzAQRO_iOkbG2ItNmT5nQGvvGkgQlvhUUe4eSGho5808zVswExAqLQGTlcaWJB0gSEOE7KBMxCiadd74Jlrc1r7dFp7bgUQjQFyygPHF0wHoiVOXi5indR5CcVSKky7FIxOP97N7EfS49PtaBaeMr13UNeigAlICZmXSficqo4K24L2uqIayTiZ5ZpeqAGBBJWPjLv3pxtwN0__75wuA5krJ:1moI5i:hqocSSwufWZ3buRXlk_G7tvgIbMVr-l5RM896NLt9z0	2021-12-04 10:05:06.678011+05:30
m1txm5kseoxlznmv50rzhgvb5imsz8kl	.eJxVjjsOgzAQRO_iOiBjjNemTJ8zoF17DSTElvhUUe4eUGho5808zUegrUgx-YIZqNCmUYUDVxU6VuAaZWovjWjXeeOb6HBbh25beO7GIFoB4pIR-henA4Qnpj6XPqd1Hqk8KuVJl_KRA0_3s3sRDLgM-zo2QVokp2LUMaggDYP2ypqAZInYa6AaNCFzpGi1qxzWUtmIEuoGzC7F8B5TN-V-TP_z3x8uJEtF:1moPCP:Rx96hCqS_Xu5uTne3RQwXr2C4us3JvcdVzcTxj1MYuk	2021-12-04 17:40:29.254976+05:30
ugmlcooqqo700f2aio0khrvwcqfe070h	eyI0NDcyNjkxMy0wMmJjLTQ4M2EtYjg2NS1hYzI0YWMxYjllYjUiOnRydWV9:1mok3n:YFuKj7Q3ztB3WVyaZMEhzMKfb8RdCEY0ZLypbudrUwQ	2021-12-05 15:56:59.504034+05:30
l8nkz609tgmpq3s6w2ahrs1c5uu8sepu	eyI3MzhmZTIxNy02ZDNlLTQwNDEtYTk0NC1kYjY3ZjhhZTY0N2EiOnRydWV9:1mp2QI:2tmtQKv8sWVFNy7mkMFFpPDRhlGmQO6Xqbq9HtjqgBw	2021-12-06 11:33:26.009053+05:30
5leqkt7e1iqnkhbwy33vc08cwtt0mt72	eyJjNzA5NjA2NC0wMTBmLTQ5ZGItOWJjZS02NWQ3YjUzNmQ5YTciOnRydWV9:1mp2Rg:ogDwPJ8cAFLQd__It4ZD6UDonlhjlYEKdurQ9Jqam4U	2021-12-06 11:34:52.281607+05:30
n39e51yw2yd96koplwbillc5nuchss5e	.eJxVjksOgzAMRO-SdUGJZeLAsvueASW2A7QVSHxWVe_e0rJhO_PmaV7GOVcjWykErRZIgYqAlSsIbHaRwFPNplnnTS-mjdvat9uiczuIaYw3pyxFfui4F3KPYzeVPI3rPKRyR8qjXcrbJPq8HuxJ0Mel_64r8OzBJfY522yBlYByCJgooHrHokIYQq3qGBJKlSGgaI5AMev-6qd7Tt0w_r-_Pyx8SkE:1mrkah:SRsbIeU3wUfO5EifmG052clhGLugU_FoN0-QGpFunIE	2021-12-13 23:07:23.348055+05:30
yhs1vse7ymwupzgkq9ck4ad1rig1csys	.eJxVjjkOgzAURO_iOiBjG2wo0-cM6G8GEmIklirK3QMKDe28maf5KCLrLZachRB95hgoC1SbTBcihdUFGRTVrPMmN9XCtvbttsjcDqwa5dUlQ6CXpAPwE1I35TSldR4wPyr5SZf8MbGM97N7EfSw9Ps6lqwDYG1idJEN60q8IxMqBgyIQs6j9Q5BJGIMri5qsNqECNrb0le7FPg9pHacuiH9z39_texL9A:1muEf4:mKHC6qGSFwfjhLfhT7w9g7ZBzVcgaiSAfYZPDkYq2iE	2021-12-20 19:38:10.254465+05:30
gajv5nicmnzvxlgtr0n6ikbsw7eke5xw	.eJxVjjsOgzAQRO_iOiCDv1CmzxnQrncNToiR-FRR7h5QaGjnvRnNR5AJ0sagC0KUhTYhFOhYFRWDNY33sAuiXeeNb6KDbR26beG5SyRa4cQlQwgvzgegJ-R-KsOU1zlheSjlSZfyMRGP99O9DAywDHs7GpIesKlj1JFqkpadDrW3BOgROWiHymkE5ojR66ZqQMnaR5BOGWf3UaB3yt049Sn_z39_DFNMWg:1muSFI:BmQBhCKJE-0hSDEiGboZunKoL5X2FI0RT9c5Tdu2t-4	2021-12-21 10:08:28.479319+05:30
ptf8m9sxtceg4e4ohtuihcdolypov217	eyJmODNhOWU3My1mMzQ4LTQ5YmMtOWVjOS04MDlhMmUwYTA1NzEiOnRydWV9:1mp8nK:1RP7UMwxJw6F0uAd-ipRikdq9IOGav4l78hqtBjiK4I	2021-12-06 18:21:38.99348+05:30
tb29pti3xfsho09ht86ig5240s40bvpe	.eJxVjDsOgzAQRO_iOlj2ml0DZfqcAa1_QIKwxKeKcvdARAqaKd68mbcAZdGl0hbIxhal3qPC2heGIJJzHhQp0azzFm9iW-Lcjrkbpj9peVv79seHIBphxIU59q84HUV48tRl6fO0zoOThyLPdpGPHOJ4P93LQc9Lv6_ZoEcklUBXKilGhcGWiqGOFVEEMMEH1qQpIFlMCWqT6uATOPKpcuLzBaFaSZI:1muUeF:zRa0ZYblSAtM5m1r8d_dmWKXVc6UVZGroOGNVe555Gs	2021-12-21 12:42:23.017612+05:30
svzte6s3nenvnmj1744tvu6t1df3psg8	.eJxVjjsOgzAQRO_iOljGH2xTps8Z0O7aBhKEJT5VlLvHJDQ0W8ybedo3Q49SNh4qi9ZUWqdQAZRjtJYKjCQKibXbsscb62Dfhm5f49KNgbXMsUuGQK84HyA8Ye4zpzxvy4j8qPCTrvyRQ5zuZ_ciGGAdyjp5EsZYMLUG6TCiVCSVJAUYtFBRUCq8MQIcImgEJyx5VK5xVMeUivSnm3I_zv_fP19WqUtZ:1mpVpX:Hete-DNrNKNsDWfAMgh8IwghpiOw2W8BUvxNgBFYCgE	2021-12-07 18:57:27.538212+05:30
ao82lnv8uyln8jg2k0dw80y7xdxu0dka	eyJmOWJlZjFiMi1lODRlLTQwODYtODRlMS01NDNkZGM2Nzg4NmUiOnRydWV9:1msOQz:G__cA0fOZyKUJOuu11RfmvMDjt4q5jjrDAnAo48RsEg	2021-12-15 17:40:01.776689+05:30
ng97iju3w7dhtxhqany4p6kxg3jb2dpa	eyI0YzM4NDYyZS1iNDNlLTQ3YTAtYTk1Mi01ZjY5NDliYTBhYmUiOnRydWV9:1mpBzE:GTc14eHSRu2_25uttAyv6dZ9jzvJ87EF91JN8q08Qa0	2021-12-06 21:46:08.262867+05:30
w3qyfgxf3kouoenqr97px203pkni2wfu	.eJxVjktuwzAMRO-idW1YFiVKWXbfMxikSMZuUxnwZ1X07k3QbLKdN_MwP04xZrDCXalgHUTEjsD7jj0llIA-puAux3bqm5voPObp3HWbFnEXh-4lY6pf2h5APqld176u7dgW7h-V_kn3_mMVvb0_uy-Cmfb5vrYoQyYuoxmYjDIkRahjTkKcmbUCckBgUjW2DMUXCsOYjQYMEdNdSvK9tOm2Xpf2f_73DwUdSxs:1mpkKq:0Nd-Hw1Zs6fOFzrulybz3oriZfGcNfmVe1ZS_BC-lF8	2021-12-08 10:26:44.06709+05:30
04uur9w58uohmj1xw2h317w0024s4aeq	eyI3YmMzMDRmZi1kZDE0LTRjYTEtOTJmYy1iYzZlNDhiNGYxNDMiOnRydWV9:1mpNYj:wzBNwnhoKr29leMVPFpJ2VP82fwAg088-Lscck0xZ28	2021-12-07 10:07:33.500601+05:30
632m7j0g0rm538c5aywx8dhchi2tcvo0	eyIyNzUxZjg4Zi1hNzY4LTQ2YjYtYjg0Ni0yMzk5OGJhYzc2MDYiOnRydWV9:1mpvQw:mbWQ1bGnaUXEDHyoCrKpKzElWFNUkgnCtg5agTSEWas	2021-12-08 22:17:46.363957+05:30
2b20hzjowfcpkoyl0crh6gbntdpdaxix	eyJjOGY0MDIwMS02NDE5LTQ1MGItYjZkNy02NDBhNzFjM2NhNDMiOnRydWV9:1msP7q:64hHZURzfpvixCmbUJ7rK5Xj8YIbOjlHXxn3gSzfd-k	2021-12-15 18:24:18.236087+05:30
inqupwoj4kv1urhvwqbt5pmf5fj8sxt3	.eJxVjjsOgzAQRO_iOkbGLLahTJ8zoF2vDU6IkfhUUe4eUGho5808zUeUxqEtHUkoay2BFEhqCKUj65lihUgg2nXewk10uK1Dty1h7hKLVlhxyQj9K-QD8BNzPxV-yuucqDgqxUmX4jFxGO9n9yIYcBn2daxZOaRGxwiRNSsTLHjtDCM5ouDBUmWBMIRI0UFTNlgp7SIqW9XW7FLkd8rdOPUp_89_f5_HS-w:1mq6eD:2JLMd4GAkgcYukTF7rAU2Ht8efAhOJyyCJFlD-ZqGiU	2021-12-09 10:16:13.16989+05:30
ryybq5221tehii99qqz3iubttx0qw8mn	.eJxVjEEOgyAQRe_CuiEUUdBl9z0DmWEGpbWQoK6a3r2auGi3_73_3sLDtk5-W7j6RGIQVlx-N4Tw5HwAekAeiwwlrzWhPBR50kXeC_F8O92_wATLtL9jS8oB9jpGE0mT6tiaoF1HgA6Rg7HYWIPAHDE60197aJR2EZRtWtvtUaBXyn4uY8piWOvGny-SWD-9:1mqS7K:Mvm3ChCzfgY-SkeMGl1yo3doe669NiKYeywGMagalmw	2021-12-10 09:11:42.4036+05:30
fpcfs5ukcbg25xoc91o49pmvpfgj907a	.eJxVjjsOwjAQRO_imkSO4_iTkp4zRLveXRIItpRPhbg7QdDQzpt5mqeiBloCkCpG4yubpKkiBqqwEy2snTOxU_227HxSA-zbOOwrL8NEqlde_WUI6c75A-gG-VrqVPK2TFh_KvWPrvWlEM_nX_dPMMI6HmvpSAfAaESskCHt2NtkgiPAgMjJemy9RWAWlGBjE6HVJgho33beHVKgx5SHuVyn_D3_egPJd0wE:1msqBG:byO1Mt9Tq8ejkgphLBAZSV4PrHLio4AnknFnZEZdBDo	2021-12-16 23:17:38.038576+05:30
0q8aw1smkatdhz3amlshcgtrtdbetw2n	eyIwYTMwNzMzNi0xY2E4LTQ4YmQtYjljMi01MjI5MzU3OWVkZWYiOnRydWV9:1mpNuW:E_5dZwAoYrsRQyJV-Ygqwz15I-iG4Rd5NJOBXACH-bM	2021-12-07 10:30:04.35771+05:30
sdghpjw8vmhr6w6mtp3n9abkzy6pdtxy	eyI5NTA0OTM5MS1jNTViLTRkZTEtYjFjNS00MTUxMGJlZDAwMmUiOnRydWV9:1mpNw5:kYtdDU5Lm5SVebqamIu-LFktfFhd8cEGckqsLYDkP74	2021-12-07 10:31:41.917128+05:30
zmet0qga6dxgsaex2qf6u45tulqxxjh9	.eJxVjjsOgzAQRO_iOiDHv7VTps8Z0K7tBRJiJD5VlLsHFBraeW9G8xHSEavgXcUeoDIaQxUw2ipaq4EwIhKJ2zKt-SIaXJeuWec8NX0SNwHilG32K5cdpCeWdqzjWJapp3pX6oPO9WNMebgf7mmgw7nb2myT9EhBMRtOKkmXwUTlXULyRDkaIA2GMGcm9iZcA2qpPKMEbcFto5jefWmGse3L__z3B7XtTAQ:1mt05H:clFQCIXj41lcU_px302MJbXE3TqY6tE8QOBIjBBnMQc	2021-12-17 09:52:07.518484+05:30
93omlbaj4evj8m8q1dgro7a77z0elank	eyIyODk1MWVjOS1iZjg2LTRiMDAtOTkzMS1mYjU4ZDU1YWMxYmYiOnRydWV9:1mpNzR:4CjHUrbbY6Nag8D40fQCYyKiZvmapzCnQ4PYyD8Kh7M	2021-12-07 10:35:09.673289+05:30
w1kqsooyc67vdr6q3w2sb6bjcmzxovmy	.eJxVjjsOgzAQRO_iOiBj_IMyfc5g7XrXQEKMxKeKcveAQkM78-ZpPsIY2ThUXETWstAKXYG20kUkn0AZVLIC0a7zxjcRYFv7sC08h4FEK5y4ZAjxxfko6Am5m8o45XUesDyQ8myX8jERj_eTvQh6WPp9nQxJD9iolHQiRdKy01F5S4AekaN2WDuNwJwwed1UDdRS7X-lq42zuxToPeQwTt2Q_-e_P1d6S4k:1muau3:_4rnlKd91X2HUZruCpLWVD2uGQreyLmip3JSTYnyD4Q	2021-12-21 19:23:07.020632+05:30
ynnb1eb5vbu8mo6rpsvc8whabjrwf0ip	.eJxVjjsOgzAQRO_iOiBjbNZOmT5nQLveNZCPkfhUUe4eUGho38w8zUdZDi4h6cLECgqLTgp0VSgMIJFtdA0Vq-syrXJRLa5L366zTO2wQQXqxAjjU_Ie8ANzN5ZxzMs0ULlXyiOdy_vI8rod3ZOgx7nf1smx9kjBpGQTG9aNgI3GN4zkiSRaoBosoUii5G2oAtba-IQaagfNJkV-D7l9jd2Q_-e_P2I-S40:1muorm:3A8EGYVlqY45w7D3-6KRl3SZENi--zM2q5-aE0XNRAo	2021-12-22 10:17:42.156764+05:30
bzfffc0pe9d70frl0aizi37w8xa3h76n	.eJxVjrkOgzAQRP_FdUA-1tikTJ9vQLteL5DDSBxVlH8PUdLQzpt5mpdiZziIb6oUrKsAPFQImioCa4zB6DyIOq_zlk-qw20dum3JczeyOqugDhlhuufyBXzD0k91mso6j1R_K_WfLvV14vy4_LsHwYDLsK_Fs45IrRUBYcu6yQGSjQ0jRaKcIJALQJizkERoTYtO2yiog_Oh2aXIz7F0j6kfy-_8-wPnsEr8:1mtNgQ:j3_zpbyIb2bK0eWEwjYOk2YfMZI56rWWV4JrBxXX3d0	2021-12-18 11:04:02.435341+05:30
dvq3qyw4q7ssd6p4u4e8g75j0xy18s2n	.eJxVjjsOg0AMRO-ydUDL4uAlZfqcAdnYBvJZJD5VlLuHKDS082ZG7-1YaxTiIhOCkIGYzwjAMoyCrG0ZLKq7LNOqJ9fQuvTNOuvUDOIuDt0hY2ofmn5A7pS6MW_HtEwD579KvtM5v42iz-vePRz0NPfb2s7iI3EdzMAkiK8UoQ2x2jwjb1KAXCIwqRpbhLqoqfQhGnksz1htpySvITXPsRvSX_7zBTdVTI4:1mtkGz:LBc8q1TU9oSsEVLd9PDRdjlvyknOcHVl5s8fKwCSM8Q	2021-12-19 11:11:17.967296+05:30
pau2n9uuc6v7zj04mvn8r3rja08xmier	eyIyOTg4OGQwOS1iMWQxLTRhMjUtOWMxZS01ZjMyNjU4N2EzZmEiOnRydWV9:1mreFg:JsFDYD86yvxfNEiF4Yc8nRx5iymRVDSiMv63LDkAHYw	2021-12-13 16:21:16.832535+05:30
nr78hiu9bjzwwdrfmip2zch10p1e19gx	.eJxVjrkOwjAQRP_FNYlMsj6Wkp5viHa9axIOR8pRIf6dRNDQvpl5mpdBEIcYsEJyUAFYW1FufZXQ8VHRemfFnJZp1YPpaF36bp116oYNmmD-GFO6a9kDuVG5jnUayzINXO-V-pfO9WUUfZx_3T9BT3O_rbMTG4mxyRmyNGK9BkhN9EIcmTVB4DYAk2rmHAGPSK1tYiYbWhf8JiV5DqV7jNehfM-_P9bISu8:1mvB8E:6FoKVlwX7nupT9E5cbPw7fLxAuItlwi1K23K1nmYaew	2021-12-23 10:04:10.982736+05:30
gzhr9xhwtbqjvxr6v6451oj7cuhq8hzs	eyI0YWQ4NjUwOC1lOWU4LTRmOTgtYTZiNi04MWMzNzYyZGI2YWIiOnRydWV9:1mvD0K:fb4SbKcsNE45d1EAstJCHPM-EfjxlEz3Zfz7O6u5Fkg	2021-12-23 12:04:08.362953+05:30
\.


--
-- Data for Name: store_banner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_banner (id, banner_image, tag_line, heading, offer_percentage, starting_price, button_url) FROM stdin;
1	photos/banners/slide-1_dpNnmMD.jpg	The Festival is here	Men T-shirts	25%OFF 	1499	http://127.0.0.1:8000/products/category/Men-T-shirt/
\.


--
-- Data for Name: store_coupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_coupon (id, coupon_code, minimum_rate, percentage, expiry_date, expiry_time) FROM stdin;
10	1dbadff7-8fef-40c8-a43d-21876bbd900c	3000	30	2021-12-15	23:45:00
12	385a646f-b3e9-4879-9d50-ff597a5c7d65	1000	25	2021-12-30	22:00:00
13	b2bbd7fe-35ae-4170-9147-d855ea35a6cc	1500	30	2021-12-30	19:30:00
\.


--
-- Data for Name: store_productimages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_productimages (id, image, product_id) FROM stdin;
9	store/products/black_shirt_2_mlF6Fkc.jpg	14
11	store/products/black_shirt_3_lUBVnqP.jpg	14
10	store/products/black_shirt_5_LFvOyIg.jpg	14
12	store/products/black_shirt_4_3jU6KNd.jpg	14
17	store/products/black_shirt_2_2VijjjY.jpg	15
18	store/products/black_shirt_3_OnuiZRy.jpg	15
19	store/products/black_shirt_4_ZTTLIdE.jpg	15
20	store/products/black_shirt_5_xVamxAX.jpg	15
21	store/products/blu_shirt_2_0mBnlpG.jpg	16
22	store/products/blu_shirt_3_6kW40zk.jpg	16
23	store/products/blu_shirt_4_mj34sly.jpg	16
24	store/products/blu_shirt_5_BBmVI9o.jpg	16
60	store/products/black_jeans2.png	137
61	store/products/black_jeans3.png	137
62	store/products/black_jeans4.png	137
63	store/products/black_jeans2_bvX675v.png	137
68	store/products/black_cotton_pants2.png	165
69	store/products/black_cotton_pants3.png	165
70	store/products/black_cotton_pants5.png	165
71	store/products/Men_Shirt_check2.png	166
72	store/products/Men_Shirt_check3.png	166
73	store/products/Men_Shirt_check4.png	166
74	store/products/Men_Shirt_check5.png	166
75	store/products/Full_sleeve_t_shirts2.png	167
76	store/products/Full_sleeve_t_shirts3.png	167
77	store/products/Full_sleeve_t_shirts4.png	167
78	store/products/Full_sleeve_t_shirts5.png	167
79	store/products/Women_pink_pants2.png	168
80	store/products/Women_pink_pants3.png	168
81	store/products/Women_pink_pants4.png	168
82	store/products/Women_pink_pants5.png	168
\.


--
-- Data for Name: store_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_products (id, product_name, slug, description, mrp, sale_price, image, stock, size, is_available, created_date, modified_date, category_id, size_l, size_m, size_s, size_xl, offer_type, product_offer_id, product_offer_price) FROM stdin;
167	Full sleeve t shirts	Full-sleeve-t-shirts	Full sleeve t shirts for men and women	1250	1249	photos/products/Full_sleeve_t_shirts1.png	49		t	2021-12-08 11:00:32.72461+05:30	2021-12-08 11:00:32.72461+05:30	14	f	t	t	f	\N	\N	\N
14	Black T shirt	Black-T-shirt	Black T shirt for men	2500	2499	photos/products/black_shirt_1.jpg	49	M	t	2021-11-12 23:07:12.537217+05:30	2021-11-12 23:07:12.537217+05:30	4	f	t	t	f	\N	\N	\N
166	Men Shirt check	Men-Shirt-check	Men Shirt check 	2750	2749	photos/products/Men_Shirt_check1.png	48		t	2021-12-08 10:53:35.513943+05:30	2021-12-08 10:53:35.513943+05:30	1	t	t	t	f	\N	\N	\N
168	Women pink pants	Women-pink-pants	Women pink pants	3500	3499	photos/products/Women_pink_pants1.png	49		t	2021-12-08 11:11:05.137884+05:30	2021-12-08 11:11:05.137884+05:30	13	f	t	f	f	\N	\N	\N
15	Red T shirt	Red-T-shirt	Red T shirt for men	2000	1999	photos/products/black_shirt_1_PfPcesB.jpg	0	XL	t	2021-11-12 23:45:14.490082+05:30	2021-11-12 23:45:14.490082+05:30	4	t	f	f	t	\N	\N	\N
137	black jeans	black-jeans	dhsghdslhgjk	1000	999	photos/products/black_jeans1.png	41		t	2021-11-29 19:12:51.763338+05:30	2021-11-29 19:12:51.763338+05:30	12	t	t	t	t	\N	\N	\N
16	Grey Shirt	Grey-Shirt	Grey shirt for men	2500	2499	photos/products/blu_shirt_1_XMzpeyb.jpg	47	M	t	2021-11-12 23:46:30.325614+05:30	2021-11-12 23:46:30.325614+05:30	4	t	t	t	f	\N	\N	\N
165	black cotton pants	black-cotton-pants	black cotton pants 	1500	1499	photos/products/black_cotton_pants1.png	50		t	2021-12-08 10:47:52.110915+05:30	2021-12-08 10:47:52.110915+05:30	12	t	t	f	f	\N	\N	\N
\.


--
-- Data for Name: store_usedcoupon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_usedcoupon (id, coupon_code, user_id) FROM stdin;
4	ed11e093-bc75-4da4-8ed4-bb0c17b5899e	6
5	b2bbd7fe-35ae-4170-9147-d855ea35a6cc	8
6	b2bbd7fe-35ae-4170-9147-d855ea35a6cc	6
\.


--
-- Data for Name: store_wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_wishlist (id, wishlist_id, date_added, user_id) FROM stdin;
2		2021-12-07 15:27:07.789498+05:30	7
1		2021-12-03 22:36:56.908422+05:30	6
\.


--
-- Data for Name: store_wishlistitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.store_wishlistitem (id, quantity, is_active, variation, product_id, wishlist_id) FROM stdin;
20	1	t	size_m	14	1
\.


--
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 21, true);


--
-- Name: accounts_useraddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_useraddress_id_seq', 11, true);


--
-- Name: adminBluemoon_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."adminBluemoon_offer_id_seq"', 12, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 80, true);


--
-- Name: carts_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_cartitem_id_seq', 253, true);


--
-- Name: carts_carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_carts_id_seq', 53, true);


--
-- Name: carts_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_order_id_seq', 140, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_category_id_seq', 10, true);


--
-- Name: category_subcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_subcategory_id_seq', 14, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 20, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 56, true);


--
-- Name: store_banner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_banner_id_seq', 2, true);


--
-- Name: store_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_coupon_id_seq', 13, true);


--
-- Name: store_productimages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_productimages_id_seq', 82, true);


--
-- Name: store_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_products_id_seq', 168, true);


--
-- Name: store_usedcoupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_usedcoupon_id_seq', 6, true);


--
-- Name: store_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_wishlist_id_seq', 4, true);


--
-- Name: store_wishlistitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.store_wishlistitem_id_seq', 20, true);


--
-- Name: accounts_account accounts_account_phone_number_49694350_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_account
    ADD CONSTRAINT accounts_account_phone_number_49694350_uniq UNIQUE (phone_number);


--
-- Name: accounts_account accounts_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_account
    ADD CONSTRAINT accounts_account_pkey PRIMARY KEY (id);


--
-- Name: accounts_account accounts_account_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_account
    ADD CONSTRAINT accounts_account_username_key UNIQUE (username);


--
-- Name: accounts_useraddress accounts_useraddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_useraddress
    ADD CONSTRAINT accounts_useraddress_pkey PRIMARY KEY (id);


--
-- Name: adminBluemoon_offer adminBluemoon_offer_offer_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."adminBluemoon_offer"
    ADD CONSTRAINT "adminBluemoon_offer_offer_name_key" UNIQUE (offer_name);


--
-- Name: adminBluemoon_offer adminBluemoon_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."adminBluemoon_offer"
    ADD CONSTRAINT "adminBluemoon_offer_pkey" PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: carts_cartitem carts_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_cartitem
    ADD CONSTRAINT carts_cartitem_pkey PRIMARY KEY (id);


--
-- Name: carts_carts carts_carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_carts
    ADD CONSTRAINT carts_carts_pkey PRIMARY KEY (id);


--
-- Name: carts_order carts_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_order
    ADD CONSTRAINT carts_order_pkey PRIMARY KEY (id);


--
-- Name: category_category category_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_pkey PRIMARY KEY (id);


--
-- Name: category_category category_category_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_category
    ADD CONSTRAINT category_category_slug_key UNIQUE (slug);


--
-- Name: category_subcategory category_subcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_subcategory
    ADD CONSTRAINT category_subcategory_pkey PRIMARY KEY (id);


--
-- Name: category_subcategory category_subcategory_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_subcategory
    ADD CONSTRAINT category_subcategory_slug_key UNIQUE (slug);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: store_banner store_banner_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_banner
    ADD CONSTRAINT store_banner_pkey PRIMARY KEY (id);


--
-- Name: store_coupon store_coupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_coupon
    ADD CONSTRAINT store_coupon_pkey PRIMARY KEY (id);


--
-- Name: store_productimages store_productimages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productimages
    ADD CONSTRAINT store_productimages_pkey PRIMARY KEY (id);


--
-- Name: store_products store_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_products
    ADD CONSTRAINT store_products_pkey PRIMARY KEY (id);


--
-- Name: store_usedcoupon store_usedcoupon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_usedcoupon
    ADD CONSTRAINT store_usedcoupon_pkey PRIMARY KEY (id);


--
-- Name: store_wishlist store_wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist
    ADD CONSTRAINT store_wishlist_pkey PRIMARY KEY (id);


--
-- Name: store_wishlistitem store_wishlistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlistitem
    ADD CONSTRAINT store_wishlistitem_pkey PRIMARY KEY (id);


--
-- Name: accounts_account_phone_number_49694350_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_account_phone_number_49694350_like ON public.accounts_account USING btree (phone_number varchar_pattern_ops);


--
-- Name: accounts_account_username_b5f69a28_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_account_username_b5f69a28_like ON public.accounts_account USING btree (username varchar_pattern_ops);


--
-- Name: accounts_useraddress_user_id_5348f16c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_useraddress_user_id_5348f16c ON public.accounts_useraddress USING btree (user_id);


--
-- Name: adminBluemoon_offer_offer_name_f3091448_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "adminBluemoon_offer_offer_name_f3091448_like" ON public."adminBluemoon_offer" USING btree (offer_name varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: carts_cartitem_cart_id_9cb0a756; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX carts_cartitem_cart_id_9cb0a756 ON public.carts_cartitem USING btree (cart_id);


--
-- Name: carts_cartitem_product_id_acd010e4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX carts_cartitem_product_id_acd010e4 ON public.carts_cartitem USING btree (product_id);


--
-- Name: carts_carts_user_id_169b4d84; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX carts_carts_user_id_169b4d84 ON public.carts_carts USING btree (user_id);


--
-- Name: carts_order_product_id_e1672f28; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX carts_order_product_id_e1672f28 ON public.carts_order USING btree (product_id);


--
-- Name: carts_order_user_id_016ce4a7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX carts_order_user_id_016ce4a7 ON public.carts_order USING btree (user_id);


--
-- Name: category_category_slug_4f83d5f6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_category_slug_4f83d5f6_like ON public.category_category USING btree (slug varchar_pattern_ops);


--
-- Name: category_subcategory_category_id_id_f9a8c8ca; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_subcategory_category_id_id_f9a8c8ca ON public.category_subcategory USING btree (category_id_id);


--
-- Name: category_subcategory_slug_b958053a_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_subcategory_slug_b958053a_like ON public.category_subcategory USING btree (slug varchar_pattern_ops);


--
-- Name: category_subcategory_subcategory_offer_id_ee15bac5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_subcategory_subcategory_offer_id_ee15bac5 ON public.category_subcategory USING btree (subcategory_offer_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: store_productimages_product_id_1b6521cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_productimages_product_id_1b6521cd ON public.store_productimages USING btree (product_id);


--
-- Name: store_products_category_id_48867233; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_products_category_id_48867233 ON public.store_products USING btree (category_id);


--
-- Name: store_products_product_offer_id_cde4f50d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_products_product_offer_id_cde4f50d ON public.store_products USING btree (product_offer_id);


--
-- Name: store_usedcoupon_user_id_bb5053bd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_usedcoupon_user_id_bb5053bd ON public.store_usedcoupon USING btree (user_id);


--
-- Name: store_wishlist_user_id_afcc4e88; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_wishlist_user_id_afcc4e88 ON public.store_wishlist USING btree (user_id);


--
-- Name: store_wishlistitem_product_id_fe19664e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_wishlistitem_product_id_fe19664e ON public.store_wishlistitem USING btree (product_id);


--
-- Name: store_wishlistitem_wishlist_id_56b9c134; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX store_wishlistitem_wishlist_id_56b9c134 ON public.store_wishlistitem USING btree (wishlist_id);


--
-- Name: accounts_useraddress accounts_useraddress_user_id_5348f16c_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_useraddress
    ADD CONSTRAINT accounts_useraddress_user_id_5348f16c_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: carts_cartitem carts_cartitem_cart_id_9cb0a756_fk_carts_carts_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_cartitem
    ADD CONSTRAINT carts_cartitem_cart_id_9cb0a756_fk_carts_carts_id FOREIGN KEY (cart_id) REFERENCES public.carts_carts(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: carts_cartitem carts_cartitem_product_id_acd010e4_fk_store_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_cartitem
    ADD CONSTRAINT carts_cartitem_product_id_acd010e4_fk_store_products_id FOREIGN KEY (product_id) REFERENCES public.store_products(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: carts_carts carts_carts_user_id_169b4d84_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_carts
    ADD CONSTRAINT carts_carts_user_id_169b4d84_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: carts_order carts_order_product_id_e1672f28_fk_store_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_order
    ADD CONSTRAINT carts_order_product_id_e1672f28_fk_store_products_id FOREIGN KEY (product_id) REFERENCES public.store_products(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: carts_order carts_order_user_id_016ce4a7_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts_order
    ADD CONSTRAINT carts_order_user_id_016ce4a7_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: category_subcategory category_subcategory_category_id_id_f9a8c8ca_fk_category_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_subcategory
    ADD CONSTRAINT category_subcategory_category_id_id_f9a8c8ca_fk_category_ FOREIGN KEY (category_id_id) REFERENCES public.category_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: category_subcategory category_subcategory_subcategory_offer_id_ee15bac5_fk_adminBlue; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_subcategory
    ADD CONSTRAINT "category_subcategory_subcategory_offer_id_ee15bac5_fk_adminBlue" FOREIGN KEY (subcategory_offer_id) REFERENCES public."adminBluemoon_offer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_productimages store_productimages_product_id_1b6521cd_fk_store_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_productimages
    ADD CONSTRAINT store_productimages_product_id_1b6521cd_fk_store_products_id FOREIGN KEY (product_id) REFERENCES public.store_products(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_products store_products_category_id_48867233_fk_category_subcategory_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_products
    ADD CONSTRAINT store_products_category_id_48867233_fk_category_subcategory_id FOREIGN KEY (category_id) REFERENCES public.category_subcategory(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_products store_products_product_offer_id_cde4f50d_fk_adminBlue; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_products
    ADD CONSTRAINT "store_products_product_offer_id_cde4f50d_fk_adminBlue" FOREIGN KEY (product_offer_id) REFERENCES public."adminBluemoon_offer"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_usedcoupon store_usedcoupon_user_id_bb5053bd_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_usedcoupon
    ADD CONSTRAINT store_usedcoupon_user_id_bb5053bd_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_wishlist store_wishlist_user_id_afcc4e88_fk_accounts_account_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlist
    ADD CONSTRAINT store_wishlist_user_id_afcc4e88_fk_accounts_account_id FOREIGN KEY (user_id) REFERENCES public.accounts_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_wishlistitem store_wishlistitem_product_id_fe19664e_fk_store_products_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlistitem
    ADD CONSTRAINT store_wishlistitem_product_id_fe19664e_fk_store_products_id FOREIGN KEY (product_id) REFERENCES public.store_products(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: store_wishlistitem store_wishlistitem_wishlist_id_56b9c134_fk_store_wishlist_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.store_wishlistitem
    ADD CONSTRAINT store_wishlistitem_wishlist_id_56b9c134_fk_store_wishlist_id FOREIGN KEY (wishlist_id) REFERENCES public.store_wishlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

