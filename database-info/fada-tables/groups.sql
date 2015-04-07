-- Table: fada.groups

-- DROP TABLE fada.groups;

CREATE TABLE fada.groups
(
  id serial NOT NULL,
  name character varying(64) NOT NULL,
  created date,
  updated date,
  description text,
  metadata text,
  coeditors text,
  inputfile_update date,
  number_species integer,
  distribution_level character varying(64),
  inputfile_received boolean,
  inputfile_validated boolean,
  inputfile_status character varying(255),
  received_date date,
  validated_date date,
  published_date date,
  inputfile_published boolean,
  inputfile_publishable character varying(1),
  version integer,
  CONSTRAINT groups_pkey PRIMARY KEY (id),
  CONSTRAINT groups_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.groups
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.groups TO biofreshown;
GRANT SELECT ON TABLE fada.groups TO biofreshreader;
