-- Table: fada.greferences

-- DROP TABLE fada.greferences;

CREATE TABLE fada.greferences
(
  group_id integer,
  file_name character varying(255),
  row_id integer,
  author character varying(255),
  year character varying(255),
  title character varying(255),
  source text,
  refkey text,
  id serial NOT NULL,
  url text,
  CONSTRAINT greferences_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.greferences
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.greferences TO biofreshown;
GRANT SELECT ON TABLE fada.greferences TO biofreshreader;
