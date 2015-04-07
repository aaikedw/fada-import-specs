-- Table: fada.conservations

-- DROP TABLE fada.conservations;

CREATE TABLE fada.conservations
(
  id serial NOT NULL,
  code character varying(4) NOT NULL,
  name character varying(64) NOT NULL,
  CONSTRAINT conservations_pkey PRIMARY KEY (id),
  CONSTRAINT conservations_code_key UNIQUE (code),
  CONSTRAINT conservations_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.conservations
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.conservations TO biofreshown;
GRANT SELECT ON TABLE fada.conservations TO biofreshreader;
