--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE addresses (
    id integer NOT NULL,
    user_id integer,
    first_name character varying,
    last_name character varying,
    company_name character varying,
    telephone character varying,
    fax character varying,
    street_address character varying,
    street_address2 character varying,
    city character varying,
    state character varying,
    zip_code character varying,
    country character varying,
    is_default_billing boolean DEFAULT false,
    is_default_shipping boolean DEFAULT false
);


ALTER TABLE addresses OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE addresses_id_seq OWNER TO postgres;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE addresses_id_seq OWNED BY addresses.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categories (
    id integer NOT NULL,
    site_cat_id integer,
    cat_name text,
    group_name text,
    pos integer,
    parent_id integer,
    is_shown_in_menu boolean DEFAULT true,
    seo_title text,
    seo_keywords text,
    seo_desc text,
    filters text
);


ALTER TABLE categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: featured_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE featured_categories (
    id integer NOT NULL,
    cat_name text,
    parent_id integer,
    image_url text,
    category_id integer,
    site_cat_id integer,
    is_top_sale boolean,
    pos integer
);


ALTER TABLE featured_categories OWNER TO postgres;

--
-- Name: featured_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE featured_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE featured_categories_id_seq OWNER TO postgres;

--
-- Name: featured_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE featured_categories_id_seq OWNED BY featured_categories.id;


--
-- Name: left_navs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE left_navs (
    id integer NOT NULL,
    cat_id integer,
    parent_id integer,
    site_cat_id integer,
    cat_name text,
    group_name text,
    pos integer,
    group_pos integer,
    seo_title text,
    seo_keywords text,
    seo_desc text
);


ALTER TABLE left_navs OWNER TO postgres;

--
-- Name: left_navs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE left_navs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE left_navs_id_seq OWNER TO postgres;

--
-- Name: left_navs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE left_navs_id_seq OWNED BY left_navs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title character varying,
    first_name character varying,
    last_name character varying,
    middle_name character varying,
    is_contact_reference boolean DEFAULT false,
    is_skas_member boolean DEFAULT false
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY addresses ALTER COLUMN id SET DEFAULT nextval('addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featured_categories ALTER COLUMN id SET DEFAULT nextval('featured_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY left_navs ALTER COLUMN id SET DEFAULT nextval('left_navs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY addresses (id, user_id, first_name, last_name, company_name, telephone, fax, street_address, street_address2, city, state, zip_code, country, is_default_billing, is_default_shipping) FROM stdin;
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('addresses_id_seq', 1, false);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categories (id, site_cat_id, cat_name, group_name, pos, parent_id, is_shown_in_menu, seo_title, seo_keywords, seo_desc, filters) FROM stdin;
6	16908	Luggage & Backpacks	Home Essentials 	3	65	t	\N	\N	\N	\N
37	26435	Window Treatments	More for the Home	8	65	t	\N	\N	\N	\N
45	51902	Dyson	Home Brands	1	700	t	\N	\N	\N	\N
31	55971	Home Decor	More for the Home	5	65	t	\N	\N	\N	\N
4	29391	Furniture 	Home Essentials 	1	65	t	\N	\N	\N	\N
11	7552	Cookware	More for the Home	1	65	t	\N	\N	\N	\N
8	30599	Holiday Lane	Home Essentials	6	1	t	\N	\N	\N	\N
46	28954	Fiesta	Home Brands	2	700	t	\N	\N	\N	\N
10	24732	Coffee, Tea & Espresso 	More for the Home	2	65	t	\N	\N	\N	\N
12	31760	Cutlery & Knives	Kitchen	3	1	t	\N	\N	\N	\N
13	7554	Electrics	Kitchen	4	1	t	\N	\N	\N	\N
14	46711	Food Processors	Kitchen	5	1	t	\N	\N	\N	\N
15	31839	Kitchen Gadgets	Kitchen	6	1	t	\N	\N	\N	\N
16	46705	Mixers & Accessories	Kitchen	7	1	t	\N	\N	\N	\N
9	0	Under Armour	Active Brands	9	700	t	\N	\N	\N	\N
17	28973	Bar & Wine Accessories	Dining & Entertaining	0	1	t	\N	\N	\N	\N
39	36321	Kids' & Baby Room	More For Kids & Baby	4	391	t	\N	\N	\N	\N
18	7919	Flatware & Silverware	Dining & Entertaining	3	1	t	\N	\N	\N	\N
19	65938	Glassware & Drinkware	Dining & Entertaining	4	1	t	\N	\N	\N	\N
20	45859	Gourmet Food & Gifts	Dining & Entertaining	5	1	t	\N	\N	\N	\N
21	7923	Serveware	Dining & Entertaining	6	1	t	\N	\N	\N	\N
22	17199	Table Linens	Dining & Entertaining	7	1	t	\N	\N	\N	\N
7	25931	Mattresses	Bedroom & Mattresses	1	65	t	\N	\N	\N	\N
24	69952	Dressers & Chests	Furniture	1	1	t	\N	\N	\N	\N
25	35419	Couches & Sofas	Furniture	2	1	t	\N	\N	\N	\N
26	36166	Chairs & Recliners	Furniture	3	1	t	\N	\N	\N	\N
27	69962	Dining Room Sets	Furniture	4	1	t	\N	\N	\N	\N
28	69961	Dining Room Tables	Furniture	5	1	t	\N	\N	\N	\N
29	70056	Outdoor & Patio Furniture	Furniture	6	1	t	\N	\N	\N	\N
30	58181	Gifts That Give Hope 	Home Furnishings	0	1	t	\N	\N	\N	\N
23	35380	Beds & Headboards	Bedroom & Mattresses	0	65	t	\N	\N	\N	\N
3	7498	Dining & Entertaining 	Home Essentials 	0	65	t	\N	\N	\N	\N
62	68223	The Wedding Shop	Featured Shops	5	120	f	\N	\N	\N	\N
55	51662	Cleaning & Organization	More for the Home	0	65	f	\N	\N	\N	\N
35	24672	Slipcovers	Home Furnishings	5	1	t	\N	\N	\N	\N
59	75820	Kelly Ripa	Brands	4	65	f	\N	\N	\N	\N
36	23481	Vacuums & Steam Cleaners	More for the Home	7	65	t	\N	\N	\N	\N
5	7497	Kitchen 	Home Essentials 	2	65	t	\N	\N	\N	\N
2	7495	Bed & Bath	Home Essentials	0	1	t	\N	\N	\N	\N
40	102842	Brookstone	Special Shops	2	1	t	\N	\N	\N	\N
54	8380	Waterford	Home Brands	7	700	t	\N	\N	\N	\N
47	46375	Hotel Collection	Home Brands	3	700	t	\N	\N	\N	\N
42	7558	Calphalon	Our Best Home Brands	1	1	t	\N	\N	\N	\N
43	36896	Charter Club	Our Best Home Brands	2	1	t	\N	\N	\N	\N
44	7560	Cuisinart	Our Best Home Brands	3	1	t	\N	\N	\N	\N
49	29422	KitchenAid	Home Brands	4	700	t	\N	\N	\N	\N
51	42151	Martha Stewart Collection	Home Brands	6	700	t	\N	\N	\N	\N
48	12291	kate spade new york	Our Best Home Brands	7	1	t	\N	\N	\N	\N
34	35611	Rugs	Home Essentials 	5	65	t	\N	\N	\N	\N
52	28928	Mikasa	Our Best Home Brands	11	1	t	\N	\N	\N	\N
53	32568	Ralph Lauren	Our Best Home Brands	12	1	t	\N	\N	\N	\N
38	92645	Fine Linens	More for the Home	4	65	t	\N	\N	\N	\N
56	32567	Calvin Klein	\N	\N	1	f	\N	\N	\N	\N
57	75656	Home Design Studio	\N	\N	1	f	\N	\N	\N	\N
58	72686	Joy Mangano	\N	\N	1	f	\N	\N	\N	\N
60	70610	Shark	\N	\N	1	f	\N	\N	\N	\N
61	80788	See All Brands	\N	\N	1	f	\N	\N	\N	\N
63	34821	Outdoor Living	\N	\N	1	f	\N	\N	\N	\N
64	63274	Monogram Gift Shop	\N	\N	1	f	\N	\N	\N	\N
1	22672	HOME	\N	0	\N	t	\N	\N	Browse and shop Boutiqueken for a wide variety of Home Goods, Bed and Bath, Furniture & more. FREE shipping with $99 purchase.	\N
41	7557	All-Clad	Home Brands	0	700	t	\N	\N	\N	\N
66	7502	Bedding Collections	Bedding	0	65	t	\N	\N	\N	\N
67	26795	Bed in a Bag	Bedding	1	65	t	\N	\N	\N	\N
68	78458	Comforters	Bedding	2	65	t	\N	\N	\N	\N
69	37945	Decorative Pillows	Bedding	3	65	t	\N	\N	\N	\N
70	25045	Duvet Covers	Bedding	4	65	t	\N	\N	\N	\N
71	22748	Quilts & Bedspreads	Bedding	5	65	t	\N	\N	\N	\N
72	9915	Sheets	Bedding	6	65	t	\N	\N	\N	\N
73	13661	Kids' & Baby Bedding	Bedding	7	65	t	\N	\N	\N	\N
74	12398	Teen Bedding	Bedding	8	65	t	\N	\N	\N	\N
75	87043	Winter Bedding	Bedding	9	65	t	\N	\N	\N	\N
76	70527	All Bedding Basics	Bedding Basics	0	65	t	\N	\N	\N	\N
77	29405	Blankets & Throws	Bedding Basics	1	65	t	\N	\N	\N	\N
78	28898	Comforters: Down & Alternative	Bedding Basics	2	65	t	\N	\N	\N	\N
79	52096	Mattress & Pillow Protectors	Bedding Basics	3	65	t	\N	\N	\N	\N
80	40384	Mattress Pads & Toppers	Bedding Basics	4	65	t	\N	\N	\N	\N
81	29483	Memory Foam Bedding	Bedding Basics	5	65	t	\N	\N	\N	\N
82	28901	Pillows	Bedding Basics	6	65	t	\N	\N	\N	\N
83	51483	Bath Robes	Bath	0	65	t	\N	\N	\N	\N
84	8240	Bath Rugs & Bath Mats	Bath	1	65	t	\N	\N	\N	\N
85	22094	Bathroom Accessories	Bath	2	65	t	\N	\N	\N	\N
86	16853	Bath Towels	Bath	3	65	t	\N	\N	\N	\N
87	51717	Beach Towels	Bath	4	65	t	\N	\N	\N	\N
88	40554	Hair Care	Bath	5	65	t	\N	\N	\N	\N
89	56062	Kids' Bath	Bath	6	65	t	\N	\N	\N	\N
50	8377	Lenox	Home Brands	5	700	t	\N	\N	\N	\N
90	58936	Shower Curtains & Accessories	Bath	8	65	t	\N	\N	\N	\N
158	99842	The Pink Shop	Featured Shops	4	120	t	\N	\N	\N	\N
92	53629	Dinnerware	More for the Home	3	65	t	\N	\N	\N	\N
93	60354	Calvin Klein	Brands	0	65	t	\N	\N	\N	\N
94	7515	Charter Club	Brands	1	65	t	\N	\N	\N	\N
95	60314	Croscill	Brands	2	65	t	\N	\N	\N	\N
96	60364	Hotel Collection	Brands	3	65	t	\N	\N	\N	\N
97	14115	Lacoste	Brands	5	65	t	\N	\N	\N	\N
98	60363	Martha Stewart Collection	Brands	6	65	t	\N	\N	\N	\N
99	65577	Ralph Lauren	Brands	7	65	t	\N	\N	\N	\N
100	27828	Tommy Hilfiger	Brands	8	65	t	\N	\N	\N	\N
101	13759	Waterford	Brands	9	65	t	\N	\N	\N	\N
102	8237	All Bath	\N	\N	65	f	\N	\N	\N	\N
103	46529	Winter Bedding	\N	\N	65	f	\N	\N	\N	\N
104	60315	J Queen New York	\N	\N	65	f	\N	\N	\N	\N
105	58118	Tommy Bahama	\N	\N	65	f	\N	\N	\N	\N
106	57827	Bar III	\N	\N	65	f	\N	\N	\N	\N
107	58111	Barbara Barry	\N	\N	65	f	\N	\N	\N	\N
108	59474	Donna Karan	\N	\N	65	f	\N	\N	\N	\N
109	58114	Echo	\N	\N	65	f	\N	\N	\N	\N
110	61877	INC International Concepts	\N	\N	65	f	\N	\N	\N	\N
111	53264	Lenox	\N	\N	65	f	\N	\N	\N	\N
112	70902	Kate Spade	\N	\N	65	f	\N	\N	\N	\N
113	74670	Kelly Ripa	\N	\N	65	f	\N	\N	\N	\N
114	66247	Nautica	\N	\N	65	f	\N	\N	\N	\N
115	65421	Tracy Porter	\N	\N	65	f	\N	\N	\N	\N
116	59103	Trina Turk	\N	\N	65	f	\N	\N	\N	\N
117	71660	Under The Canopy	\N	\N	65	f	\N	\N	\N	\N
118	63560	See All Brands	\N	\N	65	f	\N	\N	\N	\N
119	35420	Bedroom Furniture	\N	\N	65	f	\N	\N	\N	\N
65	7495	BED & BATH	\N	1	\N	t	\N	\N	Shop Bedding, Linens and Bath at Boutiqueken. Buy Bedding at Boutiqueken and Get FREE SHIPPING with $99 purchase.	\N
156	71078	Dress Codes	Featured Shops	2	120	t	\N	\N	\N	\N
91	70809	Sleep Solutions	Restore	1	454	t	\N	\N	\N	\N
122	55429	Blazers	Women's Clothing	1	120	t	\N	\N	\N	\N
123	225	Bras, Panties & Lingerie	Women's Clothing	2	120	t	\N	\N	\N	\N
124	269	Coats	Women's Clothing	3	120	t	\N	\N	\N	\N
125	5449	Dresses	Women's Clothing	4	120	t	\N	\N	\N	\N
126	120	Jackets	Women's Clothing	5	120	t	\N	\N	\N	\N
127	3111	Jeans	Women's Clothing	6	120	t	\N	\N	\N	\N
128	50684	Jumpsuits & Rompers	Women's Clothing	7	120	t	\N	\N	\N	\N
129	46905	Leggings	Women's Clothing	8	120	t	\N	\N	\N	\N
164	6218	Nike	Women's Brands	5	120	t	\N	\N	\N	\N
131	59737	Pajamas & Robes	Women's Clothing	10	120	t	\N	\N	\N	\N
132	157	Pants & Capris	Women's Clothing	11	120	t	\N	\N	\N	\N
133	5344	Shorts	Women's Clothing	12	120	t	\N	\N	\N	\N
134	131	Skirts	Women's Clothing	13	120	t	\N	\N	\N	\N
135	67592	Suits & Suit Separates	Women's Clothing	14	120	t	\N	\N	\N	\N
136	260	Sweaters	Women's Clothing	15	120	t	\N	\N	\N	\N
137	8699	Swimwear	Women's Clothing	16	120	t	\N	\N	\N	\N
157	96242	Fall 2016 Must Haves	Featured Shops	3	120	t	\N	\N	\N	\N
139	255	Tops	Women's Clothing	18	120	t	\N	\N	\N	\N
140	72589	Vests	Women's Clothing	19	120	t	\N	\N	\N	\N
141	39096	Wear to Work	Women's Clothing	20	120	t	\N	\N	\N	\N
142	34049	Coats	Plus Sizes	0	120	t	\N	\N	\N	\N
143	37038	Dresses	Plus Sizes	1	120	t	\N	\N	\N	\N
144	40227	Sweaters	Plus Sizes	2	120	t	\N	\N	\N	\N
145	34048	Tops	Plus Sizes	3	120	t	\N	\N	\N	\N
368	57576	Celebrity Pink	\N	\N	325	f	\N	\N	\N	\N
147	32147	All Plus Sizes	Plus Sizes	5	120	t	\N	\N	\N	\N
148	57535	Coats	Petites	0	120	t	\N	\N	\N	\N
149	55596	Dresses	Petites	1	120	t	\N	\N	\N	\N
150	55607	Pants	Petites	2	120	t	\N	\N	\N	\N
151	55613	Tops	Petites	3	120	t	\N	\N	\N	\N
152	18579	All Petites	Petites	4	120	t	\N	\N	\N	\N
138	40546	Tights, Socks, & Hosiery	Accessories	4	580	t	\N	\N	\N	\N
153	262	Cashmere Shop	Featured Shops	0	120	t	\N	\N	\N	\N
154	97042	Cold Weather Style	Featured Shops	1	120	t	\N	\N	\N	\N
155	75119	Denim Destination	Featured Shops	2	120	t	\N	\N	\N	\N
146	32918	All Trendy Plus Sizes	Trendy Plus Sizes	6	325	t	\N	\N	\N	\N
130	66718	All Maternity	Maternity	2	120	t	\N	\N	\N	\N
159	68357	Adrianna Papell	Women's Brands	0	120	t	\N	\N	\N	\N
160	13156	Calvin Klein	Women's Brands	1	120	t	\N	\N	\N	\N
161	3485	Lauren Ralph Lauren	Women's Brands	2	120	t	\N	\N	\N	\N
162	30760	Levi's	Women's Brands	3	120	t	\N	\N	\N	\N
163	14728	MICHAEL Michael Kors	Women's Brands	4	120	t	\N	\N	\N	\N
165	96742	Sports Fan Shop by Lids	Women's Brands	6	120	t	\N	\N	\N	\N
166	69211	The Fur Vault	Women's Brands	7	120	t	\N	\N	\N	\N
167	31074	The North Face	Women's Brands	8	120	t	\N	\N	\N	\N
168	37281	Tommy Hilfiger	Women's Brands	9	120	t	\N	\N	\N	\N
169	64869	Under Armour	Women's Brands	10	120	t	\N	\N	\N	\N
170	59981	Vince Camuto	Women's Brands	11	120	t	\N	\N	\N	\N
171	63539	See All Brands	Women's Brands	12	120	t	\N	\N	\N	\N
172	17994	Alfani	Only at Macy's	0	120	t	\N	\N	\N	\N
173	11427	Charter Club	Only at Macy's	1	120	t	\N	\N	\N	\N
174	15131	Ideology	Only at Macy's	2	120	t	\N	\N	\N	\N
175	3481	INC International Concepts	Only at Macy's	3	120	t	\N	\N	\N	\N
176	50449	JM Collection	Only at Macy's	4	120	t	\N	\N	\N	\N
177	35784	Karen Scott	Only at Macy's	5	120	t	\N	\N	\N	\N
178	29630	Style & Co.	Only at Macy's	6	120	t	\N	\N	\N	\N
179	69907	Thalia Sodi	Only at Macy's	7	120	t	\N	\N	\N	\N
369	74667	In Awe of You by AwesomenessTV	\N	\N	325	f	\N	\N	\N	\N
32	39267	Lighting & Lamps	More for the Home	6	65	t	\N	\N	\N	\N
33	23487	Personal Care	Bath	7	65	t	\N	\N	\N	\N
180	54641	Bar III	Contemporary & Designer Brands	0	120	t	\N	\N	\N	\N
181	57573	Denim & Supply Ralph Lauren	Contemporary & Designer Brands	1	120	t	\N	\N	\N	\N
182	64883	Eileen Fisher	Contemporary & Designer Brands	2	120	t	\N	\N	\N	\N
183	44498	Free People	Contemporary & Designer Brands	3	120	t	\N	\N	\N	\N
191	29440	All Accessories	Accessories	6	580	t	\N	\N	\N	\N
185	16901	Lucky Brand	Contemporary & Designer Brands	5	120	t	\N	\N	\N	\N
186	63787	Maison Jules	Contemporary & Designer Brands	6	120	t	\N	\N	\N	\N
187	69044	Polo Ralph Lauren	Contemporary & Designer Brands	7	120	t	\N	\N	\N	\N
188	49902	RACHEL Rachel Roy	Contemporary & Designer Brands	8	120	t	\N	\N	\N	\N
189	55213	Shop Contemporary	Contemporary & Designer Brands	9	120	t	\N	\N	\N	\N
190	85842	Shop Designer	Contemporary & Designer Brands	10	120	t	\N	\N	\N	\N
245	55642	Sneakers & Athletic	Men's Shoes	4	535	t	\N	\N	\N	\N
254	67609	Fitbit	Active Brands	2	221	t	\N	\N	\N	\N
193	669	Beauty	Shoes, Handbags, & More	2	120	t	\N	\N	\N	\N
194	26846	Handbags	Shoes, Handbags, & More	3	120	t	\N	\N	\N	\N
195	544	Jewelry & Watches	Shoes, Handbags, & More	4	120	t	\N	\N	\N	\N
196	13247	Shoes	Shoes, Handbags, & More	5	120	t	\N	\N	\N	\N
370	30760	Levi's	\N	\N	325	f	\N	\N	\N	\N
198	16904	Juniors	\N	\N	120	f	\N	\N	\N	\N
199	71353	32 Degrees	\N	\N	120	f	\N	\N	\N	\N
200	67663	American Living	\N	\N	120	f	\N	\N	\N	\N
201	18413	Anne Klein	\N	\N	120	f	\N	\N	\N	\N
202	42982	BCBGMAXAZRIA	\N	\N	120	f	\N	\N	\N	\N
203	83142	Catherine Malandrino	\N	\N	120	f	\N	\N	\N	\N
204	69934	Ivanka Trump	\N	\N	120	f	\N	\N	\N	\N
205	46356	Jones New York	\N	\N	120	f	\N	\N	\N	\N
206	68392	Karen Kane	\N	\N	120	f	\N	\N	\N	\N
207	79913	Lee Platinum	\N	\N	120	f	\N	\N	\N	\N
208	69131	Nautica	\N	\N	120	f	\N	\N	\N	\N
209	69589	NY Collection	\N	\N	120	f	\N	\N	\N	\N
210	39333	NYDJ	\N	\N	120	f	\N	\N	\N	\N
211	65262	Tahari by ASL	\N	\N	120	f	\N	\N	\N	\N
212	10775	Adidas	\N	\N	120	f	\N	\N	\N	\N
213	80418	Alfred Dunner	\N	\N	120	f	\N	\N	\N	\N
214	71392	B Michael	\N	\N	120	f	\N	\N	\N	\N
215	71115	CeCe	\N	\N	120	f	\N	\N	\N	\N
216	100751	ECI	\N	\N	120	f	\N	\N	\N	\N
217	75816	Fame and Partners	\N	\N	120	f	\N	\N	\N	\N
218	71322	G.H. Bass & Co.	\N	\N	120	f	\N	\N	\N	\N
219	79644	Shop Hispanic Heritage Month	\N	\N	120	f	\N	\N	\N	\N
220	58128	Sunglasses	\N	\N	120	f	\N	\N	\N	\N
120	118	WOMEN	\N	2	\N	t	\N	\N	Shop for Women's Clothing Online at Boutiqueken for the Latest Designer Brands & Fashion Trends. FREE SHIPPING AVAILABLE!	\N
243	70405	Dress Shoes	Men's Shoes	2	535	t	\N	\N	\N	\N
241	59851	Casual Shoes	Men's Shoes	1	535	t	\N	\N	\N	\N
223	16499	Blazers, Sport Coats & Vests	Men's Clothing	1	221	t	\N	\N	\N	\N
224	20627	Casual Button-Down Shirts	Men's Clothing	2	221	t	\N	\N	\N	\N
225	3763	Coats & Jackets	Men's Clothing	3	221	t	\N	\N	\N	\N
226	20635	Dress Shirts	Men's Clothing	4	221	t	\N	\N	\N	\N
227	60886	Golf Shop	Men's Clothing	5	221	t	\N	\N	\N	\N
228	60451	Guys Shop	Men's Clothing	6	221	t	\N	\N	\N	\N
229	25995	Hoodies & Sweatshirts	Men's Clothing	7	221	t	\N	\N	\N	\N
230	11221	Jeans	Men's Clothing	8	221	t	\N	\N	\N	\N
231	16295	Pajamas, Lounge & Sleepwear	Men's Clothing	9	221	t	\N	\N	\N	\N
232	89	Pants	Men's Clothing	10	221	t	\N	\N	\N	\N
233	20640	Polos	Men's Clothing	11	221	t	\N	\N	\N	\N
234	17788	Suits & Suit Separates	Men's Clothing	12	221	t	\N	\N	\N	\N
235	3310	Shorts	Men's Clothing	13	221	t	\N	\N	\N	\N
236	4286	Sweaters	Men's Clothing	14	221	t	\N	\N	\N	\N
237	30423	T-Shirts	Men's Clothing	15	221	t	\N	\N	\N	\N
238	68524	Tuxedos & Formalwear	Men's Clothing	16	221	t	\N	\N	\N	\N
239	57	Underwear	Men's Clothing	17	221	t	\N	\N	\N	\N
240	55637	Boots 	Men's Shoes	0	535	t	\N	\N	\N	\N
242	55639	Designer Shoes	Men's Shoes	2	221	t	\N	\N	\N	\N
197	28295	All Sunglasses	Sunglasses and Eyewear	3	580	t	\N	\N	\N	\N
244	63266	Finish Line Athletic Shoes	Men's Shoes	4	221	t	\N	\N	\N	\N
184	34380	GUESS?	Juniors' Brands	1	325	t	\N	\N	\N	\N
246	65	All Men's Shoes	Men's Shoes	6	221	t	\N	\N	\N	\N
247	45758	All Big & Tall	Big & Tall Shop	3	221	t	\N	\N	\N	\N
248	99042	Halloween Shop	What's Hot	1	221	t	\N	\N	\N	\N
249	80616	New Arrivals	What's Hot	2	221	t	\N	\N	\N	\N
250	99744	Outdoor Shop	What's Hot	3	221	t	\N	\N	\N	\N
251	80618	Streetwear	What's Hot	4	221	t	\N	\N	\N	\N
252	80617	Trending Now	What's Hot	5	221	t	\N	\N	\N	\N
253	60285	adidas	Active Brands	0	221	t	\N	\N	\N	\N
262	30088	Men's Cologne & Grooming	Fragrance	1	478	t	\N	\N	\N	\N
255	58432	Nike	Active Brands	3	221	t	\N	\N	\N	\N
256	64942	Polo Sport	Featured Brands	9	454	t	\N	\N	\N	\N
257	18253	The North Face	Active Brands	6	221	t	\N	\N	\N	\N
258	64998	Under Armour	Active Brands	7	221	t	\N	\N	\N	\N
259	47665	Accessories & Wallets	Accessories	0	221	t	\N	\N	\N	\N
260	45016	Bags & Backpacks	Accessories	1	221	t	\N	\N	\N	\N
261	47673	Belts & Suspenders	Accessories	2	221	t	\N	\N	\N	\N
268	57386	All Men's Watches	Men's Watches	3	661	t	\N	\N	\N	\N
263	49167	Gifts, Gadgets & Audio	Accessories	4	221	t	\N	\N	\N	\N
264	47657	Hats, Gloves & Scarves	Accessories	5	221	t	\N	\N	\N	\N
265	18245	Socks	Accessories	6	221	t	\N	\N	\N	\N
266	58262	Sunglasses by Sunglass Hut	Accessories	7	221	t	\N	\N	\N	\N
267	53239	Ties & Pocket Squares	Accessories	8	221	t	\N	\N	\N	\N
269	29415	Alfani	Men's Brands	0	221	t	\N	\N	\N	\N
371	104553	One Hart	\N	\N	325	f	\N	\N	\N	\N
372	17142	Rampage	\N	\N	325	f	\N	\N	\N	\N
270	53433	American Rag	Men's Brands	1	221	t	\N	\N	\N	\N
271	28169	Calvin Klein	Men's Brands	2	221	t	\N	\N	\N	\N
272	57979	Denim & Supply Ralph Lauren	Men's Brands	3	221	t	\N	\N	\N	\N
273	43145	Dockers	Men's Brands	4	221	t	\N	\N	\N	\N
274	31776	INC International Concepts	Men's Brands	5	221	t	\N	\N	\N	\N
275	43141	Levi's	Men's Brands	6	221	t	\N	\N	\N	\N
276	67632	Michael Kors	Men's Brands	7	221	t	\N	\N	\N	\N
277	46108	Nautica	Men's Brands	8	221	t	\N	\N	\N	\N
278	3304	Polo Ralph Lauren	Men's Brands	9	221	t	\N	\N	\N	\N
279	68293	Ryan Seacrest Distinction	Men's Brands	10	221	t	\N	\N	\N	\N
280	11345	Sean John	Men's Brands	11	221	t	\N	\N	\N	\N
281	2519	Tommy Hilfiger	Men's Brands	12	221	t	\N	\N	\N	\N
282	63581	All Mens Brands	Men's Brands	13	221	t	\N	\N	\N	\N
283	75897	Wear to Work	Featured Shops	1	221	t	\N	\N	\N	\N
284	20626	Shirts	\N	\N	221	f	\N	\N	\N	\N
285	3291	Swimwear	\N	\N	221	f	\N	\N	\N	\N
287	55641	Slippers	\N	\N	221	f	\N	\N	\N	\N
289	58082	7 for All Mankind	\N	\N	221	f	\N	\N	\N	\N
290	86842	Armani Exchange	\N	\N	221	f	\N	\N	\N	\N
291	20392	Armani Jeans	\N	\N	221	f	\N	\N	\N	\N
292	58083	Bar III	\N	\N	221	f	\N	\N	\N	\N
293	29884	Buffalo David Bitton	\N	\N	221	f	\N	\N	\N	\N
294	29414	Club Room	\N	\N	221	f	\N	\N	\N	\N
295	43206	DKNY	\N	\N	221	f	\N	\N	\N	\N
296	55271	Greg Norman	\N	\N	221	f	\N	\N	\N	\N
297	63725	G-Star	\N	\N	221	f	\N	\N	\N	\N
298	29889	GUESS	\N	\N	221	f	\N	\N	\N	\N
299	59234	Haggar	\N	\N	221	f	\N	\N	\N	\N
300	58084	Hugo Boss	\N	\N	221	f	\N	\N	\N	\N
301	44356	Izod	\N	\N	221	f	\N	\N	\N	\N
302	54272	Jockey	\N	\N	221	f	\N	\N	\N	\N
303	52843	Kenneth Cole	\N	\N	221	f	\N	\N	\N	\N
304	36943	Lacoste	\N	\N	221	f	\N	\N	\N	\N
305	38348	LRG	\N	\N	221	f	\N	\N	\N	\N
306	29883	Lucky Brand Jeans	\N	\N	221	f	\N	\N	\N	\N
307	26399	Perry Ellis	\N	\N	221	f	\N	\N	\N	\N
308	58477	Puma	\N	\N	221	f	\N	\N	\N	\N
309	11882	Quiksilver	\N	\N	221	f	\N	\N	\N	\N
310	52099	Tallia	\N	\N	221	f	\N	\N	\N	\N
311	11046	Tasso Elba	\N	\N	221	f	\N	\N	\N	\N
312	3153	Timberland	\N	\N	221	f	\N	\N	\N	\N
313	21707	Tommy Bahama	\N	\N	221	f	\N	\N	\N	\N
314	102142	Reebok	\N	\N	221	f	\N	\N	\N	\N
315	67044	Shaquille O'Neal Collection	\N	\N	221	f	\N	\N	\N	\N
316	65292	Vince Camuto	\N	\N	221	f	\N	\N	\N	\N
317	80421	WHT SPACE	\N	\N	221	f	\N	\N	\N	\N
318	96045	William Rast	\N	\N	221	f	\N	\N	\N	\N
319	62039	Weatherproof	\N	\N	221	f	\N	\N	\N	\N
320	61971	Designer Shop	\N	\N	221	f	\N	\N	\N	\N
321	79643	Shop Hispanic Heritage Month	\N	\N	221	f	\N	\N	\N	\N
323	68223	The Wedding Shop	\N	\N	221	f	\N	\N	\N	\N
324	47707	Tuxedo Rental Shop	\N	\N	221	f	\N	\N	\N	\N
221	1	MEN	\N	3	\N	t	\N	\N	Shop for Men's Clothing Online at Boutiqueken to Find the Latest Designer Brands & Fashion Trends. FREE SHIPPING AVAILABLE!	\N
288	43877	Men's Jewelry & Accessories	Shop Categories	1	626	f	\N	\N	\N	\N
326	41973	Activewear	Juniors' Clothing	0	325	t	\N	\N	\N	\N
327	70950	Basic Essentials	Juniors' Clothing	1	325	t	\N	\N	\N	\N
328	56273	Bras, Panties & Lingerie	Juniors' Clothing	2	325	t	\N	\N	\N	\N
329	21115	Coats	Juniors' Clothing	3	325	t	\N	\N	\N	\N
330	18109	Dresses	Juniors' Clothing	4	325	t	\N	\N	\N	\N
331	75819	Graphic Clothing	Juniors' Clothing	5	325	t	\N	\N	\N	\N
332	35786	Jackets & Vests	Juniors' Clothing	6	325	t	\N	\N	\N	\N
333	28754	Jeans	Juniors' Clothing	7	325	t	\N	\N	\N	\N
334	17053	Jumpsuits & Rompers	Juniors' Clothing	8	325	t	\N	\N	\N	\N
335	21561	Leggings & Pants	Juniors' Clothing	9	325	t	\N	\N	\N	\N
336	58666	Pajamas & Robes	Juniors' Clothing	10	325	t	\N	\N	\N	\N
337	28589	Shorts	Juniors' Clothing	11	325	t	\N	\N	\N	\N
338	28379	Skirts	Juniors' Clothing	12	325	t	\N	\N	\N	\N
339	20853	Sweaters	Juniors' Clothing	13	325	t	\N	\N	\N	\N
340	57597	Swimwear	Juniors' Clothing	14	325	t	\N	\N	\N	\N
341	17043	Tops	Juniors' Clothing	15	325	t	\N	\N	\N	\N
342	28001	Wear to Work	Juniors' Clothing	16	325	t	\N	\N	\N	\N
343	34051	Activewear	Trendy Plus Sizes	0	325	t	\N	\N	\N	\N
344	69557	Under $15	Shop By Price	0	325	t	\N	\N	\N	\N
345	69971	Under $20	Shop By Price	1	325	t	\N	\N	\N	\N
346	69558	Under $25	Shop By Price	2	325	t	\N	\N	\N	\N
347	69654	Under $40	Shop By Price	3	325	t	\N	\N	\N	\N
348	105542	Mock Neck	Must Haves	0	325	t	\N	\N	\N	\N
349	98742	Style Statement: Patches	Must Haves	1	325	t	\N	\N	\N	\N
350	104546	Wide-Leg Pants	Must Haves	2	325	t	\N	\N	\N	\N
351	95642	Fall Trend Report	Featured Shops	0	325	t	\N	\N	\N	\N
352	102242	Halloween	Featured Shops	1	325	t	\N	\N	\N	\N
353	102743	Homecoming	Featured Shops	2	325	t	\N	\N	\N	\N
354	70380	Surf Shop	Featured Shops	3	325	t	\N	\N	\N	\N
355	102244	Trolls Shop	Featured Shops	4	325	t	\N	\N	\N	\N
356	102243	Va-Va-Velvet	Featured Shops	5	325	t	\N	\N	\N	\N
357	104551	Whimsy Shop	Featured Shops	6	325	t	\N	\N	\N	\N
358	46810	American Rag	Juniors' Brands	0	325	t	\N	\N	\N	\N
359	53642	Jessica Simpson	Juniors' Brands	2	325	t	\N	\N	\N	\N
360	51951	Material Girl	Juniors' Brands	3	325	t	\N	\N	\N	\N
361	38661	XOXO	Juniors' Brands	5	325	t	\N	\N	\N	\N
362	63573	All Juniors' Brands	Juniors' Brands	6	325	t	\N	\N	\N	\N
363	53610	Handbags & Accessories 	Shoes, Handbags & More	1	325	t	\N	\N	\N	\N
286	55640	Sandals & Flip-Flops 	Men's Shoes	3	535	f	\N	\N	\N	\N
366	60983	All Juniors' Apparel	\N	\N	325	f	\N	\N	\N	\N
367	53640	BCX	\N	\N	325	f	\N	\N	\N	\N
365	57568	Junior's 	Featured Shops	2	535	t	\N	\N	\N	\N
364	70429	The Impulse Shop	Impulse Brands	4	478	t	\N	\N	\N	\N
373	63017	Marilyn Monroe	\N	\N	325	f	\N	\N	\N	\N
374	54641	Bar III	\N	\N	325	f	\N	\N	\N	\N
375	81022	Lisa Frank	\N	\N	325	f	\N	\N	\N	\N
376	70695	O'Neill	\N	\N	325	f	\N	\N	\N	\N
377	70694	Volcom	\N	\N	325	f	\N	\N	\N	\N
378	57590	Angie	\N	\N	325	f	\N	\N	\N	\N
379	57593	Be Bop	\N	\N	325	f	\N	\N	\N	\N
380	57591	Dollhouse	\N	\N	325	f	\N	\N	\N	\N
381	56317	Else Jeans	\N	\N	325	f	\N	\N	\N	\N
382	57581	Eyeshadow	\N	\N	325	f	\N	\N	\N	\N
383	54637	Miss Me	\N	\N	325	f	\N	\N	\N	\N
384	57582	Planet Gold	\N	\N	325	f	\N	\N	\N	\N
385	28009	Roxy	\N	\N	325	f	\N	\N	\N	\N
386	55213	Contemporary Clothing	\N	\N	325	f	\N	\N	\N	\N
389	54525	Handbags & Accessories	\N	\N	325	f	\N	\N	\N	\N
390	58128	Sunglasses	\N	\N	325	f	\N	\N	\N	\N
325	16904	JUNIORS	\N	4	\N	t	\N	\N	Buy New Juniors Clothing at Boutiqueken. Shop the Latest Junior Apparel Online at Boutiqueken. FREE SHIPPING AVAILABLE!	\N
392	6581	Toddler Girls (2T-5T)	Girls	0	391	t	\N	\N	\N	\N
393	62970	Girls 2-6X	Girls	1	391	t	\N	\N	\N	\N
394	25324	Girls 7-16	Girls	2	391	t	\N	\N	\N	\N
395	61998	All Girls	Girls' Clothing	12	391	t	\N	\N	\N	\N
396	27058	Toddler Boys (2T-5T)	Boys	0	391	t	\N	\N	\N	\N
397	62971	Boys 2-7	Boys	1	391	t	\N	\N	\N	\N
398	25325	Boys 8-20	Boys	2	391	t	\N	\N	\N	\N
399	61999	All Boys	Boys' Clothing	12	391	t	\N	\N	\N	\N
400	48692	Baby Girl (0-24 months)	Baby	0	391	t	\N	\N	\N	\N
401	48693	Baby Boy (0-24 months)	Baby	1	391	t	\N	\N	\N	\N
402	60045	Baby Shower Gifts	Baby	2	391	t	\N	\N	\N	\N
403	58376	Baby Strollers & Gear	Baby	3	391	t	\N	\N	\N	\N
404	59563	Newborn Shop	Baby	4	391	t	\N	\N	\N	\N
405	64768	Dresses & Dresswear	Baby Clothing	4	391	t	\N	\N	\N	\N
406	64761	All Baby	Baby Clothing	11	391	t	\N	\N	\N	\N
407	16342	Carter's	Kids' & baby brands	0	391	t	\N	\N	\N	\N
408	63270	Finish Line Athletic Shoes	Kids' & baby brands	1	391	t	\N	\N	\N	\N
409	45095	Levi's	Kids' & baby brands	2	391	t	\N	\N	\N	\N
410	62430	Nike	Kids' & baby brands	3	391	t	\N	\N	\N	\N
411	14355	Ralph Lauren Childrenswear	Kids' & baby brands	4	391	t	\N	\N	\N	\N
412	40660	The North Face	Kids' & baby brands	5	391	t	\N	\N	\N	\N
413	63574	All Brands	Kids' & baby brands	6	391	t	\N	\N	\N	\N
414	63009	Accessories & Backpacks	More For Kids & Baby	0	391	t	\N	\N	\N	\N
415	65147	All Characters	More For Kids & Baby	1	391	t	\N	\N	\N	\N
416	61141	Halloween Shop	More For Kids & Baby	2	391	t	\N	\N	\N	\N
417	26073	Holiday Shop	More For Kids & Baby	3	391	t	\N	\N	\N	\N
418	22911	Toys & Games	More For Kids & Baby	6	391	t	\N	\N	\N	\N
420	63010	Girls' Coats & Jackets	\N	\N	391	f	\N	\N	\N	\N
421	31460	Girls' Dresses	\N	\N	391	f	\N	\N	\N	\N
422	48561	Girls' Shoes	\N	\N	391	f	\N	\N	\N	\N
423	63016	Boys' Suits & Dress Shirts	\N	\N	391	f	\N	\N	\N	\N
424	63008	Jeans	\N	\N	391	f	\N	\N	\N	\N
425	63011	Leggings & Pants	\N	\N	391	f	\N	\N	\N	\N
426	65451	Pajamas	\N	\N	391	f	\N	\N	\N	\N
427	30057	School Uniforms	\N	\N	391	f	\N	\N	\N	\N
428	63013	Sets & Outfits	\N	\N	391	f	\N	\N	\N	\N
429	63014	Shirts & Tees	\N	\N	391	f	\N	\N	\N	\N
430	63015	Shorts	\N	\N	391	f	\N	\N	\N	\N
431	31462	Skirts	\N	\N	391	f	\N	\N	\N	\N
432	65543	Sweaters	\N	\N	391	f	\N	\N	\N	\N
433	55163	Swimwear	\N	\N	391	f	\N	\N	\N	\N
434	65582	Underwear & Socks	\N	\N	391	f	\N	\N	\N	\N
435	71187	Calvin Klein	\N	\N	391	f	\N	\N	\N	\N
436	60852	Epic Threads	\N	\N	391	f	\N	\N	\N	\N
437	32298	First Impressions	\N	\N	391	f	\N	\N	\N	\N
438	45097	Tommy Hilfiger	\N	\N	391	f	\N	\N	\N	\N
439	63114	Under Armour	\N	\N	391	f	\N	\N	\N	\N
440	69692	Frozen	\N	\N	391	f	\N	\N	\N	\N
441	66707	Graco	\N	\N	391	f	\N	\N	\N	\N
442	33448	GUESS	\N	\N	391	f	\N	\N	\N	\N
443	64809	Little Me	\N	\N	391	f	\N	\N	\N	\N
444	60292	adidas	\N	\N	391	f	\N	\N	\N	\N
445	48931	Hello Kitty	\N	\N	391	f	\N	\N	\N	\N
446	63100	Melissa and Doug	\N	\N	391	f	\N	\N	\N	\N
447	70470	Nautica	\N	\N	391	f	\N	\N	\N	\N
448	59230	Puma	\N	\N	391	f	\N	\N	\N	\N
449	81842	Mix & Match	\N	\N	391	f	\N	\N	\N	\N
450	23484	Kids' & Baby Room	\N	\N	391	f	\N	\N	\N	\N
452	70805	Kids' Luggage and Backpacks	\N	\N	391	f	\N	\N	\N	\N
391	5991	KIDS	\N	5	\N	t	\N	\N	Buy New Kids Clothing at Boutiqueken. Shop the Latest Childrens Youth Clothes Online at Boutiqueken. FREE SHIPPING AVAILABLE!	\N
470	26499	Sneakers	Women's Shoes	9	535	f	\N	\N	\N	\N
419	61228	Shop all Kids' Active	Kids' Activewear	4	454	f	\N	\N	\N	\N
456	70934	Shop All Tech	Tech Zone	2	454	t	\N	\N	\N	\N
457	46710	Blenders	Nourish	0	454	t	\N	\N	\N	\N
458	7583	Juicers	Nourish	3	454	t	\N	\N	\N	\N
459	65825	Air Purifiers & Humidifiers	Restore	0	454	t	\N	\N	\N	\N
460	74790	Sport Sunglasses	Restore	3	454	t	\N	\N	\N	\N
461	61581	Sunscreen & Lotions	Restore	4	454	t	\N	\N	\N	\N
222	3296	Shop all Men's Active	Men's Activewear	3	454	t	\N	\N	\N	\N
462	79488	Samsung	Featured Brands	11	454	t	\N	\N	\N	\N
322	65701	Sports Fan Shop by Lids	Featured Brands	12	454	f	\N	\N	\N	\N
463	67609	Fitbit	\N	\N	454	f	\N	\N	\N	\N
464	60886	Golf Shop	\N	\N	454	f	\N	\N	\N	\N
465	55642	Sneakers & Athletic Shoes	\N	\N	454	f	\N	\N	\N	\N
466	3291	Swimwear	\N	\N	454	f	\N	\N	\N	\N
467	61361	Jackets & Hoodies	\N	\N	454	f	\N	\N	\N	\N
468	53958	Pants & Leggings	\N	\N	454	f	\N	\N	\N	\N
469	61433	Shorts	\N	\N	454	f	\N	\N	\N	\N
388	55352	All Fashion Jewelry	Fashion Jewelry	4	626	f	\N	\N	\N	\N
455	76406	Fitbit	Smart Watches	1	661	t	\N	\N	\N	\N
121	29891	Shop all Women's Active	Women's Activewear	3	454	t	\N	\N	\N	\N
451	33222	Kids' Jewelry & Watches	Shop Categories	0	626	f	\N	\N	\N	\N
192	101043	Apple Watch	Featured Brands	1	700	t	\N	\N	\N	\N
471	54019	Sports Bras	\N	\N	454	f	\N	\N	\N	\N
472	53727	Tops & T-Shirts	\N	\N	454	f	\N	\N	\N	\N
473	53874	Yoga	\N	\N	454	f	\N	\N	\N	\N
474	41973	Juniors' Active	\N	\N	454	f	\N	\N	\N	\N
475	34051	Plus Size Active	\N	\N	454	f	\N	\N	\N	\N
476	23487	Massagers	\N	\N	454	f	\N	\N	\N	\N
477	16853	Towels	\N	\N	454	f	\N	\N	\N	\N
454	70868	ACTIVE	\N	6	\N	t	\N	\N	Shop the latest activewear collection at Boutiqueken. Find activewear for women, men & kids from top brands with the hottest styles. FREE SHIPPING AVAILABLE!	\N
478	669	BEAUTY	\N	7	\N	t	\N	\N	\N	\N
479	30520	Eyes	Makeup	0	478	t	\N	\N	\N	\N
480	30521	Face	Makeup	1	478	t	\N	\N	\N	\N
481	30522	Lips	Makeup	2	478	t	\N	\N	\N	\N
482	79489	Nails	Makeup	3	478	t	\N	\N	\N	\N
483	97142	Palettes	Makeup	4	478	t	\N	\N	\N	\N
484	56285	Brushes & Applicators	Makeup	5	478	t	\N	\N	\N	\N
387	30077	All Makeup	Makeup	6	478	f	\N	\N	\N	\N
485	30582	Cleansers	Skin Care	0	478	t	\N	\N	\N	\N
486	30585	Moisturizers	Skin Care	1	478	t	\N	\N	\N	\N
487	30558	Eye Care	Skin Care	2	478	t	\N	\N	\N	\N
488	50363	Serums	Skin Care	3	478	t	\N	\N	\N	\N
489	30078	All Skin Care	Skin Care	4	478	t	\N	\N	\N	\N
490	58499	Bath & Body	 Additional beauty	0	478	t	\N	\N	\N	\N
491	60600	Hair Care	 Additional beauty	1	478	t	\N	\N	\N	\N
492	56234	Tools & Brushes	 Additional beauty	2	478	t	\N	\N	\N	\N
493	68594	Travel Size	 Additional beauty	3	478	t	\N	\N	\N	\N
526	31616	BURBERRY	Beauty Brands	2	700	f	\N	\N	\N	\N
529	66024	Tom Ford	\N	\N	478	f	\N	\N	\N	\N
498	33607	Estee Lauder	Beauty Brands	10	700	t	\N	\N	\N	\N
523	51752	Clarisonic	Beauty Brands	5	700	f	\N	\N	\N	\N
528	31711	GUCCI	Beauty Brands	12	700	f	\N	\N	\N	\N
502	25677	Shiseido	Beauty Brands	17	700	t	\N	\N	\N	\N
507	55573	Urban Decay	Beauty Brands	18	700	t	\N	\N	\N	\N
494	46216	Bobbi Brown	Beauty Brands	1	700	t	\N	\N	\N	\N
513	31628	DOLCE & GABBANA	Beauty Brands	8	700	t	\N	\N	\N	\N
503	63556	All Beauty Brands	Beauty Brands	9	478	t	\N	\N	\N	\N
504	65894	Anastasia Beverly Hills	Impulse Brands	0	478	t	\N	\N	\N	\N
512	5204	Dior	Beauty Brands	7	700	t	\N	\N	\N	\N
506	15099	philosophy	Impulse Brands	2	478	t	\N	\N	\N	\N
497	47099	Clarins	Beauty Brands	4	700	t	\N	\N	\N	\N
508	85742	Gift Sets	Fragrance	0	478	t	\N	\N	\N	\N
509	30087	Women's Perfume	Fragrance	2	478	t	\N	\N	\N	\N
510	76382	Rollerballs	Fragrance	3	478	t	\N	\N	\N	\N
511	31619	Calvin Klein	Fragrance Brands	0	478	t	\N	\N	\N	\N
553	55760	MICHAEL Michael Kors	Shoe Brands	4	700	t	\N	\N	\N	\N
537	25122	All Boots	Boot Styles	7	535	t	\N	\N	\N	\N
500	45678	MAC	Beauty Brands	14	700	t	\N	\N	\N	\N
514	30150	Michael Kors	Fragrance Brands	4	478	t	\N	\N	\N	\N
515	31743	Prada	Fragrance Brands	5	478	t	\N	\N	\N	\N
516	31746	Ralph Lauren	Fragrance Brands	6	478	t	\N	\N	\N	\N
517	37621	Versace	Fragrance Brands	7	478	t	\N	\N	\N	\N
518	48991	Viktor & Rolf	Fragrance Brands	8	478	t	\N	\N	\N	\N
519	31759	Yves Saint Laurent	Fragrance Brands	9	478	t	\N	\N	\N	\N
520	55537	Gifts & Value Sets	Special Offers	0	478	t	\N	\N	\N	\N
521	58476	Gifts with Purchase	Special Offers	1	478	t	\N	\N	\N	\N
522	72195	Only at Macy's	Special Offers	2	478	t	\N	\N	\N	\N
524	75901	m-61	\N	\N	478	f	\N	\N	\N	\N
525	82442	All Impulse Brands	\N	\N	478	f	\N	\N	\N	\N
527	53005	COACH	\N	\N	478	f	\N	\N	\N	\N
530	65814	All Cologne Brands	\N	\N	478	f	\N	\N	\N	\N
531	65813	All Perfume Brands	\N	\N	478	f	\N	\N	\N	\N
532	99842	The Pink Shop	\N	\N	478	f	\N	\N	\N	\N
533	103752	Now Trending at Macy's	\N	\N	478	f	\N	\N	\N	\N
534	65384	What's New	\N	\N	478	f	\N	\N	\N	\N
536	13616	Booties	Boot Styles	1	535	t	\N	\N	\N	\N
551	63268	Finish Line Athletic	Women's Shoe Brands	2	535	t	\N	\N	\N	\N
538	27902	Comfort	Women's Shoes	2	535	t	\N	\N	\N	\N
539	13614	Evening & Bridal	Women's Shoes	3	535	t	\N	\N	\N	\N
540	50295	Flats	Women's Shoes	4	535	t	\N	\N	\N	\N
541	71123	Heels	Women's Shoes	5	535	t	\N	\N	\N	\N
542	26481	Pumps	Women's Shoes	6	535	t	\N	\N	\N	\N
543	17570	Sandals	Women's Shoes	7	535	t	\N	\N	\N	\N
544	16108	Slippers	Women's Shoes	8	535	t	\N	\N	\N	\N
545	13808	Wedges	Women's Shoes	10	535	t	\N	\N	\N	\N
552	79904	Kate Spade	Women's Shoe Brands	3	535	t	\N	\N	\N	\N
547	56233	All Women's Shoes	Women's Shoes	13	535	t	\N	\N	\N	\N
548	102442	Fall Boot Styles	Boot Styles	0	535	t	\N	\N	\N	\N
554	55765	Steve Madden	Shoe Brands	8	700	t	\N	\N	\N	\N
505	5201	Benefit	Beauty Brands	0	700	t	\N	\N	\N	\N
550	41259	COACH	Shoe Brands	2	700	t	\N	\N	\N	\N
549	56242	Clarks	Women's Shoe Brands	0	535	t	\N	\N	\N	\N
499	28688	Lancôme	Beauty Brands	13	700	t	\N	\N	\N	\N
496	37070	Clinique	Beauty Brands	6	700	t	\N	\N	\N	\N
555	63583	All Brands	Women's Shoe Brands	6	535	t	\N	\N	\N	\N
556	55822	All Men's Shoes 	Men's Shoes	5	535	t	\N	\N	\N	\N
557	78170	Boys' Shoes	Kids' & Baby Shoes	0	535	t	\N	\N	\N	\N
558	78171	Girls' Shoes	Kids' & Baby Shoes	1	535	t	\N	\N	\N	\N
559	78169	All Kids' Shoes	Kids' & Baby Shoes	2	535	t	\N	\N	\N	\N
560	50763	Designer	Featured Shops	0	535	t	\N	\N	\N	\N
561	59406	Impulse & Contemporary	Featured Shops	1	535	t	\N	\N	\N	\N
562	51662	Cleaning & Organization	\N	\N	1	f	\N	\N	\N	\N
563	75820	Kelly Ripa	\N	\N	1	f	\N	\N	\N	\N
501	33668	Origins	Beauty Brands	16	700	t	\N	\N	\N	\N
564	68223	The Wedding Shop	\N	\N	1	f	\N	\N	\N	\N
565	55640	Sandals & Flip-Flops	\N	\N	221	f	\N	\N	\N	\N
566	65701	Sports Fan Shop By Lids	\N	\N	221	f	\N	\N	\N	\N
567	30077	Beauty 	\N	\N	325	f	\N	\N	\N	\N
568	61228	Girls' Activewear	\N	\N	391	f	\N	\N	\N	\N
453	65701	Sports Fan Shop by Lids	Featured Brands	12	454	f	\N	\N	\N	\N
569	26499	Sneakers	\N	\N	454	f	\N	\N	\N	\N
605	28743	Fossil	Handbag Brands	2	700	t	\N	\N	\N	\N
546	32459	Winter & Rain	Boot Styles	6	535	t	\N	\N	\N	\N
570	60378	Wide & Narrow Widths	\N	\N	535	f	\N	\N	\N	\N
571	13604	Sale & Clearance	\N	\N	535	f	\N	\N	\N	\N
572	55636	Boat Shoes	\N	\N	535	f	\N	\N	\N	\N
573	55641	Slippers	\N	\N	535	f	\N	\N	\N	\N
574	43387	Sale & Clearance	\N	\N	535	f	\N	\N	\N	\N
575	63582	All Men's Brands	\N	\N	535	f	\N	\N	\N	\N
576	48561	Baby Shoes	\N	\N	535	f	\N	\N	\N	\N
577	68244	The Wedding Shop	\N	\N	535	f	\N	\N	\N	\N
578	39395	Women's Shoe Trends	\N	\N	535	f	\N	\N	\N	\N
579	40546	Women's Socks and Hosiery	\N	\N	535	f	\N	\N	\N	\N
535	13247	SHOES	\N	8	\N	t	\N	\N	Shop our collection of shoes online at Boutiqueken. Browse the latest trends and view our great selection of boots, heels, sandals, and more.	\N
633	78800	Wedding & Engagement Rings	Wedding Jewelry	2	626	t	\N	\N	\N	\N
581	51906	Backpacks	Handbags & Wallets	0	580	t	\N	\N	\N	\N
582	27691	Clutches & Evening Bags	Handbags & Wallets	1	580	t	\N	\N	\N	\N
583	46011	Crossbody & Messenger Bags	Handbags & Wallets	2	580	t	\N	\N	\N	\N
584	72698	Mini Bags	Handbags & Wallets	3	580	t	\N	\N	\N	\N
585	27693	Saddle Bags	Handbags & Wallets	4	580	t	\N	\N	\N	\N
586	46014	Shoulder Bags	Handbags & Wallets	5	580	t	\N	\N	\N	\N
587	46015	Tote Bags	Handbags & Wallets	6	580	t	\N	\N	\N	\N
588	27689	Wallets & Wristlets	Handbags & Wallets	7	580	t	\N	\N	\N	\N
589	27686	All Handbags	Handbags & Wallets	8	580	t	\N	\N	\N	\N
590	28265	Handbag & Accessory Trends	Trending Now	2	580	t	\N	\N	\N	\N
591	77977	Trolls	Trending Now	3	580	t	\N	\N	\N	\N
592	76877	All Luggage	Luggage & Travel	1	580	t	\N	\N	\N	\N
593	27807	Belts	Accessories	0	580	t	\N	\N	\N	\N
594	77979	Hats & Hair Accessories	Accessories	1	580	t	\N	\N	\N	\N
595	71476	Personalization Shop 	Accessories	2	580	t	\N	\N	\N	\N
596	31957	Scarves & Wraps	Accessories	3	580	t	\N	\N	\N	\N
597	80625	Winter Accessories	Accessories	5	580	t	\N	\N	\N	\N
598	78175	Phone Cases	Tech Accessories	1	580	t	\N	\N	\N	\N
599	69112	All Tech Accessories	Tech Accessories	2	580	t	\N	\N	\N	\N
600	78258	Ray-Ban	Sunglasses and Eyewear	1	580	t	\N	\N	\N	\N
601	69603	Designer Handbags	Handbag Brands	0	580	t	\N	\N	\N	\N
602	54498	Calvin Klein	Handbag Brands	3	700	t	\N	\N	\N	\N
615	68606	Vera Bradley	Handbag Brands	5	700	t	\N	\N	\N	\N
604	27725	Dooney & Bourke	Handbag Brands	1	700	t	\N	\N	\N	\N
606	54507	Giani Bernini	Handbag Brands	5	580	t	\N	\N	\N	\N
607	35848	GUESS	Handbag Brands	6	580	t	\N	\N	\N	\N
608	63441	INC International Concepts	Handbag Brands	7	580	t	\N	\N	\N	\N
609	69630	kate spade new york	Handbag Brands	8	580	t	\N	\N	\N	\N
610	54520	Kipling	Handbag Brands	9	580	t	\N	\N	\N	\N
611	52273	Lauren Ralph Lauren	Handbag Brands	10	580	t	\N	\N	\N	\N
603	25300	COACH	Handbag Brands	0	700	t	\N	\N	\N	\N
613	58096	Patricia Nash	Handbag Brands	12	580	t	\N	\N	\N	\N
614	59477	Tommy Hilfiger	Handbag Brands	13	580	t	\N	\N	\N	\N
612	27726	MICHAEL Michael Kors	Handbag Brands	4	700	t	\N	\N	\N	\N
616	63570	All Handbag Brands	Handbag Brands	15	580	t	\N	\N	\N	\N
617	66127	Nine West Crossbody Bags	\N	\N	580	f	\N	\N	\N	\N
618	66119	Nine West Handbags	\N	\N	580	f	\N	\N	\N	\N
619	66128	Nine West Satchels	\N	\N	580	f	\N	\N	\N	\N
620	66126	Nine West Totes	\N	\N	580	f	\N	\N	\N	\N
621	66116	Nine West Wallets & Accessories	\N	\N	580	f	\N	\N	\N	\N
622	70642	Gym Bags	\N	\N	580	f	\N	\N	\N	\N
623	46012	Hobo Bags	\N	\N	580	f	\N	\N	\N	\N
624	46013	Satchels	\N	\N	580	f	\N	\N	\N	\N
625	53610	Impulse Contemporary Brands	\N	\N	580	f	\N	\N	\N	\N
580	26846	HANDBAGS	\N	9	\N	t	\N	\N	Buy Handbags and Accessories at Boutiqueken & get FREE SHIPPING with $99 purchase! Shop for handbags, backpacks, accessories, wallets, phone cases & more!	\N
627	10834	Bracelets 	Fine Jewelry 	0	626	t	\N	\N	\N	\N
628	57702	Diamonds	Fine Jewelry 	1	626	t	\N	\N	\N	\N
629	10835	Earrings	Fine Jewelry 	2	626	t	\N	\N	\N	\N
630	2903	Gemstones	Fine Jewelry 	3	626	t	\N	\N	\N	\N
631	9569	Necklaces 	Fine Jewelry 	4	626	t	\N	\N	\N	\N
632	21176	Rings	Fine Jewelry 	5	626	t	\N	\N	\N	\N
634	65993	All Fine Jewelry	Fine Jewelry 	7	626	t	\N	\N	\N	\N
635	68271	Day-of Jewelry	Wedding Jewelry	1	626	t	\N	\N	\N	\N
636	68249	All Wedding Jewelry	Wedding Jewelry	3	626	t	\N	\N	\N	\N
637	66557	Diamond Bracelets	Diamond Jewelry	0	626	t	\N	\N	\N	\N
638	66558	Diamond Earrings	Diamond Jewelry	1	626	t	\N	\N	\N	\N
639	66560	Diamond Necklaces	Diamond Jewelry	2	626	t	\N	\N	\N	\N
640	66561	Diamond Rings	Diamond Jewelry	3	626	t	\N	\N	\N	\N
641	63694	Effy	Featured Brands 	1	626	t	\N	\N	\N	\N
642	79009	INC International Concepts	Featured Brands 	4	626	t	\N	\N	\N	\N
643	65939	Le Vian	Featured Brands 	7	626	t	\N	\N	\N	\N
644	68701	Marchesa Bridal 	Featured Brands 	9	626	t	\N	\N	\N	\N
645	63913	Michael Kors	Featured Brands 	10	626	t	\N	\N	\N	\N
646	72179	Swarovski	Featured Brands 	11	626	t	\N	\N	\N	\N
647	65448	All Jewelry Brands	Featured Brands 	14	626	t	\N	\N	\N	\N
648	60194	Personalized Jewelry	Trending Now	2	626	t	\N	\N	\N	\N
649	43877	Jewelry & Cufflinks	\N	\N	221	f	\N	\N	\N	\N
650	55352	Fashion Jewelry	\N	\N	325	f	\N	\N	\N	\N
651	33222	Kids' Jewelry & Watches	\N	\N	391	f	\N	\N	\N	\N
652	65701	Sports Fan Shop by Lids	\N	\N	391	f	\N	\N	\N	\N
733	31616	BURBERRY	\N	\N	478	f	\N	\N	\N	\N
653	102642	Nambé	\N	\N	626	f	\N	\N	\N	\N
654	70803	X3	\N	\N	626	f	\N	\N	\N	\N
655	55689	COACH	\N	\N	626	f	\N	\N	\N	\N
656	60053	Anniversary Bands	\N	\N	626	f	\N	\N	\N	\N
657	42041	Impulse Jewelry	\N	\N	626	f	\N	\N	\N	\N
658	55305	Jewelry Boxes & Accessories	\N	\N	626	f	\N	\N	\N	\N
659	65291	Red Box Gifts	\N	\N	626	f	\N	\N	\N	\N
660	23930	Watches	\N	\N	626	f	\N	\N	\N	\N
626	544	JEWELRY	\N	10	\N	t	\N	\N	Buy Jewelry for women and men at Boutiqueken! FREE SHIPPING with $99 purchase! Great selection of fashion and fine jewelry from the most popular brands.	\N
734	31711	GUCCI	\N	\N	478	f	\N	\N	\N	\N
662	57385	All Women's Watches	Women's Watches	3	661	t	\N	\N	\N	\N
663	71570	All Smart Watches	Smart Watches	5	661	t	\N	\N	\N	\N
664	57415	Anne Klein	Watch Brands	0	661	t	\N	\N	\N	\N
665	26215	Bulova	Watch Brands	2	661	t	\N	\N	\N	\N
666	57367	Citizen	Watch Brands	3	661	t	\N	\N	\N	\N
667	47438	COACH	Watch Brands	4	661	t	\N	\N	\N	\N
668	57421	Diesel	Watch Brands	5	661	t	\N	\N	\N	\N
669	57369	Fossil	Watch Brands	6	661	t	\N	\N	\N	\N
670	57371	GUESS	Watch Brands	7	661	t	\N	\N	\N	\N
671	57370	G-Shock	Watch Brands	8	661	t	\N	\N	\N	\N
672	62502	kate spade new york	Watch Brands	9	661	t	\N	\N	\N	\N
673	57436	Marc Jacobs	Watch Brands	10	661	t	\N	\N	\N	\N
674	57374	Michael Kors	Watch Brands	11	661	t	\N	\N	\N	\N
675	57376	Seiko	Watch Brands	12	661	t	\N	\N	\N	\N
676	57444	Skagen	Watch Brands	13	661	t	\N	\N	\N	\N
677	57453	Tommy Hilfiger	Watch Brands	14	661	t	\N	\N	\N	\N
678	63568	All Watch Brands	Watch Brands	15	661	t	\N	\N	\N	\N
679	73631	Baume & Mercier	Luxury Brands	0	661	t	\N	\N	\N	\N
680	26217	Burberry	Luxury Brands	1	661	t	\N	\N	\N	\N
681	57531	Emporio Armani 	Luxury Brands	2	661	t	\N	\N	\N	\N
682	57424	Fendi	Luxury Brands	3	661	t	\N	\N	\N	\N
683	57427	Gucci	Luxury Brands	4	661	t	\N	\N	\N	\N
684	62419	Hamilton	Luxury Brands	5	661	t	\N	\N	\N	\N
685	57435	Longines	Luxury Brands	6	661	t	\N	\N	\N	\N
686	24058	Montblanc	Luxury Brands	7	661	t	\N	\N	\N	\N
687	57375	Movado	Luxury Brands	8	661	t	\N	\N	\N	\N
688	57441	Rado	Luxury Brands	9	661	t	\N	\N	\N	\N
689	57442	RAYMOND WEIL	Luxury Brands	10	661	t	\N	\N	\N	\N
690	57448	TAG Heuer	Luxury Brands	11	661	t	\N	\N	\N	\N
691	57452	Tissot	Luxury Brands	12	661	t	\N	\N	\N	\N
692	62424	Versace	Luxury Brands	13	661	t	\N	\N	\N	\N
693	57456	Victorinox Swiss Army	Luxury Brands	14	661	t	\N	\N	\N	\N
694	75900	All Luxury Brands	Luxury Brands	15	661	t	\N	\N	\N	\N
695	71932	Watch Sets	Trends & Guides 	1	661	t	\N	\N	\N	\N
696	79488	Samsung	\N	\N	661	f	\N	\N	\N	\N
697	68180	Emporio Armani Swiss	\N	\N	661	f	\N	\N	\N	\N
698	105147	Tory Burch	\N	\N	661	f	\N	\N	\N	\N
699	62814	Ferragamo	\N	\N	661	f	\N	\N	\N	\N
661	23930	WATCHES	\N	11	\N	t	\N	\N	Buy Watches For Men and Women at Boutiqueken and get FREE SHIPPING with $99 purchase! Great selection of the most popular styles and brands of watches.	\N
700	63538	BRANDS	\N	12	\N	t	\N	\N	\N	\N
701	55784	Aerosoles	Shoe Brands	0	700	t	\N	\N	\N	\N
702	55669	Bandolino	Shoe Brands	1	700	t	\N	\N	\N	\N
703	55750	Jessica Simpson	Shoe Brands	3	700	t	\N	\N	\N	\N
704	55782	Naturalizer	Shoe Brands	5	700	t	\N	\N	\N	\N
705	55761	Nine West	Shoe Brands	6	700	t	\N	\N	\N	\N
706	57665	Vince Camuto	Shoe Brands	9	700	t	\N	\N	\N	\N
707	5205	Elizabeth Arden	Beauty Brands	9	700	t	\N	\N	\N	\N
708	31708	Giorgio Armani	Beauty Brands	11	700	t	\N	\N	\N	\N
709	30141	MARC JACOBS	Beauty Brands	15	700	t	\N	\N	\N	\N
710	63538	All Brands	\N	\N	700	f	\N	\N	\N	\N
711	76865	Athletic Shoes	\N	\N	700	f	\N	\N	\N	\N
712	63556	Beauty	\N	\N	700	f	\N	\N	\N	\N
713	63560	Bed & Bath	\N	\N	700	f	\N	\N	\N	\N
714	63565	Dining	\N	\N	700	f	\N	\N	\N	\N
715	63570	Handbags & Accessories	\N	\N	700	f	\N	\N	\N	\N
716	80788	Home	\N	\N	700	f	\N	\N	\N	\N
717	65448	Jewelry	\N	\N	700	f	\N	\N	\N	\N
718	63573	Juniors	\N	\N	700	f	\N	\N	\N	\N
719	63574	Kids	\N	\N	700	f	\N	\N	\N	\N
720	63575	Kitchen	\N	\N	700	f	\N	\N	\N	\N
721	69004	Lingerie	\N	\N	700	f	\N	\N	\N	\N
722	80686	Luggage & Backpacks	\N	\N	700	f	\N	\N	\N	\N
723	80800	Mattresses	\N	\N	700	f	\N	\N	\N	\N
724	63581	Men's	\N	\N	700	f	\N	\N	\N	\N
725	63582	Men's Shoes	\N	\N	700	f	\N	\N	\N	\N
726	63572	Petite	\N	\N	700	f	\N	\N	\N	\N
727	63571	Plus Sizes	\N	\N	700	f	\N	\N	\N	\N
728	70565	Sunglasses	\N	\N	700	f	\N	\N	\N	\N
729	63568	Watches	\N	\N	700	f	\N	\N	\N	\N
730	63539	Womens	\N	\N	700	f	\N	\N	\N	\N
731	63583	Women's Shoes	\N	\N	700	f	\N	\N	\N	\N
495	61916	CHANEL	Beauty Brands	3	700	t	\N	\N	\N	\N
738	16908	Luggage & Backpacks	\N	\N	1	f	\N	\N	\N	\N
732	51752	Clarisonic	\N	\N	478	f	\N	\N	\N	\N
735	7498	Dining & Entertaining	\N	\N	1	f	\N	\N	\N	\N
736	29391	Furniture	\N	\N	1	f	\N	\N	\N	\N
737	7497	Kitchen	\N	\N	1	f	\N	\N	\N	\N
739	25931	Mattresses	\N	\N	1	f	\N	\N	\N	\N
740	55971	Home Decor	\N	\N	1	f	\N	\N	\N	\N
741	39267	Lighting & Lamps	\N	\N	1	f	\N	\N	\N	\N
742	35611	Rugs	\N	\N	1	f	\N	\N	\N	\N
743	26435	Window Treatments	\N	\N	1	f	\N	\N	\N	\N
744	51902	Dyson	\N	\N	1	f	\N	\N	\N	\N
745	28954	Fiesta	\N	\N	1	f	\N	\N	\N	\N
746	46375	Hotel Collection	\N	\N	1	f	\N	\N	\N	\N
747	29422	KitchenAid	\N	\N	1	f	\N	\N	\N	\N
748	8377	Lenox	\N	\N	1	f	\N	\N	\N	\N
749	42151	Martha Stewart Collection	\N	\N	1	f	\N	\N	\N	\N
750	8380	Waterford	\N	\N	1	f	\N	\N	\N	\N
751	0	Wedding Registry	\N	\N	1	f	\N	\N	\N	\N
752	36321	Kids' & Baby Room	\N	\N	1	f	\N	\N	\N	\N
753	36321	Kids' & Baby Bedding	\N	\N	65	f	\N	\N	\N	\N
754	70809	Sleep Solutions	\N	\N	65	f	\N	\N	\N	\N
755	0	Bedding Buying Guide	\N	\N	65	f	\N	\N	\N	\N
756	29891	Activewear	\N	\N	120	f	\N	\N	\N	\N
757	40546	Tights, Socks & Hosiery	\N	\N	120	f	\N	\N	\N	\N
758	32918	Trendy Plus Sizes	\N	\N	120	f	\N	\N	\N	\N
759	0	#macyslove Photo Gallery	\N	\N	120	f	\N	\N	\N	\N
760	29440	Hats, Scarves & Wraps	\N	\N	120	f	\N	\N	\N	\N
761	3296	Activewear	\N	\N	221	f	\N	\N	\N	\N
762	59851	Casual Shoes	\N	\N	221	f	\N	\N	\N	\N
763	55637	Boots	\N	\N	221	f	\N	\N	\N	\N
764	70405	Dress Shoes	\N	\N	221	f	\N	\N	\N	\N
765	55642	Sneakers & Athletic 	\N	\N	221	f	\N	\N	\N	\N
766	30088	Cologne & Grooming	\N	\N	221	f	\N	\N	\N	\N
767	57386	Watches	\N	\N	221	f	\N	\N	\N	\N
768	64942	Polo Sport	\N	\N	221	f	\N	\N	\N	\N
769	0	G.H. Bass & Co.	\N	\N	221	f	\N	\N	\N	\N
770	0	#macyslove Photo Gallery	\N	\N	325	f	\N	\N	\N	\N
771	57568	Shoes	\N	\N	325	f	\N	\N	\N	\N
772	0	Trolls	\N	\N	391	f	\N	\N	\N	\N
773	0	adidas	\N	\N	454	f	\N	\N	\N	\N
774	101043	Apple Watch	\N	\N	454	f	\N	\N	\N	\N
775	46216	Bobbi Brown	\N	\N	478	f	\N	\N	\N	\N
776	61916	CHANEL	\N	\N	478	f	\N	\N	\N	\N
777	47099	Clarins	\N	\N	478	f	\N	\N	\N	\N
778	37070	Clinique	\N	\N	478	f	\N	\N	\N	\N
779	33607	Estée Lauder	\N	\N	478	f	\N	\N	\N	\N
780	28688	Lancôme	\N	\N	478	f	\N	\N	\N	\N
781	45678	MAC	\N	\N	478	f	\N	\N	\N	\N
782	33668	Origins	\N	\N	478	f	\N	\N	\N	\N
783	25677	Shiseido	\N	\N	478	f	\N	\N	\N	\N
784	5201	Benefit Cosmetics	\N	\N	478	f	\N	\N	\N	\N
785	55573	Urban Decay	\N	\N	478	f	\N	\N	\N	\N
786	5204	Dior	\N	\N	478	f	\N	\N	\N	\N
787	31628	DOLCE & GABBANA	\N	\N	478	f	\N	\N	\N	\N
788	0	Beauty Blog	\N	\N	478	f	\N	\N	\N	\N
789	54498	Calvin Klein	\N	\N	580	f	\N	\N	\N	\N
790	25300	COACH	\N	\N	580	f	\N	\N	\N	\N
791	27725	Dooney & Bourke	\N	\N	580	f	\N	\N	\N	\N
792	28743	Fossil	\N	\N	580	f	\N	\N	\N	\N
793	27726	MICHAEL Michael Kors	\N	\N	580	f	\N	\N	\N	\N
794	0	#macyslove Photo Gallery	\N	\N	580	f	\N	\N	\N	\N
795	0	Wedding & Engagement Rings	\N	\N	626	f	\N	\N	\N	\N
796	101043	Apple Watch	\N	\N	661	f	\N	\N	\N	\N
797	0	Michael Kors Access	\N	\N	661	f	\N	\N	\N	\N
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categories_id_seq', 797, true);


--
-- Data for Name: featured_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY featured_categories (id, cat_name, parent_id, image_url, category_id, site_cat_id, is_top_sale, pos) FROM stdin;
39	Furniture	1	\N	\N	29391	\N	0
40	Bed & Bath	1	\N	\N	7495	\N	1
41	Kitchen	1	\N	\N	7497	\N	2
42	Dining & Entertaining	1	\N	\N	7498	\N	3
43	Bedding Collections	65	\N	\N	7502	\N	0
44	Sheets	65	\N	\N	9915	\N	1
45	Bed in a Bag	65	\N	\N	26795	\N	2
46	Pillows	65	\N	\N	28901	\N	3
47	Bath Towels	65	\N	\N	16853	\N	4
48	Quilts & Bedspreads	65	\N	\N	22748	\N	5
49	Comforters	65	\N	\N	28898	\N	6
50	Duvet Covers	65	\N	\N	25045	\N	7
51	Mattress Pads & Toppers	65	\N	\N	40384	\N	8
52	Bath Rugs & Bath Mats	65	\N	\N	8240	\N	9
53	Bath Accessories	65	\N	\N	22094	\N	10
54	Blankets & Throws	65	\N	\N	29405	\N	11
55	Dresses	120	\N	\N	5449	\N	0
56	Tops	120	\N	\N	255	\N	1
57	Coats	120	\N	\N	269	\N	2
58	Sweaters	120	\N	\N	260	\N	3
59	Jeans	120	\N	\N	3111	\N	4
60	Wear to Work	120	\N	\N	39096	\N	5
61	Pants	120	\N	\N	157	\N	6
62	Jackets & Blazers	120	\N	\N	120	\N	7
63	Skirts	120	\N	\N	131	\N	8
64	Fall 2016 Must Haves	120	\N	\N	0	\N	9
65	Swim	120	\N	\N	8699	\N	10
66	Activewear	120	\N	\N	29891	\N	11
67	Cashmere Sweaters	120	\N	\N	262	\N	12
68	The Wedding Shop	120	\N	\N	68223	\N	13
69	Leggings	120	\N	\N	46905	\N	14
70	Petites	120	\N	\N	18579	\N	15
71	Lingerie	120	\N	\N	225	\N	16
72	Pajamas	120	\N	\N	59737	\N	17
73	Pants	221	\N	\N	89	\N	0
74	Suits & Suit Separates	221	\N	\N	17788	\N	1
75	Shoes	221	\N	\N	65	\N	2
76	Jeans	221	\N	\N	11221	\N	3
77	Jackets & Coats	221	\N	\N	3763	\N	4
78	Casual Shirts	221	\N	\N	20627	\N	5
79	Dress Shirts	221	\N	\N	20635	\N	6
80	Underwear	221	\N	\N	57	\N	7
81	Blazers & Sports Coats	221	\N	\N	16499	\N	8
82	T-Shirts	221	\N	\N	30423	\N	9
83	Polos	221	\N	\N	20640	\N	10
84	Swimwear	221	\N	\N	3291	\N	11
85	Sweaters	221	\N	\N	4286	\N	12
86	Hoodies & Fleece	221	\N	\N	25995	\N	13
87	Activewear	221	\N	\N	3296	\N	14
88	Ties & Pocket Squares	221	\N	\N	0	\N	15
89	Shorts	221	\N	\N	3310	\N	16
90	Sunglasses	221	\N	\N	58262	\N	17
91	Dresses	325	\N	\N	18109	\N	0
92	Tops	325	\N	\N	17043	\N	1
93	Jeans	325	\N	\N	28754	\N	2
94	Sweaters	325	\N	\N	20853	\N	3
95	Leggings & Pants	325	\N	\N	21561	\N	4
96	Coats	325	\N	\N	21115	\N	5
97	Homecoming	325	\N	\N	0	\N	6
98	Jackets & Vests	325	\N	\N	35786	\N	7
99	Activewear	325	\N	\N	41973	\N	8
100	Jumpsuits & Rompers	325	\N	\N	17053	\N	9
101	Wear to Work	325	\N	\N	28001	\N	10
102	Graphic Tees	325	\N	\N	75819	\N	11
103	Shop Dresses	391	\N	421	31460	\N	0
106	Shop Shirts & Tees	391	\N	429	63014	\N	7
105	Shop Sets	391	\N	428	63013	\N	2
134	Boots	535	\N	\N	25122	\N	1
107	Shop Activewear	391	\N	568	61228	\N	4
104	Shop Shoes	391	\N	422	48561	\N	5
108	Shop Suits & Dresswear	391	\N	423	63016	\N	6
109	Shop Dresses	391	\N	406	64761	\N	9
110	Shop Strollers & Gear	391	\N	772	0	\N	10
111	Newborn Shop	391	\N	404	59563	\N	11
112	champion	454	\N	\N	\N	\N	0
113	puma	454	\N	\N	\N	\N	1
114	ideology	454	\N	\N	\N	\N	2
115	calvin klein performance	454	\N	\N	\N	\N	3
116	nike	454	\N	\N	\N	\N	4
117	under armour	454	\N	\N	\N	\N	5
118	adidas	454	\N	\N	\N	\N	6
119	the north face	454	\N	\N	\N	\N	7
120	kids	454	\N	\N	\N	\N	8
121	women	454	\N	\N	\N	\N	9
122	Gifts with Purchase	478	\N	\N	58476	\N	0
123	Perfume	478	\N	\N	30087	\N	1
124	Makeup	478	\N	\N	30077	\N	2
135	Pumps	535	\N	\N	26481	\N	2
126	Skincare	478	\N	\N	30078	\N	4
127	Gifts & Value Sets	478	\N	\N	55537	\N	5
128	Tools	478	\N	\N	56234	\N	6
129	Travel Size	478	\N	\N	68594	\N	7
130	Cologne & Grooming	478	\N	\N	30088	\N	8
131	Lips	478	\N	\N	30522	\N	9
125	Foundation	478	\N	\N	0	\N	10
132	Impulse Beauty	478	\N	\N	70429	\N	11
133	Booties	535	\N	\N	13616	\N	0
136	Flats	535	\N	\N	50295	\N	3
137	Heels	535	\N	\N	71123	\N	4
138	Sneakers	535	\N	\N	26499	\N	5
139	block heels	535	\N	\N	84749	\N	6
140	Menswear	535	\N	\N	84750	\N	7
141	Fashion Sneakers	535	\N	\N	60305	\N	8
145	Sandals	535	\N	\N	55640	\N	15
143	Dress Shoes	535	\N	\N	70405	\N	12
144	Boat Shoes	535	\N	\N	55636	\N	13
142	Drivers	535	\N	\N	0	\N	14
146	Fashion Sneakers	535	\N	\N	55642	\N	16
147	Athletic Sneakers	535	\N	\N	63266	\N	17
148	MICHAEL Michael Kors	580	\N	\N	27726	\N	0
149	Tommy Hilfiger	580	\N	\N	59477	\N	1
150	Giani Bernini	580	\N	\N	54507	\N	2
151	Kipling	580	\N	\N	54520	\N	3
152	Vera Bradley	580	\N	\N	68606	\N	4
153	Patricia Nash	580	\N	\N	58096	\N	5
154	Backpacks	580	\N	\N	51906	\N	6
155	Crossbody Bags	580	\N	\N	46011	\N	7
156	Totes	580	\N	\N	46015	\N	8
157	Satchels	580	\N	\N	46013	\N	9
158	Saddle Bags	580	\N	\N	27693	\N	10
159	Clutches & Evening bags	580	\N	\N	27691	\N	11
160	Wallets & Wristlets	580	\N	\N	27689	\N	12
161	Tech Accessories	580	\N	\N	69112	\N	13
162	Belts	580	\N	\N	27807	\N	14
163	Hats, Scarves & Wraps	580	\N	\N	0	\N	15
164	Sale	580	\N	\N	28273	\N	16
165	sunglasses	580	\N	\N	28295	\N	17
166	Necklaces	626	\N	\N	9569	\N	0
167	Bracelets	626	\N	\N	10834	\N	1
168	Earrings	626	\N	\N	10835	\N	2
169	Rings	626	\N	\N	21176	\N	3
171	Diamonds	626	\N	\N	57702	\N	5
172	Gold Jewelry	626	\N	\N	2904	\N	6
173	Pearls	626	\N	\N	2905	\N	7
174	Gemstones	626	\N	\N	2903	\N	8
175	Silver Jewelry	626	\N	\N	21997	\N	9
176	Men's Jewelry	626	\N	\N	43877	\N	10
170	New Arrivals	626	\N	\N	0	\N	17
177	Men's watches	661	\N	\N	57386	\N	0
178	Women's watches	661	\N	\N	57385	\N	1
179	Sale watches	661	\N	\N	28067	\N	2
180	Luxury watches	661	\N	\N	75900	\N	3
181	Smart watches	661	\N	\N	71570	\N	4
182	Michael Kors	661	\N	\N	57374	\N	5
183	Alfani	700	\N	\N	69375	\N	0
184	Apple Watch	700	\N	\N	101043	\N	1
185	Calvin Klein	700	\N	\N	69265	\N	2
186	Charter Club	700	\N	\N	69382	\N	3
187	COACH	700	\N	\N	25300	\N	4
188	DKNY	700	\N	\N	69387	\N	5
189	GUESS	700	\N	\N	69319	\N	6
191	INC International Concepts	700	\N	\N	69393	\N	8
192	Kenneth Cole	700	\N	\N	69401	\N	10
193	KitchenAid	700	\N	\N	29422	\N	11
194	Lancôme	700	\N	\N	28688	\N	12
195	Lenox	700	\N	\N	8377	\N	13
196	Levi's	700	\N	\N	69314	\N	14
190	Martha Stewart Collection	700	\N	\N	0	\N	15
197	Michael Kors	700	\N	\N	69257	\N	16
198	Nautica	700	\N	\N	69325	\N	17
199	Nike	700	\N	\N	69222	\N	18
200	Nine West	700	\N	\N	69406	\N	19
201	Ralph Lauren	700	\N	\N	69270	\N	20
202	Style&co.	700	\N	\N	69415	\N	21
203	The North Face	700	\N	\N	69293	\N	22
204	Tommy Hilfiger	700	\N	\N	69297	\N	23
205	Vince Camuto	700	\N	\N	69422	\N	24
\.


--
-- Name: featured_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('featured_categories_id_seq', 205, true);


--
-- Data for Name: left_navs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY left_navs (id, cat_id, parent_id, site_cat_id, cat_name, group_name, pos, group_pos, seo_title, seo_keywords, seo_desc) FROM stdin;
3	736	1	29391	Furniture	home essentials	2	1	\N	\N	\N
4	737	1	7497	Kitchen	home essentials	3	1	\N	\N	\N
5	738	1	16908	Luggage & Backpacks	home essentials	4	1	\N	\N	\N
6	739	1	25931	Mattresses	home essentials	5	1	\N	\N	\N
8	740	1	55971	Home Decor	more for the home	0	2	\N	\N	\N
7	8	1	30599	Holiday Lane	home essentials	6	1	\N	\N	\N
9	741	1	39267	Lighting & Lamps	more for the home	1	2	\N	\N	\N
11	742	1	35611	Rugs	more for the home	3	2	\N	\N	\N
10	29	1	70056	Outdoor & Patio Furniture	more for the home	2	2	\N	\N	\N
14	743	1	26435	Window Treatments	more for the home	6	2	\N	\N	\N
12	35	1	24672	Slipcovers	more for the home	4	2	\N	\N	\N
26	57	1	75656	Home Design Studio	home brands	21	3	\N	\N	\N
37	752	1	36321	Kids' & Baby Room	featured shops	9	4	\N	\N	\N
25	52	1	28928	Mikasa	home brands	20	3	\N	\N	\N
34	63	1	34821	Outdoor Living	featured shops	2	4	\N	\N	\N
45	57	55	26795	Bed in a Bag	bedding	1	2	\N	\N	\N
17	744	1	51902	Dyson	home brands	5	3	\N	\N	\N
18	745	1	28954	Fiesta	home brands	7	3	\N	\N	\N
46	58	55	78458	Comforters	bedding	2	2	\N	\N	\N
19	746	1	46375	Hotel Collection	home brands	9	3	\N	\N	\N
20	747	1	29422	KitchenAid	home brands	11	3	\N	\N	\N
47	59	55	37945	Decorative & Throw Pillows	bedding	3	2	\N	\N	\N
21	53	1	32568	Ralph Lauren	home brands	13	3	\N	\N	\N
22	748	1	8377	Lenox	home brands	15	3	\N	\N	\N
48	60	55	25045	Duvet Covers	bedding	4	2	\N	\N	\N
23	749	1	42151	Martha Stewart Collection	home brands	17	3	\N	\N	\N
24	750	1	8380	Waterford	home brands	19	3	\N	\N	\N
49	61	55	22748	Quilts & Bedspreads	bedding	5	2	\N	\N	\N
27	58	1	72686	Joy Mangano	home brands	22	3	\N	\N	\N
33	564	1	68223	The Wedding Shop	featured shops	1	4	\N	\N	\N
28	48	1	12291	Kate Spade	home brands	23	3	\N	\N	\N
30	60	1	70610	Shark	home brands	25	3	\N	\N	\N
31	61	1	80788	See All Brands	home brands	26	3	\N	\N	\N
2	735	1	7498	Dining & Entertaining	home essentials	1	1	\N	\N	\N
36	30	1	58181	Gifts That Give Hope	featured shops	7	4	\N	\N	\N
35	64	1	63274	Monogram Gift Shop	featured shops	5	4	\N	\N	\N
13	562	1	51662	Cleaning & Organization	more for the home	5	2	\N	\N	\N
50	62	55	9915	Sheets	bedding	6	2	\N	\N	\N
38	516	55	8237	All Bath	bath	0	1	\N	\N	\N
51	39	55	36321	Kids' & Baby Bedding	bedding	7	2	\N	\N	\N
39	74	55	8240	Bath Rugs & Bath Mats	bath	1	1	\N	\N	\N
40	76	55	16853	Bath Towels	bath	2	1	\N	\N	\N
52	64	55	12398	Teen Bedding	bedding	8	2	\N	\N	\N
87	533	55	35420	Bedroom Furniture	more bedroom essentials	1	5	\N	\N	\N
41	75	55	22094	Bathroom Accessories	bath	3	1	\N	\N	\N
42	80	55	58936	Shower Curtains & Accessories	bath	4	1	\N	\N	\N
43	33	55	23487	Personal Care	bath	5	1	\N	\N	\N
44	56	55	7502	Bedding Collections	bedding	0	2	\N	\N	\N
53	517	55	46529	Winter Bedding	bedding	9	2	\N	\N	\N
54	67	55	29405	Blankets & Throws	bedding basics	0	3	\N	\N	\N
55	68	55	28898	Comforters: Down & Alternative	bedding basics	1	3	\N	\N	\N
56	70	55	40384	Mattress Pads & Toppers	bedding basics	2	3	\N	\N	\N
57	69	55	52096	Mattress & Pillow Protectors	bedding basics	3	3	\N	\N	\N
58	71	55	29483	Memory Foam Bedding	bedding basics	4	3	\N	\N	\N
59	72	55	28901	Pillows	bedding basics	5	3	\N	\N	\N
60	81	55	70809	Sleep Solutions	bedding basics	6	3	\N	\N	\N
61	66	55	70527	All Bedding Basics	bedding basics	7	3	\N	\N	\N
72	520	55	57827	Bar III	brands	20	4	\N	\N	\N
62	87	55	60364	Hotel Collection	brands	1	4	\N	\N	\N
63	85	55	7515	Charter Club	brands	3	4	\N	\N	\N
74	522	55	59474	Donna Karan	brands	22	4	\N	\N	\N
65	91	55	65577	Ralph Lauren	brands	7	4	\N	\N	\N
66	92	55	27828	Tommy Hilfiger	brands	9	4	\N	\N	\N
67	84	55	60354	Calvin Klein	brands	11	4	\N	\N	\N
68	89	55	14115	Lacoste	brands	13	4	\N	\N	\N
69	86	55	60314	Croscill	brands	15	4	\N	\N	\N
70	518	55	60315	J Queen New York	brands	17	4	\N	\N	\N
75	523	55	58114	Echo	brands	23	4	\N	\N	\N
71	519	55	58118	Tommy Bahama	brands	19	4	\N	\N	\N
73	521	55	58111	Barbara Barry	brands	21	4	\N	\N	\N
76	524	55	61877	INC International Concepts	brands	24	4	\N	\N	\N
77	525	55	53264	Lenox	brands	25	4	\N	\N	\N
78	526	55	70902	Kate Spade	brands	26	4	\N	\N	\N
79	527	55	74670	Kelly Ripa	brands	27	4	\N	\N	\N
80	528	55	66247	Nautica	brands	28	4	\N	\N	\N
81	529	55	65421	Tracy Porter	brands	29	4	\N	\N	\N
82	530	55	59103	Trina Turk	brands	30	4	\N	\N	\N
83	93	55	13759	Waterford	brands	31	4	\N	\N	\N
84	531	55	71660	Under The Canopy	brands	32	4	\N	\N	\N
85	532	55	63560	See All Brands	brands	33	4	\N	\N	\N
88	7	55	25931	Mattresses	more bedroom essentials	2	5	\N	\N	\N
89	38	55	92645	Fine Linens	more bedroom essentials	3	5	\N	\N	\N
90	95	94	29891	Activewear	women's clothing	0	1	\N	\N	\N
29	563	1	75820	Kelly Ripa	home brands	24	3	\N	\N	\N
1	2	1	7495	Bed & Bath	home essentials	0	1	\N	\N	\N
93	98	94	269	Coats	women's clothing	3	1	\N	\N	\N
94	99	94	5449	Dresses	women's clothing	4	1	\N	\N	\N
95	100	94	120	Jackets	women's clothing	5	1	\N	\N	\N
96	101	94	3111	Jeans	women's clothing	6	1	\N	\N	\N
97	102	94	50684	Jumpsuits & Rompers	women's clothing	7	1	\N	\N	\N
98	103	94	46905	Leggings	women's clothing	8	1	\N	\N	\N
121	163	94	55213	Contemporary Clothing	contemporary & juniors	0	5	\N	\N	\N
137	154	94	54641	Bar III	women's brands	24	6	\N	\N	\N
101	106	94	157	Pants & Capris	women's clothing	11	1	\N	\N	\N
102	107	94	5344	Shorts	women's clothing	12	1	\N	\N	\N
103	108	94	131	Skirts	women's clothing	13	1	\N	\N	\N
104	109	94	67592	Suits & Suit Separates	women's clothing	14	1	\N	\N	\N
105	110	94	260	Sweaters	women's clothing	15	1	\N	\N	\N
106	111	94	8699	Swimwear	women's clothing	16	1	\N	\N	\N
107	112	94	40546	Tights, Socks & Hosiery	women's clothing	17	1	\N	\N	\N
108	113	94	255	Tops	women's clothing	18	1	\N	\N	\N
109	114	94	72589	Vests	women's clothing	19	1	\N	\N	\N
110	115	94	39096	Wear to Work	women's clothing	20	1	\N	\N	\N
111	116	94	34049	Coats	plus sizes	0	2	\N	\N	\N
112	117	94	37038	Dresses	plus sizes	1	2	\N	\N	\N
113	119	94	34048	Tops	plus sizes	2	2	\N	\N	\N
114	120	94	32918	Trendy Plus Sizes	plus sizes	3	2	\N	\N	\N
115	121	94	32147	All Plus Sizes	plus sizes	4	2	\N	\N	\N
116	122	94	57535	Coats	petites	0	3	\N	\N	\N
117	123	94	55596	Dresses	petites	1	3	\N	\N	\N
118	124	94	55607	Pants & Capris	petites	2	3	\N	\N	\N
119	125	94	55613	Tops	petites	3	3	\N	\N	\N
120	126	94	18579	All Petites	petites	4	3	\N	\N	\N
99	104	94	66718	All Maternity	maternity	2	4	\N	\N	\N
138	538	94	42982	BCBGMAXAZRIA	women's brands	25	6	\N	\N	\N
100	105	94	59737	Pajamas & Robes	women's clothing	10	1	\N	\N	\N
122	534	94	16904	Juniors	contemporary & juniors	1	5	\N	\N	\N
133	144	94	59981	Vince Camuto	women's brands	20	6	\N	\N	\N
123	146	94	17994	Alfani	women's brands	1	6	\N	\N	\N
139	539	94	83142	Catherine Malandrino	women's brands	26	6	\N	\N	\N
124	134	94	13156	Calvin Klein	women's brands	3	6	\N	\N	\N
125	147	94	11427	Charter Club	women's brands	5	6	\N	\N	\N
140	156	94	64883	Eileen Fisher	women's brands	27	6	\N	\N	\N
127	149	94	3481	INC International Concepts	women's brands	9	6	\N	\N	\N
128	135	94	3485	Lauren Ralph Lauren	women's brands	11	6	\N	\N	\N
141	148	94	15131	Ideology	women's brands	28	6	\N	\N	\N
129	137	94	14728	MICHAEL Michael Kors	women's brands	13	6	\N	\N	\N
130	152	94	29630	Style & Co.	women's brands	15	6	\N	\N	\N
142	540	94	69934	Ivanka Trump	women's brands	29	6	\N	\N	\N
131	141	94	31074	The North Face	women's brands	17	6	\N	\N	\N
132	142	94	37281	Tommy Hilfiger	women's brands	19	6	\N	\N	\N
143	150	94	50449	JM Collection	women's brands	30	6	\N	\N	\N
134	535	94	71353	32 Degrees	women's brands	21	6	\N	\N	\N
135	536	94	67663	American Living	women's brands	22	6	\N	\N	\N
136	537	94	18413	Anne Klein	women's brands	23	6	\N	\N	\N
144	541	94	46356	Jones New York	women's brands	31	6	\N	\N	\N
145	542	94	68392	Karen Kane	women's brands	32	6	\N	\N	\N
147	543	94	79913	Lee Platinum	women's brands	34	6	\N	\N	\N
148	544	94	69131	Nautica	women's brands	35	6	\N	\N	\N
149	138	94	6218	Nike	women's brands	36	6	\N	\N	\N
150	545	94	69589	NY Collection	women's brands	37	6	\N	\N	\N
151	546	94	39333	NYDJ	women's brands	38	6	\N	\N	\N
152	161	94	69044	Polo Ralph Lauren	women's brands	39	6	\N	\N	\N
153	162	94	49902	RACHEL Rachel Roy	women's brands	40	6	\N	\N	\N
154	547	94	65262	Tahari by ASL	women's brands	41	6	\N	\N	\N
155	153	94	69907	Thalia Sodi	women's brands	42	6	\N	\N	\N
156	143	94	64869	Under Armour	women's brands	43	6	\N	\N	\N
157	548	94	10775	Adidas	women's brands	44	6	\N	\N	\N
158	133	94	68357	Adrianna Papell	women's brands	45	6	\N	\N	\N
159	549	94	80418	Alfred Dunner	women's brands	46	6	\N	\N	\N
160	550	94	71392	B Michael	women's brands	47	6	\N	\N	\N
161	551	94	71115	CeCe	women's brands	48	6	\N	\N	\N
162	552	94	100751	ECI	women's brands	49	6	\N	\N	\N
164	554	94	71322	G.H. Bass & Co.	women's brands	51	6	\N	\N	\N
165	136	94	30760	Levi's	women's brands	52	6	\N	\N	\N
166	145	94	63539	See All Brands	women's brands	53	6	\N	\N	\N
170	555	94	79644	Shop Hispanic Heritage Month	featured shops	8	7	\N	\N	\N
168	127	94	262	Cashmere Shop	featured shops	1	7	\N	\N	\N
169	164	94	85842	Designer Shop	featured shops	4	7	\N	\N	\N
167	9	94	0	Office Must Haves	featured shops	7	7	\N	\N	\N
171	139	94	96742	Sports Fan Shop By Lids	featured shops	9	7	\N	\N	\N
172	140	94	69211	The Fur Vault	featured shops	10	7	\N	\N	\N
173	131	94	99842	The Pink Shop	featured shops	11	7	\N	\N	\N
174	132	94	68223	The Wedding Shop	featured shops	12	7	\N	\N	\N
175	167	94	669	Beauty	shoes & accessories	0	8	\N	\N	\N
176	168	94	26846	Handbags & Accessories	shoes & accessories	1	8	\N	\N	\N
177	165	94	29440	Hats, Scarves & Wraps	shoes & accessories	2	8	\N	\N	\N
178	170	94	13247	Shoes	shoes & accessories	3	8	\N	\N	\N
91	96	94	55429	Blazers	women's clothing	1	1	\N	\N	\N
264	\N	173	0	LensCrafters	coming soon	0	7	\N	\N	\N
181	\N	173	45758	Big & Tall	men's clothing	1	1	\N	\N	\N
182	\N	173	16499	Blazers & Sport Coats	men's clothing	2	1	\N	\N	\N
183	\N	173	20627	Casual Button-Down Shirts	men's clothing	3	1	\N	\N	\N
184	\N	173	3763	Coats & Jackets	men's clothing	4	1	\N	\N	\N
185	\N	173	20635	Dress Shirts	men's clothing	5	1	\N	\N	\N
186	\N	173	60886	Golf Shop	men's clothing	6	1	\N	\N	\N
187	\N	173	60451	Guys	men's clothing	7	1	\N	\N	\N
188	\N	173	25995	Hoodies & Sweatshirts	men's clothing	8	1	\N	\N	\N
189	\N	173	11221	Jeans	men's clothing	9	1	\N	\N	\N
190	\N	173	99744	Outdoor Shop	men's clothing	10	1	\N	\N	\N
191	\N	173	16295	Pajamas, Lounge & Sleepwear	men's clothing	11	1	\N	\N	\N
192	\N	173	89	Pants	men's clothing	12	1	\N	\N	\N
193	\N	173	20640	Polos	men's clothing	13	1	\N	\N	\N
194	\N	173	20626	Shirts	men's clothing	14	1	\N	\N	\N
195	\N	173	3310	Shorts	men's clothing	15	1	\N	\N	\N
196	\N	173	17788	Suits & Suit Separates	men's clothing	16	1	\N	\N	\N
197	\N	173	4286	Sweaters	men's clothing	17	1	\N	\N	\N
198	\N	173	3291	Swimwear	men's clothing	18	1	\N	\N	\N
199	\N	173	30423	T-Shirts	men's clothing	19	1	\N	\N	\N
200	\N	173	68524	Tuxedos & Formalwear	men's clothing	20	1	\N	\N	\N
201	\N	173	57	Underwear 	men's clothing	21	1	\N	\N	\N
202	\N	173	75897	Wear to Work	men's clothing	22	1	\N	\N	\N
203	\N	173	65	All Men's Shoes	men's shoes	0	2	\N	\N	\N
204	\N	173	59851	Casual Shoes	men's shoes	1	2	\N	\N	\N
205	\N	173	55637	Boots	men's shoes	2	2	\N	\N	\N
206	\N	173	70405	Dress Shoes	men's shoes	3	2	\N	\N	\N
207	\N	173	55640	Sandals & Flip-Flops	men's shoes	4	2	\N	\N	\N
208	\N	173	55641	Slippers	men's shoes	5	2	\N	\N	\N
209	\N	173	55642	Sneakers & Athletic 	men's shoes	6	2	\N	\N	\N
210	\N	173	47665	Accessories & Wallets	accessories	0	3	\N	\N	\N
211	\N	173	45016	Bags & Backpacks	accessories	1	3	\N	\N	\N
212	\N	173	47673	Belts & Suspenders	accessories	2	3	\N	\N	\N
213	\N	173	30088	Cologne & Grooming	accessories	3	3	\N	\N	\N
214	\N	173	49167	Gifts, Gadgets & Audio	accessories	4	3	\N	\N	\N
215	\N	173	47657	Hats, Gloves & Scarves	accessories	5	3	\N	\N	\N
216	\N	173	43877	Jewelry & Cufflinks	accessories	6	3	\N	\N	\N
217	\N	173	18245	Socks	accessories	7	3	\N	\N	\N
218	\N	173	58262	Sunglasses by Sunglass Hut	accessories	8	3	\N	\N	\N
219	\N	173	53239	Ties & Pocket Squares	accessories	9	3	\N	\N	\N
220	\N	173	57386	Watches	accessories	10	3	\N	\N	\N
221	\N	173	29415	Alfani	men's brands	1	4	\N	\N	\N
247	\N	173	44356	Izod	men's brands	36	4	\N	\N	\N
222	\N	173	28169	Calvin Klein	men's brands	3	4	\N	\N	\N
228	\N	173	3304	Polo Ralph Lauren	men's brands	15	4	\N	\N	\N
223	\N	173	43145	Dockers	men's brands	5	4	\N	\N	\N
224	\N	173	31776	INC International Concepts	men's brands	7	4	\N	\N	\N
225	\N	173	43141	Levi's	men's brands	9	4	\N	\N	\N
229	\N	173	11345	Sean John	men's brands	17	4	\N	\N	\N
226	\N	173	67632	Michael Kors	men's brands	11	4	\N	\N	\N
227	\N	173	46108	Nautica	men's brands	13	4	\N	\N	\N
248	\N	173	54272	Jockey	men's brands	37	4	\N	\N	\N
230	\N	173	2519	Tommy Hilfiger	men's brands	19	4	\N	\N	\N
253	\N	173	58432	Nike	activewear	2	5	\N	\N	\N
232	\N	173	58082	7 for All Mankind	men's brands	21	4	\N	\N	\N
233	\N	173	53433	American Rag	men's brands	22	4	\N	\N	\N
234	\N	173	86842	Armani Exchange	men's brands	23	4	\N	\N	\N
235	\N	173	20392	Armani Jeans	men's brands	24	4	\N	\N	\N
236	\N	173	58083	Bar III	men's brands	25	4	\N	\N	\N
237	\N	173	29884	Buffalo David Bitton	men's brands	26	4	\N	\N	\N
238	\N	173	29414	Club Room	men's brands	27	4	\N	\N	\N
239	\N	173	57979	Denim & Supply Ralph Lauren	men's brands	28	4	\N	\N	\N
240	\N	173	43206	DKNY	men's brands	29	4	\N	\N	\N
241	\N	173	55271	Greg Norman	men's brands	30	4	\N	\N	\N
242	\N	173	63725	G-Star	men's brands	31	4	\N	\N	\N
243	\N	173	29889	GUESS	men's brands	32	4	\N	\N	\N
244	\N	173	59234	Haggar	men's brands	33	4	\N	\N	\N
245	\N	173	64942	Polo Sport	men's brands	34	4	\N	\N	\N
246	\N	173	58084	Hugo Boss	men's brands	35	4	\N	\N	\N
249	\N	173	52843	Kenneth Cole	men's brands	38	4	\N	\N	\N
250	\N	173	36943	Lacoste	men's brands	39	4	\N	\N	\N
251	\N	173	38348	LRG	men's brands	40	4	\N	\N	\N
252	\N	173	29883	Lucky Brand Jeans	men's brands	41	4	\N	\N	\N
231	\N	173	60285	adidas	activewear	0	5	\N	\N	\N
254	\N	173	26399	Perry Ellis	men's brands	43	4	\N	\N	\N
179	556	94	58128	Sunglasses	shoes & accessories	4	8	\N	\N	\N
256	\N	173	11882	Quiksilver	men's brands	45	4	\N	\N	\N
257	\N	173	52099	Tallia	men's brands	46	4	\N	\N	\N
258	\N	173	11046	Tasso Elba	men's brands	47	4	\N	\N	\N
255	\N	173	58477	Puma	activewear	3	5	\N	\N	\N
260	\N	173	3153	Timberland	men's brands	49	4	\N	\N	\N
261	\N	173	21707	Tommy Bahama	men's brands	50	4	\N	\N	\N
262	\N	173	64998	Under Armour	activewear	5	5	\N	\N	\N
263	\N	173	67609	Fitbit	men's brands	52	4	\N	\N	\N
259	\N	173	18253	The North Face	activewear	4	5	\N	\N	\N
265	\N	173	102142	Reebok	men's brands	55	4	\N	\N	\N
266	\N	173	68293	Ryan Seacrest Distinction	men's brands	56	4	\N	\N	\N
267	\N	173	67044	Shaquille O'Neal Collection	men's brands	57	4	\N	\N	\N
268	\N	173	65292	Vince Camuto	men's brands	58	4	\N	\N	\N
269	\N	173	80421	WHT SPACE	men's brands	59	4	\N	\N	\N
270	\N	173	96045	William Rast	men's brands	60	4	\N	\N	\N
271	\N	173	62039	Weatherproof	men's brands	61	4	\N	\N	\N
272	\N	173	63581	See All Brands	men's brands	62	4	\N	\N	\N
273	\N	173	61971	Designer Shop	featured shops	0	6	\N	\N	\N
274	\N	173	63266	Finish Line Athletic Shoes	featured shops	1	6	\N	\N	\N
275	\N	173	99042	Halloween Shop	featured shops	3	6	\N	\N	\N
276	\N	173	80616	New Arrivals	featured shops	4	6	\N	\N	\N
277	\N	173	79643	Shop Hispanic Heritage Month	featured shops	5	6	\N	\N	\N
278	\N	173	65701	Sports Fan Shop By Lids	featured shops	6	6	\N	\N	\N
279	\N	173	80618	Streetwear	featured shops	7	6	\N	\N	\N
280	\N	173	68223	The Wedding Shop	featured shops	8	6	\N	\N	\N
281	\N	173	80617	Trending Now	featured shops	9	6	\N	\N	\N
282	\N	173	47707	Tuxedo Rental Shop	coming soon	1	7	\N	\N	\N
283	\N	236	41973	Activewear	juniors' clothing	0	1	\N	\N	\N
284	\N	236	70950	Basic Essentials	juniors' clothing	1	1	\N	\N	\N
285	\N	236	56273	Bras, Panties & Lingerie	juniors' clothing	2	1	\N	\N	\N
286	\N	236	21115	Coats	juniors' clothing	3	1	\N	\N	\N
287	\N	236	18109	Dresses	juniors' clothing	4	1	\N	\N	\N
288	\N	236	75819	Graphic Clothing	juniors' clothing	5	1	\N	\N	\N
289	\N	236	35786	Jackets & Vests	juniors' clothing	6	1	\N	\N	\N
290	\N	236	28754	Jeans	juniors' clothing	7	1	\N	\N	\N
291	\N	236	17053	Jumpsuits & Rompers	juniors' clothing	8	1	\N	\N	\N
293	\N	236	58666	Pajamas & Robes	juniors' clothing	10	1	\N	\N	\N
294	\N	236	28589	Shorts	juniors' clothing	11	1	\N	\N	\N
295	\N	236	28379	Skirts	juniors' clothing	12	1	\N	\N	\N
296	\N	236	20853	Sweaters	juniors' clothing	13	1	\N	\N	\N
297	\N	236	57597	Swimwear	juniors' clothing	14	1	\N	\N	\N
298	\N	236	17043	Tops	juniors' clothing	15	1	\N	\N	\N
299	\N	236	28001	Wear to Work	juniors' clothing	16	1	\N	\N	\N
301	\N	236	105542	Mock Neck	must haves	0	2	\N	\N	\N
302	\N	236	98742	Style Statement: Patches	must haves	1	2	\N	\N	\N
300	\N	236	60983	Under $40	shop by price	3	3	\N	\N	\N
312	\N	236	38661	XOXO	juniors' brands	19	4	\N	\N	\N
313	\N	236	17142	Rampage	juniors' brands	20	4	\N	\N	\N
292	\N	236	21561	Wide- Leg Pants	must haves	2	2	\N	\N	\N
303	\N	236	46810	American Rag	juniors' brands	1	4	\N	\N	\N
314	\N	236	63017	Marilyn Monroe	juniors' brands	21	4	\N	\N	\N
304	\N	236	53640	BCX	juniors' brands	3	4	\N	\N	\N
305	\N	236	57576	Celebrity Pink	juniors' brands	5	4	\N	\N	\N
315	\N	236	54641	Bar III	juniors' brands	22	4	\N	\N	\N
306	\N	236	34380	GUESS?	juniors' brands	7	4	\N	\N	\N
307	\N	236	74667	In Awe of You by AwesomenessTV	juniors' brands	9	4	\N	\N	\N
316	\N	236	81022	Lisa Frank	juniors' brands	23	4	\N	\N	\N
308	\N	236	53642	Jessica Simpson	juniors' brands	11	4	\N	\N	\N
309	\N	236	30760	Levi's	juniors' brands	13	4	\N	\N	\N
317	\N	236	70695	O'Neill	juniors' brands	24	4	\N	\N	\N
310	\N	236	51951	Material Girl	juniors' brands	15	4	\N	\N	\N
311	\N	236	104553	One Hart	juniors' brands	17	4	\N	\N	\N
318	\N	236	70694	Volcom	juniors' brands	25	4	\N	\N	\N
319	\N	236	57590	Angie	juniors' brands	26	4	\N	\N	\N
320	\N	236	57593	Be Bop	juniors' brands	27	4	\N	\N	\N
321	\N	236	57591	Dollhouse	juniors' brands	28	4	\N	\N	\N
322	\N	236	56317	Else Jeans	juniors' brands	29	4	\N	\N	\N
323	\N	236	57581	Eyeshadow	juniors' brands	30	4	\N	\N	\N
324	\N	236	54637	Miss Me	juniors' brands	31	4	\N	\N	\N
325	\N	236	57582	Planet Gold	juniors' brands	32	4	\N	\N	\N
326	\N	236	28009	Roxy	juniors' brands	33	4	\N	\N	\N
327	\N	236	63573	See All Brands	juniors' brands	34	4	\N	\N	\N
328	\N	236	55213	Contemporary Clothing	more choices, more sizes	0	5	\N	\N	\N
329	\N	236	32918	Trendy Plus Sizes	more choices, more sizes	1	5	\N	\N	\N
333	\N	236	102244	Trolls Shop	featured shops	6	6	\N	\N	\N
334	\N	236	102243	Velvet Shop	featured shops	7	6	\N	\N	\N
331	\N	236	102242	Halloween Shop	featured shops	3	6	\N	\N	\N
332	\N	236	70380	Surf Shop	featured shops	4	6	\N	\N	\N
330	\N	236	0	Throwback Shop	featured shops	5	6	\N	\N	\N
335	\N	236	104551	Whimsy Shop	featured shops	8	6	\N	\N	\N
336	\N	236	30077	Beauty 	shoes & accessories	0	7	\N	\N	\N
337	\N	236	55352	Fashion Jewelry	shoes & accessories	1	7	\N	\N	\N
338	\N	236	54525	Handbags & Accessories	shoes & accessories	2	7	\N	\N	\N
339	\N	236	53610	Hats, Gloves & Scarves	shoes & accessories	3	7	\N	\N	\N
340	\N	236	57568	Shoes	shoes & accessories	4	7	\N	\N	\N
341	\N	236	58128	Sunglasses	shoes & accessories	5	7	\N	\N	\N
342	\N	277	48692	Baby Girl (0-24 months)	baby	0	1	\N	\N	\N
343	\N	277	48693	Baby Boy (0-24 months)	baby	1	1	\N	\N	\N
344	\N	277	60045	Baby Shower Gifts	baby	2	1	\N	\N	\N
345	\N	277	58376	Baby Strollers & Gear	baby	3	1	\N	\N	\N
346	\N	277	59563	Newborn Shop	baby	4	1	\N	\N	\N
347	\N	277	64761	All Baby	baby	5	1	\N	\N	\N
348	\N	277	6581	Toddler Girls (2T-5T)	girls	0	2	\N	\N	\N
349	\N	277	62970	Girls 2-6X	girls	1	2	\N	\N	\N
350	\N	277	25324	Girls 7-16	girls	2	2	\N	\N	\N
351	\N	277	61228	Activewear	kids' & baby clothing	1	4	\N	\N	\N
352	\N	277	63010	Coats & Jackets	kids' & baby clothing	2	4	\N	\N	\N
353	\N	277	31460	Dresses 	kids' & baby clothing	3	4	\N	\N	\N
355	\N	277	61998	All Girls	girls	7	2	\N	\N	\N
354	\N	277	48561	Shoes	kids' & baby clothing	10	4	\N	\N	\N
1426	583	580	46011	Crossbody & Messenger Bags	handbags & wallets	2	2	\N	\N	\N
356	\N	277	27058	Toddler Boys (2T-5T)	boys	0	3	\N	\N	\N
357	\N	277	62971	Boys 2-7	boys	1	3	\N	\N	\N
358	\N	277	25325	Boys 8-20	boys	2	3	\N	\N	\N
360	\N	277	61999	All Boys	boys	7	3	\N	\N	\N
361	\N	277	63009	Accessories & Backpacks	kids' & baby clothing	0	4	\N	\N	\N
362	\N	277	63008	Jeans	kids' & baby clothing	4	4	\N	\N	\N
363	\N	277	63011	Leggings & Pants	kids' & baby clothing	5	4	\N	\N	\N
364	\N	277	65451	Pajamas	kids' & baby clothing	6	4	\N	\N	\N
365	\N	277	30057	School Uniforms	kids' & baby clothing	7	4	\N	\N	\N
366	\N	277	63013	Sets & Outfits	kids' & baby clothing	8	4	\N	\N	\N
367	\N	277	63014	Shirts & Tees	kids' & baby clothing	9	4	\N	\N	\N
368	\N	277	63015	Shorts	kids' & baby clothing	11	4	\N	\N	\N
369	\N	277	31462	Skirts	kids' & baby clothing	12	4	\N	\N	\N
359	\N	277	63016	Suits & Dress Shirts	kids' & baby clothing	13	4	\N	\N	\N
370	\N	277	65543	Sweaters	kids' & baby clothing	14	4	\N	\N	\N
371	\N	277	55163	Swimwear	kids' & baby clothing	15	4	\N	\N	\N
372	\N	277	65582	Underwear & Socks	kids' & baby clothing	16	4	\N	\N	\N
397	\N	277	81842	Mix & Match	more for kids' & baby	0	8	\N	\N	\N
398	\N	277	22911	Toys & Games	more for kids' & baby	1	8	\N	\N	\N
399	\N	277	23484	Kids' & Baby Room	more for kids' & baby	2	8	\N	\N	\N
410	\N	305	3296	T-Shirts	men's active	8	2	\N	\N	\N
404	\N	305	0	Top Fitness Clothing Brands	guides & inspiration	3	7	\N	\N	\N
400	\N	277	33222	Kids' Jewelry & Watches	more for kids' & baby	3	8	\N	\N	\N
377	\N	277	60852	Epic Threads	kids' & baby brands	5	6	\N	\N	\N
378	\N	277	32298	First Impressions	kids' & baby brands	7	6	\N	\N	\N
401	\N	277	70805	Kids' Luggage and Backpacks	more for kids' & baby	4	8	\N	\N	\N
379	\N	277	45095	Levi's	kids' & baby brands	9	6	\N	\N	\N
380	\N	277	62430	Nike	kids' & baby brands	11	6	\N	\N	\N
402	\N	277	63270	Finish Line Athletic Shoes	more for kids' & baby	5	8	\N	\N	\N
381	\N	277	14355	Ralph Lauren Childrenswear	kids' & baby brands	13	6	\N	\N	\N
382	\N	277	40660	The North Face	kids' & baby brands	15	6	\N	\N	\N
403	\N	277	65701	Sports Fan Shop by Lids	more for kids' & baby	6	8	\N	\N	\N
383	\N	277	45097	Tommy Hilfiger	kids' & baby brands	17	6	\N	\N	\N
384	\N	277	63114	Under Armour	kids' & baby brands	19	6	\N	\N	\N
374	\N	277	0	Kids Winter Fashions & Trends	kids' style watch	1	7	\N	\N	\N
385	\N	277	69692	Frozen	kids' & baby brands	20	6	\N	\N	\N
386	\N	277	66707	Graco	kids' & baby brands	21	6	\N	\N	\N
387	\N	277	33448	GUESS	kids' & baby brands	22	6	\N	\N	\N
388	\N	277	64809	Little Me	kids' & baby brands	23	6	\N	\N	\N
389	\N	277	60292	adidas	kids' & baby brands	24	6	\N	\N	\N
390	\N	277	48931	Hello Kitty	kids' & baby brands	25	6	\N	\N	\N
391	\N	277	63100	Melissa and Doug	kids' & baby brands	26	6	\N	\N	\N
392	\N	277	70470	Nautica	kids' & baby brands	27	6	\N	\N	\N
393	\N	277	59230	Puma	kids' & baby brands	28	6	\N	\N	\N
394	\N	277	63574	See All Brands	kids' & baby brands	29	6	\N	\N	\N
395	\N	277	61141	Halloween Shop	kids' style watch	2	7	\N	\N	\N
396	\N	277	26073	Holiday Shop	kids' style watch	3	7	\N	\N	\N
405	\N	305	101043	Apple Watch	featured active brands	1	1	\N	\N	\N
413	\N	305	61361	Jackets & Hoodies	women's active	0	3	\N	\N	\N
406	\N	305	67609	Fitbit	featured active brands	3	1	\N	\N	\N
414	\N	305	53958	Pants & Leggings	women's active	1	3	\N	\N	\N
407	\N	305	64942	Polo Sport	featured active brands	6	1	\N	\N	\N
415	\N	305	61433	Shorts	women's active	2	3	\N	\N	\N
416	\N	305	26499	Sneakers	women's active	3	3	\N	\N	\N
409	\N	305	60886	Golf Shop	men's active	0	2	\N	\N	\N
417	\N	305	54019	Sports Bras	women's active	4	3	\N	\N	\N
425	\N	305	74790	Sport Sunglasses	active accessories	4	5	\N	\N	\N
411	\N	305	55642	Sneakers & Athletic Shoes	men's active	5	2	\N	\N	\N
412	\N	305	3291	Swimwear	men's active	7	2	\N	\N	\N
408	\N	305	65701	Sports Team Gear	kids' active	6	4	\N	\N	\N
418	\N	305	29891	Swimwear	women's active	6	3	\N	\N	\N
419	\N	305	53727	Tops & T-Shirts	women's active	7	3	\N	\N	\N
420	\N	305	53874	Yoga	women's active	8	3	\N	\N	\N
421	\N	305	41973	Juniors' Active	women's active	9	3	\N	\N	\N
422	\N	305	34051	Plus Size Active	women's active	10	3	\N	\N	\N
426	\N	305	46710	Blenders	healthy living	0	6	\N	\N	\N
423	\N	305	61228	T-Shirts	kids' active	8	4	\N	\N	\N
427	\N	305	65825	Fans & Humidifiers	healthy living	1	6	\N	\N	\N
433	\N	316	55537	Gifts & Value Sets	special offers	1	1	\N	\N	\N
428	\N	305	7583	Juicers	healthy living	2	6	\N	\N	\N
424	\N	305	70934	Fitness Trackers & Gadgets	active accessories	2	5	\N	\N	\N
429	\N	305	23487	Massagers	healthy living	3	6	\N	\N	\N
430	\N	305	70809	Sleep Solutions	healthy living	4	6	\N	\N	\N
431	\N	305	61581	Sunscreen & Lotions	healthy living	5	6	\N	\N	\N
432	\N	305	16853	Towels	healthy living	6	6	\N	\N	\N
434	\N	316	58476	Gifts with Purchase	special offers	3	1	\N	\N	\N
435	\N	316	72195	Only at Macy's	special offers	5	1	\N	\N	\N
436	\N	316	58499	Bath & Body	shop by category	1	2	\N	\N	\N
437	\N	316	30087	Fragrance	shop by category	3	2	\N	\N	\N
438	\N	316	60600	Hair Care	shop by category	5	2	\N	\N	\N
439	\N	316	30077	Makeup	shop by category	7	2	\N	\N	\N
373	\N	277	65147	All Characters	character shop	5	5	\N	\N	\N
441	\N	316	30078	Skin Care	shop by category	11	2	\N	\N	\N
442	\N	316	56234	Tools & Brushes	shop by category	13	2	\N	\N	\N
472	\N	316	65813	All Perfume Brands	fragrance brands	23	5	\N	\N	\N
443	\N	316	68594	Travel Size	shop by category	15	2	\N	\N	\N
444	\N	316	46216	Bobbi Brown	beauty brands	1	3	\N	\N	\N
498	688	362	55641	Slippers	men's shoes	5	2	\N	\N	\N
499	196	362	55642	Sneakers & Athletic	men's shoes	6	2	\N	\N	\N
446	\N	316	47099	Clarins	beauty brands	5	3	\N	\N	\N
447	\N	316	37070	Clinique	beauty brands	7	3	\N	\N	\N
500	689	362	43387	Sale & Clearance	men's shoes	7	2	\N	\N	\N
448	\N	316	33607	Estée Lauder	beauty brands	9	3	\N	\N	\N
473	\N	316	0	#macyslove Photo Gallery	beauty trends & advice	5	6	\N	\N	\N
449	\N	316	28688	Lancôme	beauty brands	11	3	\N	\N	\N
450	\N	316	45678	MAC	beauty brands	13	3	\N	\N	\N
451	\N	316	33668	Origins	beauty brands	15	3	\N	\N	\N
474	\N	316	99842	The Pink Shop	beauty trends & advice	7	6	\N	\N	\N
452	\N	316	25677	Shiseido	beauty brands	17	3	\N	\N	\N
453	\N	316	63556	All Beauty Brands	beauty brands	19	3	\N	\N	\N
501	690	362	63582	All Men's Brands	men's shoes	8	2	\N	\N	\N
477	363	362	13616	Booties	women's shoes	0	1	\N	\N	\N
475	\N	316	103752	Now Trending at Macy's	beauty trends & advice	9	6	\N	\N	\N
455	\N	316	5201	Benefit Cosmetics	impulse beauty brands	3	4	\N	\N	\N
456	\N	316	51752	Clarisonic	impulse beauty brands	5	4	\N	\N	\N
457	\N	316	75901	m-61	impulse beauty brands	7	4	\N	\N	\N
476	\N	316	65384	What's New	beauty trends & advice	11	6	\N	\N	\N
458	\N	316	15099	philosophy	impulse beauty brands	9	4	\N	\N	\N
459	\N	316	55573	Urban Decay	impulse beauty brands	11	4	\N	\N	\N
478	364	362	25122	Boots	women's shoes	1	1	\N	\N	\N
460	\N	316	70429	The Impulse Shop	impulse beauty brands	13	4	\N	\N	\N
461	\N	316	82442	All Impulse Brands	impulse beauty brands	15	4	\N	\N	\N
479	365	362	27902	Comfort	women's shoes	2	1	\N	\N	\N
462	\N	316	31616	BURBERRY	fragrance brands	1	5	\N	\N	\N
463	\N	316	31619	Calvin Klein	fragrance brands	3	5	\N	\N	\N
480	366	362	13614	Evening & Bridal	women's shoes	3	1	\N	\N	\N
445	\N	316	61916	CHANEL	fragrance brands	5	5	\N	\N	\N
464	\N	316	53005	COACH	fragrance brands	7	5	\N	\N	\N
481	367	362	50295	Flats	women's shoes	4	1	\N	\N	\N
465	\N	316	5204	Dior	fragrance brands	9	5	\N	\N	\N
466	\N	316	31628	DOLCE & GABBANA	fragrance brands	11	5	\N	\N	\N
482	368	362	71123	Heels	women's shoes	5	1	\N	\N	\N
467	\N	316	31711	GUCCI	fragrance brands	13	5	\N	\N	\N
468	\N	316	30150	Michael Kors	fragrance brands	15	5	\N	\N	\N
483	369	362	26481	Pumps	women's shoes	6	1	\N	\N	\N
469	\N	316	31746	Ralph Lauren	fragrance brands	17	5	\N	\N	\N
470	\N	316	66024	Tom Ford	fragrance brands	19	5	\N	\N	\N
484	370	362	17570	Sandals	women's shoes	7	1	\N	\N	\N
471	\N	316	65814	All Cologne Brands	fragrance brands	21	5	\N	\N	\N
485	371	362	16108	Slippers	women's shoes	8	1	\N	\N	\N
486	372	362	26499	Sneakers	women's shoes	9	1	\N	\N	\N
487	373	362	13808	Wedges	women's shoes	10	1	\N	\N	\N
488	685	362	60378	Wide & Narrow Widths	women's shoes	11	1	\N	\N	\N
489	374	362	32459	Winter & Rain Boots	women's shoes	12	1	\N	\N	\N
490	686	362	13604	Sale & Clearance	women's shoes	13	1	\N	\N	\N
491	383	362	63583	All Women's Brands	women's shoes	14	1	\N	\N	\N
492	375	362	56233	All Women's Shoes	women's shoes	15	1	\N	\N	\N
493	687	362	55636	Boat Shoes	men's shoes	0	2	\N	\N	\N
494	191	362	55637	Boots	men's shoes	1	2	\N	\N	\N
495	192	362	59851	Casual Shoes	men's shoes	2	2	\N	\N	\N
496	194	362	70405	Dress Shoes	men's shoes	3	2	\N	\N	\N
497	384	362	55640	Sandals & Flip-Flops	men's shoes	4	2	\N	\N	\N
502	385	362	55822	All Men's Shoes	men's shoes	9	2	\N	\N	\N
510	694	362	40546	Women's Socks and Hosiery	featured shops	6	4	\N	\N	\N
521	695	391	66127	Nine West Crossbody Bags	handbag brands	20	1	\N	\N	\N
505	390	362	59406	Impulse Contemporary Shoes	featured shops	1	4	\N	\N	\N
506	275	362	57568	Junior's Shoes	featured shops	2	4	\N	\N	\N
507	692	362	68244	The Wedding Shop	featured shops	3	4	\N	\N	\N
508	389	362	50763	Women's Designer Shoes	featured shops	4	4	\N	\N	\N
509	693	362	39395	Women's Shoe Trends	featured shops	5	4	\N	\N	\N
511	412	391	69603	Designer Handbags	handbag brands	1	1	\N	\N	\N
512	413	391	54498	Calvin Klein	handbag brands	3	1	\N	\N	\N
513	414	391	25300	COACH	handbag brands	5	1	\N	\N	\N
514	415	391	27725	Dooney & Bourke	handbag brands	7	1	\N	\N	\N
515	416	391	28743	Fossil	handbag brands	9	1	\N	\N	\N
516	418	391	35848	GUESS	handbag brands	11	1	\N	\N	\N
517	419	391	63441	INC International Concepts	handbag brands	13	1	\N	\N	\N
518	420	391	69630	kate spade new york	handbag brands	15	1	\N	\N	\N
519	422	391	52273	Lauren Ralph Lauren	handbag brands	17	1	\N	\N	\N
520	423	391	27726	MICHAEL Michael Kors	handbag brands	19	1	\N	\N	\N
522	696	391	66119	Nine West Handbags	handbag brands	21	1	\N	\N	\N
523	697	391	66128	Nine West Satchels	handbag brands	22	1	\N	\N	\N
524	698	391	66126	Nine West Totes	handbag brands	23	1	\N	\N	\N
525	699	391	66116	Nine West Wallets & Accessories	handbag brands	24	1	\N	\N	\N
503	691	362	48561	All Kids' Shoes	kids' shoes	4	3	\N	\N	\N
440	\N	316	30088	Men's Cologne & Grooming	shop by category	9	2	\N	\N	\N
584	306	454	76406	Fitbit	smart watches	1	2	\N	\N	\N
527	427	391	63570	See All Brands	handbag brands	27	1	\N	\N	\N
552	429	428	10834	Bracelets	fine jewelry	0	1	\N	\N	\N
560	437	428	55352	Kate Spade New York	jewelry brands	9	4	\N	\N	\N
531	700	391	70642	Gym Bags	handbags & wallets	3	2	\N	\N	\N
532	701	391	46012	Hobo Bags	handbags & wallets	4	2	\N	\N	\N
533	395	391	72698	Mini Bags	handbags & wallets	5	2	\N	\N	\N
534	396	391	27693	Saddle Bags	handbags & wallets	6	2	\N	\N	\N
535	702	391	46013	Satchels	handbags & wallets	7	2	\N	\N	\N
536	397	391	46014	Shoulder Bags	handbags & wallets	8	2	\N	\N	\N
537	398	391	46015	Tote Bags	handbags & wallets	9	2	\N	\N	\N
538	399	391	27689	Wallets & Wristlets	handbags & wallets	10	2	\N	\N	\N
539	400	391	27686	All Handbags	handbags & wallets	11	2	\N	\N	\N
529	393	391	27691	The Wedding Shop	trending now	3	5	\N	\N	\N
530	394	391	46011	Crossbody & Messenger Bags	handbags & wallets	2	2	\N	\N	\N
542	405	391	77979	Hats & Hair Accessories	accessories	1	4	\N	\N	\N
543	406	391	71476	Personalization Shop	accessories	2	4	\N	\N	\N
544	407	391	31957	Scarves & Wraps	accessories	3	4	\N	\N	\N
545	171	391	28295	Sunglasses by Sunglass Hut	accessories	4	4	\N	\N	\N
546	112	391	40546	Tights, Socks, & Hosiery	accessories	5	4	\N	\N	\N
550	401	391	28265	Handbag & Accessory Trends	trending now	1	5	\N	\N	\N
565	448	428	65939	Le Vian Shop	jewelry brands	11	4	\N	\N	\N
547	165	391	29440	All Accessories	accessories	8	4	\N	\N	\N
548	408	391	80625	Winter Accessories	accessories	7	4	\N	\N	\N
551	703	391	53610	Impulse Contemporary Brands	trending now	2	5	\N	\N	\N
540	410	391	69112	All Tech Accessories	tech accessories	2	3	\N	\N	\N
553	430	428	57702	Diamonds	fine jewelry	1	1	\N	\N	\N
526	425	391	59477	Tommy Hilfiger	handbag brands	25	1	\N	\N	\N
554	431	428	10835	Earrings	fine jewelry	2	1	\N	\N	\N
555	432	428	2903	Gemstones	fine jewelry	3	1	\N	\N	\N
556	433	428	9569	Necklaces 	fine jewelry	4	1	\N	\N	\N
557	434	428	21176	Rings	fine jewelry	5	1	\N	\N	\N
576	708	428	42041	Impulse Jewelry	what's trending	1	6	\N	\N	\N
559	436	428	65993	All Fine Jewelry	fine jewelry	7	1	\N	\N	\N
561	444	428	33222	Kids' Jewelry & Watches	shop categories	0	3	\N	\N	\N
566	449	428	68701	Marchesa	jewelry brands	13	4	\N	\N	\N
598	468	454	57376	Seiko	watch brands	21	3	\N	\N	\N
567	450	428	63913	Michael Kors	jewelry brands	15	4	\N	\N	\N
568	704	428	102642	Nambé	jewelry brands	17	4	\N	\N	\N
593	464	454	57370	G-Shock	watch brands	13	3	\N	\N	\N
569	451	428	72179	Swarovski	jewelry brands	19	4	\N	\N	\N
562	445	428	43877	Men's Jewelry & Accessories	shop categories	1	3	\N	\N	\N
570	705	428	70803	X3	jewelry brands	20	4	\N	\N	\N
588	457	454	57415	Anne Klein	watch brands	1	3	\N	\N	\N
571	706	428	55689	COACH	jewelry brands	21	4	\N	\N	\N
563	446	428	63694	EFFY Shop	jewelry brands	3	4	\N	\N	\N
572	452	428	65448	See All Brands	jewelry brands	22	4	\N	\N	\N
564	447	428	79009	INC International Concepts	jewelry brands	7	4	\N	\N	\N
573	707	428	60053	Anniversary Bands	wedding jewelry	0	5	\N	\N	\N
574	438	428	68271	Day-Of Jewelry	wedding jewelry	1	5	\N	\N	\N
575	439	428	68249	All Wedding Jewelry	wedding jewelry	2	5	\N	\N	\N
577	709	428	55305	Jewelry Boxes & Accessories	what's trending	2	6	\N	\N	\N
578	453	428	60194	Personalized Jewelry	what's trending	3	6	\N	\N	\N
579	710	428	65291	Red Box Gifts	what's trending	4	6	\N	\N	\N
580	711	428	23930	Watches	watches	0	7	\N	\N	\N
581	219	454	57386	Men's Watches	watches by gender	0	1	\N	\N	\N
582	455	454	57385	Women's Watches	watches by gender	1	1	\N	\N	\N
587	712	454	79488	Samsung	watch brands	22	3	\N	\N	\N
600	472	454	73631	Baume & Mercier	luxury brands	0	4	\N	\N	\N
599	466	454	57436	Marc Jacobs	watch brands	23	3	\N	\N	\N
589	458	454	26215	Bulova	watch brands	5	3	\N	\N	\N
594	463	454	57371	GUESS	watch brands	15	3	\N	\N	\N
541	404	391	27807	Belts	accessories	0	4	\N	\N	\N
590	459	454	57367	Citizen	watch brands	7	3	\N	\N	\N
591	460	454	47438	COACH	watch brands	9	3	\N	\N	\N
595	465	454	62502	Kate Spade New York	watch brands	17	3	\N	\N	\N
592	462	454	57369	Fossil	watch brands	11	3	\N	\N	\N
596	467	454	57374	Michael Kors	watch brands	19	3	\N	\N	\N
601	473	454	26217	Burberry	luxury brands	1	4	\N	\N	\N
585	456	454	71570	All Smart Watches	smart watches	5	2	\N	\N	\N
602	713	454	68180	Emporio Armani Swiss	luxury brands	2	4	\N	\N	\N
603	475	454	57424	Fendi	luxury brands	3	4	\N	\N	\N
604	476	454	57427	Gucci	luxury brands	4	4	\N	\N	\N
605	478	454	57435	Longines	luxury brands	5	4	\N	\N	\N
606	479	454	24058	Montblanc	luxury brands	6	4	\N	\N	\N
607	480	454	57375	Movado	luxury brands	7	4	\N	\N	\N
608	481	454	57441	Rado	luxury brands	8	4	\N	\N	\N
609	482	454	57442	RAYMOND WEIL	luxury brands	9	4	\N	\N	\N
610	483	454	57448	TAG Heuer	luxury brands	10	4	\N	\N	\N
611	714	454	105147	Tory Burch	luxury brands	11	4	\N	\N	\N
612	484	454	57452	Tissot	luxury brands	12	4	\N	\N	\N
613	715	454	62814	Ferragamo	luxury brands	13	4	\N	\N	\N
583	774	454	101043	Apple Watch	featured active brands	1	1	\N	\N	\N
528	392	391	51906	Backpacks	handbags & wallets	0	2	\N	\N	\N
616	487	454	75900	All Luxury Watches	luxury brands	16	4	\N	\N	\N
617	488	454	71932	Watch Sets	trends & guides	2	5	\N	\N	\N
375	\N	277	16342	Carter's	kids' & baby brands	1	6	\N	\N	\N
586	773	454	0	Top Fitness Clothing Brands	guides & inspiration	3	7	\N	\N	\N
668	560	172	55641	Slippers	men's shoes	5	2	\N	\N	\N
619	717	489	76865	Athletic Shoes	\N	1	\N	\N	\N	\N
620	718	489	63556	Beauty	\N	2	\N	\N	\N	\N
627	725	489	63574	Kids	\N	9	\N	\N	\N	\N
622	720	489	63565	Dining	\N	4	\N	\N	\N	\N
623	721	489	63570	Handbags & Accessories	\N	5	\N	\N	\N	\N
624	722	489	80788	Home	\N	6	\N	\N	\N	\N
625	723	489	65448	Jewelry	\N	7	\N	\N	\N	\N
626	724	489	63573	Juniors	\N	8	\N	\N	\N	\N
628	726	489	63575	Kitchen	\N	10	\N	\N	\N	\N
633	731	489	63582	Men's Shoes	\N	15	\N	\N	\N	\N
629	727	489	69004	Lingerie	\N	11	\N	\N	\N	\N
630	728	489	80686	Luggage & Backpacks	\N	12	\N	\N	\N	\N
631	729	489	80800	Mattresses	\N	13	\N	\N	\N	\N
632	730	489	63581	Men's	\N	14	\N	\N	\N	\N
639	737	489	63583	Women's Shoes	\N	21	\N	\N	\N	\N
634	732	489	63572	Petite	\N	16	\N	\N	\N	\N
635	733	489	63571	Plus Sizes	\N	17	\N	\N	\N	\N
636	734	489	70565	Sunglasses	\N	18	\N	\N	\N	\N
637	735	489	63568	Watches	\N	19	\N	\N	\N	\N
638	736	489	63539	Womens	\N	20	\N	\N	\N	\N
618	716	489	63538	All Brands	\N	0	\N	\N	\N	\N
376	\N	277	71187	Calvin Klein	kids' & baby brands	3	6	\N	\N	\N
454	\N	316	65894	Anastasia Beverly Hills	impulse beauty brands	1	4	\N	\N	\N
669	196	172	55642	Sneakers & Athletic 	men's shoes	6	2	\N	\N	\N
670	210	172	47665	Accessories & Wallets	accessories	0	3	\N	\N	\N
614	485	454	62424	Versace	luxury brands	14	4	\N	\N	\N
15	56	1	32567	Calvin Klein	home brands	1	3	\N	\N	\N
621	719	489	63560	Bed & Bath	\N	3	\N	\N	\N	\N
671	211	172	45016	Bags & Backpacks	accessories	1	3	\N	\N	\N
642	174	172	16499	Blazers & Sport Coats	men's clothing	2	1	\N	\N	\N
643	175	172	20627	Casual Button-Down Shirts	men's clothing	3	1	\N	\N	\N
644	176	172	3763	Coats & Jackets	men's clothing	4	1	\N	\N	\N
645	177	172	20635	Dress Shirts	men's clothing	5	1	\N	\N	\N
646	178	172	60886	Golf Shop	men's clothing	6	1	\N	\N	\N
647	179	172	60451	Guys	men's clothing	7	1	\N	\N	\N
649	181	172	11221	Jeans	men's clothing	9	1	\N	\N	\N
650	201	172	99744	Outdoor Shop	men's clothing	10	1	\N	\N	\N
651	182	172	16295	Pajamas, Lounge & Sleepwear	men's clothing	11	1	\N	\N	\N
672	212	172	47673	Belts & Suspenders	accessories	2	3	\N	\N	\N
652	183	172	89	Pants	men's clothing	12	1	\N	\N	\N
180	\N	173	3296	All Active Brands	activewear	6	5	\N	\N	\N
673	213	172	30088	Cologne & Grooming	accessories	3	3	\N	\N	\N
653	184	172	20640	Polos	men's clothing	13	1	\N	\N	\N
654	557	172	20626	Shirts	men's clothing	14	1	\N	\N	\N
655	186	172	3310	Shorts	men's clothing	15	1	\N	\N	\N
656	185	172	17788	Suits & Suit Separates	men's clothing	16	1	\N	\N	\N
657	187	172	4286	Sweaters	men's clothing	17	1	\N	\N	\N
658	558	172	3291	Swimwear	men's clothing	18	1	\N	\N	\N
659	188	172	30423	T-Shirts	men's clothing	19	1	\N	\N	\N
660	189	172	68524	Tuxedos & Formalwear	men's clothing	20	1	\N	\N	\N
661	190	172	57	Underwear 	men's clothing	21	1	\N	\N	\N
662	234	172	75897	Wear to Work	men's clothing	22	1	\N	\N	\N
663	197	172	65	All Men's Shoes	men's shoes	0	2	\N	\N	\N
664	192	172	59851	Casual Shoes	men's shoes	1	2	\N	\N	\N
665	191	172	55637	Boots	men's shoes	2	2	\N	\N	\N
666	194	172	70405	Dress Shoes	men's shoes	3	2	\N	\N	\N
667	559	172	55640	Sandals & Flip-Flops	men's shoes	4	2	\N	\N	\N
675	215	172	47657	Hats, Gloves & Scarves	accessories	5	3	\N	\N	\N
676	561	172	43877	Jewelry & Cufflinks	accessories	6	3	\N	\N	\N
677	216	172	18245	Socks	accessories	7	3	\N	\N	\N
678	217	172	58262	Sunglasses by Sunglass Hut	accessories	8	3	\N	\N	\N
679	218	172	53239	Ties & Pocket Squares	accessories	9	3	\N	\N	\N
680	219	172	57386	Watches	accessories	10	3	\N	\N	\N
692	562	172	58082	7 for All Mankind	men's brands	21	4	\N	\N	\N
681	220	172	29415	Alfani	men's brands	1	4	\N	\N	\N
682	222	172	28169	Calvin Klein	men's brands	3	4	\N	\N	\N
683	224	172	43145	Dockers	men's brands	5	4	\N	\N	\N
640	173	172	3296	All Active Brands	activewear	6	5	\N	\N	\N
685	226	172	43141	Levi's	men's brands	9	4	\N	\N	\N
689	231	172	11345	Sean John	men's brands	17	4	\N	\N	\N
686	227	172	67632	Michael Kors	men's brands	11	4	\N	\N	\N
687	228	172	46108	Nautica	men's brands	13	4	\N	\N	\N
688	229	172	3304	Polo Ralph Lauren	men's brands	15	4	\N	\N	\N
690	232	172	2519	Tommy Hilfiger	men's brands	19	4	\N	\N	\N
693	221	172	53433	American Rag	men's brands	22	4	\N	\N	\N
641	198	172	45758	Big & Tall	men's clothing	1	1	\N	\N	\N
694	563	172	86842	Armani Exchange	men's brands	23	4	\N	\N	\N
695	564	172	20392	Armani Jeans	men's brands	24	4	\N	\N	\N
696	565	172	58083	Bar III	men's brands	25	4	\N	\N	\N
698	567	172	29414	Club Room	men's brands	27	4	\N	\N	\N
699	223	172	57979	Denim & Supply Ralph Lauren	men's brands	28	4	\N	\N	\N
700	568	172	43206	DKNY	men's brands	29	4	\N	\N	\N
615	486	454	57456	Victorinox Swiss Army	luxury brands	15	4	\N	\N	\N
703	571	172	29889	GUESS	men's brands	32	4	\N	\N	\N
704	572	172	59234	Haggar	men's brands	33	4	\N	\N	\N
705	207	172	64942	Polo Sport	men's brands	34	4	\N	\N	\N
706	573	172	58084	Hugo Boss	men's brands	35	4	\N	\N	\N
707	574	172	44356	Izod	men's brands	36	4	\N	\N	\N
709	576	172	52843	Kenneth Cole	men's brands	38	4	\N	\N	\N
710	577	172	36943	Lacoste	men's brands	39	4	\N	\N	\N
711	578	172	38348	LRG	men's brands	40	4	\N	\N	\N
712	579	172	29883	Lucky Brand Jeans	men's brands	41	4	\N	\N	\N
724	9	172	0	LensCrafters	coming soon	0	7	\N	\N	\N
714	580	172	26399	Perry Ellis	men's brands	43	4	\N	\N	\N
750	243	235	28754	Jeans	juniors' clothing	7	1	\N	\N	\N
715	581	172	58477	Puma	activewear	3	5	\N	\N	\N
717	583	172	52099	Tallia	men's brands	46	4	\N	\N	\N
718	584	172	11046	Tasso Elba	men's brands	47	4	\N	\N	\N
733	593	172	61971	Designer Shop	featured shops	0	6	\N	\N	\N
751	244	235	17053	Jumpsuits & Rompers	juniors' clothing	8	1	\N	\N	\N
721	586	172	21707	Tommy Bahama	men's brands	50	4	\N	\N	\N
723	205	172	67609	Fitbit	men's brands	52	4	\N	\N	\N
725	587	172	102142	Reebok	men's brands	55	4	\N	\N	\N
773	604	235	17142	Rampage	juniors' brands	20	4	\N	\N	\N
726	230	172	68293	Ryan Seacrest Distinction	men's brands	56	4	\N	\N	\N
727	588	172	67044	Shaquille O'Neal Collection	men's brands	57	4	\N	\N	\N
728	589	172	65292	Vince Camuto	men's brands	58	4	\N	\N	\N
729	590	172	80421	WHT SPACE	men's brands	59	4	\N	\N	\N
730	591	172	96045	William Rast	men's brands	60	4	\N	\N	\N
731	592	172	62039	Weatherproof	men's brands	61	4	\N	\N	\N
732	233	172	63581	See All Brands	men's brands	62	4	\N	\N	\N
765	600	235	57576	Celebrity Pink	juniors' brands	5	4	\N	\N	\N
720	585	172	3153	Timberland	men's brands	49	4	\N	\N	\N
691	204	172	60285	adidas	activewear	0	5	\N	\N	\N
735	199	172	99042	Halloween Shop	featured shops	3	6	\N	\N	\N
701	569	172	55271	Greg Norman	men's brands	30	4	\N	\N	\N
734	195	172	63266	Finish Line Athletic Shoes	featured shops	1	6	\N	\N	\N
742	597	172	47707	Tuxedo Rental Shop	coming soon	1	7	\N	\N	\N
736	200	172	80616	New Arrivals	featured shops	4	6	\N	\N	\N
738	595	172	65701	Sports Fan Shop By Lids	featured shops	6	6	\N	\N	\N
739	202	172	80618	Streetwear	featured shops	7	6	\N	\N	\N
740	596	172	68223	The Wedding Shop	featured shops	8	6	\N	\N	\N
741	203	172	80617	Trending Now	featured shops	9	6	\N	\N	\N
719	208	172	18253	The North Face	activewear	4	5	\N	\N	\N
743	236	235	41973	Activewear	juniors' clothing	0	1	\N	\N	\N
716	582	172	11882	Quiksilver	men's brands	45	4	\N	\N	\N
744	237	235	70950	Basic Essentials	juniors' clothing	1	1	\N	\N	\N
745	238	235	56273	Bras, Panties & Lingerie	juniors' clothing	2	1	\N	\N	\N
746	239	235	21115	Coats	juniors' clothing	3	1	\N	\N	\N
747	240	235	18109	Dresses	juniors' clothing	4	1	\N	\N	\N
748	241	235	75819	Graphic Clothing	juniors' clothing	5	1	\N	\N	\N
749	242	235	35786	Jackets & Vests	juniors' clothing	6	1	\N	\N	\N
753	246	235	58666	Pajamas & Robes	juniors' clothing	10	1	\N	\N	\N
754	247	235	28589	Shorts	juniors' clothing	11	1	\N	\N	\N
755	248	235	28379	Skirts	juniors' clothing	12	1	\N	\N	\N
756	249	235	20853	Sweaters	juniors' clothing	13	1	\N	\N	\N
757	250	235	57597	Swimwear	juniors' clothing	14	1	\N	\N	\N
758	251	235	17043	Tops	juniors' clothing	15	1	\N	\N	\N
760	598	235	60983	Under $40	shop by price	3	3	\N	\N	\N
761	258	235	105542	Mock Neck	must haves	0	2	\N	\N	\N
762	259	235	98742	Style Statement: Patches	must haves	1	2	\N	\N	\N
752	245	235	21561	Wide- Leg Pants	must haves	2	2	\N	\N	\N
763	268	235	46810	American Rag	juniors' brands	1	4	\N	\N	\N
766	158	235	34380	GUESS?	juniors' brands	7	4	\N	\N	\N
764	599	235	53640	BCX	juniors' brands	3	4	\N	\N	\N
767	601	235	74667	In Awe of You by AwesomenessTV	juniors' brands	9	4	\N	\N	\N
768	269	235	53642	Jessica Simpson	juniors' brands	11	4	\N	\N	\N
769	602	235	30760	Levi's	juniors' brands	13	4	\N	\N	\N
772	271	235	38661	XOXO	juniors' brands	19	4	\N	\N	\N
770	270	235	51951	Material Girl	juniors' brands	15	4	\N	\N	\N
774	605	235	63017	Marilyn Monroe	juniors' brands	21	4	\N	\N	\N
771	603	235	104553	One Hart	juniors' brands	17	4	\N	\N	\N
775	606	235	54641	Bar III	juniors' brands	22	4	\N	\N	\N
776	607	235	81022	Lisa Frank	juniors' brands	23	4	\N	\N	\N
777	608	235	70695	O'Neill	juniors' brands	24	4	\N	\N	\N
778	609	235	70694	Volcom	juniors' brands	25	4	\N	\N	\N
779	610	235	57590	Angie	juniors' brands	26	4	\N	\N	\N
780	611	235	57593	Be Bop	juniors' brands	27	4	\N	\N	\N
781	612	235	57591	Dollhouse	juniors' brands	28	4	\N	\N	\N
782	613	235	56317	Else Jeans	juniors' brands	29	4	\N	\N	\N
783	614	235	57581	Eyeshadow	juniors' brands	30	4	\N	\N	\N
784	615	235	54637	Miss Me	juniors' brands	31	4	\N	\N	\N
785	616	235	57582	Planet Gold	juniors' brands	32	4	\N	\N	\N
786	617	235	28009	Roxy	juniors' brands	33	4	\N	\N	\N
787	272	235	63573	See All Brands	juniors' brands	34	4	\N	\N	\N
788	618	235	55213	Contemporary Clothing	more choices, more sizes	0	5	\N	\N	\N
713	206	172	58432	Nike	activewear	2	5	\N	\N	\N
702	570	172	63725	G-Star	men's brands	31	4	\N	\N	\N
792	264	235	70380	Surf Shop	featured shops	4	6	\N	\N	\N
790	9	235	0	Throwback Shop	featured shops	5	6	\N	\N	\N
791	262	235	102242	Halloween Shop	featured shops	3	6	\N	\N	\N
794	266	235	102243	Velvet Shop	featured shops	7	6	\N	\N	\N
795	267	235	104551	Whimsy Shop	featured shops	8	6	\N	\N	\N
796	619	235	30077	Beauty 	shoes & accessories	0	7	\N	\N	\N
797	620	235	55352	Fashion Jewelry	shoes & accessories	1	7	\N	\N	\N
798	621	235	54525	Handbags & Accessories	shoes & accessories	2	7	\N	\N	\N
799	273	235	53610	Hats, Gloves & Scarves	shoes & accessories	3	7	\N	\N	\N
800	275	235	57568	Shoes	shoes & accessories	4	7	\N	\N	\N
801	622	235	58128	Sunglasses	shoes & accessories	5	7	\N	\N	\N
802	285	276	48692	Baby Girl (0-24 months)	baby	0	1	\N	\N	\N
803	286	276	48693	Baby Boy (0-24 months)	baby	1	1	\N	\N	\N
804	287	276	60045	Baby Shower Gifts	baby	2	1	\N	\N	\N
805	288	276	58376	Baby Strollers & Gear	baby	3	1	\N	\N	\N
806	289	276	59563	Newborn Shop	baby	4	1	\N	\N	\N
807	291	276	64761	All Baby	baby	5	1	\N	\N	\N
808	277	276	6581	Toddler Girls (2T-5T)	girls	0	2	\N	\N	\N
809	278	276	62970	Girls 2-6X	girls	1	2	\N	\N	\N
828	634	276	63015	Shorts	kids' & baby clothing	11	4	\N	\N	\N
873	662	304	61361	Jackets & Hoodies	women's active	0	3	\N	\N	\N
850	649	276	48931	Hello Kitty	kids' & baby brands	25	6	\N	\N	\N
835	292	276	16342	Carter's	kids' & baby brands	1	6	\N	\N	\N
816	281	276	27058	Toddler Boys (2T-5T)	boys	0	3	\N	\N	\N
817	282	276	62971	Boys 2-7	boys	1	3	\N	\N	\N
818	283	276	25325	Boys 8-20	boys	2	3	\N	\N	\N
812	624	276	63010	Coats & Jackets	kids' & baby clothing	2	4	\N	\N	\N
836	639	276	71187	Calvin Klein	kids' & baby brands	3	6	\N	\N	\N
821	299	276	63009	Accessories & Backpacks	kids' & baby clothing	0	4	\N	\N	\N
811	623	276	61228	Activewear	kids' & baby clothing	1	4	\N	\N	\N
820	284	276	61999	All Boys	boys	7	3	\N	\N	\N
815	280	276	61998	All Girls	girls	7	2	\N	\N	\N
845	644	276	69692	Frozen	kids' & baby brands	20	6	\N	\N	\N
823	629	276	63011	Leggings & Pants	kids' & baby clothing	5	4	\N	\N	\N
824	630	276	65451	Pajamas	kids' & baby clothing	6	4	\N	\N	\N
825	631	276	30057	School Uniforms	kids' & baby clothing	7	4	\N	\N	\N
826	632	276	63013	Sets & Outfits	kids' & baby clothing	8	4	\N	\N	\N
827	633	276	63014	Shirts & Tees	kids' & baby clothing	9	4	\N	\N	\N
814	626	276	48561	Shoes	kids' & baby clothing	10	4	\N	\N	\N
822	628	276	63008	Jeans	kids' & baby clothing	4	4	\N	\N	\N
829	635	276	31462	Skirts	kids' & baby clothing	12	4	\N	\N	\N
819	627	276	63016	Suits & Dress Shirts	kids' & baby clothing	13	4	\N	\N	\N
830	636	276	65543	Sweaters	kids' & baby clothing	14	4	\N	\N	\N
831	637	276	55163	Swimwear	kids' & baby clothing	15	4	\N	\N	\N
832	638	276	65582	Underwear & Socks	kids' & baby clothing	16	4	\N	\N	\N
855	301	276	61141	Halloween Shop	kids' style watch	2	7	\N	\N	\N
851	650	276	63100	Melissa and Doug	kids' & baby brands	26	6	\N	\N	\N
837	640	276	60852	Epic Threads	kids' & baby brands	5	6	\N	\N	\N
852	651	276	70470	Nautica	kids' & baby brands	27	6	\N	\N	\N
838	641	276	32298	First Impressions	kids' & baby brands	7	6	\N	\N	\N
839	294	276	45095	Levi's	kids' & baby brands	9	6	\N	\N	\N
853	652	276	59230	Puma	kids' & baby brands	28	6	\N	\N	\N
840	295	276	62430	Nike	kids' & baby brands	11	6	\N	\N	\N
841	296	276	14355	Ralph Lauren Childrenswear	kids' & baby brands	13	6	\N	\N	\N
854	298	276	63574	See All Brands	kids' & baby brands	29	6	\N	\N	\N
842	297	276	40660	The North Face	kids' & baby brands	15	6	\N	\N	\N
843	642	276	45097	Tommy Hilfiger	kids' & baby brands	17	6	\N	\N	\N
856	302	276	26073	Holiday Shop	kids' style watch	3	7	\N	\N	\N
844	643	276	63114	Under Armour	kids' & baby brands	19	6	\N	\N	\N
846	645	276	66707	Graco	kids' & baby brands	21	6	\N	\N	\N
847	646	276	33448	GUESS	kids' & baby brands	22	6	\N	\N	\N
848	647	276	64809	Little Me	kids' & baby brands	23	6	\N	\N	\N
849	648	276	60292	adidas	kids' & baby brands	24	6	\N	\N	\N
861	656	276	70805	Kids' Luggage and Backpacks	more for kids' & baby	4	8	\N	\N	\N
857	653	276	81842	Mix & Match	more for kids' & baby	0	8	\N	\N	\N
858	303	276	22911	Toys & Games	more for kids' & baby	1	8	\N	\N	\N
859	654	276	23484	Kids' & Baby Room	more for kids' & baby	2	8	\N	\N	\N
860	655	276	33222	Kids' Jewelry & Watches	more for kids' & baby	3	8	\N	\N	\N
862	293	276	63270	Finish Line Athletic Shoes	more for kids' & baby	5	8	\N	\N	\N
863	657	276	65701	Sports Fan Shop by Lids	more for kids' & baby	6	8	\N	\N	\N
865	166	304	101043	Apple Watch	featured active brands	1	1	\N	\N	\N
866	658	304	67609	Fitbit	featured active brands	3	1	\N	\N	\N
867	207	304	64942	Polo Sport	featured active brands	6	1	\N	\N	\N
872	661	304	3291	Swimwear	men's active	7	2	\N	\N	\N
869	659	304	60886	Golf Shop	men's active	0	2	\N	\N	\N
871	660	304	55642	Sneakers & Athletic Shoes	men's active	5	2	\N	\N	\N
868	314	304	65701	Sports Team Gear	kids' active	6	4	\N	\N	\N
813	625	276	31460	Dresses 	kids' & baby clothing	3	4	\N	\N	\N
870	173	304	3296	T-Shirts	men's active	8	2	\N	\N	\N
789	120	235	32918	Trendy Plus Sizes	more choices, more sizes	1	5	\N	\N	\N
793	265	235	102244	Trolls Shop	featured shops	6	6	\N	\N	\N
878	95	304	29891	Swimwear	women's active	6	3	\N	\N	\N
879	667	304	53727	Tops & T-Shirts	women's active	7	3	\N	\N	\N
880	668	304	53874	Yoga	women's active	8	3	\N	\N	\N
882	670	304	34051	Plus Size Active	women's active	10	3	\N	\N	\N
883	305	304	61228	T-Shirts	kids' active	8	4	\N	\N	\N
894	359	315	58476	Gifts with Purchase	special offers	3	1	\N	\N	\N
888	309	304	7583	Juicers	healthy living	2	6	\N	\N	\N
884	307	304	70934	Fitness Trackers & Gadgets	active accessories	2	5	\N	\N	\N
900	213	315	30088	Men's Cologne & Grooming	shop by category	9	2	\N	\N	\N
903	331	315	68594	Travel Size	shop by category	15	2	\N	\N	\N
921	675	315	82442	All Impulse Brands	impulse beauty brands	15	4	\N	\N	\N
906	335	315	47099	Clarins	beauty brands	5	3	\N	\N	\N
885	311	304	74790	Sport Sunglasses	active accessories	4	5	\N	\N	\N
889	671	304	23487	Massagers	healthy living	3	6	\N	\N	\N
890	81	304	70809	Sleep Solutions	healthy living	4	6	\N	\N	\N
891	312	304	61581	Sunscreen & Lotions	healthy living	5	6	\N	\N	\N
892	672	304	16853	Towels	healthy living	6	6	\N	\N	\N
893	358	315	55537	Gifts & Value Sets	special offers	1	1	\N	\N	\N
897	347	315	30087	Fragrance	shop by category	3	2	\N	\N	\N
864	9	304	0	Top Fitness Clothing Brands	guides & inspiration	3	7	\N	\N	\N
896	328	315	58499	Bath & Body	shop by category	1	2	\N	\N	\N
904	332	315	46216	Bobbi Brown	beauty brands	1	3	\N	\N	\N
874	663	304	53958	Pants & Leggings	women's active	1	3	\N	\N	\N
905	333	315	61916	CHANEL	fragrance brands	5	5	\N	\N	\N
922	676	315	31616	BURBERRY	fragrance brands	1	5	\N	\N	\N
875	664	304	61433	Shorts	women's active	2	3	\N	\N	\N
909	337	315	28688	Lancôme	beauty brands	11	3	\N	\N	\N
876	665	304	26499	Sneakers	women's active	3	3	\N	\N	\N
908	336	315	33607	Estée Lauder	beauty brands	9	3	\N	\N	\N
923	349	315	31619	Calvin Klein	fragrance brands	3	5	\N	\N	\N
886	308	304	46710	Blenders	healthy living	0	6	\N	\N	\N
912	340	315	25677	Shiseido	beauty brands	17	3	\N	\N	\N
877	666	304	54019	Sports Bras	women's active	4	3	\N	\N	\N
910	338	315	45678	MAC	beauty brands	13	3	\N	\N	\N
907	334	315	37070	Clinique	beauty brands	7	3	\N	\N	\N
911	339	315	33668	Origins	beauty brands	15	3	\N	\N	\N
887	310	304	65825	Fans & Humidifiers	healthy living	1	6	\N	\N	\N
895	360	315	72195	Only at Macy's	special offers	5	1	\N	\N	\N
902	330	315	56234	Tools & Brushes	shop by category	13	2	\N	\N	\N
914	342	315	65894	Anastasia Beverly Hills	impulse beauty brands	1	4	\N	\N	\N
899	322	315	30077	Makeup	shop by category	7	2	\N	\N	\N
898	329	315	60600	Hair Care	shop by category	5	2	\N	\N	\N
881	669	304	41973	Juniors' Active	women's active	9	3	\N	\N	\N
913	341	315	63556	All Beauty Brands	beauty brands	19	3	\N	\N	\N
915	343	315	5201	Benefit Cosmetics	impulse beauty brands	3	4	\N	\N	\N
901	327	315	30078	Skin Care	shop by category	11	2	\N	\N	\N
916	673	315	51752	Clarisonic	impulse beauty brands	5	4	\N	\N	\N
924	677	315	53005	COACH	fragrance brands	7	5	\N	\N	\N
917	674	315	75901	m-61	impulse beauty brands	7	4	\N	\N	\N
918	344	315	15099	philosophy	impulse beauty brands	9	4	\N	\N	\N
933	9	315	0	#macyslove Photo Gallery	beauty trends & advice	5	6	\N	\N	\N
919	345	315	55573	Urban Decay	impulse beauty brands	11	4	\N	\N	\N
925	350	315	5204	Dior	fragrance brands	9	5	\N	\N	\N
920	274	315	70429	The Impulse Shop	impulse beauty brands	13	4	\N	\N	\N
926	351	315	31628	DOLCE & GABBANA	fragrance brands	11	5	\N	\N	\N
927	678	315	31711	GUCCI	fragrance brands	13	5	\N	\N	\N
928	352	315	30150	Michael Kors	fragrance brands	15	5	\N	\N	\N
929	354	315	31746	Ralph Lauren	fragrance brands	17	5	\N	\N	\N
930	679	315	66024	Tom Ford	fragrance brands	19	5	\N	\N	\N
931	680	315	65814	All Cologne Brands	fragrance brands	21	5	\N	\N	\N
934	682	315	99842	The Pink Shop	beauty trends & advice	7	6	\N	\N	\N
932	681	315	65813	All Perfume Brands	fragrance brands	23	5	\N	\N	\N
935	683	315	103752	Now Trending at Macy's	beauty trends & advice	9	6	\N	\N	\N
936	684	315	65384	What's New	beauty trends & advice	11	6	\N	\N	\N
16	43	1	36896	Charter Club	home brands	3	3	\N	\N	\N
86	9	55	0	Bedding Buying Guide	more bedroom essentials	0	5	\N	\N	\N
64	90	55	60363	Martha Stewart Collection	brands	5	4	\N	\N	\N
32	751	1	0	Grandin Road Halloween Décor	featured shops	11	4	\N	\N	\N
126	157	94	44498	Free People	women's brands	7	6	\N	\N	\N
92	97	94	225	Bras, Panties & Shapewear	women's clothing	2	1	\N	\N	\N
146	151	94	35784	Karen Scott	women's brands	33	6	\N	\N	\N
163	553	94	75816	Fame and Partners	women's brands	50	6	\N	\N	\N
648	180	172	25995	Hoodies & Sweatshirts	men's clothing	8	1	\N	\N	\N
674	214	172	49167	Gifts, Gadgets & Audio	accessories	4	3	\N	\N	\N
697	566	172	29884	Buffalo David Bitton	men's brands	26	4	\N	\N	\N
708	575	172	54272	Jockey	men's brands	37	4	\N	\N	\N
956	79	65	52096	Mattress & Pillow Protectors	bedding basics	3	3	\N	\N	\N
737	594	172	79643	Shop Hispanic Heritage Month	featured shops	5	6	\N	\N	\N
759	252	235	28001	Wear to Work	juniors' clothing	16	1	\N	\N	\N
810	279	276	25324	Girls 7-16	girls	2	2	\N	\N	\N
957	81	65	29483	Memory Foam Bedding	bedding basics	4	3	\N	\N	\N
504	379	362	63268	Finish Line Athletic Shoes	featured shops	0	4	\N	\N	\N
958	82	65	28901	Pillows	bedding basics	5	3	\N	\N	\N
985	755	65	0	Bedding Buying Guide	more bedroom essentials	0	5	\N	\N	\N
960	76	65	70527	All Bedding Basics	bedding basics	7	3	\N	\N	\N
981	116	65	59103	Trina Turk	brands	30	4	\N	\N	\N
961	96	65	60364	Hotel Collection	brands	1	4	\N	\N	\N
962	94	65	7515	Charter Club	brands	3	4	\N	\N	\N
684	225	172	31776	INC International Concepts	men's brands	7	4	\N	\N	\N
982	101	65	13759	Waterford	brands	31	4	\N	\N	\N
722	209	172	64998	Under Armour	activewear	5	5	\N	\N	\N
963	98	65	60363	Martha Stewart Collection	brands	5	4	\N	\N	\N
964	99	65	65577	Ralph Lauren	brands	7	4	\N	\N	\N
833	300	276	65147	All Characters	character shop	5	5	\N	\N	\N
983	117	65	71660	Under The Canopy	brands	32	4	\N	\N	\N
834	9	276	0	Kids Winter Fashions & Trends	kids' style watch	1	7	\N	\N	\N
965	100	65	27828	Tommy Hilfiger	brands	9	4	\N	\N	\N
950	753	65	36321	Kids' & Baby Bedding	bedding	7	2	\N	\N	\N
966	93	65	60354	Calvin Klein	brands	11	4	\N	\N	\N
558	9	428	0	#macyslove Photo Gallery	what's trending	0	6	\N	\N	\N
597	471	454	63568	See All Brands	watch brands	24	3	\N	\N	\N
937	102	65	8237	All Bath	bath	0	1	\N	\N	\N
938	84	65	8240	Bath Rugs & Bath Mats	bath	1	1	\N	\N	\N
939	86	65	16853	Bath Towels	bath	2	1	\N	\N	\N
940	85	65	22094	Bathroom Accessories	bath	3	1	\N	\N	\N
941	90	65	58936	Shower Curtains & Accessories	bath	4	1	\N	\N	\N
942	33	65	23487	Personal Care	bath	5	1	\N	\N	\N
943	66	65	7502	Bedding Collections	bedding	0	2	\N	\N	\N
944	67	65	26795	Bed in a Bag	bedding	1	2	\N	\N	\N
945	68	65	78458	Comforters	bedding	2	2	\N	\N	\N
946	69	65	37945	Decorative & Throw Pillows	bedding	3	2	\N	\N	\N
947	70	65	25045	Duvet Covers	bedding	4	2	\N	\N	\N
948	71	65	22748	Quilts & Bedspreads	bedding	5	2	\N	\N	\N
949	72	65	9915	Sheets	bedding	6	2	\N	\N	\N
959	754	65	70809	Sleep Solutions	bedding basics	6	3	\N	\N	\N
951	74	65	12398	Teen Bedding	bedding	8	2	\N	\N	\N
952	103	65	46529	Winter Bedding	bedding	9	2	\N	\N	\N
953	77	65	29405	Blankets & Throws	bedding basics	0	3	\N	\N	\N
954	78	65	28898	Comforters: Down & Alternative	bedding basics	1	3	\N	\N	\N
955	80	65	40384	Mattress Pads & Toppers	bedding basics	2	3	\N	\N	\N
984	118	65	63560	See All Brands	brands	33	4	\N	\N	\N
967	97	65	14115	Lacoste	brands	13	4	\N	\N	\N
968	95	65	60314	Croscill	brands	15	4	\N	\N	\N
989	756	120	29891	Activewear	women's clothing	0	1	\N	\N	\N
969	104	65	60315	J Queen New York	brands	17	4	\N	\N	\N
970	105	65	58118	Tommy Bahama	brands	19	4	\N	\N	\N
971	106	65	57827	Bar III	brands	20	4	\N	\N	\N
972	107	65	58111	Barbara Barry	brands	21	4	\N	\N	\N
973	108	65	59474	Donna Karan	brands	22	4	\N	\N	\N
974	109	65	58114	Echo	brands	23	4	\N	\N	\N
975	110	65	61877	INC International Concepts	brands	24	4	\N	\N	\N
976	111	65	53264	Lenox	brands	25	4	\N	\N	\N
977	112	65	70902	Kate Spade	brands	26	4	\N	\N	\N
978	113	65	74670	Kelly Ripa	brands	27	4	\N	\N	\N
979	114	65	66247	Nautica	brands	28	4	\N	\N	\N
980	115	65	65421	Tracy Porter	brands	29	4	\N	\N	\N
986	119	65	35420	Bedroom Furniture	more bedroom essentials	1	5	\N	\N	\N
987	7	65	25931	Mattresses	more bedroom essentials	2	5	\N	\N	\N
988	38	65	92645	Fine Linens	more bedroom essentials	3	5	\N	\N	\N
1006	757	120	40546	Tights, Socks & Hosiery	women's clothing	17	1	\N	\N	\N
990	122	120	55429	Blazers	women's clothing	1	1	\N	\N	\N
991	123	120	225	Bras, Panties & Shapewear	women's clothing	2	1	\N	\N	\N
992	124	120	269	Coats	women's clothing	3	1	\N	\N	\N
993	125	120	5449	Dresses	women's clothing	4	1	\N	\N	\N
994	126	120	120	Jackets	women's clothing	5	1	\N	\N	\N
995	127	120	3111	Jeans	women's clothing	6	1	\N	\N	\N
996	128	120	50684	Jumpsuits & Rompers	women's clothing	7	1	\N	\N	\N
997	129	120	46905	Leggings	women's clothing	8	1	\N	\N	\N
999	131	120	59737	Pajamas & Robes	women's clothing	10	1	\N	\N	\N
1000	132	120	157	Pants & Capris	women's clothing	11	1	\N	\N	\N
1001	133	120	5344	Shorts	women's clothing	12	1	\N	\N	\N
1002	134	120	131	Skirts	women's clothing	13	1	\N	\N	\N
1003	135	120	67592	Suits & Suit Separates	women's clothing	14	1	\N	\N	\N
1004	136	120	260	Sweaters	women's clothing	15	1	\N	\N	\N
1005	137	120	8699	Swimwear	women's clothing	16	1	\N	\N	\N
549	772	391	0	Kids Winter Fashions & Trends	kids' style watch	1	7	\N	\N	\N
1007	139	120	255	Tops	women's clothing	18	1	\N	\N	\N
1008	140	120	72589	Vests	women's clothing	19	1	\N	\N	\N
1009	141	120	39096	Wear to Work	women's clothing	20	1	\N	\N	\N
1010	142	120	34049	Coats	plus sizes	0	2	\N	\N	\N
1011	143	120	37038	Dresses	plus sizes	1	2	\N	\N	\N
1012	145	120	34048	Tops	plus sizes	2	2	\N	\N	\N
998	130	120	66718	All Maternity	maternity	2	4	\N	\N	\N
1014	147	120	32147	All Plus Sizes	plus sizes	4	2	\N	\N	\N
1015	148	120	57535	Coats	petites	0	3	\N	\N	\N
1016	149	120	55596	Dresses	petites	1	3	\N	\N	\N
1017	150	120	55607	Pants & Capris	petites	2	3	\N	\N	\N
1018	151	120	55613	Tops	petites	3	3	\N	\N	\N
1019	152	120	18579	All Petites	petites	4	3	\N	\N	\N
1013	758	120	32918	Trendy Plus Sizes	plus sizes	3	2	\N	\N	\N
1020	189	120	55213	Contemporary Clothing	contemporary & juniors	0	5	\N	\N	\N
1021	198	120	16904	Juniors	contemporary & juniors	1	5	\N	\N	\N
1054	179	120	69907	Thalia Sodi	women's brands	42	6	\N	\N	\N
1022	172	120	17994	Alfani	women's brands	1	6	\N	\N	\N
1023	160	120	13156	Calvin Klein	women's brands	3	6	\N	\N	\N
1055	169	120	64869	Under Armour	women's brands	43	6	\N	\N	\N
1024	173	120	11427	Charter Club	women's brands	5	6	\N	\N	\N
1025	183	120	44498	Free People	women's brands	7	6	\N	\N	\N
1056	212	120	10775	Adidas	women's brands	44	6	\N	\N	\N
1026	175	120	3481	INC International Concepts	women's brands	9	6	\N	\N	\N
1027	161	120	3485	Lauren Ralph Lauren	women's brands	11	6	\N	\N	\N
1057	159	120	68357	Adrianna Papell	women's brands	45	6	\N	\N	\N
1028	163	120	14728	MICHAEL Michael Kors	women's brands	13	6	\N	\N	\N
1029	178	120	29630	Style & Co.	women's brands	15	6	\N	\N	\N
1058	213	120	80418	Alfred Dunner	women's brands	46	6	\N	\N	\N
1030	167	120	31074	The North Face	women's brands	17	6	\N	\N	\N
1076	760	120	29440	Hats, Scarves & Wraps	shoes & accessories	2	8	\N	\N	\N
1032	170	120	59981	Vince Camuto	women's brands	20	6	\N	\N	\N
1033	199	120	71353	32 Degrees	women's brands	21	6	\N	\N	\N
1034	200	120	67663	American Living	women's brands	22	6	\N	\N	\N
1035	201	120	18413	Anne Klein	women's brands	23	6	\N	\N	\N
1036	180	120	54641	Bar III	women's brands	24	6	\N	\N	\N
1037	202	120	42982	BCBGMAXAZRIA	women's brands	25	6	\N	\N	\N
1038	203	120	83142	Catherine Malandrino	women's brands	26	6	\N	\N	\N
1039	182	120	64883	Eileen Fisher	women's brands	27	6	\N	\N	\N
1040	174	120	15131	Ideology	women's brands	28	6	\N	\N	\N
1041	204	120	69934	Ivanka Trump	women's brands	29	6	\N	\N	\N
1042	176	120	50449	JM Collection	women's brands	30	6	\N	\N	\N
1043	205	120	46356	Jones New York	women's brands	31	6	\N	\N	\N
1044	206	120	68392	Karen Kane	women's brands	32	6	\N	\N	\N
1045	177	120	35784	Karen Scott	women's brands	33	6	\N	\N	\N
1046	207	120	79913	Lee Platinum	women's brands	34	6	\N	\N	\N
1047	208	120	69131	Nautica	women's brands	35	6	\N	\N	\N
1048	164	120	6218	Nike	women's brands	36	6	\N	\N	\N
1049	209	120	69589	NY Collection	women's brands	37	6	\N	\N	\N
1050	210	120	39333	NYDJ	women's brands	38	6	\N	\N	\N
1051	187	120	69044	Polo Ralph Lauren	women's brands	39	6	\N	\N	\N
1052	188	120	49902	RACHEL Rachel Roy	women's brands	40	6	\N	\N	\N
1053	211	120	65262	Tahari by ASL	women's brands	41	6	\N	\N	\N
1059	214	120	71392	B Michael	women's brands	47	6	\N	\N	\N
1060	215	120	71115	CeCe	women's brands	48	6	\N	\N	\N
1061	216	120	100751	ECI	women's brands	49	6	\N	\N	\N
1062	217	120	75816	Fame and Partners	women's brands	50	6	\N	\N	\N
1063	218	120	71322	G.H. Bass & Co.	women's brands	51	6	\N	\N	\N
1064	162	120	30760	Levi's	women's brands	52	6	\N	\N	\N
1065	171	120	63539	See All Brands	women's brands	53	6	\N	\N	\N
1072	158	120	99842	The Pink Shop	featured shops	11	7	\N	\N	\N
1067	153	120	262	Cashmere Shop	featured shops	1	7	\N	\N	\N
1073	62	120	68223	The Wedding Shop	featured shops	12	7	\N	\N	\N
1068	190	120	85842	Designer Shop	featured shops	4	7	\N	\N	\N
1074	193	120	669	Beauty	shoes & accessories	0	8	\N	\N	\N
1066	759	120	0	Office Must Haves	featured shops	7	7	\N	\N	\N
1069	219	120	79644	Shop Hispanic Heritage Month	featured shops	8	7	\N	\N	\N
1070	165	120	96742	Sports Fan Shop By Lids	featured shops	9	7	\N	\N	\N
1071	166	120	69211	The Fur Vault	featured shops	10	7	\N	\N	\N
1075	194	120	26846	Handbags & Accessories	shoes & accessories	1	8	\N	\N	\N
1077	196	120	13247	Shoes	shoes & accessories	3	8	\N	\N	\N
1078	220	120	58128	Sunglasses	shoes & accessories	4	8	\N	\N	\N
1079	761	221	3296	All Active Brands	activewear	6	5	\N	\N	\N
1080	247	221	45758	Big & Tall	men's clothing	1	1	\N	\N	\N
1081	223	221	16499	Blazers & Sport Coats	men's clothing	2	1	\N	\N	\N
1082	224	221	20627	Casual Button-Down Shirts	men's clothing	3	1	\N	\N	\N
1083	225	221	3763	Coats & Jackets	men's clothing	4	1	\N	\N	\N
1084	226	221	20635	Dress Shirts	men's clothing	5	1	\N	\N	\N
1085	227	221	60886	Golf Shop	men's clothing	6	1	\N	\N	\N
1086	228	221	60451	Guys	men's clothing	7	1	\N	\N	\N
1087	229	221	25995	Hoodies & Sweatshirts	men's clothing	8	1	\N	\N	\N
1088	230	221	11221	Jeans	men's clothing	9	1	\N	\N	\N
1089	250	221	99744	Outdoor Shop	men's clothing	10	1	\N	\N	\N
1090	231	221	16295	Pajamas, Lounge & Sleepwear	men's clothing	11	1	\N	\N	\N
1091	232	221	89	Pants	men's clothing	12	1	\N	\N	\N
1092	233	221	20640	Polos	men's clothing	13	1	\N	\N	\N
1093	284	221	20626	Shirts	men's clothing	14	1	\N	\N	\N
1094	235	221	3310	Shorts	men's clothing	15	1	\N	\N	\N
1095	234	221	17788	Suits & Suit Separates	men's clothing	16	1	\N	\N	\N
1096	236	221	4286	Sweaters	men's clothing	17	1	\N	\N	\N
1097	285	221	3291	Swimwear	men's clothing	18	1	\N	\N	\N
1098	237	221	30423	T-Shirts	men's clothing	19	1	\N	\N	\N
1099	238	221	68524	Tuxedos & Formalwear	men's clothing	20	1	\N	\N	\N
1100	239	221	57	Underwear 	men's clothing	21	1	\N	\N	\N
1101	283	221	75897	Wear to Work	men's clothing	22	1	\N	\N	\N
1102	246	221	65	All Men's Shoes	men's shoes	0	2	\N	\N	\N
1104	763	221	55637	Boots	men's shoes	2	2	\N	\N	\N
1105	764	221	70405	Dress Shoes	men's shoes	3	2	\N	\N	\N
1108	765	221	55642	Sneakers & Athletic 	men's shoes	6	2	\N	\N	\N
1103	762	221	59851	Casual Shoes	men's shoes	1	2	\N	\N	\N
1107	287	221	55641	Slippers	men's shoes	5	2	\N	\N	\N
1112	766	221	30088	Cologne & Grooming	accessories	3	3	\N	\N	\N
1109	259	221	47665	Accessories & Wallets	accessories	0	3	\N	\N	\N
1110	260	221	45016	Bags & Backpacks	accessories	1	3	\N	\N	\N
1111	261	221	47673	Belts & Suspenders	accessories	2	3	\N	\N	\N
1119	767	221	57386	Watches	accessories	10	3	\N	\N	\N
1113	263	221	49167	Gifts, Gadgets & Audio	accessories	4	3	\N	\N	\N
1114	264	221	47657	Hats, Gloves & Scarves	accessories	5	3	\N	\N	\N
1116	265	221	18245	Socks	accessories	7	3	\N	\N	\N
1117	266	221	58262	Sunglasses by Sunglass Hut	accessories	8	3	\N	\N	\N
1118	267	221	53239	Ties & Pocket Squares	accessories	9	3	\N	\N	\N
1152	255	221	58432	Nike	activewear	2	5	\N	\N	\N
1120	269	221	29415	Alfani	men's brands	1	4	\N	\N	\N
1139	295	221	43206	DKNY	men's brands	29	4	\N	\N	\N
1121	271	221	28169	Calvin Klein	men's brands	3	4	\N	\N	\N
1122	273	221	43145	Dockers	men's brands	5	4	\N	\N	\N
1140	296	221	55271	Greg Norman	men's brands	30	4	\N	\N	\N
1123	274	221	31776	INC International Concepts	men's brands	7	4	\N	\N	\N
1124	275	221	43141	Levi's	men's brands	9	4	\N	\N	\N
1141	297	221	63725	G-Star	men's brands	31	4	\N	\N	\N
1125	276	221	67632	Michael Kors	men's brands	11	4	\N	\N	\N
1126	277	221	46108	Nautica	men's brands	13	4	\N	\N	\N
1142	298	221	29889	GUESS	men's brands	32	4	\N	\N	\N
1127	278	221	3304	Polo Ralph Lauren	men's brands	15	4	\N	\N	\N
1128	280	221	11345	Sean John	men's brands	17	4	\N	\N	\N
1143	299	221	59234	Haggar	men's brands	33	4	\N	\N	\N
1129	281	221	2519	Tommy Hilfiger	men's brands	19	4	\N	\N	\N
1131	289	221	58082	7 for All Mankind	men's brands	21	4	\N	\N	\N
1132	270	221	53433	American Rag	men's brands	22	4	\N	\N	\N
1133	290	221	86842	Armani Exchange	men's brands	23	4	\N	\N	\N
1134	291	221	20392	Armani Jeans	men's brands	24	4	\N	\N	\N
1135	292	221	58083	Bar III	men's brands	25	4	\N	\N	\N
1136	293	221	29884	Buffalo David Bitton	men's brands	26	4	\N	\N	\N
1137	294	221	29414	Club Room	men's brands	27	4	\N	\N	\N
1138	272	221	57979	Denim & Supply Ralph Lauren	men's brands	28	4	\N	\N	\N
1154	308	221	58477	Puma	activewear	3	5	\N	\N	\N
1145	300	221	58084	Hugo Boss	men's brands	35	4	\N	\N	\N
1146	301	221	44356	Izod	men's brands	36	4	\N	\N	\N
1147	302	221	54272	Jockey	men's brands	37	4	\N	\N	\N
1148	303	221	52843	Kenneth Cole	men's brands	38	4	\N	\N	\N
1149	304	221	36943	Lacoste	men's brands	39	4	\N	\N	\N
1150	305	221	38348	LRG	men's brands	40	4	\N	\N	\N
1151	306	221	29883	Lucky Brand Jeans	men's brands	41	4	\N	\N	\N
1161	258	221	64998	Under Armour	activewear	5	5	\N	\N	\N
1153	307	221	26399	Perry Ellis	men's brands	43	4	\N	\N	\N
1177	566	221	65701	Sports Fan Shop By Lids	featured shops	6	6	\N	\N	\N
1155	309	221	11882	Quiksilver	men's brands	45	4	\N	\N	\N
1156	310	221	52099	Tallia	men's brands	46	4	\N	\N	\N
1157	311	221	11046	Tasso Elba	men's brands	47	4	\N	\N	\N
1130	253	221	60285	adidas	activewear	0	5	\N	\N	\N
1159	312	221	3153	Timberland	men's brands	49	4	\N	\N	\N
1160	313	221	21707	Tommy Bahama	men's brands	50	4	\N	\N	\N
1162	254	221	67609	Fitbit	men's brands	52	4	\N	\N	\N
1167	316	221	65292	Vince Camuto	men's brands	58	4	\N	\N	\N
1158	257	221	18253	The North Face	activewear	4	5	\N	\N	\N
1164	314	221	102142	Reebok	men's brands	55	4	\N	\N	\N
1165	279	221	68293	Ryan Seacrest Distinction	men's brands	56	4	\N	\N	\N
1166	315	221	67044	Shaquille O'Neal Collection	men's brands	57	4	\N	\N	\N
1168	317	221	80421	WHT SPACE	men's brands	59	4	\N	\N	\N
1169	318	221	96045	William Rast	men's brands	60	4	\N	\N	\N
1170	319	221	62039	Weatherproof	men's brands	61	4	\N	\N	\N
1171	282	221	63581	See All Brands	men's brands	62	4	\N	\N	\N
1144	768	221	64942	Polo Sport	men's brands	34	4	\N	\N	\N
1172	320	221	61971	Designer Shop	featured shops	0	6	\N	\N	\N
1173	244	221	63266	Finish Line Athletic Shoes	featured shops	1	6	\N	\N	\N
1106	565	221	55640	Sandals & Flip-Flops	men's shoes	4	2	\N	\N	\N
1174	248	221	99042	Halloween Shop	featured shops	3	6	\N	\N	\N
1175	249	221	80616	New Arrivals	featured shops	4	6	\N	\N	\N
1176	321	221	79643	Shop Hispanic Heritage Month	featured shops	5	6	\N	\N	\N
1115	649	221	43877	Jewelry & Cufflinks	accessories	6	3	\N	\N	\N
1178	251	221	80618	Streetwear	featured shops	7	6	\N	\N	\N
1179	323	221	68223	The Wedding Shop	featured shops	8	6	\N	\N	\N
1180	252	221	80617	Trending Now	featured shops	9	6	\N	\N	\N
1181	324	221	47707	Tuxedo Rental Shop	coming soon	1	7	\N	\N	\N
1182	326	325	41973	Activewear	juniors' clothing	0	1	\N	\N	\N
1183	327	325	70950	Basic Essentials	juniors' clothing	1	1	\N	\N	\N
1184	328	325	56273	Bras, Panties & Lingerie	juniors' clothing	2	1	\N	\N	\N
1185	329	325	21115	Coats	juniors' clothing	3	1	\N	\N	\N
1186	330	325	18109	Dresses	juniors' clothing	4	1	\N	\N	\N
1187	331	325	75819	Graphic Clothing	juniors' clothing	5	1	\N	\N	\N
1188	332	325	35786	Jackets & Vests	juniors' clothing	6	1	\N	\N	\N
1189	333	325	28754	Jeans	juniors' clothing	7	1	\N	\N	\N
1190	334	325	17053	Jumpsuits & Rompers	juniors' clothing	8	1	\N	\N	\N
1192	336	325	58666	Pajamas & Robes	juniors' clothing	10	1	\N	\N	\N
1193	337	325	28589	Shorts	juniors' clothing	11	1	\N	\N	\N
1194	338	325	28379	Skirts	juniors' clothing	12	1	\N	\N	\N
1195	339	325	20853	Sweaters	juniors' clothing	13	1	\N	\N	\N
1196	340	325	57597	Swimwear	juniors' clothing	14	1	\N	\N	\N
1197	341	325	17043	Tops	juniors' clothing	15	1	\N	\N	\N
1198	342	325	28001	Wear to Work	juniors' clothing	16	1	\N	\N	\N
1221	381	325	56317	Else Jeans	juniors' brands	29	4	\N	\N	\N
1200	348	325	105542	Mock Neck	must haves	0	2	\N	\N	\N
1201	349	325	98742	Style Statement: Patches	must haves	1	2	\N	\N	\N
1191	335	325	21561	Wide- Leg Pants	must haves	2	2	\N	\N	\N
1222	382	325	57581	Eyeshadow	juniors' brands	30	4	\N	\N	\N
1199	366	325	60983	Under $40	shop by price	3	3	\N	\N	\N
1223	383	325	54637	Miss Me	juniors' brands	31	4	\N	\N	\N
1202	358	325	46810	American Rag	juniors' brands	1	4	\N	\N	\N
1203	367	325	53640	BCX	juniors' brands	3	4	\N	\N	\N
1224	384	325	57582	Planet Gold	juniors' brands	32	4	\N	\N	\N
1204	368	325	57576	Celebrity Pink	juniors' brands	5	4	\N	\N	\N
1205	184	325	34380	GUESS?	juniors' brands	7	4	\N	\N	\N
1225	385	325	28009	Roxy	juniors' brands	33	4	\N	\N	\N
1206	369	325	74667	In Awe of You by AwesomenessTV	juniors' brands	9	4	\N	\N	\N
1207	359	325	53642	Jessica Simpson	juniors' brands	11	4	\N	\N	\N
1226	362	325	63573	See All Brands	juniors' brands	34	4	\N	\N	\N
1208	370	325	30760	Levi's	juniors' brands	13	4	\N	\N	\N
1209	360	325	51951	Material Girl	juniors' brands	15	4	\N	\N	\N
1227	386	325	55213	Contemporary Clothing	more choices, more sizes	0	5	\N	\N	\N
1210	371	325	104553	One Hart	juniors' brands	17	4	\N	\N	\N
1211	361	325	38661	XOXO	juniors' brands	19	4	\N	\N	\N
1212	372	325	17142	Rampage	juniors' brands	20	4	\N	\N	\N
1213	373	325	63017	Marilyn Monroe	juniors' brands	21	4	\N	\N	\N
1214	374	325	54641	Bar III	juniors' brands	22	4	\N	\N	\N
1215	375	325	81022	Lisa Frank	juniors' brands	23	4	\N	\N	\N
1216	376	325	70695	O'Neill	juniors' brands	24	4	\N	\N	\N
1217	377	325	70694	Volcom	juniors' brands	25	4	\N	\N	\N
1218	378	325	57590	Angie	juniors' brands	26	4	\N	\N	\N
1219	379	325	57593	Be Bop	juniors' brands	27	4	\N	\N	\N
1220	380	325	57591	Dollhouse	juniors' brands	28	4	\N	\N	\N
1228	146	325	32918	Trendy Plus Sizes	more choices, more sizes	1	5	\N	\N	\N
1241	400	391	48692	Baby Girl (0-24 months)	baby	0	1	\N	\N	\N
1242	401	391	48693	Baby Boy (0-24 months)	baby	1	1	\N	\N	\N
1230	352	325	102242	Halloween Shop	featured shops	3	6	\N	\N	\N
1231	354	325	70380	Surf Shop	featured shops	4	6	\N	\N	\N
1229	770	325	0	Throwback Shop	featured shops	5	6	\N	\N	\N
1232	355	325	102244	Trolls Shop	featured shops	6	6	\N	\N	\N
1233	356	325	102243	Velvet Shop	featured shops	7	6	\N	\N	\N
1234	357	325	104551	Whimsy Shop	featured shops	8	6	\N	\N	\N
1250	568	391	61228	Activewear	kids' & baby clothing	1	4	\N	\N	\N
1258	423	391	63016	Suits & Dress Shirts	kids' & baby clothing	13	4	\N	\N	\N
1237	389	325	54525	Handbags & Accessories	shoes & accessories	2	7	\N	\N	\N
1238	363	325	53610	Hats, Gloves & Scarves	shoes & accessories	3	7	\N	\N	\N
1252	421	391	31460	Dresses 	kids' & baby clothing	3	4	\N	\N	\N
1240	390	325	58128	Sunglasses	shoes & accessories	5	7	\N	\N	\N
1243	402	391	60045	Baby Shower Gifts	baby	2	1	\N	\N	\N
1244	403	391	58376	Baby Strollers & Gear	baby	3	1	\N	\N	\N
1245	404	391	59563	Newborn Shop	baby	4	1	\N	\N	\N
1246	406	391	64761	All Baby	baby	5	1	\N	\N	\N
1247	392	391	6581	Toddler Girls (2T-5T)	girls	0	2	\N	\N	\N
1248	393	391	62970	Girls 2-6X	girls	1	2	\N	\N	\N
1249	394	391	25324	Girls 7-16	girls	2	2	\N	\N	\N
1239	771	325	57568	Shoes	shoes & accessories	4	7	\N	\N	\N
1254	395	391	61998	All Girls	girls	7	2	\N	\N	\N
1255	396	391	27058	Toddler Boys (2T-5T)	boys	0	3	\N	\N	\N
1256	397	391	62971	Boys 2-7	boys	1	3	\N	\N	\N
1257	398	391	25325	Boys 8-20	boys	2	3	\N	\N	\N
1163	769	221	0	LensCrafters	coming soon	0	7	\N	\N	\N
1236	650	325	55352	Fashion Jewelry	shoes & accessories	1	7	\N	\N	\N
1259	399	391	61999	All Boys	boys	7	3	\N	\N	\N
1260	414	391	63009	Accessories & Backpacks	kids' & baby clothing	0	4	\N	\N	\N
1251	420	391	63010	Coats & Jackets	kids' & baby clothing	2	4	\N	\N	\N
1261	424	391	63008	Jeans	kids' & baby clothing	4	4	\N	\N	\N
1262	425	391	63011	Leggings & Pants	kids' & baby clothing	5	4	\N	\N	\N
1235	567	325	30077	Beauty 	shoes & accessories	0	7	\N	\N	\N
1263	426	391	65451	Pajamas	kids' & baby clothing	6	4	\N	\N	\N
1264	427	391	30057	School Uniforms	kids' & baby clothing	7	4	\N	\N	\N
1265	428	391	63013	Sets & Outfits	kids' & baby clothing	8	4	\N	\N	\N
1266	429	391	63014	Shirts & Tees	kids' & baby clothing	9	4	\N	\N	\N
1267	430	391	63015	Shorts	kids' & baby clothing	11	4	\N	\N	\N
1268	431	391	31462	Skirts	kids' & baby clothing	12	4	\N	\N	\N
1269	432	391	65543	Sweaters	kids' & baby clothing	14	4	\N	\N	\N
1270	433	391	55163	Swimwear	kids' & baby clothing	15	4	\N	\N	\N
1271	434	391	65582	Underwear & Socks	kids' & baby clothing	16	4	\N	\N	\N
1303	256	454	64942	Polo Sport	featured active brands	6	1	\N	\N	\N
1306	222	454	3296	T-Shirts	men's active	8	2	\N	\N	\N
1273	407	391	16342	Carter's	kids' & baby brands	1	6	\N	\N	\N
1305	464	454	60886	Golf Shop	men's active	0	2	\N	\N	\N
1274	435	391	71187	Calvin Klein	kids' & baby brands	3	6	\N	\N	\N
1275	436	391	60852	Epic Threads	kids' & baby brands	5	6	\N	\N	\N
1328	477	454	16853	Towels	healthy living	6	6	\N	\N	\N
1276	437	391	32298	First Impressions	kids' & baby brands	7	6	\N	\N	\N
1304	322	454	65701	Sports Team Gear	kids' active	6	4	\N	\N	\N
1277	409	391	45095	Levi's	kids' & baby brands	9	6	\N	\N	\N
1278	410	391	62430	Nike	kids' & baby brands	11	6	\N	\N	\N
1319	419	454	61228	T-Shirts	kids' active	8	4	\N	\N	\N
1279	411	391	14355	Ralph Lauren Childrenswear	kids' & baby brands	13	6	\N	\N	\N
1280	412	391	40660	The North Face	kids' & baby brands	15	6	\N	\N	\N
1307	465	454	55642	Sneakers & Athletic Shoes	men's active	5	2	\N	\N	\N
1281	438	391	45097	Tommy Hilfiger	kids' & baby brands	17	6	\N	\N	\N
1282	439	391	63114	Under Armour	kids' & baby brands	19	6	\N	\N	\N
1283	440	391	69692	Frozen	kids' & baby brands	20	6	\N	\N	\N
1284	441	391	66707	Graco	kids' & baby brands	21	6	\N	\N	\N
1285	442	391	33448	GUESS	kids' & baby brands	22	6	\N	\N	\N
1286	443	391	64809	Little Me	kids' & baby brands	23	6	\N	\N	\N
1287	444	391	60292	adidas	kids' & baby brands	24	6	\N	\N	\N
1288	445	391	48931	Hello Kitty	kids' & baby brands	25	6	\N	\N	\N
1289	446	391	63100	Melissa and Doug	kids' & baby brands	26	6	\N	\N	\N
1290	447	391	70470	Nautica	kids' & baby brands	27	6	\N	\N	\N
1291	448	391	59230	Puma	kids' & baby brands	28	6	\N	\N	\N
1292	413	391	63574	See All Brands	kids' & baby brands	29	6	\N	\N	\N
1293	416	391	61141	Halloween Shop	kids' style watch	2	7	\N	\N	\N
1294	417	391	26073	Holiday Shop	kids' style watch	3	7	\N	\N	\N
1295	449	391	81842	Mix & Match	more for kids' & baby	0	8	\N	\N	\N
1296	418	391	22911	Toys & Games	more for kids' & baby	1	8	\N	\N	\N
1297	450	391	23484	Kids' & Baby Room	more for kids' & baby	2	8	\N	\N	\N
1301	652	391	65701	Sports Fan Shop by Lids	more for kids' & baby	6	8	\N	\N	\N
1299	452	391	70805	Kids' Luggage and Backpacks	more for kids' & baby	4	8	\N	\N	\N
1300	408	391	63270	Finish Line Athletic Shoes	more for kids' & baby	5	8	\N	\N	\N
1253	422	391	48561	Shoes	kids' & baby clothing	10	4	\N	\N	\N
1302	463	454	67609	Fitbit	featured active brands	3	1	\N	\N	\N
1308	466	454	3291	Swimwear	men's active	7	2	\N	\N	\N
1312	569	454	26499	Sneakers	women's active	3	3	\N	\N	\N
1309	467	454	61361	Jackets & Hoodies	women's active	0	3	\N	\N	\N
1310	468	454	53958	Pants & Leggings	women's active	1	3	\N	\N	\N
1311	469	454	61433	Shorts	women's active	2	3	\N	\N	\N
1313	471	454	54019	Sports Bras	women's active	4	3	\N	\N	\N
1314	121	454	29891	Swimwear	women's active	6	3	\N	\N	\N
1315	472	454	53727	Tops & T-Shirts	women's active	7	3	\N	\N	\N
1316	473	454	53874	Yoga	women's active	8	3	\N	\N	\N
1317	474	454	41973	Juniors' Active	women's active	9	3	\N	\N	\N
1318	475	454	34051	Plus Size Active	women's active	10	3	\N	\N	\N
1320	456	454	70934	Fitness Trackers & Gadgets	active accessories	2	5	\N	\N	\N
1321	460	454	74790	Sport Sunglasses	active accessories	4	5	\N	\N	\N
1329	520	478	55537	Gifts & Value Sets	special offers	1	1	\N	\N	\N
1322	457	454	46710	Blenders	healthy living	0	6	\N	\N	\N
1323	459	454	65825	Fans & Humidifiers	healthy living	1	6	\N	\N	\N
1324	458	454	7583	Juicers	healthy living	2	6	\N	\N	\N
1325	476	454	23487	Massagers	healthy living	3	6	\N	\N	\N
1326	91	454	70809	Sleep Solutions	healthy living	4	6	\N	\N	\N
1327	461	454	61581	Sunscreen & Lotions	healthy living	5	6	\N	\N	\N
1330	521	478	58476	Gifts with Purchase	special offers	3	1	\N	\N	\N
1332	490	478	58499	Bath & Body	shop by category	1	2	\N	\N	\N
1331	522	478	72195	Only at Macy's	special offers	5	1	\N	\N	\N
1333	509	478	30087	Fragrance	shop by category	3	2	\N	\N	\N
1334	491	478	60600	Hair Care	shop by category	5	2	\N	\N	\N
1335	387	478	30077	Makeup	shop by category	7	2	\N	\N	\N
1336	262	478	30088	Men's Cologne & Grooming	shop by category	9	2	\N	\N	\N
1337	489	478	30078	Skin Care	shop by category	11	2	\N	\N	\N
1338	492	478	56234	Tools & Brushes	shop by category	13	2	\N	\N	\N
1339	493	478	68594	Travel Size	shop by category	15	2	\N	\N	\N
1340	775	478	46216	Bobbi Brown	beauty brands	1	3	\N	\N	\N
1341	776	478	61916	CHANEL	fragrance brands	5	5	\N	\N	\N
1342	777	478	47099	Clarins	beauty brands	5	3	\N	\N	\N
1343	778	478	37070	Clinique	beauty brands	7	3	\N	\N	\N
1298	651	391	33222	Kids' Jewelry & Watches	more for kids' & baby	3	8	\N	\N	\N
1365	516	478	31746	Ralph Lauren	fragrance brands	17	5	\N	\N	\N
1366	529	478	66024	Tom Ford	fragrance brands	19	5	\N	\N	\N
1391	241	535	59851	Casual Shoes	men's shoes	2	2	\N	\N	\N
1367	530	478	65814	All Cologne Brands	fragrance brands	21	5	\N	\N	\N
1368	531	478	65813	All Perfume Brands	fragrance brands	23	5	\N	\N	\N
1272	415	391	65147	All Characters	character shop	5	5	\N	\N	\N
1392	243	535	70405	Dress Shoes	men's shoes	3	2	\N	\N	\N
1393	286	535	55640	Sandals & Flip-Flops	men's shoes	4	2	\N	\N	\N
1344	779	478	33607	Estée Lauder	beauty brands	9	3	\N	\N	\N
1394	573	535	55641	Slippers	men's shoes	5	2	\N	\N	\N
1369	788	478	0	#macyslove Photo Gallery	beauty trends & advice	5	6	\N	\N	\N
1345	780	478	28688	Lancôme	beauty brands	11	3	\N	\N	\N
1370	532	478	99842	The Pink Shop	beauty trends & advice	7	6	\N	\N	\N
1395	245	535	55642	Sneakers & Athletic	men's shoes	6	2	\N	\N	\N
1346	781	478	45678	MAC	beauty brands	13	3	\N	\N	\N
1371	533	478	103752	Now Trending at Macy's	beauty trends & advice	9	6	\N	\N	\N
1372	534	478	65384	What's New	beauty trends & advice	11	6	\N	\N	\N
1347	782	478	33668	Origins	beauty brands	15	3	\N	\N	\N
1373	536	535	13616	Booties	women's shoes	0	1	\N	\N	\N
1348	783	478	25677	Shiseido	beauty brands	17	3	\N	\N	\N
1374	537	535	25122	Boots	women's shoes	1	1	\N	\N	\N
1375	538	535	27902	Comfort	women's shoes	2	1	\N	\N	\N
1349	503	478	63556	All Beauty Brands	beauty brands	19	3	\N	\N	\N
1376	539	535	13614	Evening & Bridal	women's shoes	3	1	\N	\N	\N
1350	504	478	65894	Anastasia Beverly Hills	impulse beauty brands	1	4	\N	\N	\N
1377	540	535	50295	Flats	women's shoes	4	1	\N	\N	\N
1378	541	535	71123	Heels	women's shoes	5	1	\N	\N	\N
1351	784	478	5201	Benefit Cosmetics	impulse beauty brands	3	4	\N	\N	\N
1379	542	535	26481	Pumps	women's shoes	6	1	\N	\N	\N
1352	732	478	51752	Clarisonic	impulse beauty brands	5	4	\N	\N	\N
1396	574	535	43387	Sale & Clearance	men's shoes	7	2	\N	\N	\N
1380	543	535	17570	Sandals	women's shoes	7	1	\N	\N	\N
1353	524	478	75901	m-61	impulse beauty brands	7	4	\N	\N	\N
1397	575	535	63582	All Men's Brands	men's shoes	8	2	\N	\N	\N
1354	506	478	15099	philosophy	impulse beauty brands	9	4	\N	\N	\N
1381	544	535	16108	Slippers	women's shoes	8	1	\N	\N	\N
1355	785	478	55573	Urban Decay	impulse beauty brands	11	4	\N	\N	\N
1356	364	478	70429	The Impulse Shop	impulse beauty brands	13	4	\N	\N	\N
1398	556	535	55822	All Men's Shoes	men's shoes	9	2	\N	\N	\N
1382	470	535	26499	Sneakers	women's shoes	9	1	\N	\N	\N
1357	525	478	82442	All Impulse Brands	impulse beauty brands	15	4	\N	\N	\N
1358	733	478	31616	BURBERRY	fragrance brands	1	5	\N	\N	\N
1383	545	535	13808	Wedges	women's shoes	10	1	\N	\N	\N
1359	511	478	31619	Calvin Klein	fragrance brands	3	5	\N	\N	\N
1360	527	478	53005	COACH	fragrance brands	7	5	\N	\N	\N
1384	570	535	60378	Wide & Narrow Widths	women's shoes	11	1	\N	\N	\N
1361	786	478	5204	Dior	fragrance brands	9	5	\N	\N	\N
1362	787	478	31628	DOLCE & GABBANA	fragrance brands	11	5	\N	\N	\N
1385	546	535	32459	Winter & Rain Boots	women's shoes	12	1	\N	\N	\N
1363	734	478	31711	GUCCI	fragrance brands	13	5	\N	\N	\N
1364	514	478	30150	Michael Kors	fragrance brands	15	5	\N	\N	\N
1407	601	580	69603	Designer Handbags	handbag brands	1	1	\N	\N	\N
1386	571	535	13604	Sale & Clearance	women's shoes	13	1	\N	\N	\N
1387	555	535	63583	All Women's Brands	women's shoes	14	1	\N	\N	\N
1388	547	535	56233	All Women's Shoes	women's shoes	15	1	\N	\N	\N
1389	572	535	55636	Boat Shoes	men's shoes	0	2	\N	\N	\N
1390	240	535	55637	Boots	men's shoes	1	2	\N	\N	\N
1399	576	535	48561	All Kids' Shoes	kids' shoes	4	3	\N	\N	\N
1400	551	535	63268	Finish Line Athletic Shoes	featured shops	0	4	\N	\N	\N
1401	561	535	59406	Impulse Contemporary Shoes	featured shops	1	4	\N	\N	\N
1402	365	535	57568	Junior's Shoes	featured shops	2	4	\N	\N	\N
1403	577	535	68244	The Wedding Shop	featured shops	3	4	\N	\N	\N
1404	560	535	50763	Women's Designer Shoes	featured shops	4	4	\N	\N	\N
1405	578	535	39395	Women's Shoe Trends	featured shops	5	4	\N	\N	\N
1406	579	535	40546	Women's Socks and Hosiery	featured shops	6	4	\N	\N	\N
1408	789	580	54498	Calvin Klein	handbag brands	3	1	\N	\N	\N
1412	607	580	35848	GUESS	handbag brands	11	1	\N	\N	\N
1409	790	580	25300	COACH	handbag brands	5	1	\N	\N	\N
1410	791	580	27725	Dooney & Bourke	handbag brands	7	1	\N	\N	\N
1416	793	580	27726	MICHAEL Michael Kors	handbag brands	19	1	\N	\N	\N
1411	792	580	28743	Fossil	handbag brands	9	1	\N	\N	\N
1413	608	580	63441	INC International Concepts	handbag brands	13	1	\N	\N	\N
1415	611	580	52273	Lauren Ralph Lauren	handbag brands	17	1	\N	\N	\N
1414	609	580	69630	kate spade new york	handbag brands	15	1	\N	\N	\N
1417	617	580	66127	Nine West Crossbody Bags	handbag brands	20	1	\N	\N	\N
1418	618	580	66119	Nine West Handbags	handbag brands	21	1	\N	\N	\N
1419	619	580	66128	Nine West Satchels	handbag brands	22	1	\N	\N	\N
1420	620	580	66126	Nine West Totes	handbag brands	23	1	\N	\N	\N
1421	621	580	66116	Nine West Wallets & Accessories	handbag brands	24	1	\N	\N	\N
1422	614	580	59477	Tommy Hilfiger	handbag brands	25	1	\N	\N	\N
1423	616	580	63570	See All Brands	handbag brands	27	1	\N	\N	\N
1424	581	580	51906	Backpacks	handbags & wallets	0	2	\N	\N	\N
1427	622	580	70642	Gym Bags	handbags & wallets	3	2	\N	\N	\N
1428	623	580	46012	Hobo Bags	handbags & wallets	4	2	\N	\N	\N
1429	584	580	72698	Mini Bags	handbags & wallets	5	2	\N	\N	\N
1430	585	580	27693	Saddle Bags	handbags & wallets	6	2	\N	\N	\N
1431	624	580	46013	Satchels	handbags & wallets	7	2	\N	\N	\N
1432	586	580	46014	Shoulder Bags	handbags & wallets	8	2	\N	\N	\N
1433	587	580	46015	Tote Bags	handbags & wallets	9	2	\N	\N	\N
1434	588	580	27689	Wallets & Wristlets	handbags & wallets	10	2	\N	\N	\N
1435	589	580	27686	All Handbags	handbags & wallets	11	2	\N	\N	\N
1425	582	580	27691	The Wedding Shop	trending now	3	5	\N	\N	\N
1460	642	626	79009	INC International Concepts	jewelry brands	7	4	\N	\N	\N
1437	593	580	27807	Belts	accessories	0	4	\N	\N	\N
1438	594	580	77979	Hats & Hair Accessories	accessories	1	4	\N	\N	\N
1439	595	580	71476	Personalization Shop	accessories	2	4	\N	\N	\N
1440	596	580	31957	Scarves & Wraps	accessories	3	4	\N	\N	\N
1441	197	580	28295	Sunglasses by Sunglass Hut	accessories	4	4	\N	\N	\N
1442	138	580	40546	Tights, Socks, & Hosiery	accessories	5	4	\N	\N	\N
1444	597	580	80625	Winter Accessories	accessories	7	4	\N	\N	\N
1456	388	626	55352	Kate Spade New York	jewelry brands	9	4	\N	\N	\N
1446	590	580	28265	Handbag & Accessory Trends	trending now	1	5	\N	\N	\N
1447	625	580	53610	Impulse Contemporary Brands	trending now	2	5	\N	\N	\N
1481	663	661	71570	All Smart Watches	smart watches	5	2	\N	\N	\N
1461	643	626	65939	Le Vian Shop	jewelry brands	11	4	\N	\N	\N
1483	696	661	79488	Samsung	watch brands	22	3	\N	\N	\N
1462	644	626	68701	Marchesa	jewelry brands	13	4	\N	\N	\N
1443	191	580	29440	All Accessories	accessories	8	4	\N	\N	\N
1479	796	661	101043	Apple Watch	watch brands	3	3	\N	\N	\N
1436	599	580	69112	All Tech Accessories	tech accessories	2	3	\N	\N	\N
1448	627	626	10834	Bracelets	fine jewelry	0	1	\N	\N	\N
1449	628	626	57702	Diamonds	fine jewelry	1	1	\N	\N	\N
1450	629	626	10835	Earrings	fine jewelry	2	1	\N	\N	\N
1451	630	626	2903	Gemstones	fine jewelry	3	1	\N	\N	\N
1452	631	626	9569	Necklaces 	fine jewelry	4	1	\N	\N	\N
1453	632	626	21176	Rings	fine jewelry	5	1	\N	\N	\N
1455	634	626	65993	All Fine Jewelry	fine jewelry	7	1	\N	\N	\N
1463	645	626	63913	Michael Kors	jewelry brands	15	4	\N	\N	\N
1464	653	626	102642	Nambé	jewelry brands	17	4	\N	\N	\N
1484	664	661	57415	Anne Klein	watch brands	1	3	\N	\N	\N
1465	646	626	72179	Swarovski	jewelry brands	19	4	\N	\N	\N
1466	654	626	70803	X3	jewelry brands	20	4	\N	\N	\N
1457	451	626	33222	Kids' Jewelry & Watches	shop categories	0	3	\N	\N	\N
1458	288	626	43877	Men's Jewelry & Accessories	shop categories	1	3	\N	\N	\N
1467	655	626	55689	COACH	jewelry brands	21	4	\N	\N	\N
1490	670	661	57371	GUESS	watch brands	15	3	\N	\N	\N
1459	641	626	63694	EFFY Shop	jewelry brands	3	4	\N	\N	\N
1468	647	626	65448	See All Brands	jewelry brands	22	4	\N	\N	\N
1445	794	580	0	Trolls	trending now	4	5	\N	\N	\N
1469	656	626	60053	Anniversary Bands	wedding jewelry	0	5	\N	\N	\N
1470	635	626	68271	Day-Of Jewelry	wedding jewelry	1	5	\N	\N	\N
1471	636	626	68249	All Wedding Jewelry	wedding jewelry	2	5	\N	\N	\N
1454	795	626	0	#macyslove Photo Gallery	what's trending	0	6	\N	\N	\N
1472	657	626	42041	Impulse Jewelry	what's trending	1	6	\N	\N	\N
1473	658	626	55305	Jewelry Boxes & Accessories	what's trending	2	6	\N	\N	\N
1474	648	626	60194	Personalized Jewelry	what's trending	3	6	\N	\N	\N
1475	659	626	65291	Red Box Gifts	what's trending	4	6	\N	\N	\N
1476	660	626	23930	Watches	watches	0	7	\N	\N	\N
1477	268	661	57386	Men's Watches	watches by gender	0	1	\N	\N	\N
1478	662	661	57385	Women's Watches	watches by gender	1	1	\N	\N	\N
1480	455	661	76406	Fitbit	smart watches	1	2	\N	\N	\N
1496	679	661	73631	Baume & Mercier	luxury brands	0	4	\N	\N	\N
1491	672	661	62502	Kate Spade New York	watch brands	17	3	\N	\N	\N
1485	665	661	26215	Bulova	watch brands	5	3	\N	\N	\N
1486	666	661	57367	Citizen	watch brands	7	3	\N	\N	\N
1487	667	661	47438	COACH	watch brands	9	3	\N	\N	\N
1492	674	661	57374	Michael Kors	watch brands	19	3	\N	\N	\N
1488	669	661	57369	Fossil	watch brands	11	3	\N	\N	\N
1489	671	661	57370	G-Shock	watch brands	13	3	\N	\N	\N
1494	675	661	57376	Seiko	watch brands	21	3	\N	\N	\N
1493	678	661	63568	See All Brands	watch brands	24	3	\N	\N	\N
1495	673	661	57436	Marc Jacobs	watch brands	23	3	\N	\N	\N
1497	680	661	26217	Burberry	luxury brands	1	4	\N	\N	\N
1498	697	661	68180	Emporio Armani Swiss	luxury brands	2	4	\N	\N	\N
1499	682	661	57424	Fendi	luxury brands	3	4	\N	\N	\N
1500	683	661	57427	Gucci	luxury brands	4	4	\N	\N	\N
1501	685	661	57435	Longines	luxury brands	5	4	\N	\N	\N
1502	686	661	24058	Montblanc	luxury brands	6	4	\N	\N	\N
1503	687	661	57375	Movado	luxury brands	7	4	\N	\N	\N
1504	688	661	57441	Rado	luxury brands	8	4	\N	\N	\N
1505	689	661	57442	RAYMOND WEIL	luxury brands	9	4	\N	\N	\N
1506	690	661	57448	TAG Heuer	luxury brands	10	4	\N	\N	\N
1507	698	661	105147	Tory Burch	luxury brands	11	4	\N	\N	\N
1508	691	661	57452	Tissot	luxury brands	12	4	\N	\N	\N
1509	699	661	62814	Ferragamo	luxury brands	13	4	\N	\N	\N
1510	692	661	62424	Versace	luxury brands	14	4	\N	\N	\N
1511	693	661	57456	Victorinox Swiss Army	luxury brands	15	4	\N	\N	\N
1512	694	661	75900	All Luxury Watches	luxury brands	16	4	\N	\N	\N
1513	695	661	71932	Watch Sets	trends & guides	2	5	\N	\N	\N
1514	710	700	63538	All Brands	\N	0	\N	\N	\N	\N
1515	711	700	76865	Athletic Shoes	\N	1	\N	\N	\N	\N
1516	712	700	63556	Beauty	\N	2	\N	\N	\N	\N
1517	713	700	63560	Bed & Bath	\N	3	\N	\N	\N	\N
1518	714	700	63565	Dining	\N	4	\N	\N	\N	\N
1519	715	700	63570	Handbags & Accessories	\N	5	\N	\N	\N	\N
1520	716	700	80788	Home	\N	6	\N	\N	\N	\N
1521	717	700	65448	Jewelry	\N	7	\N	\N	\N	\N
1522	718	700	63573	Juniors	\N	8	\N	\N	\N	\N
1523	719	700	63574	Kids	\N	9	\N	\N	\N	\N
1524	720	700	63575	Kitchen	\N	10	\N	\N	\N	\N
1525	721	700	69004	Lingerie	\N	11	\N	\N	\N	\N
1526	722	700	80686	Luggage & Backpacks	\N	12	\N	\N	\N	\N
1527	723	700	80800	Mattresses	\N	13	\N	\N	\N	\N
1528	724	700	63581	Men's	\N	14	\N	\N	\N	\N
1529	725	700	63582	Men's Shoes	\N	15	\N	\N	\N	\N
1530	726	700	63572	Petite	\N	16	\N	\N	\N	\N
1531	727	700	63571	Plus Sizes	\N	17	\N	\N	\N	\N
1532	728	700	70565	Sunglasses	\N	18	\N	\N	\N	\N
1533	729	700	63568	Watches	\N	19	\N	\N	\N	\N
1534	730	700	63539	Womens	\N	20	\N	\N	\N	\N
1535	731	700	63583	Women's Shoes	\N	21	\N	\N	\N	\N
1031	168	120	37281	Tommy Hilfiger	women's brands	19	6	\N	\N	\N
1482	797	661	0	Watch Trend Guide	trends & guides	3	5	\N	\N	\N
\.


--
-- Name: left_navs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('left_navs_id_seq', 1535, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schema_migrations (version) FROM stdin;
20160720144615
20161013072846
20161017015907
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, title, first_name, last_name, middle_name, is_contact_reference, is_skas_member) FROM stdin;
1	kalickvn@gmail.com	$2a$11$M1IUqrM532zqvwnBgh0XROiuuR4bQ.7KAmNHzVNbMumRo4neaf/BG	\N	\N	\N	1	2016-10-18 10:05:36.292791	2016-10-18 10:05:36.292791	127.0.0.1	127.0.0.1	2016-10-18 10:05:36.275737	2016-10-18 10:05:36.29457	\N	test	test	test	t	t
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: featured_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY featured_categories
    ADD CONSTRAINT featured_categories_pkey PRIMARY KEY (id);


--
-- Name: left_navs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY left_navs
    ADD CONSTRAINT left_navs_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

