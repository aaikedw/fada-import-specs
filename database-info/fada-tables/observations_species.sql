-- Table: fada.observations_species

-- DROP TABLE fada.observations_species;

CREATE TABLE fada.observations_species
(
  observation_id integer NOT NULL,
  species_id integer NOT NULL,
  CONSTRAINT observations_species_observation_id_fkey FOREIGN KEY (observation_id)
      REFERENCES fada.observations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT observations_species_species_id_fkey FOREIGN KEY (species_id)
      REFERENCES fada.species (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.observations_species
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.observations_species TO biofreshown;
GRANT SELECT ON TABLE fada.observations_species TO biofreshreader;
