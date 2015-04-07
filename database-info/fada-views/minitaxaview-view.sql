-- View: fada.minitaxaview

-- DROP VIEW fada.minitaxaview;

CREATE OR REPLACE VIEW fada.minitaxaview AS 
 SELECT DISTINCT taxa_table.group_id, taxa_table.family, taxa_table.subfamily, taxa_table.tribe, taxa_table.subtribe, taxa_table.genus, taxa_table.subgenus, taxa_table.species, taxa_table.subspecies, taxa_table.authors, taxa_table.date
   FROM fada.taxa_table
  ORDER BY taxa_table.family, taxa_table.subfamily DESC, taxa_table.tribe DESC, taxa_table.subtribe DESC, taxa_table.genus DESC, taxa_table.subgenus DESC, taxa_table.species DESC, taxa_table.subspecies DESC, taxa_table.authors DESC, taxa_table.date DESC;

ALTER TABLE fada.minitaxaview
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.minitaxaview TO biofreshown;
GRANT SELECT ON TABLE fada.minitaxaview TO biofreshreader;

