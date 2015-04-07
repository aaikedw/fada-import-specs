-- Table: fada.synonyms

-- DROP TABLE fada.synonyms;

CREATE TABLE fada.synonyms
(
  id serial NOT NULL,
  genus_species_name character varying(100) NOT NULL,
  author_id integer,
  year character varying(4),
  taxon_id integer,
  syn_taxonomic_comment text,
  publication_id integer,
  CONSTRAINT synonyms_pkey PRIMARY KEY (id),
  CONSTRAINT synonyms_author_id_fkey FOREIGN KEY (author_id)
      REFERENCES fada.authors (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT synonyms_publication_fk FOREIGN KEY (publication_id)
      REFERENCES fada.publications (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT synonyms_taxon_id_fkey FOREIGN KEY (taxon_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.synonyms
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.synonyms TO biofreshown;
GRANT SELECT ON TABLE fada.synonyms TO biofreshreader;
