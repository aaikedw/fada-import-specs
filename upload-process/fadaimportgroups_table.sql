--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = fadaimport, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: groups; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    group_id integer NOT NULL,
    name character varying(50) NOT NULL,
    version integer DEFAULT 0 NOT NULL
);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: fadaimport; Owner: -
--

COPY groups (group_id, name, version) FROM stdin;
12	Annelida-Oligochaeta	0
11	Annelida-Polychaeta	0
31	Arachnida-Hydracarida	0
9	Bryozoa	0
34	Collembola	0
25	Crustacea-Amphipoda	0
16	Crustacea-Branchiopoda non Clado	0
20	Crustacea-Branchiura	0
23	Crustacea-Cumacea & Tanaidacea	0
27	Crustacea-Decapoda-Anomura-Aeglidae	0
30	Crustacea-Decapoda-Astacidea	0
28	Crustacea-Decapoda-Brachyura	0
29	Crustacea-Decapoda-Caridea	0
24	Crustacea-Isopoda	0
22	Crustacea-Spelaeogriphacea and Thermosbaenacea	0
26	Crustacea-Syncarids	0
8	Gastrotricha	0
41	Insecta-Coleoptera	0
43	Insecta-Dipt-Chironomidae	0
47	Insecta-Dipt-Culicidae	0
48	Insecta-Dipt-other families	0
46	Insecta-Dipt-Simulidae	0
45	Insecta-Dipt-Tipulidae	0
38	Insecta-Heteroptera	0
50	Insecta-Hymenoptera	0
49	Insecta-Lepidoptera	0
42	Insecta-Mecoptera	0
40	Insecta-Megaloptera & Neuroptera	0
15	Mollusca-Gastropoda	0
6	Nematoda	0
5	Nemertea	0
1	Porifera	0
10	Tardigrada	0
53	Vertebrates-Amphibia	0
55	Vertebrates-Reptiles-Crocodiles	0
54	Vertebrates-Reptiles-Lizards	0
57	Vertebrates-Reptiles-Snakes	0
56	Vertebrates-Reptiles-Turtles	0
59	Verterbates-Birds	0
13	Annelida-Hirudinea	0
36	Insecta-Odonata	0
18	Crustacea-Ostracoda	0
33	Arachnida-Oritiba	0
4	Rotifera	0
32	Arachnida-Halacaridae	0
19	Crustacea-Copepoda	0
37	Insecta-Plecoptera	0
14	Mollusca-Bivalvia	0
7	Nematomorpha	0
51	Insecta-Orthoptera	0
2	Cnidaria-Hydroida	0
17	Crustacea-Cladocera	0
35	Insecta-Ephemeroptera	0
21	Crustacea-Mysidacea	0
58	Vertebrates-Mammals	0
60	Macrophytes	0
39	Insecta-Trichoptera	0
52	Vertebrates-Fish	0
3	Platyhelminthes-Turbellaria	0
61	Insecta-Coleoptera-Psephenidae	0
\.


--
-- Name: groups_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pk PRIMARY KEY (group_id);


--
-- PostgreSQL database dump complete
--

