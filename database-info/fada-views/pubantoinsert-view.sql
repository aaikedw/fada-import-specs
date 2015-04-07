-- View: fada.pubantoinsert

-- DROP VIEW fada.pubantoinsert;

CREATE OR REPLACE VIEW fada.pubantoinsert AS 
 SELECT fs.species_taxon_id AS taxonid, fip.scientificname, fip.fullspeciesname, fa.id AS authorid, fj.id AS journalid, fip.year, fip.publicationtitle, fip.volume, fip.issue, fip.editor, fip.publicationlocation, fip.publisher, fip.serieseditor, fip.seriestitle, fip.pages
   FROM fada.import_publications fip, fada.species fs, fada.authors fa, fada.journals fj
  WHERE fip.author IS NOT NULL AND fip.publicationtitle IS NOT NULL AND fip.journaltitle IS NOT NULL AND fip.synonymto IS NULL AND fs.scientific_name::text = fip.fullspeciesname::text AND fip.author::text = fa.name::text AND fj.name::text = fip.journaltitle::text;

ALTER TABLE fada.pubantoinsert
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.pubantoinsert TO biofreshown;
GRANT SELECT ON TABLE fada.pubantoinsert TO biofreshreader;

