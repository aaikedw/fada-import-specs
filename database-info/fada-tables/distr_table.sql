-- Table: fada.distr_table

-- DROP TABLE fada.distr_table;

CREATE TABLE fada.distr_table
(
  id serial NOT NULL,
  group_id integer NOT NULL,
  file_name character varying(255) NOT NULL,
  row_id integer NOT NULL,
  genus character varying(30),
  subgenus character varying(30),
  species character varying(30),
  subspecies character varying(30),
  authors character varying(150),
  date character varying(10),
  pa character varying(1),
  ate character varying(1),
  au character varying(1),
  ol character varying(1),
  na character varying(1),
  nt character varying(1),
  ant character varying(1),
  pac character varying(1),
  faunistic_comment text,
  countrylevel character varying(300),
  refkey text,
  lentic character varying(1),
  lotic character varying(1),
  exotic character varying(1),
  body_size character varying(30),
  parasitic character varying(1),
  aquatic_water_dependant character varying(1),
  upload_comments character varying(255),
  version integer,
  CONSTRAINT distr_table_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.distr_table
  OWNER TO biofreshown;
