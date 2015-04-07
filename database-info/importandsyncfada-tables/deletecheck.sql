-- Table: importandsyncfada.deletecheck

-- DROP TABLE importandsyncfada.deletecheck;

CREATE TABLE importandsyncfada.deletecheck
(
  shortspname character varying(120) NOT NULL,
  searchpat character varying(120),
  fullspname character varying(120),
  group_id integer,
  CONSTRAINT deletecheck_pk PRIMARY KEY (shortspname)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.deletecheck
  OWNER TO biofreshown;
