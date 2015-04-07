-- View: fada.refscnames

-- DROP VIEW fada.refscnames;

CREATE OR REPLACE VIEW fada.refscnames AS 
 SELECT regds.fkbiofreshid AS regid, fs.id, fs.genus_taxon_id AS genustaxonid, fs.species_taxon_id AS speciestaxonid, fs.group_id AS groupid, fg.name AS groupname, fs.taxonomic_comment, fs.faunistic_comment, 0 AS version
   FROM register.biofreshdatasources regds, fada.biofresh_key_species bks, fada.species fs, fada.groups fg
  WHERE regds.fkdatasourceabrev::text = 'FADA'::text AND regds.intdatasourcekey = bks.id AND bks.species_id = fs.id AND fs.group_id = fg.id;

ALTER TABLE fada.refscnames
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.refscnames TO biofreshown;
GRANT SELECT ON TABLE fada.refscnames TO biofreshreader;

