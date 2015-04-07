-- Table: fada.ranks

-- DROP TABLE fada.ranks;

CREATE TABLE fada.ranks
(
  id serial NOT NULL,
  name character varying(64) NOT NULL,
  CONSTRAINT ranks_pkey PRIMARY KEY (id),
  CONSTRAINT ranks_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.ranks
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.ranks TO biofreshown;
GRANT SELECT ON TABLE fada.ranks TO biofreshreader;
