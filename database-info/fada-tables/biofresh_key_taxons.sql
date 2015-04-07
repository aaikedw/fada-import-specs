-- Table: fada.biofresh_key_taxons

-- DROP TABLE fada.biofresh_key_taxons;

CREATE TABLE fada.biofresh_key_taxons
(
  id integer NOT NULL DEFAULT 0,
  parent_id integer,
  rank_id integer NOT NULL,
  name character varying(64) NOT NULL,
  author_id integer,
  publication_id integer,
  tx_id integer,
  tx_parent_id integer,
  group_id integer,
  year character varying(4),
  logicaldelete boolean DEFAULT false,
  date_logical_delete timestamp without time zone,
  version integer DEFAULT 0,
  CONSTRAINT biofresh_key_taxons_pk PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.biofresh_key_taxons
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.biofresh_key_taxons TO biofreshown;
GRANT SELECT ON TABLE fada.biofresh_key_taxons TO biofreshreader;
