--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: fadaimport; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA fadaimport;


SET search_path = fadaimport, pg_catalog;

--
-- Name: analysisnum_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE analysisnum_seq
    START WITH 11
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: changednames; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE changednames (
    thename character varying NOT NULL,
    fada_id integer NOT NULL,
    new_fada_name character varying NOT NULL,
    register_id integer NOT NULL,
    group_id integer NOT NULL,
    version integer DEFAULT 0 NOT NULL
);


--
-- Name: distr_table; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE distr_table (
    record_id integer NOT NULL,
    group_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    row_id integer NOT NULL,
    genus character varying(64),
    subgenus character varying(64),
    species character varying(64),
    subspecies character varying(64),
    authors character varying(150),
    date character varying(10),
    pa character varying(5),
    ate character varying(5),
    au character varying(5),
    ol character varying(5),
    na character varying(5),
    nt character varying(5),
    ant character varying(5),
    pac character varying(5),
    faunistic_comment text,
    countrylevel character varying(300),
    refkey text,
    lentic character varying(5),
    lotic character varying(5),
    exotic character varying(5),
    body_size character varying(30),
    parasitic character varying(5),
    aquatic_water_dependant character varying(5),
    version integer DEFAULT 0 NOT NULL,
    rank character varying
);


--
-- Name: distr_table_record_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE distr_table_record_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


--
-- Name: distr_table_record_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE distr_table_record_id_seq OWNED BY distr_table.record_id;


--
-- Name: errs_upload; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE errs_upload (
    errs_id integer NOT NULL,
    data_sheet character varying(15) NOT NULL,
    file_name character varying(255) NOT NULL,
    group_id integer NOT NULL,
    row_id integer NOT NULL,
    record_id integer NOT NULL,
    msg_type character varying(20) NOT NULL,
    msg text NOT NULL,
    version integer DEFAULT 0 NOT NULL,
    field_name character varying(30)
);


--
-- Name: errs_upload_errs_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE errs_upload_errs_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


--
-- Name: errs_upload_errs_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE errs_upload_errs_id_seq OWNED BY errs_upload.errs_id;


--
-- Name: errs_validation; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE errs_validation (
    errs_id integer NOT NULL,
    data_sheet character varying(15) NOT NULL,
    file_name character varying(255) NOT NULL,
    group_id integer NOT NULL,
    msg_type character varying(20) NOT NULL,
    msg text NOT NULL,
    version integer DEFAULT 0 NOT NULL
);


--
-- Name: errs_validation_errs_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE errs_validation_errs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: errs_validation_errs_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE errs_validation_errs_id_seq OWNED BY errs_validation.errs_id;


--
-- Name: groups; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    group_id integer NOT NULL,
    name character varying(50) NOT NULL,
    version integer DEFAULT 0 NOT NULL
);


--
-- Name: knowntofada; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE knowntofada (
    register_id integer NOT NULL,
    group_id integer,
    version integer DEFAULT 0 NOT NULL
);


--
-- Name: minitaxa_table; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE minitaxa_table (
    id integer NOT NULL,
    group_id integer NOT NULL,
    rank character varying,
    family character varying,
    subfamily character varying,
    tribe character varying,
    subtribe character varying,
    genus character varying,
    subgenus character varying,
    speciesgroup character varying,
    species character varying,
    subspecies character varying,
    authors character varying,
    date character varying,
    parentheses character varying,
    version integer
);


--
-- Name: minitaxa_table_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE minitaxa_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: minitaxa_table_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE minitaxa_table_id_seq OWNED BY minitaxa_table.id;


--
-- Name: ref_table; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE ref_table (
    record_id integer NOT NULL,
    group_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    row_id integer NOT NULL,
    author character varying(300),
    year character varying(10),
    title character varying(255),
    source text,
    refkey text,
    url text,
    version integer DEFAULT 0 NOT NULL
);


--
-- Name: ref_table_record_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE ref_table_record_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


--
-- Name: ref_table_record_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE ref_table_record_id_seq OWNED BY ref_table.record_id;


--
-- Name: sync_errors; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE sync_errors (
    id integer NOT NULL,
    checkingfrom character varying NOT NULL,
    registerid integer,
    groupid integer NOT NULL,
    fadaspeciesid integer,
    regfullname character varying,
    fadafullname character varying,
    errordescription character varying,
    status character varying,
    created timestamp without time zone,
    modified timestamp without time zone,
    version integer
);


--
-- Name: sync_errors_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE sync_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sync_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE sync_errors_id_seq OWNED BY sync_errors.id;


--
-- Name: syncanalysisreport; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE syncanalysisreport (
    id integer NOT NULL,
    groupid integer NOT NULL,
    analysisnum integer NOT NULL,
    regid integer,
    bksid integer,
    regfullname character varying,
    fadafullname character varying,
    description character varying,
    namestatus character varying NOT NULL,
    linestatus character varying NOT NULL,
    action character varying NOT NULL,
    created timestamp without time zone NOT NULL,
    modified timestamp without time zone,
    version integer
);


--
-- Name: syncanalysisreport_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE syncanalysisreport_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: syncanalysisreport_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE syncanalysisreport_id_seq OWNED BY syncanalysisreport.id;


--
-- Name: taxa_table; Type: TABLE; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE TABLE taxa_table (
    record_id integer NOT NULL,
    group_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    row_id integer NOT NULL,
    family character varying(64),
    subfamily character varying(64),
    tribe character varying(64),
    subtribe character varying(64),
    genus character varying(64),
    subgenus character varying(64),
    species character varying(64),
    subspecies character varying(64),
    authors character varying(150),
    date character varying(10),
    original_genus character varying(64),
    declension_species character varying(64),
    parentheses character varying(1),
    syn_genus_subgenus character varying(64),
    syn_species_subspecies character varying(64),
    syn_authors character varying(150),
    syn_date character varying(10),
    syn_original_genus character varying(64),
    taxonomic_comments text,
    refkey text,
    rank character varying(15) NOT NULL,
    speciesgroup character varying(40),
    version integer DEFAULT 0 NOT NULL
);


--
-- Name: taxa_table_record_id_seq; Type: SEQUENCE; Schema: fadaimport; Owner: -
--

CREATE SEQUENCE taxa_table_record_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxa_table_record_id_seq; Type: SEQUENCE OWNED BY; Schema: fadaimport; Owner: -
--

ALTER SEQUENCE taxa_table_record_id_seq OWNED BY taxa_table.record_id;


--
-- Name: record_id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY distr_table ALTER COLUMN record_id SET DEFAULT nextval('distr_table_record_id_seq'::regclass);


--
-- Name: errs_id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY errs_upload ALTER COLUMN errs_id SET DEFAULT nextval('errs_upload_errs_id_seq'::regclass);


--
-- Name: errs_id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY errs_validation ALTER COLUMN errs_id SET DEFAULT nextval('errs_validation_errs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY minitaxa_table ALTER COLUMN id SET DEFAULT nextval('minitaxa_table_id_seq'::regclass);


--
-- Name: record_id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY ref_table ALTER COLUMN record_id SET DEFAULT nextval('ref_table_record_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY sync_errors ALTER COLUMN id SET DEFAULT nextval('sync_errors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY syncanalysisreport ALTER COLUMN id SET DEFAULT nextval('syncanalysisreport_id_seq'::regclass);


--
-- Name: record_id; Type: DEFAULT; Schema: fadaimport; Owner: -
--

ALTER TABLE ONLY taxa_table ALTER COLUMN record_id SET DEFAULT nextval('taxa_table_record_id_seq'::regclass);


--
-- Name: changednames_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY changednames
    ADD CONSTRAINT changednames_pk PRIMARY KEY (register_id);


--
-- Name: distr_table_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY distr_table
    ADD CONSTRAINT distr_table_pk PRIMARY KEY (record_id);


--
-- Name: errs_upload_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY errs_upload
    ADD CONSTRAINT errs_upload_pk PRIMARY KEY (errs_id);


--
-- Name: errs_validation_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY errs_validation
    ADD CONSTRAINT errs_validation_pk PRIMARY KEY (errs_id);


--
-- Name: groups_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pk PRIMARY KEY (group_id);


--
-- Name: knowntofada_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY knowntofada
    ADD CONSTRAINT knowntofada_pk PRIMARY KEY (register_id);


--
-- Name: minitaxa_table_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY minitaxa_table
    ADD CONSTRAINT minitaxa_table_pk PRIMARY KEY (id);


--
-- Name: ref_table_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ref_table
    ADD CONSTRAINT ref_table_pk PRIMARY KEY (record_id);


--
-- Name: sync_errors_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sync_errors
    ADD CONSTRAINT sync_errors_pk PRIMARY KEY (id);


--
-- Name: syncanalysisreport_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY syncanalysisreport
    ADD CONSTRAINT syncanalysisreport_pk PRIMARY KEY (id);


--
-- Name: taxa_table_pk; Type: CONSTRAINT; Schema: fadaimport; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxa_table
    ADD CONSTRAINT taxa_table_pk PRIMARY KEY (record_id);


--
-- Name: knowntofada_group_idx; Type: INDEX; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE INDEX knowntofada_group_idx ON knowntofada USING btree (group_id);


--
-- Name: minitaxa_group_id_idx; Type: INDEX; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE INDEX minitaxa_group_id_idx ON minitaxa_table USING btree (group_id);


--
-- Name: minitaxa_rank_idx; Type: INDEX; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE INDEX minitaxa_rank_idx ON minitaxa_table USING btree (rank);


--
-- Name: taxa_table_rank_idx; Type: INDEX; Schema: fadaimport; Owner: -; Tablespace: 
--

CREATE INDEX taxa_table_rank_idx ON taxa_table USING btree (rank);


--
-- PostgreSQL database dump complete
--

