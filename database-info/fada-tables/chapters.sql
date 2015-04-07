-- Table: fada.chapters

-- DROP TABLE fada.chapters;

CREATE TABLE fada.chapters
(
  id serial NOT NULL,
  title character varying(256),
  authors character varying(256),
  abstract text,
  doi character varying(64),
  CONSTRAINT chapters_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.chapters
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.chapters TO biofreshown;
GRANT SELECT ON TABLE fada.chapters TO biofreshreader;
