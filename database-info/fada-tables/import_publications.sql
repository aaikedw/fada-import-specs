-- Table: fada.import_publications

-- DROP TABLE fada.import_publications;

CREATE TABLE fada.import_publications
(
  id integer NOT NULL,
  synonymto integer,
  scientificname character varying(255),
  fullspeciesname character varying(255),
  author character varying(255),
  year character varying(4),
  publicationtitle text,
  journaltitle character varying(150),
  volume character varying(60),
  issue character varying(60),
  editor character varying(60),
  publicationlocation character varying(60),
  publisher character varying(60),
  serieseditor character varying(60),
  seriestitle character varying(60),
  pages character varying(35),
  CONSTRAINT import_publications_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.import_publications
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.import_publications TO biofreshown;
GRANT SELECT ON TABLE fada.import_publications TO biofreshreader;
