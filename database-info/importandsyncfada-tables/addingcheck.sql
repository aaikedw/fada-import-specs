-- Table: importandsyncfada.addingcheck

-- DROP TABLE importandsyncfada.addingcheck;

CREATE TABLE importandsyncfada.addingcheck
(
  shortspname character varying(120) NOT NULL,
  searchpat character varying(120),
  fullspname character varying(120),
  group_id integer,
  CONSTRAINT addingcheck_pk PRIMARY KEY (shortspname)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.addingcheck
  OWNER TO biofreshown;
