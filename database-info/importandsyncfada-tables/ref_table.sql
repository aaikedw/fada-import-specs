﻿-- Table: importandsyncfada.ref_table

-- DROP TABLE importandsyncfada.ref_table;

CREATE TABLE importandsyncfada.ref_table
(
  id serial NOT NULL,
  group_id integer NOT NULL,
  file_name character varying(255) NOT NULL,
  row_id integer NOT NULL,
  author character varying(300),
  year character varying(10),
  title character varying(255),
  source text,
  refkey text,
  url text,
  upload_comments character varying(255),
  version integer,
  CONSTRAINT ref_table_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE importandsyncfada.ref_table
  OWNER TO biofreshown;
