-- View: fada.fst_for_tribe

-- DROP VIEW fada.fst_for_tribe;

CREATE OR REPLACE VIEW fada.fst_for_tribe AS 
 SELECT DISTINCT genus_to_family.tribeid, ff.name AS family
   FROM fada.genus_to_family
   LEFT JOIN fada.taxons fs ON genus_to_family.subfamilyid = fs.id
   LEFT JOIN fada.taxons ff ON genus_to_family.familyid = ff.id
  WHERE genus_to_family.tribeid IS NOT NULL
  ORDER BY genus_to_family.tribeid;

ALTER TABLE fada.fst_for_tribe
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.fst_for_tribe TO biofreshown;
GRANT ALL ON TABLE fada.fst_for_tribe TO public;
GRANT SELECT ON TABLE fada.fst_for_tribe TO biofreshreader;

