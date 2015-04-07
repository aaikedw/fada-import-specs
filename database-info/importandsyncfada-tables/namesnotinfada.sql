-- Table: importandsyncfada.namesnotinfada

-- DROP TABLE importandsyncfada.namesnotinfada;

CREATE TABLE importandsyncfada.namesnotinfada
(
  id integer NOT NULL,
  group_id integer,
  fullspeciesname character varying(255),
  CONSTRAINT namesnotinfada_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.namesnotinfada
  OWNER TO biofreshown;
