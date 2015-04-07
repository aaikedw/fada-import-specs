-- View: fada.smallspecies

-- DROP VIEW fada.smallspecies;

CREATE OR REPLACE VIEW fada.smallspecies AS 
 SELECT fs.id AS speciesid, fs.species_taxon_id AS taxonid, fs.scientific_name AS fullspeciesname
   FROM fada.species fs;

ALTER TABLE fada.smallspecies
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.smallspecies TO biofreshown;
GRANT SELECT ON TABLE fada.smallspecies TO biofreshreader;

