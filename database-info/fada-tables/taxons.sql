-- Table: fada.taxons

-- DROP TABLE fada.taxons;

CREATE TABLE fada.taxons
(
  id serial NOT NULL,
  rank_id integer NOT NULL,
  name character varying(64) NOT NULL,
  author_id integer,
  publication_id integer,
  parent_id integer,
  group_id integer,
  year character varying(4),
  CONSTRAINT taxons_pkey PRIMARY KEY (id),
  CONSTRAINT taxons_author_id_fkey FOREIGN KEY (author_id)
      REFERENCES fada.authors (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT taxons_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES fada.taxons (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT taxons_publication_id_fkey FOREIGN KEY (publication_id)
      REFERENCES fada.publications (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT taxons_rank_id_fkey FOREIGN KEY (rank_id)
      REFERENCES fada.ranks (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.taxons
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.taxons TO biofreshown;
GRANT SELECT ON TABLE fada.taxons TO biofreshreader;
