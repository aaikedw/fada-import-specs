-- Table: fada.publications

-- DROP TABLE fada.publications;

CREATE TABLE fada.publications
(
  id serial NOT NULL,
  author_id integer NOT NULL,
  journal_id integer NOT NULL,
  title text NOT NULL,
  publisher text,
  year character varying(4),
  volume character varying(64),
  issue character varying(64),
  pages character varying(35),
  source text,
  editor character varying(30),
  publisherlocation character varying(30),
  sereditor character varying(30),
  sertitle character varying(30),
  CONSTRAINT publications_pkey PRIMARY KEY (id),
  CONSTRAINT publications_author_id_fkey FOREIGN KEY (author_id)
      REFERENCES fada.authors (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE,
  CONSTRAINT publications_journal_id_fkey FOREIGN KEY (journal_id)
      REFERENCES fada.journals (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE CASCADE
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.publications
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.publications TO biofreshown;
GRANT SELECT ON TABLE fada.publications TO biofreshreader;
