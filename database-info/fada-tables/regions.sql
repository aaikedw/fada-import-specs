-- Table: fada.regions

-- DROP TABLE fada.regions;

CREATE TABLE fada.regions
(
  id serial NOT NULL,
  code character varying(4) NOT NULL,
  name character varying(64) NOT NULL,
  parent_id integer,
  distribution character varying(30),
  CONSTRAINT regions_pkey PRIMARY KEY (id),
  CONSTRAINT regions_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES fada.regions (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT regions_code_key UNIQUE (code),
  CONSTRAINT regions_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.regions
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.regions TO biofreshown;
GRANT SELECT ON TABLE fada.regions TO biofreshreader;
