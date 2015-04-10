-- Table: register.biofreshspeciesregistry

-- DROP TABLE register.biofreshspeciesregistry;

CREATE TABLE register.biofreshspeciesregistry
(
  id serial NOT NULL,
  genus character varying(64),
  subgenus character varying(64),
  specificepithet character varying(64),
  infraspecificepithetrank integer,
  infraspecificepithet character varying(64),
  scientificnameauthorship character varying(255),
  brackets boolean DEFAULT false,
  scientificnameyear integer,
  scientificname character varying(128) NOT NULL,
  group_id integer, -- FADA group (if found)....
  taxonomicstatus_id integer,
  relatedname_id integer, -- Other name to which the current name is related....
  nameverificationstatus character varying(10),
  lsid character varying(255),
  version integer NOT NULL DEFAULT 0,
  created timestamp without time zone NOT NULL,
  modified timestamp without time zone NOT NULL,
  fullspeciesname character varying(255), -- scientificname + scientificnameauthorship
  name_authoritative_source character varying(20), -- DataProvider from which the name has been gathered....
  CONSTRAINT biofreshregistry_pk PRIMARY KEY (id),
  CONSTRAINT biofreshspeciesregistry_taxonomicstatus_fkey FOREIGN KEY (taxonomicstatus_id)
      REFERENCES register.taxonomicstatus (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE register.biofreshspeciesregistry
  OWNER TO biofreshown;
GRANT ALL ON TABLE register.biofreshspeciesregistry TO biofreshown;
GRANT SELECT ON TABLE register.biofreshspeciesregistry TO biofreshreader;
COMMENT ON COLUMN register.biofreshspeciesregistry.group_id IS 'FADA group (if found).
Has been considered usefull for disambiguation.';
COMMENT ON COLUMN register.biofreshspeciesregistry.relatedname_id IS 'Other name to which the current name is related.
Look to the value of namerelationship_id for the type of relationship.';
COMMENT ON COLUMN register.biofreshspeciesregistry.fullspeciesname IS 'scientificname + scientificnameauthorship';
COMMENT ON COLUMN register.biofreshspeciesregistry.name_authoritative_source IS 'DataProvider from which the name has been gathered.
Name-Authoritative-Source';


-- Index: register.register_biofreshspeciesregistry_fullspeciesname

-- DROP INDEX register.register_biofreshspeciesregistry_fullspeciesname;

CREATE INDEX register_biofreshspeciesregistry_fullspeciesname
  ON register.biofreshspeciesregistry
  USING btree
  (fullspeciesname);

-- Index: register.register_biofreshspeciesregistry_genus

-- DROP INDEX register.register_biofreshspeciesregistry_genus;

CREATE INDEX register_biofreshspeciesregistry_genus
  ON register.biofreshspeciesregistry
  USING btree
  (genus);

-- Index: register.register_biofreshspeciesregistry_regex_fullspeciesname

-- DROP INDEX register.register_biofreshspeciesregistry_regex_fullspeciesname;

CREATE INDEX register_biofreshspeciesregistry_regex_fullspeciesname
  ON register.biofreshspeciesregistry
  USING btree
  (fullspeciesname varchar_pattern_ops);

-- Index: register.register_biofreshspeciesregistry_regex_genus

-- DROP INDEX register.register_biofreshspeciesregistry_regex_genus;

CREATE INDEX register_biofreshspeciesregistry_regex_genus
  ON register.biofreshspeciesregistry
  USING btree
  (genus varchar_pattern_ops);

-- Index: register.register_biofreshspeciesregistry_regex_specificepithet

-- DROP INDEX register.register_biofreshspeciesregistry_regex_specificepithet;

CREATE INDEX register_biofreshspeciesregistry_regex_specificepithet
  ON register.biofreshspeciesregistry
  USING btree
  (specificepithet varchar_pattern_ops);

-- Index: register.register_biofreshspeciesregistry_specificepithet

-- DROP INDEX register.register_biofreshspeciesregistry_specificepithet;

CREATE INDEX register_biofreshspeciesregistry_specificepithet
  ON register.biofreshspeciesregistry
  USING btree
  (specificepithet);

