-- Table: fada.bassins

-- DROP TABLE fada.bassins;

CREATE TABLE fada.bassins
(
  id serial NOT NULL,
  code character varying(8) NOT NULL,
  name character varying(64) NOT NULL,
  parent_id integer,
  CONSTRAINT bassins_pkey PRIMARY KEY (id),
  CONSTRAINT bassins_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES fada.bassins (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT bassins_code_key UNIQUE (code),
  CONSTRAINT bassins_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.bassins
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.bassins TO biofreshown;
GRANT SELECT ON TABLE fada.bassins TO biofreshreader;
