-- Table: fada.obs_statuses

-- DROP TABLE fada.obs_statuses;

CREATE TABLE fada.obs_statuses
(
  id serial NOT NULL,
  name character varying(64) NOT NULL,
  CONSTRAINT obs_statuses_pkey PRIMARY KEY (id),
  CONSTRAINT obs_statuses_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.obs_statuses
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.obs_statuses TO biofreshown;
GRANT SELECT ON TABLE fada.obs_statuses TO biofreshreader;
