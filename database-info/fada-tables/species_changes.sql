-- These are only changes to table fada.species
-- They must be executed after species.sql
ALTER TABLE fada.species ADD COLUMN brackish boolean DEFAULT false;
ALTER TABLE fada.species ADD COLUMN freshwater boolean DEFAULT true;
ALTER TABLE fada.species ADD COLUMN terrestrial boolean DEFAULT false;
ALTER TABLE fada.species ADD COLUMN marine boolean DEFAULT false;
ALTER TABLE fada.species ADD COLUMN speciesgroup_taxon_id integer;
ALTER TABLE fada.species
  ADD CONSTRAINT species_speciesgroup_taxon_id_fkey FOREIGN KEY (speciesgroup_taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
UPDATE fada.species SET brackish=DEFAULT, freshwater=DEFAULT, terrestrial=DEFAULT, marine=DEFAULT;

