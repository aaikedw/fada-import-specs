-- Table: register.biofreshdatasources

-- DROP TABLE register.biofreshdatasources;

CREATE TABLE register.biofreshdatasources
(
  compositekey character varying(100) NOT NULL,
  fkbiofreshid integer NOT NULL,
  stringdatasourcekey character varying(20),
  intdatasourcekey integer,
  fkdatasourceabrev character varying(10) NOT NULL,
  fkoridatasourceabrev character varying(10),
  version integer NOT NULL DEFAULT 0,
  matchstatus integer,
  validated integer,
  ambiguous integer,
  numberofgeorefoccurrences integer,
  gbifsyn boolean NOT NULL DEFAULT false,
  CONSTRAINT biofreshdatasources_pk PRIMARY KEY (compositekey),
  CONSTRAINT biofreshdatasources_datasourceabrev_fkey FOREIGN KEY (fkdatasourceabrev)
      REFERENCES register.datasources (abrev) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT biofreshdatasources_oridatasourceabrev_fkey FOREIGN KEY (fkoridatasourceabrev)
      REFERENCES register.datasources (abrev) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fkbiofreshid FOREIGN KEY (fkbiofreshid)
      REFERENCES register.biofreshspeciesregistry (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE register.biofreshdatasources
  OWNER TO biofreshown;
GRANT ALL ON TABLE register.biofreshdatasources TO biofreshown;
GRANT SELECT ON TABLE register.biofreshdatasources TO biofreshreader;

-- Index: register.fki_fkbiofreshid

-- DROP INDEX register.fki_fkbiofreshid;

CREATE INDEX fki_fkbiofreshid
  ON register.biofreshdatasources
  USING btree
  (fkbiofreshid);

-- Index: register.register_biofreshdatasources_fkdatasourceabrev

-- DROP INDEX register.register_biofreshdatasources_fkdatasourceabrev;

CREATE INDEX register_biofreshdatasources_fkdatasourceabrev
  ON register.biofreshdatasources
  USING btree
  (fkdatasourceabrev);

-- Index: register.register_biofreshdatasources_intdatasourcekey

-- DROP INDEX register.register_biofreshdatasources_intdatasourcekey;

CREATE INDEX register_biofreshdatasources_intdatasourcekey
  ON register.biofreshdatasources
  USING btree
  (intdatasourcekey);

