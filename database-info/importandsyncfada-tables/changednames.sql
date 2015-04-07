-- Table: importandsyncfada.changednames

-- DROP TABLE importandsyncfada.changednames;

CREATE TABLE importandsyncfada.changednames
(
  thename character varying NOT NULL,
  bksid integer NOT NULL,
  speciesid integer,
  newfadaname character varying(120),
  version integer,
  CONSTRAINT changednames_pk PRIMARY KEY (thename)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.changednames
  OWNER TO biofreshown;
