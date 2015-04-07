-- Table: importandsyncfada.groups

-- DROP TABLE importandsyncfada.groups;

CREATE TABLE importandsyncfada.groups
(
  id integer NOT NULL,
  name character varying(50) NOT NULL,
  version integer,
  CONSTRAINT groups_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.groups
  OWNER TO biofreshown;
