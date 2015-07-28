-- These are only changes to table fada.species
-- They must be executed after species.sql
ALTER TABLE fada.species ADD COLUMN brackish boolean DEFAULT false;
ALTER TABLE fada.species ADD COLUMN freshwater boolean DEFAULT true;
ALTER TABLE fada.species ADD COLUMN terrestrial boolean DEFAULT false;
ALTER TABLE fada.species ADD COLUMN marine boolean DEFAULT false;
ALTER TABLE fada.species ADD COLUMN speciesgroup text;
UPDATE fada.species SET brackish=DEFAULT, freshwater=DEFAULT, terrestrial=DEFAULT, marine=DEFAULT;
