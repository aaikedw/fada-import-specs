-- Table: fada.roles

-- DROP TABLE fada.roles;

CREATE TABLE fada.roles
(
  id serial NOT NULL,
  name character varying(20) NOT NULL,
  description text,
  CONSTRAINT roles_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.roles
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.roles TO biofreshown;
GRANT SELECT ON TABLE fada.roles TO biofreshreader;
