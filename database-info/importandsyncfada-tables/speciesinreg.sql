-- Table: importandsyncfada.speciesinreg

-- DROP TABLE importandsyncfada.speciesinreg;

CREATE TABLE importandsyncfada.speciesinreg
(
  id integer NOT NULL,
  group_id integer,
  fullspeciesname character varying(255),
  CONSTRAINT speciesinreg_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.speciesinreg
  OWNER TO biofreshown;
