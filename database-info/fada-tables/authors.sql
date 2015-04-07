-- Table: fada.authors

-- DROP TABLE fada.authors;

CREATE TABLE fada.authors
(
  id serial NOT NULL,
  name character varying(255) NOT NULL,
  CONSTRAINT authors_pkey PRIMARY KEY (id),
  CONSTRAINT authors_name_key UNIQUE (name)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.authors
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.authors TO biofreshown;
GRANT SELECT ON TABLE fada.authors TO biofreshreader;
