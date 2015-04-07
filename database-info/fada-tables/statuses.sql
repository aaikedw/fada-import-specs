-- Table: fada.statuses

-- DROP TABLE fada.statuses;

CREATE TABLE fada.statuses
(
  id serial NOT NULL,
  name character varying(64) NOT NULL,
  CONSTRAINT statuses_pkey PRIMARY KEY (id),
  CONSTRAINT statuses_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.statuses
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.statuses TO biofreshown;
GRANT SELECT ON TABLE fada.statuses TO biofreshreader;
