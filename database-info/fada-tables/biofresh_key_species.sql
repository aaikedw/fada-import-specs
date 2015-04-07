-- Table: fada.biofresh_key_species

-- DROP TABLE fada.biofresh_key_species;

CREATE TABLE fada.biofresh_key_species
(
  id serial NOT NULL,
  scientific_name character varying(120) NOT NULL,
  species_id integer,
  version integer NOT NULL DEFAULT 0,
  CONSTRAINT biofresh_key_species_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.biofresh_key_species
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.biofresh_key_species TO biofreshown;
GRANT SELECT ON TABLE fada.biofresh_key_species TO biofreshreader;

-- Index: fada.fada_biofresh_key_species_regex_scientific_name

-- DROP INDEX fada.fada_biofresh_key_species_regex_scientific_name;

CREATE INDEX fada_biofresh_key_species_regex_scientific_name
  ON fada.biofresh_key_species
  USING btree
  (scientific_name varchar_pattern_ops);

-- Index: fada.fada_biofresh_key_species_scientific_name

-- DROP INDEX fada.fada_biofresh_key_species_scientific_name;

CREATE INDEX fada_biofresh_key_species_scientific_name
  ON fada.biofresh_key_species
  USING btree
  (scientific_name);

