-- Table: importandsyncfada.former_taxa_table

-- DROP TABLE importandsyncfada.former_taxa_table;

CREATE TABLE importandsyncfada.former_taxa_table
(
  id integer NOT NULL DEFAULT nextval('importandsyncfada.taxa_table_id_seq'::regclass),
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
  version integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.former_taxa_table
  OWNER TO biofreshown;
