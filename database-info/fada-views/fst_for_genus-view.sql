-- View: fada.fst_for_genus

-- DROP VIEW fada.fst_for_genus;

CREATE OR REPLACE VIEW fada.fst_for_genus AS 
 SELECT DISTINCT ON (species.genus_taxon_id) species.genus_taxon_id, tf.name AS family, ts.name AS subfamily, tt.name AS tribe
   FROM fada.species, fada.genus_to_family
   LEFT JOIN fada.taxons tt ON genus_to_family.tribeid = tt.id
   LEFT JOIN fada.taxons ts ON genus_to_family.subfamilyid = ts.id
   LEFT JOIN fada.taxons tf ON genus_to_family.familyid = tf.id
  WHERE species.genus_taxon_id = genus_to_family.genusid
  ORDER BY species.genus_taxon_id;

ALTER TABLE fada.fst_for_genus
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.fst_for_genus TO biofreshown;
GRANT SELECT ON TABLE fada.fst_for_genus TO biofreshreader;

