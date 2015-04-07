-- Table: fada.journals

-- DROP TABLE fada.journals;

CREATE TABLE fada.journals
(
  id serial NOT NULL,
  name character varying(256) NOT NULL,
  CONSTRAINT journals_pkey PRIMARY KEY (id),
  CONSTRAINT journals_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.journals
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.journals TO biofreshown;
GRANT SELECT ON TABLE fada.journals TO biofreshreader;
