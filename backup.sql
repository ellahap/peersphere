--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 14.17 (Homebrew)

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
-- Name: answers; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    thread_id integer,
    content text NOT NULL,
    created_by integer,
    votes integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.answers OWNER TO ellahappel;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answers_id_seq OWNER TO ellahappel;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: availabilities; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.availabilities (
    id integer NOT NULL,
    group_id integer,
    username text NOT NULL,
    day text NOT NULL,
    hour integer NOT NULL,
    color text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.availabilities OWNER TO ellahappel;

--
-- Name: availabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.availabilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.availabilities_id_seq OWNER TO ellahappel;

--
-- Name: availabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.availabilities_id_seq OWNED BY public.availabilities.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.events (
    id integer NOT NULL,
    group_id integer,
    name text NOT NULL,
    description text,
    location text,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.events OWNER TO ellahappel;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO ellahappel;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: flashcards; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.flashcards (
    id integer NOT NULL,
    group_id integer,
    front text NOT NULL,
    back text NOT NULL,
    created_by integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.flashcards OWNER TO ellahappel;

--
-- Name: flashcards_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.flashcards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.flashcards_id_seq OWNER TO ellahappel;

--
-- Name: flashcards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.flashcards_id_seq OWNED BY public.flashcards.id;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.memberships (
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.memberships OWNER TO ellahappel;

--
-- Name: notes; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    group_id integer,
    title text NOT NULL,
    content text NOT NULL,
    created_by integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notes OWNER TO ellahappel;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO ellahappel;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.resources (
    id integer NOT NULL,
    group_id integer,
    uploaded_by integer,
    title text NOT NULL,
    file_name text NOT NULL,
    content_type text,
    likes integer DEFAULT 0,
    hearts integer DEFAULT 0,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.resources OWNER TO ellahappel;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resources_id_seq OWNER TO ellahappel;

--
-- Name: resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.resources_id_seq OWNED BY public.resources.id;


--
-- Name: study_groups; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.study_groups (
    id integer NOT NULL,
    name text NOT NULL,
    join_code text
);


ALTER TABLE public.study_groups OWNER TO ellahappel;

--
-- Name: study_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.study_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.study_groups_id_seq OWNER TO ellahappel;

--
-- Name: study_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.study_groups_id_seq OWNED BY public.study_groups.id;


--
-- Name: threads; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.threads (
    id integer NOT NULL,
    group_id integer,
    title text NOT NULL,
    created_by integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.threads OWNER TO ellahappel;

--
-- Name: threads_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.threads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.threads_id_seq OWNER TO ellahappel;

--
-- Name: threads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.threads_id_seq OWNED BY public.threads.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO ellahappel;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO ellahappel;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: ellahappel
--

CREATE TABLE public.votes (
    id integer NOT NULL,
    answer_id integer,
    user_id integer,
    vote_type smallint
);


ALTER TABLE public.votes OWNER TO ellahappel;

--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: ellahappel
--

CREATE SEQUENCE public.votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.votes_id_seq OWNER TO ellahappel;

--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ellahappel
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: availabilities id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.availabilities ALTER COLUMN id SET DEFAULT nextval('public.availabilities_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: flashcards id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.flashcards ALTER COLUMN id SET DEFAULT nextval('public.flashcards_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: resources id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.resources ALTER COLUMN id SET DEFAULT nextval('public.resources_id_seq'::regclass);


--
-- Name: study_groups id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.study_groups ALTER COLUMN id SET DEFAULT nextval('public.study_groups_id_seq'::regclass);


--
-- Name: threads id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.threads ALTER COLUMN id SET DEFAULT nextval('public.threads_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.answers (id, thread_id, content, created_by, votes, created_at) FROM stdin;
3	3	answer	1	0	2025-04-26 22:10:28.599789
4	4	a	1	0	2025-04-26 22:13:00.482128
5	5	a	1	1	2025-04-26 22:13:21.017571
2	2	a	1	1	2025-04-26 22:07:57.903477
6	6	a	10	1	2025-04-26 23:30:22.338995
7	7	answer	10	1	2025-04-27 00:49:57.640907
1	1	a	1	1	2025-04-26 22:04:12.284584
\.


--
-- Data for Name: availabilities; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.availabilities (id, group_id, username, day, hour, color, created_at) FROM stdin;
1	10	Adhwita	Monday	0	#a56ec9	2025-04-26 22:26:32.472015
2	10	Adhwita	Monday	1	#a56ec9	2025-04-26 22:26:32.472015
3	10	Adhwita	Monday	2	#a56ec9	2025-04-26 22:26:32.472015
4	10	Adhwita	Wednesday	2	#a56ec9	2025-04-26 22:26:32.472015
5	10	Adhwita	Monday	3	#a56ec9	2025-04-26 22:26:32.472015
6	10	Adhwita	Wednesday	3	#a56ec9	2025-04-26 22:26:32.472015
7	10	Adhwita	Monday	4	#a56ec9	2025-04-26 22:26:32.472015
8	10	Adhwita	Wednesday	4	#a56ec9	2025-04-26 22:26:32.472015
9	10	Adhwita	Wednesday	5	#a56ec9	2025-04-26 22:26:32.472015
174	1	Ella Happel	Monday	0	\N	2025-04-26 22:52:52.558661
11	22	Ella Happel	Monday	0	#409fbf	2025-04-26 22:29:16.725525
12	22	Ella Happel	Monday	1	#409fbf	2025-04-26 22:29:16.725525
175	1	Ella Happel	Monday	1	\N	2025-04-26 22:52:52.571821
179	82	Ella M Happel	Monday	0	#ffae3d	2025-04-26 22:58:52.521844
180	82	Ella M Happel	Monday	1	#ffae3d	2025-04-26 22:58:52.521844
181	82	Ella M Happel	Monday	2	#ffae3d	2025-04-26 22:58:52.521844
185	82	Adhwita	Monday	0	#f773cd	2025-04-26 22:59:37.114027
186	82	Adhwita	Monday	1	#f773cd	2025-04-26 22:59:37.114027
197	82	Shreya	Monday	0	#6fff47	2025-04-26 23:00:16.563212
198	82	Shreya	Monday	1	#6fff47	2025-04-26 23:00:16.563212
199	82	Shreya	Tuesday	2	#6fff47	2025-04-26 23:00:16.563212
200	82	Shreya	Tuesday	3	#6fff47	2025-04-26 23:00:16.563212
201	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:03:53.975737
202	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:03:54.523993
203	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:03:54.525771
204	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:03:55.459012
205	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:03:55.460853
206	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:03:55.461944
207	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:03:56.560302
208	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:03:56.562124
209	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:03:56.563301
210	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:03:56.564255
211	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:03:57.018817
212	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:03:57.02081
213	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:03:57.022435
214	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:03:57.024031
215	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:03:57.025021
216	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:03:57.777306
217	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:03:57.779516
218	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:03:57.780802
219	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:03:57.781776
220	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:03:57.782849
221	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:04:10.942505
222	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:04:11.520999
223	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:04:11.523264
224	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:06:55.914396
225	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:06:55.9222
226	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:06:55.923312
227	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:06:55.924514
228	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:06:55.925505
229	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:06:55.926627
230	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:06:55.927723
231	83	adhwita	Monday	1	#ff0095	2025-04-26 23:06:55.928494
70	6	Adhwita	Monday	0	#000000	2025-04-26 22:30:06.94291
71	6	Adhwita	Monday	1	#000000	2025-04-26 22:30:06.94291
72	6	Adhwita	Wednesday	1	#000000	2025-04-26 22:30:06.94291
73	6	Adhwita	Monday	2	#000000	2025-04-26 22:30:06.94291
74	6	Adhwita	Wednesday	2	#000000	2025-04-26 22:30:06.94291
75	6	Adhwita	Monday	3	#000000	2025-04-26 22:30:06.94291
76	6	Adhwita	Wednesday	3	#000000	2025-04-26 22:30:06.94291
77	6	Adhwita	Monday	4	#000000	2025-04-26 22:30:06.94291
78	6	Adhwita	Monday	5	#000000	2025-04-26 22:30:06.94291
232	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:06:56.590928
233	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:06:56.592999
234	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:06:56.594133
235	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:06:56.595267
236	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:06:56.596291
237	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:06:56.59748
238	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:06:56.598254
239	83	adhwita	Monday	0	#ff0095	2025-04-26 23:06:56.599249
240	83	adhwita	Monday	1	#ff0095	2025-04-26 23:06:56.600598
241	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:06:59.426131
242	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:06:59.427546
161	6	Ella Happel	Monday	0	#000000	2025-04-26 22:30:23.861244
162	6	Ella Happel	Tuesday	0	#000000	2025-04-26 22:30:23.861244
163	6	Ella Happel	Monday	1	#000000	2025-04-26 22:30:23.861244
164	6	Ella Happel	Tuesday	1	#000000	2025-04-26 22:30:23.861244
165	6	Ella Happel	Monday	2	#000000	2025-04-26 22:30:23.861244
166	6	Ella Happel	Tuesday	2	#000000	2025-04-26 22:30:23.861244
167	6	Ella Happel	Monday	3	#000000	2025-04-26 22:30:23.861244
168	6	Ella Happel	Tuesday	3	#000000	2025-04-26 22:30:23.861244
169	6	Ella Happel	Monday	4	#000000	2025-04-26 22:30:23.861244
170	6	Ella Happel	Tuesday	4	#000000	2025-04-26 22:30:23.861244
171	6	Ella Happel	Monday	5	#000000	2025-04-26 22:30:23.861244
172	6	Ella Happel	Tuesday	5	#000000	2025-04-26 22:30:23.861244
173	6	Ella Happel	Tuesday	6	#000000	2025-04-26 22:30:23.861244
243	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:06:59.428526
244	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:06:59.430088
245	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:06:59.43111
246	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:06:59.432185
247	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:06:59.433099
248	83	adhwita	Monday	0	#ff0095	2025-04-26 23:06:59.434392
249	83	adhwita	Monday	1	#ff0095	2025-04-26 23:06:59.435551
250	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:06:59.436663
251	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:06:59.822483
252	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:06:59.82444
253	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:06:59.825739
254	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:06:59.826808
255	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:06:59.827745
256	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:06:59.828503
257	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:06:59.829566
258	83	adhwita	Monday	0	#ff0095	2025-04-26 23:06:59.830785
259	83	adhwita	Monday	1	#ff0095	2025-04-26 23:06:59.831798
260	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:06:59.832439
261	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:06:59.833462
262	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:00.225886
263	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:00.227705
264	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:00.229226
265	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:00.230181
266	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:00.231329
267	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:00.232436
268	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:00.233713
269	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:00.234901
270	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:00.236157
271	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:00.237259
272	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:00.238568
273	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:00.239672
274	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:02.142158
275	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:02.143945
276	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:02.144853
277	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:02.14583
278	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:02.146667
279	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:02.147602
280	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:02.148623
281	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:02.14993
282	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:02.151234
283	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:02.152619
284	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:02.153643
285	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:02.154219
286	83	adhwita	Tuesday	4	#ff0095	2025-04-26 23:07:02.154761
287	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:21.438292
288	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:21.445395
289	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:21.446541
290	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:21.447378
291	83	adhwita	Wednesday	2	#ff0095	2025-04-26 23:07:21.448127
292	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:21.449024
293	83	adhwita	Tuesday	4	#ff0095	2025-04-26 23:07:21.450062
294	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:21.450782
295	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:21.451473
296	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:21.452147
297	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:21.452777
298	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:21.453433
299	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:21.454115
300	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:21.454795
301	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:21.8574
302	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:21.858889
303	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:21.8597
304	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:21.860917
305	83	adhwita	Wednesday	2	#ff0095	2025-04-26 23:07:21.861815
306	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:21.86262
307	83	adhwita	Wednesday	3	#ff0095	2025-04-26 23:07:21.863516
308	83	adhwita	Tuesday	4	#ff0095	2025-04-26 23:07:21.864048
309	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:21.864558
310	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:21.865144
311	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:21.865718
312	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:21.866279
313	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:21.866782
314	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:21.8673
315	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:21.867832
316	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:22.324072
317	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:22.325861
318	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:22.327239
319	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:22.328049
320	83	adhwita	Wednesday	2	#ff0095	2025-04-26 23:07:22.328983
321	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:22.33054
322	83	adhwita	Wednesday	3	#ff0095	2025-04-26 23:07:22.331753
323	83	adhwita	Tuesday	4	#ff0095	2025-04-26 23:07:22.333242
324	83	adhwita	Wednesday	4	#ff0095	2025-04-26 23:07:22.334297
325	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:22.33543
326	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:22.336335
327	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:22.337168
328	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:22.337956
329	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:22.338828
330	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:22.339607
331	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:22.340558
332	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:31.587325
333	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:31.599215
334	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:31.60082
335	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:31.602112
336	83	adhwita	Wednesday	2	#ff0095	2025-04-26 23:07:31.60333
337	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:31.604482
338	83	adhwita	Wednesday	3	#ff0095	2025-04-26 23:07:31.606011
339	83	adhwita	Tuesday	4	#ff0095	2025-04-26 23:07:31.606971
340	83	adhwita	Wednesday	4	#ff0095	2025-04-26 23:07:31.608015
341	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:31.608927
342	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:31.610148
343	83	Ella M Happel	Monday	5	#ff6161	2025-04-26 23:07:31.611084
344	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:31.612241
345	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:31.613288
346	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:31.614289
347	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:31.615251
348	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:31.616132
349	83	adhwita	Monday	0	#ff0095	2025-04-26 23:07:31.923954
350	83	adhwita	Monday	1	#ff0095	2025-04-26 23:07:31.925791
351	83	adhwita	Tuesday	1	#ff0095	2025-04-26 23:07:31.926989
352	83	adhwita	Tuesday	2	#ff0095	2025-04-26 23:07:31.928169
353	83	adhwita	Wednesday	2	#ff0095	2025-04-26 23:07:31.929636
354	83	adhwita	Tuesday	3	#ff0095	2025-04-26 23:07:31.931215
355	83	adhwita	Wednesday	3	#ff0095	2025-04-26 23:07:31.931953
356	83	adhwita	Tuesday	4	#ff0095	2025-04-26 23:07:31.932742
357	83	adhwita	Wednesday	4	#ff0095	2025-04-26 23:07:31.93374
358	83	Ella M Happel	Monday	0	#ff6161	2025-04-26 23:07:31.934563
359	83	Ella M Happel	Monday	1	#ff6161	2025-04-26 23:07:31.935187
360	83	Ella M Happel	Monday	5	#ff6161	2025-04-26 23:07:31.935796
361	83	Ella M Happel	Monday	6	#ff6161	2025-04-26 23:07:31.93652
362	83	Ella Happel	Monday	0	#fafd44	2025-04-26 23:07:31.93708
363	83	Ella Happel	Monday	1	#fafd44	2025-04-26 23:07:31.937593
364	83	Ella Happel	Monday	2	#fafd44	2025-04-26 23:07:31.938342
365	83	Ella Happel	Monday	3	#fafd44	2025-04-26 23:07:31.938988
366	83	Ella Happel	Monday	4	#fafd44	2025-04-26 23:07:31.939788
367	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:25.202716
368	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:25.634038
369	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:25.636203
370	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:26.150618
371	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:26.152562
372	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:26.154174
373	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:26.665156
374	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:26.666573
375	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:26.667785
376	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:26.66879
377	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:27.045075
378	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:27.046851
379	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:27.048487
380	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:27.049551
381	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:27.050349
382	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:27.690565
383	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:27.692526
384	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:27.69365
385	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:27.694398
386	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:27.695624
387	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:27.696981
388	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:29.266853
389	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:29.268503
390	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:29.269107
391	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:29.269754
392	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:29.270732
393	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:29.271261
394	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:29.271824
395	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:29.623322
396	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:29.625305
397	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:29.626569
398	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:29.627484
399	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:29.628406
400	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:29.629107
401	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:29.629973
402	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:29.630948
403	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:29.985534
404	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:29.987308
405	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:29.988324
406	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:29.98939
407	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:29.990399
408	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:29.991542
409	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:29.992579
410	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:29.993336
411	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:29.99413
412	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:45.941667
413	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:45.949892
414	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:45.951695
415	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:45.952776
416	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:45.953768
417	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:45.954683
418	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:45.955684
419	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:45.956504
420	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:45.957311
421	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:45.958169
422	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:46.350163
423	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:46.352193
424	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:46.35379
425	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:46.354914
426	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:46.356061
427	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:46.357506
428	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:46.358985
429	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:46.360433
430	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:46.36119
431	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:46.362048
432	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:46.36289
433	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:46.896859
434	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:46.898308
435	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:46.899498
436	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:46.901053
437	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:46.902217
438	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:46.90269
439	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:46.903094
440	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:46.90363
441	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:46.903945
442	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:46.904353
443	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:46.904844
444	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:46.905375
445	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:47.387337
446	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:47.388898
447	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:47.389691
448	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:47.390706
449	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:47.391644
450	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:47.392525
451	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:47.393411
452	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:47.394031
453	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:47.394711
454	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:47.39542
455	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:47.39691
456	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:47.397812
457	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:47.398668
458	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:48.014081
459	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:48.015475
460	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:48.016281
461	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:48.016821
462	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:48.01732
463	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:48.018064
464	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:48.019012
465	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:48.020352
466	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:48.020724
467	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:48.02104
468	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:48.021634
469	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:48.022039
470	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:48.022455
471	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:48.022857
472	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:48.341354
473	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:48.343507
474	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:48.344798
475	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:48.345778
476	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:48.346458
477	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:48.347445
478	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:48.348676
479	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:48.349848
480	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:48.350975
481	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:48.352338
482	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:48.353286
483	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:48.354272
484	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:48.355029
485	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:48.356029
486	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:48.357108
487	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:48.668667
488	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:48.670437
489	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:48.671158
490	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:48.671766
491	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:48.672379
492	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:48.672916
493	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:48.673522
494	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:48.674147
495	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:48.674727
496	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:48.675468
497	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:48.676343
498	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:48.677429
499	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:48.678514
500	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:48.679786
501	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:48.680849
502	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:48.681896
503	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:53.14371
504	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:53.145568
505	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:53.147046
506	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:53.147831
507	84	Ella Happel	Thursday	1	#63b3fd	2025-04-26 23:20:53.14888
508	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:53.150298
509	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:53.151617
510	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:53.152938
511	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:53.154133
512	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:53.154961
513	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:53.155786
514	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:53.156543
515	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:53.157417
516	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:53.158879
517	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:53.159686
518	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:53.160801
519	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:53.1617
520	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:53.488385
521	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:53.490109
522	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:53.491423
523	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:53.492365
524	84	Ella Happel	Thursday	1	#63b3fd	2025-04-26 23:20:53.493318
525	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:53.494306
526	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:53.495192
527	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:53.495888
528	84	Ella Happel	Thursday	3	#63b3fd	2025-04-26 23:20:53.496619
529	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:53.497476
530	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:53.498569
531	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:53.499719
532	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:53.500701
533	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:53.501437
534	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:53.502259
535	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:53.502998
536	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:53.503651
537	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:53.504376
538	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:54.013222
539	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:54.015109
540	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:54.016436
541	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:54.01737
542	84	Ella Happel	Thursday	1	#63b3fd	2025-04-26 23:20:54.018142
543	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:54.018932
544	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:54.02013
545	84	Ella Happel	Thursday	2	#63b3fd	2025-04-26 23:20:54.020834
546	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:54.021545
547	84	Ella Happel	Thursday	3	#63b3fd	2025-04-26 23:20:54.022374
548	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:54.023153
549	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:54.025288
550	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:54.026196
551	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:54.027191
552	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:54.028123
553	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:54.029047
554	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:54.029673
555	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:54.030757
556	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:54.03126
557	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:56.463622
558	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:56.465618
559	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:56.467324
560	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:56.46847
561	84	Ella Happel	Thursday	1	#63b3fd	2025-04-26 23:20:56.469405
562	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:56.470374
563	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:56.47123
564	84	Ella Happel	Thursday	2	#63b3fd	2025-04-26 23:20:56.472219
565	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:56.473679
566	84	Ella Happel	Thursday	3	#63b3fd	2025-04-26 23:20:56.475027
567	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:56.476369
568	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:56.477619
569	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:56.478604
570	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:56.479525
571	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:56.480365
572	84	Clare Donahue	Friday	1	#ff99da	2025-04-26 23:20:56.481192
573	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:56.48218
574	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:56.483339
575	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:56.484169
576	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:56.484893
577	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:56.785496
578	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:56.787258
579	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:56.788249
580	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:56.789062
581	84	Ella Happel	Thursday	1	#63b3fd	2025-04-26 23:20:56.789659
582	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:56.790397
583	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:56.791427
584	84	Ella Happel	Thursday	2	#63b3fd	2025-04-26 23:20:56.79239
585	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:56.79325
586	84	Ella Happel	Thursday	3	#63b3fd	2025-04-26 23:20:56.793774
587	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:56.79422
588	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:56.794674
589	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:56.795229
590	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:56.795735
591	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:56.796752
592	84	Clare Donahue	Friday	1	#ff99da	2025-04-26 23:20:56.797608
593	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:56.798287
594	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:56.79905
595	84	Clare Donahue	Friday	2	#ff99da	2025-04-26 23:20:56.799972
596	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:56.800853
597	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:56.801737
598	84	Ella Happel	Monday	0	#63b3fd	2025-04-26 23:20:57.15602
599	84	Ella Happel	Tuesday	0	#63b3fd	2025-04-26 23:20:57.158176
600	84	Ella Happel	Monday	1	#63b3fd	2025-04-26 23:20:57.159891
601	84	Ella Happel	Tuesday	1	#63b3fd	2025-04-26 23:20:57.161332
602	84	Ella Happel	Thursday	1	#63b3fd	2025-04-26 23:20:57.162513
603	84	Ella Happel	Monday	2	#63b3fd	2025-04-26 23:20:57.163354
604	84	Ella Happel	Tuesday	2	#63b3fd	2025-04-26 23:20:57.164252
605	84	Ella Happel	Thursday	2	#63b3fd	2025-04-26 23:20:57.165213
606	84	Ella Happel	Monday	3	#63b3fd	2025-04-26 23:20:57.166389
607	84	Ella Happel	Thursday	3	#63b3fd	2025-04-26 23:20:57.167572
608	84	Ella Happel	Monday	4	#63b3fd	2025-04-26 23:20:57.168826
609	84	Ella Happel	Monday	5	#63b3fd	2025-04-26 23:20:57.169821
610	84	Clare Donahue	Monday	0	#ff99da	2025-04-26 23:20:57.170743
611	84	Clare Donahue	Monday	1	#ff99da	2025-04-26 23:20:57.171532
612	84	Clare Donahue	Wednesday	1	#ff99da	2025-04-26 23:20:57.172414
613	84	Clare Donahue	Friday	1	#ff99da	2025-04-26 23:20:57.173428
614	84	Clare Donahue	Monday	2	#ff99da	2025-04-26 23:20:57.1746
615	84	Clare Donahue	Wednesday	2	#ff99da	2025-04-26 23:20:57.175669
616	84	Clare Donahue	Friday	2	#ff99da	2025-04-26 23:20:57.177034
617	84	Clare Donahue	Monday	3	#ff99da	2025-04-26 23:20:57.1779
618	84	Clare Donahue	Wednesday	3	#ff99da	2025-04-26 23:20:57.178831
619	84	Clare Donahue	Friday	3	#ff99da	2025-04-26 23:20:57.179576
620	82	ella	Monday	0	#eecb81	2025-04-26 23:30:36.605994
621	82	ella	Monday	0	#eecb81	2025-04-26 23:30:37.025358
622	82	ella	Monday	1	#eecb81	2025-04-26 23:30:37.027363
623	82	ella	Monday	0	#eecb81	2025-04-26 23:30:37.364459
624	82	ella	Monday	1	#eecb81	2025-04-26 23:30:37.36686
625	82	ella	Monday	2	#eecb81	2025-04-26 23:30:37.369343
626	82	Ella Happel	Monday	0	#a97aff	2025-04-26 23:33:30.605273
627	82	Ella Happel	Monday	0	#a97aff	2025-04-26 23:33:30.986622
628	82	Ella Happel	Monday	2	#a97aff	2025-04-26 23:33:30.989538
629	82	Ella Happel	Monday	0	#a97aff	2025-04-26 23:33:31.502343
630	82	Ella Happel	Monday	1	#a97aff	2025-04-26 23:33:31.504755
631	82	Ella Happel	Monday	2	#a97aff	2025-04-26 23:33:31.506576
632	82	e	Monday	0	#000000	2025-04-26 23:34:18.971483
633	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:47:49.224088
634	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:47:49.235686
635	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:47:49.236298
636	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:47:49.237289
637	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:47:49.238169
638	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:47:49.239122
639	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:47:49.240603
640	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:47:49.241762
641	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:47:49.24275
642	82	Shreya	Monday	0	#6fff47	2025-04-27 00:47:49.243846
643	82	Shreya	Monday	1	#6fff47	2025-04-27 00:47:49.244261
644	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:47:49.244986
645	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:47:49.246327
646	82	e	Monday	0	#000000	2025-04-27 00:47:49.247491
647	82	ella	Monday	0	#eecb81	2025-04-27 00:47:49.248782
648	82	ella	Monday	1	#eecb81	2025-04-27 00:47:49.249734
649	82	ella	Monday	2	#eecb81	2025-04-27 00:47:49.250842
650	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:47:49.539348
651	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:47:49.541189
652	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:47:49.542221
653	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:47:49.543242
654	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:47:49.544193
655	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:47:49.545165
656	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:47:49.546283
657	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:47:49.547411
658	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:47:49.548628
659	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:47:49.549852
660	82	Shreya	Monday	0	#6fff47	2025-04-27 00:47:49.551766
661	82	Shreya	Monday	1	#6fff47	2025-04-27 00:47:49.552786
662	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:47:49.553745
663	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:47:49.554635
664	82	e	Monday	0	#000000	2025-04-27 00:47:49.555517
665	82	ella	Monday	0	#eecb81	2025-04-27 00:47:49.556377
666	82	ella	Monday	1	#eecb81	2025-04-27 00:47:49.557241
667	82	ella	Monday	2	#eecb81	2025-04-27 00:47:49.558163
668	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:49:04.159927
669	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:49:04.171151
670	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:49:04.172089
671	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:49:04.172834
672	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:49:04.17359
673	82	e	Monday	0	#000000	2025-04-27 00:49:04.174472
674	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:49:04.17541
675	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:49:04.176208
676	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:49:04.17695
677	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:49:04.177657
678	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:49:04.178376
679	82	ella	Monday	0	#eecb81	2025-04-27 00:49:04.17912
680	82	ella	Monday	1	#eecb81	2025-04-27 00:49:04.179652
681	82	ella	Monday	2	#eecb81	2025-04-27 00:49:04.179993
682	82	Shreya	Monday	0	#6fff47	2025-04-27 00:49:04.180266
683	82	Shreya	Monday	1	#6fff47	2025-04-27 00:49:04.180705
684	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:49:04.181546
685	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:49:04.182197
686	82	new	Wednesday	1	#c72323	2025-04-27 00:49:04.183175
687	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:49:04.563661
688	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:49:04.565482
689	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:49:04.566761
690	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:49:04.567707
691	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:49:04.569115
692	82	e	Monday	0	#000000	2025-04-27 00:49:04.570651
693	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:49:04.572326
694	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:49:04.573142
695	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:49:04.57403
696	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:49:04.574964
697	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:49:04.575639
698	82	ella	Monday	0	#eecb81	2025-04-27 00:49:04.577233
699	82	ella	Monday	1	#eecb81	2025-04-27 00:49:04.578511
700	82	ella	Monday	2	#eecb81	2025-04-27 00:49:04.580087
701	82	Shreya	Monday	0	#6fff47	2025-04-27 00:49:04.580946
702	82	Shreya	Monday	1	#6fff47	2025-04-27 00:49:04.581515
703	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:49:04.582078
704	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:49:04.582774
705	82	new	Wednesday	1	#c72323	2025-04-27 00:49:04.583725
706	82	new	Wednesday	2	#c72323	2025-04-27 00:49:04.584739
707	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:49:04.926675
708	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:49:04.928604
709	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:49:04.929775
710	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:49:04.93069
711	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:49:04.931477
712	82	e	Monday	0	#000000	2025-04-27 00:49:04.932522
713	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:49:04.93374
714	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:49:04.934861
715	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:49:04.936019
716	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:49:04.937346
717	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:49:04.938123
718	82	ella	Monday	0	#eecb81	2025-04-27 00:49:04.938839
719	82	ella	Monday	1	#eecb81	2025-04-27 00:49:04.939502
720	82	ella	Monday	2	#eecb81	2025-04-27 00:49:04.940144
721	82	Shreya	Monday	0	#6fff47	2025-04-27 00:49:04.940984
722	82	Shreya	Monday	1	#6fff47	2025-04-27 00:49:04.941991
723	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:49:04.943041
724	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:49:04.944333
725	82	new	Wednesday	1	#c72323	2025-04-27 00:49:04.945382
726	82	new	Wednesday	2	#c72323	2025-04-27 00:49:04.945999
727	82	new	Wednesday	3	#c72323	2025-04-27 00:49:04.946595
728	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:23.051982
729	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:23.055878
730	82	ella	Monday	0	#eecb81	2025-04-27 00:50:23.05736
731	82	ella	Monday	1	#eecb81	2025-04-27 00:50:23.059168
732	82	ella	Monday	2	#eecb81	2025-04-27 00:50:23.060866
733	82	new	Wednesday	1	#c72323	2025-04-27 00:50:23.062329
734	82	new	Wednesday	2	#c72323	2025-04-27 00:50:23.063609
735	82	new	Wednesday	3	#c72323	2025-04-27 00:50:23.064316
736	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:23.064978
737	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:23.065859
738	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:23.066674
739	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:23.067359
740	82	e	Monday	0	#000000	2025-04-27 00:50:23.068224
741	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:23.069327
742	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:23.070572
743	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:23.071307
744	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:50:23.071974
745	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:23.072608
746	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:23.073881
747	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:23.074624
748	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:23.07535
749	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:23.076229
750	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:29.343139
751	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:29.352564
752	82	ella	Monday	0	#eecb81	2025-04-27 00:50:29.353843
753	82	ella	Monday	1	#eecb81	2025-04-27 00:50:29.354888
754	82	ella	Monday	2	#eecb81	2025-04-27 00:50:29.355882
755	82	new	Wednesday	1	#c72323	2025-04-27 00:50:29.357103
756	82	new	Wednesday	2	#c72323	2025-04-27 00:50:29.359124
757	82	new	Wednesday	3	#c72323	2025-04-27 00:50:29.360882
758	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:29.36223
759	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:29.363475
760	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:29.364577
761	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:29.36545
762	82	e	Monday	0	#000000	2025-04-27 00:50:29.36624
763	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:29.367213
764	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:29.368054
765	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:29.368828
766	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:50:29.369715
767	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:50:29.371008
768	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:29.371912
769	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:29.372964
770	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:29.373951
771	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:29.375125
772	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:29.376073
773	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:29.969182
774	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:29.970567
775	82	ella	Monday	0	#eecb81	2025-04-27 00:50:29.971803
776	82	ella	Monday	1	#eecb81	2025-04-27 00:50:29.972904
777	82	ella	Monday	2	#eecb81	2025-04-27 00:50:29.973777
778	82	new	Wednesday	1	#c72323	2025-04-27 00:50:29.974585
779	82	new	Wednesday	2	#c72323	2025-04-27 00:50:29.975598
780	82	new	Wednesday	3	#c72323	2025-04-27 00:50:29.977205
781	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:29.977902
782	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:29.978537
783	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:29.979204
784	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:29.979977
785	82	e	Monday	0	#000000	2025-04-27 00:50:29.980916
786	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:29.981433
787	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:29.981777
788	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:29.982065
789	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:50:29.982733
790	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:50:29.984152
791	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:50:29.985094
792	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:29.985729
793	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:29.986038
794	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:29.986296
795	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:29.986552
796	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:29.98681
797	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:30.744546
798	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:30.746589
799	82	ella	Monday	0	#eecb81	2025-04-27 00:50:30.747914
800	82	ella	Monday	1	#eecb81	2025-04-27 00:50:30.749124
801	82	ella	Monday	2	#eecb81	2025-04-27 00:50:30.750766
802	82	new	Wednesday	1	#c72323	2025-04-27 00:50:30.752274
803	82	new	Wednesday	2	#c72323	2025-04-27 00:50:30.753553
804	82	new	Wednesday	3	#c72323	2025-04-27 00:50:30.754954
805	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:30.756003
806	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:30.756797
807	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:30.758158
808	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:30.759301
809	82	e	Monday	0	#000000	2025-04-27 00:50:30.760537
810	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:30.761812
811	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:30.762881
812	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:30.763801
813	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:50:30.764614
814	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:50:30.765268
815	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:30.765885
816	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:30.766707
817	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:30.767655
818	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:30.768756
819	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:30.769873
820	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:31.757057
821	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:31.759323
822	82	ella	Monday	0	#eecb81	2025-04-27 00:50:31.760937
823	82	ella	Monday	1	#eecb81	2025-04-27 00:50:31.761957
824	82	ella	Monday	2	#eecb81	2025-04-27 00:50:31.762918
825	82	new	Wednesday	1	#c72323	2025-04-27 00:50:31.763847
826	82	new	Wednesday	2	#c72323	2025-04-27 00:50:31.764752
827	82	new	Wednesday	3	#c72323	2025-04-27 00:50:31.765562
828	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:31.766341
829	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:31.76734
830	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:31.768497
831	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:31.769478
832	82	e	Monday	0	#000000	2025-04-27 00:50:31.770738
833	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:31.771644
834	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:31.772542
835	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:31.773517
836	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:50:31.774705
837	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:50:31.775507
838	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:50:31.776272
839	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:31.777013
840	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:31.777808
841	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:31.778849
842	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:31.779789
843	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:31.780375
844	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:33.040138
845	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:33.042023
846	82	ella	Monday	0	#eecb81	2025-04-27 00:50:33.043323
847	82	ella	Monday	1	#eecb81	2025-04-27 00:50:33.044473
848	82	ella	Monday	2	#eecb81	2025-04-27 00:50:33.045687
849	82	new	Wednesday	1	#c72323	2025-04-27 00:50:33.046614
850	82	new	Wednesday	2	#c72323	2025-04-27 00:50:33.047109
851	82	new	Wednesday	3	#c72323	2025-04-27 00:50:33.047495
852	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:33.047813
853	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:33.04808
854	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:33.048697
855	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:33.050033
856	82	e	Monday	0	#000000	2025-04-27 00:50:33.051186
857	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:33.051895
858	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:33.052321
859	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:33.052709
860	82	Ella M Happel	Tuesday	2	#ffae3d	2025-04-27 00:50:33.053195
861	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:50:33.053579
862	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:50:33.054049
863	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:50:33.054793
864	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:33.055137
865	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:33.055422
866	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:33.056073
867	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:33.056885
868	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:33.057681
869	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:50:39.273247
870	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:50:39.274931
871	82	ella	Monday	0	#eecb81	2025-04-27 00:50:39.275601
872	82	ella	Monday	1	#eecb81	2025-04-27 00:50:39.276176
873	82	ella	Monday	2	#eecb81	2025-04-27 00:50:39.276659
874	82	new	Wednesday	1	#c72323	2025-04-27 00:50:39.277131
875	82	new	Wednesday	2	#c72323	2025-04-27 00:50:39.277817
876	82	new	Wednesday	3	#c72323	2025-04-27 00:50:39.278477
877	82	Shreya	Monday	0	#6fff47	2025-04-27 00:50:39.278941
878	82	Shreya	Monday	1	#6fff47	2025-04-27 00:50:39.279483
879	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:50:39.279921
880	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:50:39.280387
881	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:50:39.280889
882	82	Ella M Happel	Tuesday	0	#ffae3d	2025-04-27 00:50:39.281297
883	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:50:39.281569
884	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:50:39.282529
885	82	Ella M Happel	Tuesday	2	#ffae3d	2025-04-27 00:50:39.283325
886	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:50:39.284113
887	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:50:39.284897
888	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:50:39.28568
889	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:50:39.286485
890	82	name	Tuesday	0	#e88c8c	2025-04-27 00:50:39.287183
891	82	e	Monday	0	#000000	2025-04-27 00:50:39.287591
892	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:50:39.288014
893	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:50:39.288418
894	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:50:39.288833
895	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:54:32.85864
896	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:54:32.867452
897	82	ella	Monday	0	#eecb81	2025-04-27 00:54:32.868758
898	82	ella	Monday	1	#eecb81	2025-04-27 00:54:32.870086
899	82	ella	Monday	2	#eecb81	2025-04-27 00:54:32.871255
900	82	new	Wednesday	1	#c72323	2025-04-27 00:54:32.872347
901	82	new	Wednesday	2	#c72323	2025-04-27 00:54:32.873507
902	82	new	Wednesday	3	#c72323	2025-04-27 00:54:32.874382
903	82	Shreya	Monday	0	#6fff47	2025-04-27 00:54:32.875336
904	82	Shreya	Monday	1	#6fff47	2025-04-27 00:54:32.876215
905	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:54:32.876885
906	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:54:32.877584
907	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:54:32.878874
908	82	Ella M Happel	Tuesday	0	#ffae3d	2025-04-27 00:54:32.879861
909	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:54:32.880815
910	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:54:32.881701
911	82	Ella M Happel	Tuesday	2	#ffae3d	2025-04-27 00:54:32.882411
912	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:54:32.88304
913	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:54:32.88375
914	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:54:32.884464
915	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:54:32.88582
916	82	name	Tuesday	0	#e88c8c	2025-04-27 00:54:32.886708
917	82	e	Monday	0	#000000	2025-04-27 00:54:32.88767
918	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:54:32.888671
919	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:54:32.89059
920	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:54:32.891696
921	82	Ella Happel	Monday	6	#a97aff	2025-04-27 00:54:32.892379
922	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:54:33.440383
923	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:54:33.442636
924	82	ella	Monday	0	#eecb81	2025-04-27 00:54:33.443914
925	82	ella	Monday	1	#eecb81	2025-04-27 00:54:33.444634
926	82	ella	Monday	2	#eecb81	2025-04-27 00:54:33.445154
927	82	new	Wednesday	1	#c72323	2025-04-27 00:54:33.445785
928	82	new	Wednesday	2	#c72323	2025-04-27 00:54:33.446595
929	82	new	Wednesday	3	#c72323	2025-04-27 00:54:33.447518
930	82	Shreya	Monday	0	#6fff47	2025-04-27 00:54:33.448399
931	82	Shreya	Monday	1	#6fff47	2025-04-27 00:54:33.44916
932	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:54:33.449976
933	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:54:33.450873
934	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:54:33.451683
935	82	Ella M Happel	Tuesday	0	#ffae3d	2025-04-27 00:54:33.452015
936	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:54:33.452255
937	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:54:33.452815
938	82	Ella M Happel	Tuesday	2	#ffae3d	2025-04-27 00:54:33.453612
939	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:54:33.454405
940	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:54:33.455194
941	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:54:33.455972
942	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:54:33.456864
943	82	name	Tuesday	0	#e88c8c	2025-04-27 00:54:33.457729
944	82	e	Monday	0	#000000	2025-04-27 00:54:33.458358
945	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:54:33.458842
946	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:54:33.45927
947	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:54:33.459754
948	82	Ella Happel	Monday	6	#a97aff	2025-04-27 00:54:33.460296
949	82	Ella Happel	Monday	7	#a97aff	2025-04-27 00:54:33.460954
950	82	Adhwita	Monday	0	#f773cd	2025-04-27 00:54:33.835945
951	82	Adhwita	Monday	1	#f773cd	2025-04-27 00:54:33.837629
952	82	ella	Monday	0	#eecb81	2025-04-27 00:54:33.838392
953	82	ella	Monday	1	#eecb81	2025-04-27 00:54:33.83898
954	82	ella	Monday	2	#eecb81	2025-04-27 00:54:33.839811
955	82	new	Wednesday	1	#c72323	2025-04-27 00:54:33.84066
956	82	new	Wednesday	2	#c72323	2025-04-27 00:54:33.841791
957	82	new	Wednesday	3	#c72323	2025-04-27 00:54:33.842308
958	82	Shreya	Monday	0	#6fff47	2025-04-27 00:54:33.842728
959	82	Shreya	Monday	1	#6fff47	2025-04-27 00:54:33.843217
960	82	Shreya	Tuesday	2	#6fff47	2025-04-27 00:54:33.843794
961	82	Shreya	Tuesday	3	#6fff47	2025-04-27 00:54:33.844674
962	82	Ella M Happel	Monday	0	#ffae3d	2025-04-27 00:54:33.845274
963	82	Ella M Happel	Tuesday	0	#ffae3d	2025-04-27 00:54:33.845697
964	82	Ella M Happel	Monday	1	#ffae3d	2025-04-27 00:54:33.84617
965	82	Ella M Happel	Monday	2	#ffae3d	2025-04-27 00:54:33.846746
966	82	Ella M Happel	Tuesday	2	#ffae3d	2025-04-27 00:54:33.847299
967	82	Ella M Happel	Monday	3	#ffae3d	2025-04-27 00:54:33.848309
968	82	Ella M Happel	Monday	4	#ffae3d	2025-04-27 00:54:33.849319
969	82	Ella M Happel	Tuesday	4	#ffae3d	2025-04-27 00:54:33.85015
970	82	Ella M Happel	Monday	5	#ffae3d	2025-04-27 00:54:33.850952
971	82	name	Tuesday	0	#e88c8c	2025-04-27 00:54:33.851764
972	82	e	Monday	0	#000000	2025-04-27 00:54:33.852143
973	82	Ella Happel	Monday	0	#a97aff	2025-04-27 00:54:33.852457
974	82	Ella Happel	Monday	1	#a97aff	2025-04-27 00:54:33.85283
975	82	Ella Happel	Monday	2	#a97aff	2025-04-27 00:54:33.853532
976	82	Ella Happel	Monday	6	#a97aff	2025-04-27 00:54:33.854065
977	82	Ella Happel	Monday	7	#a97aff	2025-04-27 00:54:33.854451
978	82	Ella Happel	Monday	8	#a97aff	2025-04-27 00:54:33.854944
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.events (id, group_id, name, description, location, start_time, end_time, created_at) FROM stdin;
1	10	event	descr	grainger	2025-04-26 22:21:00	2025-04-26 22:21:00	2025-04-26 22:21:28.206238
2	10	event2	descr	grainger	2025-04-26 22:21:00	2025-04-26 22:21:00	2025-04-26 22:21:51.654239
\.


--
-- Data for Name: flashcards; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.flashcards (id, group_id, front, back, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: memberships; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.memberships (user_id, group_id) FROM stdin;
6	1
6	3
6	4
2	6
1	10
8	11
1	15
2	18
2	19
2	10
1	20
1	21
1	22
1	23
1	24
3	25
3	10
2	28
2	29
2	30
2	31
2	32
2	33
2	34
2	35
2	36
2	37
2	38
2	39
2	40
2	41
2	42
2	43
2	44
2	45
3	45
3	48
3	37
6	49
6	37
6	50
6	51
6	52
6	53
6	61
6	62
6	63
6	64
6	66
6	67
6	68
6	69
6	70
6	71
6	72
6	73
6	74
6	75
2	48
9	76
9	77
9	78
1	45
1	79
3	80
3	81
10	82
10	83
10	84
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.notes (id, group_id, title, content, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.resources (id, group_id, uploaded_by, title, file_name, content_type, likes, hearts, uploaded_at) FROM stdin;
2	22	1	f2	cosine_similarity_overlap_1745720615160.png	PDF	0	0	2025-04-26 21:23:35.162405
3	22	1	file3!!	collage_1745720742041.pdf	PPT	2	2	2025-04-26 21:25:42.058573
1	10	1	f	CF Allergy Alert Form_1745720603540.pdf	PPT	3	2	2025-04-26 21:23:23.549491
4	10	1	f2	cosine_similarity_overlap_1745721964825.png	PPT	1	1	2025-04-26 21:46:04.82933
5	10	1	f3	collage_1745722151350.pdf	PPT	0	0	2025-04-26 21:49:11.363912
6	82	10	f	CF Allergy Alert Form_1745728212989.pdf	Notes	0	0	2025-04-26 23:30:12.999758
7	82	10	f2	collage_1745733049348.pdf	PPT	0	0	2025-04-27 00:50:49.36276
\.


--
-- Data for Name: study_groups; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.study_groups (id, name, join_code) FROM stdin;
1	cs	Z8JDM5
3	cs1	XSVY4S
4	cs2	99WKHP
6	hi	N9NYS4
10	hello	GVLWT5
11	jessie	3WJX6C
15	hey	JCAGMF
18	hi	9URQWR
19	hi	A634CT
20	hello	9DXFCU
21	hello	AX29GW
22	hello	95VESA
23	hello	7EN2Q5
24	cs 222	YVU8LY
25	GVLWT	5353FS
26	hi	KUHWL8
27	hi	MX3Y3Y
28	cs	6ED295
29	cs	LYNMXJ
30	cs	3ZTLRE
31	cs	6NM838
32	cs 222	C2VHEQ
33	cs	GQ3RQ2
34	cs	9K632J
35	hiiii	ALGRHG
36	hey	PS8HHV
37	hi	PRNMH5
38	cs	P2W4ZM
39	cs 222	9NWWVL
40	cs 222	ZHP72E
41	cs	BSYHXW
42	ds	8J8JDX
43	group	UP73RE
44	gropu 2	Y5BJAP
45	g	ETKF4V
46	cs	2W4GFA
47	cs	JTEHP7
48	cooool	6RQ9JM
49	PRNMH5	9E52YV
50	group asf	J244NN
51	cs 34	BFZGY9
52	group 3	RE5BHG
53	group 4	CYH868
54	Test Group	QHHJY3
55	Test Group	ULT6ZD
56	Test Group	XWLFE9
57	Test Group	PTF3F7
58	Test Group	2CKZEJ
59	Test Group	D3GPNF
60	cs 300	8EAQVY
61	Test Group	7NB3RD
62	Test Group	7DMN92
63	Test Group	EW2Q9L
64	Test Group	A96MSW
65	Test Group	B96G2P
66	Test Group	NACBUE
67	Test Group	WVEVS9
68	Test Group	69B2NS
69	Test Group	42QPHK
70	Test Group	8SHTVZ
71	Test Group	5744TN
72	Test Group	FPQ3U3
73	Test Group	4P2BVK
74	Test Group	BKHFE5
75	Test Group	HJGYAE
76	cs34	MS2EEC
77	cs222	JTQLDR
78	ling413	LLS88Q
79	cs 300	ELJ75C
80	cs	VGK4GX
81	new group	X2GXHG
82	cs	QGZK5C
83	cs2	H83UHX
84	cs 222	V6N3CU
\.


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.threads (id, group_id, title, created_by, created_at) FROM stdin;
1	10	q	1	2025-04-26 22:04:10.680747
2	10	question	1	2025-04-26 22:07:56.051362
3	21	question	1	2025-04-26 22:10:26.342166
4	45	q	1	2025-04-26 22:12:58.115826
5	79	q	1	2025-04-26 22:13:19.534347
6	82	q	10	2025-04-26 23:30:20.879242
7	82	question	10	2025-04-27 00:49:53.516729
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.users (id, username, password) FROM stdin;
1	ellahappel	pass
2	ellahappel2	pass
3	ellahappel20	pass
4	ellahappel201	pass
5	adhwita	pass
6	ellahappel200	pass
7	ellahappel2002	pass
8	ellahappel22	pass
9	ellahappel4	pass
10	ellahappel8	pass
\.


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: ellahappel
--

COPY public.votes (id, answer_id, user_id, vote_type) FROM stdin;
34	2	1	1
35	6	10	1
37	7	10	1
18	1	1	-1
32	5	1	1
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.answers_id_seq', 7, true);


--
-- Name: availabilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.availabilities_id_seq', 978, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.events_id_seq', 2, true);


--
-- Name: flashcards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.flashcards_id_seq', 1, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.resources_id_seq', 7, true);


--
-- Name: study_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.study_groups_id_seq', 84, true);


--
-- Name: threads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.threads_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ellahappel
--

SELECT pg_catalog.setval('public.votes_id_seq', 37, true);


--
-- Name: answers answers_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: availabilities availabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.availabilities
    ADD CONSTRAINT availabilities_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: flashcards flashcards_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_pkey PRIMARY KEY (id);


--
-- Name: memberships memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (user_id, group_id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: study_groups study_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.study_groups
    ADD CONSTRAINT study_groups_pkey PRIMARY KEY (id);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (id);


--
-- Name: study_groups unique_join_code; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.study_groups
    ADD CONSTRAINT unique_join_code UNIQUE (join_code);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: votes votes_answer_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_answer_id_user_id_key UNIQUE (answer_id, user_id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: answers answers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: answers answers_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.threads(id);


--
-- Name: availabilities availabilities_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.availabilities
    ADD CONSTRAINT availabilities_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id);


--
-- Name: events events_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id);


--
-- Name: flashcards flashcards_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: flashcards flashcards_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.flashcards
    ADD CONSTRAINT flashcards_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id) ON DELETE CASCADE;


--
-- Name: memberships memberships_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id);


--
-- Name: memberships memberships_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.memberships
    ADD CONSTRAINT memberships_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notes notes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: notes notes_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id) ON DELETE CASCADE;


--
-- Name: resources resources_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id);


--
-- Name: resources resources_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: threads threads_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- Name: threads threads_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.study_groups(id) ON DELETE CASCADE;


--
-- Name: votes votes_answer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.answers(id);


--
-- Name: votes votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ellahappel
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

