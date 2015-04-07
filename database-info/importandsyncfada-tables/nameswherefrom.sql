-- Table: importandsyncfada.nameswherefrom

-- DROP TABLE importandsyncfada.nameswherefrom;

CREATE TABLE importandsyncfada.nameswherefrom
(
  id integer NOT NULL,
  group_id integer,
  fullspeciesname character varying(255),
  searchpat character varying(120),
  CONSTRAINT nameswherefrom_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.nameswherefrom
  OWNER TO biofreshown;
