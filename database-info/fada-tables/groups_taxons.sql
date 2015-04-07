-- Table: fada.groups_taxons

-- DROP TABLE fada.groups_taxons;

CREATE TABLE fada.groups_taxons
(
  taxon_id integer NOT NULL,
  group_id integer NOT NULL,
  id serial NOT NULL,
  CONSTRAINT groups_taxons_taxon_id_fkey FOREIGN KEY (taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.groups_taxons
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.groups_taxons TO biofreshown;
GRANT SELECT ON TABLE fada.groups_taxons TO biofreshreader;
