-- View: fada.originalnames

-- DROP VIEW fada.originalnames;

CREATE OR REPLACE VIEW fada.originalnames AS 
 SELECT fs.id, fs.group_id, gtaxons.name AS gtaxon, sgtaxons.name AS sgtaxon, ogtaxons.name AS ogtaxon, sptaxons.name AS sptaxon, sstaxons.name AS sstaxon, dstaxons.name AS dstaxon, COALESCE(dsauthors.name, spauthors.name) AS author, COALESCE(dstaxons.year, sptaxons.year) AS year, (((((((ogtaxons.name::text || ' '::text) || 
        CASE
            WHEN sgtaxons.name IS NOT NULL THEN ('('::text || sgtaxons.name::text) || ') '::text
            ELSE ''::text
        END) || COALESCE(dstaxons.name, sptaxons.name)::text) || ' '::text) || 
        CASE
            WHEN sstaxons.name IS NOT NULL THEN sstaxons.name::text || ' '::text
            ELSE ''::text
        END) || COALESCE(dsauthors.name, spauthors.name)::text) || ', '::text) || COALESCE(dstaxons.year, sptaxons.year)::text AS oriname
   FROM fada.species fs
   LEFT JOIN fada.taxons gtaxons ON fs.genus_taxon_id = gtaxons.id
   LEFT JOIN fada.taxons sgtaxons ON fs.subgenus_taxon_id = sgtaxons.id
   LEFT JOIN fada.taxons ogtaxons ON fs.original_genus_id = ogtaxons.id
   LEFT JOIN fada.taxons dstaxons ON fs.declension_species_id = dstaxons.id
   LEFT JOIN fada.taxons sptaxons ON fs.species_taxon_id = sptaxons.id
   LEFT JOIN fada.taxons sstaxons ON fs.subspecies_taxon_id = sstaxons.id
   LEFT JOIN fada.authors spauthors ON spauthors.id = sptaxons.author_id
   LEFT JOIN fada.authors dsauthors ON dsauthors.id = dstaxons.author_id
  WHERE fs.original_genus_id IS NOT NULL
  ORDER BY fs.group_id, fs.id;

ALTER TABLE fada.originalnames
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.originalnames TO biofreshown;
GRANT SELECT ON TABLE fada.originalnames TO biofreshreader;

