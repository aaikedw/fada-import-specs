-- Table: fada.species

-- DROP TABLE fada.species;

CREATE TABLE fada.species
(
  id serial NOT NULL,
  group_id integer NOT NULL,
  status_id integer NOT NULL,
  conservation_id integer NOT NULL,
  genus_taxon_id integer NOT NULL,
  subgenus_taxon_id integer,
  species_taxon_id integer NOT NULL,
  subspecies_taxon_id integer,
  original_genus_id integer,
  declension_species_id integer,
  taxonomic_comment text,
  faunistic_comment text,
  conservation_comment text,
  scientific_name character varying(120),
  CONSTRAINT species_pkey PRIMARY KEY (id),
  CONSTRAINT species_conservation_id_fkey FOREIGN KEY (conservation_id)
      REFERENCES fada.conservations (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT species_declension_species_id_fkey FOREIGN KEY (declension_species_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT species_genus_taxon_id_fkey FOREIGN KEY (genus_taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT species_original_genus_id_fkey FOREIGN KEY (original_genus_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT species_species_taxon_id_fkey FOREIGN KEY (species_taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT species_status_id_fkey FOREIGN KEY (status_id)
      REFERENCES fada.statuses (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT species_subgenus_taxon_id_fkey FOREIGN KEY (subgenus_taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT species_subspecies_taxon_id_fkey FOREIGN KEY (subspecies_taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.species
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.species TO biofreshown;
GRANT SELECT ON TABLE fada.species TO biofreshreader;
