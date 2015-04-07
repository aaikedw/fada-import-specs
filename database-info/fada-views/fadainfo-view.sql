-- View: fada.fadainfo

-- DROP VIEW fada.fadainfo;

CREATE OR REPLACE VIEW fada.fadainfo AS 
 SELECT fs.id, fs.genus_taxon_id AS genustaxonid, fs.species_taxon_id AS speciestaxonid, fs.group_id AS groupid, fg.name AS groupname, fs.taxonomic_comment, fs.faunistic_comment, 0 AS version
   FROM fada.species fs, fada.groups fg
  WHERE fg.id = fs.group_id;

ALTER TABLE fada.fadainfo
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.fadainfo TO biofreshown;
GRANT SELECT ON TABLE fada.fadainfo TO biofreshreader;

