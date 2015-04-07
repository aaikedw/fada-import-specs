-- Table: fada.versions

-- DROP TABLE fada.versions;

CREATE TABLE fada.versions
(
  id serial NOT NULL,
  group_id integer NOT NULL,
  user_id integer NOT NULL,
  imported date,
  comment text,
  CONSTRAINT versions_pkey PRIMARY KEY (id),
  CONSTRAINT versions_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES fada.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.versions
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.versions TO biofreshown;
GRANT SELECT ON TABLE fada.versions TO biofreshreader;
