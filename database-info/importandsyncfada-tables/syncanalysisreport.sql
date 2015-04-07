-- Table: importandsyncfada.syncanalysisreport

-- DROP TABLE importandsyncfada.syncanalysisreport;

CREATE TABLE importandsyncfada.syncanalysisreport
(
  id serial NOT NULL,
  groupid integer NOT NULL,
  analysisnum integer NOT NULL,
  regid integer,
  bksid integer NOT NULL,
  regfullname character varying(110),
  fadafullname character varying(110),
  description character varying(60),
  namestatus character varying(15) NOT NULL,
  action character varying(4) NOT NULL,
  created timestamp without time zone NOT NULL,
  modified timestamp without time zone,
  version integer,
  linestatus character varying(4) DEFAULT 'PROC'::character varying,
  CONSTRAINT syncanalysisreport_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.syncanalysisreport
  OWNER TO biofreshown;
