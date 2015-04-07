-- View: fada.species_crosstab

-- DROP VIEW fada.species_crosstab;

CREATE OR REPLACE VIEW fada.species_crosstab AS 
 SELECT ct.speciesid, ct."AT", ct."ANT", ct."AU", ct."NA", ct."NT", ct."OL", ct."PAC", ct."PA"
   FROM crosstab('select species_id, region_id, 1 as value from fada.regions_species order by 1,2'::text, 'select id from fada.regions order by 1'::text) ct(speciesid integer, "AT" integer, "ANT" integer, "AU" integer, "NA" integer, "NT" integer, "OL" integer, "PAC" integer, "PA" integer);

ALTER TABLE fada.species_crosstab
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.species_crosstab TO biofreshown;
GRANT SELECT ON TABLE fada.species_crosstab TO biofreshreader;

