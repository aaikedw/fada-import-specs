-- Table: fada.archived_observations

-- DROP TABLE fada.archived_observations;

CREATE TABLE fada.archived_observations
(
  id serial NOT NULL,
  scientific_name character varying(120) NOT NULL,
  group_id integer NOT NULL,
  observation_id integer,
  CONSTRAINT old_observations_pkey PRIMARY KEY (id),
  CONSTRAINT old_observations_observation_id_fkey FOREIGN KEY (observation_id)
      REFERENCES fada.observations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.archived_observations
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.archived_observations TO biofreshown;
GRANT SELECT ON TABLE fada.archived_observations TO biofreshreader;
