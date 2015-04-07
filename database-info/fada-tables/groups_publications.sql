-- Table: fada.groups_publications

-- DROP TABLE fada.groups_publications;

CREATE TABLE fada.groups_publications
(
  publication_id integer NOT NULL,
  group_id integer NOT NULL,
  CONSTRAINT groups_publications_publication_id_fkey FOREIGN KEY (publication_id)
      REFERENCES fada.publications (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.groups_publications
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.groups_publications TO biofreshown;
GRANT SELECT ON TABLE fada.groups_publications TO biofreshreader;
