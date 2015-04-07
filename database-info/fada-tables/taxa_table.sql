-- Table: fada.taxa_table

-- DROP TABLE fada.taxa_table;

CREATE TABLE fada.taxa_table
(
  id serial NOT NULL,
  group_id integer NOT NULL,
  file_name character varying(255) NOT NULL,
  row_id integer NOT NULL,
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
  original_genus character varying(50),
  declension_species character varying(30),
  parentheses character varying(1),
  syn_genus_subgenus character varying(50),
  syn_species_subspecies character varying(50),
  syn_authors character varying(150),
  syn_date character varying(10),
  syn_original_genus character varying(30),
  taxonomic_comments text,
  refkey text,
  upload_comments character varying(255),
  version integer,
  CONSTRAINT taxa_table_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.taxa_table
  OWNER TO biofreshown;
