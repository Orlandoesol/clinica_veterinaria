--
-- PostgreSQL database dump
--

\restrict qfVHcbELotWdCyuaiUaxA0RNR0bQpOjBYWqMSop8fuf6SHawH1jO4ZAKuJn2NkO

-- Dumped from database version 17.11
-- Dumped by pg_dump version 17.11

-- Started on 2026-11-09 22:31:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 217 (class 1259 OID 16553)
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos (
    id_cargos integer NOT NULL,
    cargo character varying(100) NOT NULL,
    id_vete_cargo bigint
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16556)
-- Name: cargos_id_cargos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cargos_id_cargos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cargos_id_cargos_seq OWNER TO postgres;

--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 218
-- Name: cargos_id_cargos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargos_id_cargos_seq OWNED BY public.cargos.id_cargos;


--
-- TOC entry 219 (class 1259 OID 16557)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id_cliente bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    primer_apellido character varying(100) NOT NULL,
    segundo_apellido character varying(100) NOT NULL,
    telefono_1 character varying(15) NOT NULL,
    telefono_2 character varying(15),
    email character varying(100) NOT NULL
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16560)
-- Name: diagnostico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagnostico (
    id_diag integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.diagnostico OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16565)
-- Name: especie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especie (
    id_especie integer NOT NULL,
    raza character varying(100) NOT NULL,
    especie character varying(100) NOT NULL,
    id_especie_paciente integer
);


ALTER TABLE public.especie OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16568)
-- Name: especie_id_especie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.especie_id_especie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.especie_id_especie_seq OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 222
-- Name: especie_id_especie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especie_id_especie_seq OWNED BY public.especie.id_especie;


--
-- TOC entry 223 (class 1259 OID 16569)
-- Name: factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura (
    id_factura integer NOT NULL,
    valor numeric(10,2) NOT NULL,
    fecha_emision date NOT NULL,
    descripcion text NOT NULL,
    cantidad integer NOT NULL,
    id_factura_cliente bigint,
    id_factura_hc integer,
    id_factura_pago integer
);


ALTER TABLE public.factura OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16574)
-- Name: historia_clinica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historia_clinica (
    id_hc integer NOT NULL,
    fecha_atencion date NOT NULL,
    fecha_salida date NOT NULL,
    motivo_consulta character varying(255) NOT NULL,
    id_hc_veterinario bigint,
    id_hc_especie integer,
    id_hc_proc integer,
    id_hc_diag integer,
    id_hc_medicamento integer,
    id_medicamento integer
);


ALTER TABLE public.historia_clinica OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16577)
-- Name: historia_clinica_id_hc_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historia_clinica_id_hc_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historia_clinica_id_hc_seq OWNER TO postgres;

--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 225
-- Name: historia_clinica_id_hc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historia_clinica_id_hc_seq OWNED BY public.historia_clinica.id_hc;


--
-- TOC entry 226 (class 1259 OID 16578)
-- Name: medicamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicamentos (
    id_medicamento integer NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo character varying(50) NOT NULL,
    cantidad integer NOT NULL,
    fecha_vencimiento date NOT NULL
);


ALTER TABLE public.medicamentos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16581)
-- Name: paciente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paciente (
    id_paciente integer NOT NULL,
    nombre character varying(100) NOT NULL,
    sexo character varying(10) NOT NULL,
    edad integer NOT NULL,
    peso numeric(5,2),
    id_paciente_cliente bigint
);


ALTER TABLE public.paciente OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16584)
-- Name: paciente_id_paciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paciente_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paciente_id_paciente_seq OWNER TO postgres;

--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 228
-- Name: paciente_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paciente_id_paciente_seq OWNED BY public.paciente.id_paciente;


--
-- TOC entry 235 (class 1259 OID 16695)
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacientes (
    id_paciente integer NOT NULL,
    nombre_mascota character varying(100) NOT NULL,
    sexo character varying(30) NOT NULL,
    edad integer NOT NULL,
    peso numeric(5,2) NOT NULL,
    id_cliente integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16694)
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacientes_id_paciente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pacientes_id_paciente_seq OWNER TO postgres;

--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 234
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacientes_id_paciente_seq OWNED BY public.pacientes.id_paciente;


--
-- TOC entry 229 (class 1259 OID 16585)
-- Name: procedimientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procedimientos (
    id_proced integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.procedimientos OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16590)
-- Name: tipo_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_pago (
    id_pago integer NOT NULL,
    codigo character varying(5) NOT NULL,
    tipo character varying(15) NOT NULL,
    medio character varying(15) NOT NULL,
    num_cuenta bigint,
    vencimiento character varying(10)
);


ALTER TABLE public.tipo_pago OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16683)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password text NOT NULL,
    role character varying(50) DEFAULT 'Usuario'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16682)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 232
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 231 (class 1259 OID 16593)
-- Name: veterinarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.veterinarios (
    id_veterinario bigint NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    telefono character varying(15) NOT NULL,
    email character varying(100) NOT NULL,
    especialidad character varying(100) NOT NULL,
    tp character varying(20)
);


ALTER TABLE public.veterinarios OWNER TO postgres;

--
-- TOC entry 4795 (class 2604 OID 16596)
-- Name: cargos id_cargos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos ALTER COLUMN id_cargos SET DEFAULT nextval('public.cargos_id_cargos_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 16597)
-- Name: especie id_especie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie ALTER COLUMN id_especie SET DEFAULT nextval('public.especie_id_especie_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 16598)
-- Name: historia_clinica id_hc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica ALTER COLUMN id_hc SET DEFAULT nextval('public.historia_clinica_id_hc_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 16599)
-- Name: paciente id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente ALTER COLUMN id_paciente SET DEFAULT nextval('public.paciente_id_paciente_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 16698)
-- Name: pacientes id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes ALTER COLUMN id_paciente SET DEFAULT nextval('public.pacientes_id_paciente_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 16686)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4993 (class 0 OID 16553)
-- Dependencies: 217
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargos (id_cargos, cargo, id_vete_cargo) FROM stdin;
1	Médico Cirujano	498938231
2	Médico General	370748571
3	Dermatologo	771045946
\.


--
-- TOC entry 4995 (class 0 OID 16557)
-- Dependencies: 219
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email) FROM stdin;
1076017781	Juan	Pérez	Ortiz	123456789	987654321	juan@email.com
499641788	Ana	Gómez	Viafara	987654321	\N	ana@email.com
843466820	Luis	Martínez	Arango	456123789	\N	luis@email.com
1095689566	Margarita	Marin	Ocampo	32156897456	311563365896	margarita@email.com
\.


--
-- TOC entry 4996 (class 0 OID 16560)
-- Dependencies: 220
-- Data for Name: diagnostico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagnostico (id_diag, nombre, descripcion) FROM stdin;
12	Otitis	k godhpiu
32	Masas	iusa gpih ;
56	Parásitos	liugauf lukshl
59	No definido	gl ailgs liufg
\.


--
-- TOC entry 4997 (class 0 OID 16565)
-- Dependencies: 221
-- Data for Name: especie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especie (id_especie, raza, especie, id_especie_paciente) FROM stdin;
1	Labrador	Perro	1
2	Pincher	Perro	2
3	Persa	Gato	3
4	Bulldog	Perro	4
\.


--
-- TOC entry 4999 (class 0 OID 16569)
-- Dependencies: 223
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura (id_factura, valor, fecha_emision, descripcion, cantidad, id_factura_cliente, id_factura_hc, id_factura_pago) FROM stdin;
4565	150000.00	2024-01-16	Consulta y medicación	1	499641788	7	1740
4432	200000.00	2024-02-21	Consulta y exámenes	1	499641788	12	7716
4791	400000.00	2024-05-08	RX	1	1076017781	9	1058
4065	100000.00	2024-03-11	Consulta	1	499641788	10	7716
\.


--
-- TOC entry 5000 (class 0 OID 16574)
-- Dependencies: 224
-- Data for Name: historia_clinica; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historia_clinica (id_hc, fecha_atencion, fecha_salida, motivo_consulta, id_hc_veterinario, id_hc_especie, id_hc_proc, id_hc_diag, id_hc_medicamento, id_medicamento) FROM stdin;
7	2024-01-15	2024-01-18	Malestar auditivo	370748571	3	951	12	1736	\N
8	2024-01-15	2024-01-18	Malestar auditivo	771045946	4	624	12	1736	\N
9	2024-02-20	2024-02-23	Bolas en el cuerpo	771045946	1	587	32	1054	\N
10	2024-04-12	2024-04-15	Sangre en la nariz	370748571	3	563	56	3589	\N
11	2024-04-12	2024-04-15	Decaimiento	370748571	3	3654	56	7712	\N
12	2024-03-10	2024-03-13	Control	498938231	2	3654	59	7712	\N
13	2024-01-12	2024-01-15	Urgencia	498938231	1	563	56	1054	\N
14	2024-06-18	2024-07-25	Control	498938231	4	3654	32	3589	\N
\.


--
-- TOC entry 5002 (class 0 OID 16578)
-- Dependencies: 226
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicamentos (id_medicamento, nombre, tipo, cantidad, fecha_vencimiento) FROM stdin;
1736	Antibiótico	Pastilla	30	2025-05-01
7712	Analgésico	Inyección	10	2024-12-15
1054	Antiinflamatorio	Pastilla	20	2025-03-10
\.


--
-- TOC entry 5003 (class 0 OID 16581)
-- Dependencies: 227
-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paciente (id_paciente, nombre, sexo, edad, peso, id_paciente_cliente) FROM stdin;
1	Max	macho	5	25.00	1076017781
2	Luky	macho	2	2.00	1076017781
3	Bella	hembra	3	4.70	499641788
4	Rocky	macho	4	20.00	843466820
\.


--
-- TOC entry 5011 (class 0 OID 16695)
-- Dependencies: 235
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pacientes (id_paciente, nombre_mascota, sexo, edad, peso, id_cliente, created_at) FROM stdin;
\.


--
-- TOC entry 5005 (class 0 OID 16585)
-- Dependencies: 229
-- Data for Name: procedimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.procedimientos (id_proced, nombre, descripcion) FROM stdin;
951	Limpieza de oídos	k godhpiu
624	Antibioticos	iusa gpih ;
587	RX	liugauf lukshl
563	Desparasitante	gl ailgs liufg
3654	Ex menes de sangre	I gauwlkuyeryh
\.


--
-- TOC entry 5006 (class 0 OID 16590)
-- Dependencies: 230
-- Data for Name: tipo_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_pago (id_pago, codigo, tipo, medio, num_cuenta, vencimiento) FROM stdin;
1740	C_1	Contado	Efectivo	\N	\N
7716	TC_2	Tarjeta Credito	Electronico	-9134	0
1058	T_3	Transferencia	Electronico	1234567890	\N
1059	C_1	Contado	Efectivo	\N	\N
\.


--
-- TOC entry 5009 (class 0 OID 16683)
-- Dependencies: 233
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, role) FROM stdin;
1	usuarioMas@email.com	$2a$10$y7757LaDX5sFp/tfnGiBOeVIR0jtT907PF4z5LRc7Q1GEOUL4M3K2	Superadmin
\.


--
-- TOC entry 5007 (class 0 OID 16593)
-- Dependencies: 231
-- Data for Name: veterinarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.veterinarios (id_veterinario, nombre, apellido, telefono, email, especialidad, tp) FROM stdin;
498938231	Carlos	Cardenas	321654987	carlos@email.com	Cirugía	QND-123
370748571	Maria	Davila	654789123	maria@email.com	Medicina Interna	VDC-687
771045946	Javier	Congote	987321654	javier@email.com	Dermatología	TLM-493
\.


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 218
-- Name: cargos_id_cargos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargos_id_cargos_seq', 3, true);


--
-- TOC entry 5024 (class 0 OID 0)
-- Dependencies: 222
-- Name: especie_id_especie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especie_id_especie_seq', 4, true);


--
-- TOC entry 5025 (class 0 OID 0)
-- Dependencies: 225
-- Name: historia_clinica_id_hc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historia_clinica_id_hc_seq', 13, true);


--
-- TOC entry 5026 (class 0 OID 0)
-- Dependencies: 228
-- Name: paciente_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 4, true);


--
-- TOC entry 5027 (class 0 OID 0)
-- Dependencies: 234
-- Name: pacientes_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacientes_id_paciente_seq', 1, false);


--
-- TOC entry 5028 (class 0 OID 0)
-- Dependencies: 232
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4804 (class 2606 OID 16601)
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id_cargos);


--
-- TOC entry 4806 (class 2606 OID 16603)
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- TOC entry 4808 (class 2606 OID 16605)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4810 (class 2606 OID 16607)
-- Name: diagnostico diagnostico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diag);


--
-- TOC entry 4812 (class 2606 OID 16609)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (id_especie);


--
-- TOC entry 4814 (class 2606 OID 16611)
-- Name: factura factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 4816 (class 2606 OID 16613)
-- Name: historia_clinica historia_clinica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_pkey PRIMARY KEY (id_hc);


--
-- TOC entry 4818 (class 2606 OID 16615)
-- Name: medicamentos medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id_medicamento);


--
-- TOC entry 4821 (class 2606 OID 16617)
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 4835 (class 2606 OID 16701)
-- Name: pacientes pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 4823 (class 2606 OID 16619)
-- Name: procedimientos procedimientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimientos
    ADD CONSTRAINT procedimientos_pkey PRIMARY KEY (id_proced);


--
-- TOC entry 4825 (class 2606 OID 16621)
-- Name: tipo_pago tipo_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_pago
    ADD CONSTRAINT tipo_pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4831 (class 2606 OID 16693)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4833 (class 2606 OID 16691)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 16623)
-- Name: veterinarios veterinarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veterinarios
    ADD CONSTRAINT veterinarios_email_key UNIQUE (email);


--
-- TOC entry 4829 (class 2606 OID 16625)
-- Name: veterinarios veterinarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veterinarios
    ADD CONSTRAINT veterinarios_pkey PRIMARY KEY (id_veterinario);


--
-- TOC entry 4819 (class 1259 OID 16626)
-- Name: idx_paciente_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_paciente_cliente ON public.paciente USING btree (id_paciente_cliente);


--
-- TOC entry 4836 (class 2606 OID 16627)
-- Name: cargos cargos_id_vete_cargo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_id_vete_cargo_fkey FOREIGN KEY (id_vete_cargo) REFERENCES public.veterinarios(id_veterinario);


--
-- TOC entry 4837 (class 2606 OID 16632)
-- Name: especie especie_id_especie_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_id_especie_paciente_fkey FOREIGN KEY (id_especie_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 4838 (class 2606 OID 16637)
-- Name: factura factura_id_factura_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_factura_cliente_fkey FOREIGN KEY (id_factura_cliente) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 4839 (class 2606 OID 16642)
-- Name: factura factura_id_factura_hc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_factura_hc_fkey FOREIGN KEY (id_factura_hc) REFERENCES public.historia_clinica(id_hc);


--
-- TOC entry 4840 (class 2606 OID 16647)
-- Name: factura factura_id_factura_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_factura_pago_fkey FOREIGN KEY (id_factura_pago) REFERENCES public.tipo_pago(id_pago);


--
-- TOC entry 4847 (class 2606 OID 16702)
-- Name: pacientes fk_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente) ON DELETE CASCADE;


--
-- TOC entry 4841 (class 2606 OID 16652)
-- Name: historia_clinica historia_clinica_id_hc_diag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_diag_fkey FOREIGN KEY (id_hc_diag) REFERENCES public.diagnostico(id_diag);


--
-- TOC entry 4842 (class 2606 OID 16657)
-- Name: historia_clinica historia_clinica_id_hc_especie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_especie_fkey FOREIGN KEY (id_hc_especie) REFERENCES public.especie(id_especie);


--
-- TOC entry 4843 (class 2606 OID 16662)
-- Name: historia_clinica historia_clinica_id_hc_proc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_proc_fkey FOREIGN KEY (id_hc_proc) REFERENCES public.procedimientos(id_proced);


--
-- TOC entry 4844 (class 2606 OID 16667)
-- Name: historia_clinica historia_clinica_id_hc_veterinario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_veterinario_fkey FOREIGN KEY (id_hc_veterinario) REFERENCES public.veterinarios(id_veterinario);


--
-- TOC entry 4845 (class 2606 OID 16672)
-- Name: historia_clinica historia_clinica_id_medicamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_medicamento_fkey FOREIGN KEY (id_medicamento) REFERENCES public.medicamentos(id_medicamento);


--
-- TOC entry 4846 (class 2606 OID 16677)
-- Name: paciente paciente_id_paciente_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_id_paciente_cliente_fkey FOREIGN KEY (id_paciente_cliente) REFERENCES public.clientes(id_cliente);


-- Completed on 2026-11-09 22:31:35

--
-- PostgreSQL database dump complete
--

\unrestrict qfVHcbELotWdCyuaiUaxA0RNR0bQpOjBYWqMSop8fuf6SHawH1jO4ZAKuJn2NkO

