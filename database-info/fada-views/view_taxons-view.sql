-- View: fada.view_taxons

-- DROP VIEW fada.view_taxons;

CREATE OR REPLACE VIEW fada.view_taxons AS 
 SELECT taxons.id, taxons.rank_id AS rankid, taxons.name, taxons.author_id AS authorid, taxons.year, taxons.publication_id AS publicationid, taxons.parent_id AS parentid, taxons.group_id AS groupid, 0 AS version
   FROM fada.taxons;

ALTER TABLE fada.view_taxons
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.view_taxons TO biofreshown;
GRANT SELECT ON TABLE fada.view_taxons TO biofreshreader;

