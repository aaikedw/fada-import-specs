-- Table: importandsyncfada.minitaxa_table

-- DROP TABLE importandsyncfada.minitaxa_table;

CREATE TABLE importandsyncfada.minitaxa_table
(
  id serial NOT NULL,
  group_id integer NOT NULL,
  family character varying(30),
  subfamily character varying(30),
  tribe character varying(30),
  subtribe character varying(30),
  genus character varying(30),
  subgenus character varying(30),
  species character varying(30),
  subspecies character varying(30),
  authors character varying(150),
  date character varying(10),
  parenthesis boolean,
  version integer DEFAULT 0,
  CONSTRAINT minitaxa_table_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.minitaxa_table
  OWNER TO biofreshown;
