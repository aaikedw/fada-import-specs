-- Table: fada.regions_species

-- DROP TABLE fada.regions_species;

CREATE TABLE fada.regions_species
(
  id serial NOT NULL,
  species_id integer NOT NULL,
  region_id integer NOT NULL,
  CONSTRAINT regions_species_pkey PRIMARY KEY (id),
  CONSTRAINT regions_species_region_id_fkey FOREIGN KEY (region_id)
      REFERENCES fada.regions (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT regions_species_species_id_fkey FOREIGN KEY (species_id)
      REFERENCES fada.species (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.regions_species
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.regions_species TO biofreshown;
GRANT SELECT ON TABLE fada.regions_species TO biofreshreader;
