-- Table: fada.observations

-- DROP TABLE fada.observations;

CREATE TABLE fada.observations
(
  id serial NOT NULL,
  user_id integer NOT NULL,
  group_id integer NOT NULL,
  region_id integer,
  bassin_id integer,
  location_id integer,
  taxonomy text,
  ecology text,
  geography text,
  site_id integer,
  observed date,
  submitted date,
  verified date,
  verified_by integer,
  verification_comment text,
  obs_status_id integer NOT NULL,
  scientifc_names character varying[],
  CONSTRAINT observations_pkey PRIMARY KEY (id),
  CONSTRAINT observations_bassin_id_fkey FOREIGN KEY (bassin_id)
      REFERENCES fada.bassins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT observations_location_id_fkey FOREIGN KEY (location_id)
      REFERENCES fada.locations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT observations_obs_status_id_fkey FOREIGN KEY (obs_status_id)
      REFERENCES fada.obs_statuses (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT observations_region_id_fkey FOREIGN KEY (region_id)
      REFERENCES fada.regions (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT observations_site_id_fkey FOREIGN KEY (site_id)
      REFERENCES fada.sites (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT observations_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES fada.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT observations_verified_by_fkey FOREIGN KEY (verified_by)
      REFERENCES fada.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.observations
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.observations TO biofreshown;
GRANT SELECT ON TABLE fada.observations TO biofreshreader;
