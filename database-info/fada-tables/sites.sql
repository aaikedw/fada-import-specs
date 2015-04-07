-- Table: fada.sites

-- DROP TABLE fada.sites;

CREATE TABLE fada.sites
(
  id serial NOT NULL,
  name character varying(100) NOT NULL,
  user_id integer NOT NULL,
  region_id integer NOT NULL,
  longitude double precision,
  latitude double precision,
  altitude integer,
  extent integer,
  CONSTRAINT sites_pkey PRIMARY KEY (id),
  CONSTRAINT sites_region_id_fkey FOREIGN KEY (region_id)
      REFERENCES fada.regions (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT sites_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES fada.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.sites
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.sites TO biofreshown;
GRANT SELECT ON TABLE fada.sites TO biofreshreader;
