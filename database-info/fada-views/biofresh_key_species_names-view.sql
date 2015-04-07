-- View: fada.biofresh_key_species_names

-- DROP VIEW fada.biofresh_key_species_names;

CREATE OR REPLACE VIEW fada.biofresh_key_species_names AS 
 SELECT fs.id AS spid, bks.id AS bksid, fs.group_id AS groupid, gt.name AS gname, sgt.name AS sgname, st.name AS sname, sst.name AS ssname, bks.scientific_name AS scientificname, st.year AS syear, sst.year AS ssyear
   FROM fada.species fs
   LEFT JOIN fada.taxons gt ON fs.genus_taxon_id = gt.id
   LEFT JOIN fada.taxons sgt ON fs.subgenus_taxon_id = sgt.id
   LEFT JOIN fada.taxons st ON fs.species_taxon_id = st.id
   LEFT JOIN fada.taxons sst ON fs.subspecies_taxon_id = sst.id
   LEFT JOIN fada.biofresh_key_species bks ON fs.id = bks.species_id;

ALTER TABLE fada.biofresh_key_species_names
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.biofresh_key_species_names TO biofreshown;
GRANT SELECT ON TABLE fada.biofresh_key_species_names TO biofreshreader;

