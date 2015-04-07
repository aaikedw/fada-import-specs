-- Table: fada.locations

-- DROP TABLE fada.locations;

CREATE TABLE fada.locations
(
  id serial NOT NULL,
  code character varying(8) NOT NULL,
  name character varying(64) NOT NULL,
  parent_id integer,
  CONSTRAINT locations_pkey PRIMARY KEY (id),
  CONSTRAINT locations_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES fada.locations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT locations_code_key UNIQUE (code),
  CONSTRAINT locations_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.locations
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.locations TO biofreshown;
GRANT SELECT ON TABLE fada.locations TO biofreshreader;
