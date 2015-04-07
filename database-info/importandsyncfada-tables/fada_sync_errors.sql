-- Table: importandsyncfada.fada_sync_errors

-- DROP TABLE importandsyncfada.fada_sync_errors;

CREATE TABLE importandsyncfada.fada_sync_errors
(
  checkingfrom character varying(4) NOT NULL,
  groupid integer NOT NULL,
  regid integer,
  bksid integer,
  errordescription character varying(50),
  id serial NOT NULL,
  regfullname character varying(110),
  fadafullname character varying(110),
  version integer,
  status character varying(10) NOT NULL,
  created timestamp without time zone NOT NULL,
  modified timestamp without time zone,
  CONSTRAINT fada_sync_errors_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.fada_sync_errors
  OWNER TO biofreshown;
