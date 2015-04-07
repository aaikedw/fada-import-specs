-- Table: fada.biofresh_key_synonyms

-- DROP TABLE fada.biofresh_key_synonyms;

CREATE TABLE fada.biofresh_key_synonyms
(
  id integer NOT NULL,
  syn_id integer,
  genus_species_name character varying(100) NOT NULL,
  author_id integer,
  year character varying(4),
  publication_id integer,
  group_id integer NOT NULL,
  logicaldelete boolean DEFAULT false,
  date_logical_delete timestamp without time zone,
  version integer DEFAULT 0,
  CONSTRAINT biofresh_key_synonyms_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.biofresh_key_synonyms
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.biofresh_key_synonyms TO biofreshown;
GRANT SELECT ON TABLE fada.biofresh_key_synonyms TO biofreshreader;
