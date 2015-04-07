-- View: fada.pubsyntoinsert

-- DROP VIEW fada.pubsyntoinsert;

CREATE OR REPLACE VIEW fada.pubsyntoinsert AS 
 SELECT fip.id, fip.synonymto, fip.scientificname, fip.fullspeciesname, fa.id AS authorid, fip.year, fip.publicationtitle, fj.id AS journalid, fip.volume, fip.issue, fip.editor, fip.publicationlocation, fip.publisher, fip.serieseditor, fip.seriestitle, fip.pages
   FROM fada.import_publications fip, fada.authors fa, fada.journals fj
  WHERE fip.author IS NOT NULL AND fip.publicationtitle IS NOT NULL AND fip.journaltitle IS NOT NULL AND fip.synonymto IS NOT NULL AND fip.author::text = fa.name::text AND fj.name::text = fip.journaltitle::text;

ALTER TABLE fada.pubsyntoinsert
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.pubsyntoinsert TO biofreshown;
GRANT SELECT ON TABLE fada.pubsyntoinsert TO biofreshreader;

