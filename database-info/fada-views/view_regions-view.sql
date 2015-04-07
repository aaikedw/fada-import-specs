-- View: fada.view_regions

-- DROP VIEW fada.view_regions;

CREATE OR REPLACE VIEW fada.view_regions AS 
 SELECT regions.id, f.gid, regions.code, regions.name, regions.distribution, 0 AS version
   FROM fada.regions, utilities.fadaregions f
  WHERE regions.code::text = f.fadaregion::text;

ALTER TABLE fada.view_regions
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.view_regions TO biofreshown;
GRANT SELECT ON TABLE fada.view_regions TO biofreshreader;

