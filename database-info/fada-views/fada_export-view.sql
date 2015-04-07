-- View: fada.fada_export

-- DROP VIEW fada.fada_export;

CREATE OR REPLACE VIEW fada.fada_export AS 
         SELECT fg.name AS fada_group, fs.scientific_name, ft2.name AS genus, ft3.name AS subgenus, ft.name AS specific_name, NULL::unknown AS subspecies, ft4.name AS original_genus, fa.name AS author, ft.year, fs.taxonomic_comment, 0 AS version
           FROM fada.species fs, fada.groups fg, fada.taxons ft, fada.taxons ft2, fada.species fs2
      LEFT JOIN fada.taxons ft3 ON fs2.subgenus_taxon_id = ft3.id, fada.species fs3
   LEFT JOIN fada.taxons ft4 ON fs3.original_genus_id = ft4.id, fada.authors fa
  WHERE fs.id = fs2.id AND fs.id = fs3.id AND fg.id = fs.group_id AND ft2.id = fs.genus_taxon_id AND fs.species_taxon_id = ft.id AND ft.author_id = fa.id AND fs.subspecies_taxon_id IS NULL
UNION 
         SELECT fg.name AS fada_group, fs.scientific_name, ft2.name AS genus, ft3.name AS subgenus, ft5.name AS specific_name, ft.name AS subspecies, ft4.name AS original_genus, fa.name AS author, ft.year, fs.taxonomic_comment, 0 AS version
           FROM fada.species fs, fada.groups fg, fada.taxons ft, fada.taxons ft2, fada.species fs2
      LEFT JOIN fada.taxons ft3 ON fs2.subgenus_taxon_id = ft3.id, fada.species fs3
   LEFT JOIN fada.taxons ft4 ON fs3.original_genus_id = ft4.id, fada.taxons ft5, fada.authors fa
  WHERE fs.id = fs2.id AND fs.id = fs3.id AND fg.id = fs.group_id AND ft2.id = fs.genus_taxon_id AND ft5.id = fs.species_taxon_id AND fs.subspecies_taxon_id = ft.id AND ft.author_id = fa.id AND fs.subspecies_taxon_id IS NOT NULL;

ALTER TABLE fada.fada_export
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.fada_export TO biofreshown;
GRANT SELECT ON TABLE fada.fada_export TO biofreshreader;

