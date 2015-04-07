-- View: fada.fada_export_region

-- DROP VIEW fada.fada_export_region;

CREATE OR REPLACE VIEW fada.fada_export_region AS 
         SELECT groups.name AS "group", fst.family, fst.subfamily, fst.tribe, tg.name AS genus, ts.name AS "specific name", ss.name AS subspecies, authors.name, ts.year, sc."AT", sc."ANT", sc."AU", sc."NA", sc."NT", sc."OL", sc."PAC", sc."PA"
           FROM fada.species, fada.groups, fada.fst_for_genus fst, fada.taxons ts, fada.taxons tg, fada.authors, fada.species fs2
      LEFT JOIN fada.species_crosstab sc ON fs2.id = sc.speciesid, fada.species fs
   LEFT JOIN fada.taxons ss ON fs.subspecies_taxon_id = ss.id
  WHERE groups.id = species.group_id AND tg.id = species.genus_taxon_id AND tg.id = fst.genus_taxon_id AND ts.id = species.species_taxon_id AND ts.author_id = authors.id AND species.subspecies_taxon_id IS NULL AND species.id = fs2.id AND species.id = fs.id
UNION 
         SELECT groups.name AS "group", fst.family, fst.subfamily, fst.tribe, tg.name AS genus, ts.name AS "specific name", tss.name AS subspecies, authors.name, tss.year, sc."AT", sc."ANT", sc."AU", sc."NA", sc."NT", sc."OL", sc."PAC", sc."PA"
           FROM fada.species, fada.groups, fada.fst_for_genus fst, fada.taxons ts, fada.taxons tg, fada.taxons tss, fada.authors, fada.species fs2
      LEFT JOIN fada.species_crosstab sc ON fs2.id = sc.speciesid
     WHERE groups.id = species.group_id AND tg.id = species.genus_taxon_id AND tg.id = fst.genus_taxon_id AND ts.id = species.species_taxon_id AND tss.id = species.subspecies_taxon_id AND tss.author_id = authors.id AND species.id = fs2.id
  ORDER BY 1, 2, 3;

ALTER TABLE fada.fada_export_region
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.fada_export_region TO biofreshown;
GRANT SELECT ON TABLE fada.fada_export_region TO biofreshreader;

