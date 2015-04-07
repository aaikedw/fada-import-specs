-- Table: importandsyncfada.changednamesfadaimport

-- DROP TABLE importandsyncfada.changednamesfadaimport;

CREATE TABLE importandsyncfada.changednamesfadaimport
(
  orifadaname character varying(120) NOT NULL,
  bksid integer NOT NULL,
  speciesid integer,
  newfadaname character varying(120) NOT NULL,
  group_id integer,
  CONSTRAINT changednamesfadaimport_pk PRIMARY KEY (orifadaname)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.changednamesfadaimport
  OWNER TO biofreshown;
