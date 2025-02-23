--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2024-11-26 19:35:10

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
-- TOC entry 222 (class 1259 OID 33075)
-- Name: cargos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cargos (
    id_cargos integer NOT NULL,
    cargo character varying(100) NOT NULL,
    id_vete_cargo bigint
);


ALTER TABLE public.cargos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 33074)
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
-- TOC entry 4882 (class 0 OID 0)
-- Dependencies: 221
-- Name: cargos_id_cargos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cargos_id_cargos_seq OWNED BY public.cargos.id_cargos;


--
-- TOC entry 215 (class 1259 OID 33036)
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
-- TOC entry 223 (class 1259 OID 33103)
-- Name: diagnostico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagnostico (
    id_diag integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.diagnostico OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33056)
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
-- TOC entry 218 (class 1259 OID 33055)
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
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 218
-- Name: especie_id_especie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especie_id_especie_seq OWNED BY public.especie.id_especie;


--
-- TOC entry 229 (class 1259 OID 33213)
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
-- TOC entry 226 (class 1259 OID 33118)
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
-- TOC entry 225 (class 1259 OID 33117)
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
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 225
-- Name: historia_clinica_id_hc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historia_clinica_id_hc_seq OWNED BY public.historia_clinica.id_hc;


--
-- TOC entry 227 (class 1259 OID 33203)
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
-- TOC entry 217 (class 1259 OID 33044)
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
-- TOC entry 216 (class 1259 OID 33043)
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
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 216
-- Name: paciente_id_paciente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paciente_id_paciente_seq OWNED BY public.paciente.id_paciente;


--
-- TOC entry 224 (class 1259 OID 33110)
-- Name: procedimientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.procedimientos (
    id_proced integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.procedimientos OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 33208)
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
-- TOC entry 220 (class 1259 OID 33067)
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
-- TOC entry 4679 (class 2604 OID 33078)
-- Name: cargos id_cargos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos ALTER COLUMN id_cargos SET DEFAULT nextval('public.cargos_id_cargos_seq'::regclass);


--
-- TOC entry 4678 (class 2604 OID 33059)
-- Name: especie id_especie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie ALTER COLUMN id_especie SET DEFAULT nextval('public.especie_id_especie_seq'::regclass);


--
-- TOC entry 4680 (class 2604 OID 33121)
-- Name: historia_clinica id_hc; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica ALTER COLUMN id_hc SET DEFAULT nextval('public.historia_clinica_id_hc_seq'::regclass);


--
-- TOC entry 4677 (class 2604 OID 33047)
-- Name: paciente id_paciente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente ALTER COLUMN id_paciente SET DEFAULT nextval('public.paciente_id_paciente_seq'::regclass);


--
-- TOC entry 4869 (class 0 OID 33075)
-- Dependencies: 222
-- Data for Name: cargos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cargos (id_cargos, cargo, id_vete_cargo) FROM stdin;
1	Medico Cirujano	498938231
2	Medico General	370748571
3	Dermatologo	771045946
\.


--
-- TOC entry 4862 (class 0 OID 33036)
-- Dependencies: 215
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email) FROM stdin;
1076017781	Juan	P‚rez	Ortiz	123456789	987654321	juan@email.com
499641788	Ana	G¢mez	Viafara	987654321	\N	ana@email.com
843466820	Luis	Mart¡nez	Arango	456123789	\N	luis@email.com
1095689566	Margarita	Marin	Ocampo	32156897456	311563365896	margarita@email.com
\.


--
-- TOC entry 4870 (class 0 OID 33103)
-- Dependencies: 223
-- Data for Name: diagnostico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagnostico (id_diag, nombre, descripcion) FROM stdin;
12	Otitis	k godhpiu
32	Masas	iusa gpih ;
56	Parasitos	liugauf lukshl
59	No definido	gl ailgs liufg
\.


--
-- TOC entry 4866 (class 0 OID 33056)
-- Dependencies: 219
-- Data for Name: especie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especie (id_especie, raza, especie, id_especie_paciente) FROM stdin;
1	Labrador	Perro	1
2	Pincher	Perro	2
3	Persa	Gato	3
4	Bulldog	Perro	4
\.


--
-- TOC entry 4876 (class 0 OID 33213)
-- Dependencies: 229
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.factura (id_factura, valor, fecha_emision, descripcion, cantidad, id_factura_cliente, id_factura_hc, id_factura_pago) FROM stdin;
4565	150000.00	2024-01-16	Consulta y medicaci¢n	1	499641788	7	1740
4432	200000.00	2024-02-21	Consulta y ex menes	1	499641788	12	7716
4791	400000.00	2024-05-08	RX	1	1076017781	9	1058
4065	100000.00	2024-03-11	Consulta	1	499641788	10	7716
\.


--
-- TOC entry 4873 (class 0 OID 33118)
-- Dependencies: 226
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
-- TOC entry 4874 (class 0 OID 33203)
-- Dependencies: 227
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicamentos (id_medicamento, nombre, tipo, cantidad, fecha_vencimiento) FROM stdin;
1736	Antibi¢tico	Pastilla	30	2025-05-01
7712	Analg‚sico	Inyecccion	10	2024-12-15
1054	Antiinflamatorio	Pastilla	20	2025-03-10
\.


--
-- TOC entry 4864 (class 0 OID 33044)
-- Dependencies: 217
-- Data for Name: paciente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paciente (id_paciente, nombre, sexo, edad, peso, id_paciente_cliente) FROM stdin;
1	Max	macho	5	25.00	1076017781
2	Luky	macho	2	2.00	1076017781
3	Bella	hembra	3	4.70	499641788
4	Rocky	macho	4	20.00	843466820
\.


--
-- TOC entry 4871 (class 0 OID 33110)
-- Dependencies: 224
-- Data for Name: procedimientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.procedimientos (id_proced, nombre, descripcion) FROM stdin;
951	Limpieza de o¡dos	k godhpiu
624	Antibioticos	iusa gpih ;
587	RX	liugauf lukshl
563	Desparasitante	gl ailgs liufg
3654	Ex menes de sangre	I gauwlkuyeryh
\.


--
-- TOC entry 4875 (class 0 OID 33208)
-- Dependencies: 228
-- Data for Name: tipo_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_pago (id_pago, codigo, tipo, medio, num_cuenta, vencimiento) FROM stdin;
1740	C_1	Contado	Efectivo	\N	\N
7716	TC_2	Tarjeta Credito	Electronico	-9134	0
1058	T_3	Transferencia	Electronico	1234567890	\N
1059	C_1	Contado	Efectivo	\N	\N
\.


--
-- TOC entry 4867 (class 0 OID 33067)
-- Dependencies: 220
-- Data for Name: veterinarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.veterinarios (id_veterinario, nombre, apellido, telefono, email, especialidad, tp) FROM stdin;
498938231	Carlos	Cardenas	321654987	carlos@email.com	Cirug¡a	QND-123
370748571	Maria	Davila	654789123	maria@email.com	Medicina Interna	VDC-687
771045946	Javier	Congote	987321654	javier@email.com	Dermatolog¡a	TLM-493
\.


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 221
-- Name: cargos_id_cargos_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cargos_id_cargos_seq', 3, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 218
-- Name: especie_id_especie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especie_id_especie_seq', 4, true);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 225
-- Name: historia_clinica_id_hc_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historia_clinica_id_hc_seq', 13, true);


--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 216
-- Name: paciente_id_paciente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 4, true);


--
-- TOC entry 4695 (class 2606 OID 33080)
-- Name: cargos cargos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_pkey PRIMARY KEY (id_cargos);


--
-- TOC entry 4682 (class 2606 OID 33042)
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- TOC entry 4684 (class 2606 OID 33040)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente);


--
-- TOC entry 4697 (class 2606 OID 33109)
-- Name: diagnostico diagnostico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diag);


--
-- TOC entry 4689 (class 2606 OID 33061)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (id_especie);


--
-- TOC entry 4707 (class 2606 OID 33219)
-- Name: factura factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (id_factura);


--
-- TOC entry 4701 (class 2606 OID 33123)
-- Name: historia_clinica historia_clinica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_pkey PRIMARY KEY (id_hc);


--
-- TOC entry 4703 (class 2606 OID 33207)
-- Name: medicamentos medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id_medicamento);


--
-- TOC entry 4687 (class 2606 OID 33049)
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);


--
-- TOC entry 4699 (class 2606 OID 33116)
-- Name: procedimientos procedimientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.procedimientos
    ADD CONSTRAINT procedimientos_pkey PRIMARY KEY (id_proced);


--
-- TOC entry 4705 (class 2606 OID 33212)
-- Name: tipo_pago tipo_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_pago
    ADD CONSTRAINT tipo_pago_pkey PRIMARY KEY (id_pago);


--
-- TOC entry 4691 (class 2606 OID 33073)
-- Name: veterinarios veterinarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veterinarios
    ADD CONSTRAINT veterinarios_email_key UNIQUE (email);


--
-- TOC entry 4693 (class 2606 OID 33071)
-- Name: veterinarios veterinarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.veterinarios
    ADD CONSTRAINT veterinarios_pkey PRIMARY KEY (id_veterinario);


--
-- TOC entry 4685 (class 1259 OID 33240)
-- Name: idx_paciente_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_paciente_cliente ON public.paciente USING btree (id_paciente_cliente);


--
-- TOC entry 4710 (class 2606 OID 33081)
-- Name: cargos cargos_id_vete_cargo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cargos
    ADD CONSTRAINT cargos_id_vete_cargo_fkey FOREIGN KEY (id_vete_cargo) REFERENCES public.veterinarios(id_veterinario);


--
-- TOC entry 4709 (class 2606 OID 33062)
-- Name: especie especie_id_especie_paciente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_id_especie_paciente_fkey FOREIGN KEY (id_especie_paciente) REFERENCES public.paciente(id_paciente);


--
-- TOC entry 4716 (class 2606 OID 33220)
-- Name: factura factura_id_factura_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_factura_cliente_fkey FOREIGN KEY (id_factura_cliente) REFERENCES public.clientes(id_cliente);


--
-- TOC entry 4717 (class 2606 OID 33225)
-- Name: factura factura_id_factura_hc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_factura_hc_fkey FOREIGN KEY (id_factura_hc) REFERENCES public.historia_clinica(id_hc);


--
-- TOC entry 4718 (class 2606 OID 33230)
-- Name: factura factura_id_factura_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_id_factura_pago_fkey FOREIGN KEY (id_factura_pago) REFERENCES public.tipo_pago(id_pago);


--
-- TOC entry 4711 (class 2606 OID 33139)
-- Name: historia_clinica historia_clinica_id_hc_diag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_diag_fkey FOREIGN KEY (id_hc_diag) REFERENCES public.diagnostico(id_diag);


--
-- TOC entry 4712 (class 2606 OID 33129)
-- Name: historia_clinica historia_clinica_id_hc_especie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_especie_fkey FOREIGN KEY (id_hc_especie) REFERENCES public.especie(id_especie);


--
-- TOC entry 4713 (class 2606 OID 33134)
-- Name: historia_clinica historia_clinica_id_hc_proc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_proc_fkey FOREIGN KEY (id_hc_proc) REFERENCES public.procedimientos(id_proced);


--
-- TOC entry 4714 (class 2606 OID 33124)
-- Name: historia_clinica historia_clinica_id_hc_veterinario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_hc_veterinario_fkey FOREIGN KEY (id_hc_veterinario) REFERENCES public.veterinarios(id_veterinario);


--
-- TOC entry 4715 (class 2606 OID 33235)
-- Name: historia_clinica historia_clinica_id_medicamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historia_clinica
    ADD CONSTRAINT historia_clinica_id_medicamento_fkey FOREIGN KEY (id_medicamento) REFERENCES public.medicamentos(id_medicamento);


--
-- TOC entry 4708 (class 2606 OID 33050)
-- Name: paciente paciente_id_paciente_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_id_paciente_cliente_fkey FOREIGN KEY (id_paciente_cliente) REFERENCES public.clientes(id_cliente);


-- Completed on 2024-11-26 19:35:11

--
-- PostgreSQL database dump complete
--

