-- View: fada.synonyms_split

-- DROP VIEW fada.synonyms_split;

CREATE OR REPLACE VIEW fada.synonyms_split AS 
 SELECT synonyms.id, synonyms.genus_species_name, 
        CASE
            WHEN split_part(synonyms.genus_species_name::text, '	'::text, 1) ~~* '%(%'::text THEN split_part(split_part(synonyms.genus_species_name::text, '	'::text, 1), ' '::text, 1)
            ELSE split_part(synonyms.genus_species_name::text, '	'::text, 1)
        END AS genus, 
        CASE
            WHEN split_part(synonyms.genus_species_name::text, '	'::text, 1) ~~* '%(%'::text THEN split_part(synonyms.genus_species_name::text, '	'::text, 1)
            ELSE ''::text
        END AS subgenus, 
        CASE
            WHEN split_part(synonyms.genus_species_name::text, '	'::text, 2) ~~* 'var.%'::text THEN ''::text
            ELSE split_part(split_part(synonyms.genus_species_name::text, '	'::text, 2), ' '::text, 1)
        END AS specificepithet, 
        CASE
            WHEN split_part(synonyms.genus_species_name::text, '	'::text, 2) ~~* '%. %'::text THEN split_part(synonyms.genus_species_name::text, '. '::text, 2)
            ELSE split_part(split_part(synonyms.genus_species_name::text, '	'::text, 2), ' '::text, 2)
        END AS infraspecificepithet, 
        CASE
            WHEN synonyms.genus_species_name::text ~~* '%var.%'::text THEN 'varietas'::text
            WHEN synonyms.genus_species_name::text ~~* '%f.%'::text THEN 'forma'::text
            WHEN split_part(synonyms.genus_species_name::text, '	'::text, 2) ~~* ''::text THEN 'genus'::text
            WHEN split_part(split_part(synonyms.genus_species_name::text, '	'::text, 2), ' '::text, 2) ~~* ''::text THEN 'species'::text
            ELSE 'subspecies'::text
        END AS taxonrank, synonyms.author_id, synonyms.year, synonyms.taxon_id, synonyms.syn_taxonomic_comment
   FROM fada.synonyms;

ALTER TABLE fada.synonyms_split
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.synonyms_split TO biofreshown;
GRANT SELECT ON TABLE fada.synonyms_split TO biofreshreader;

