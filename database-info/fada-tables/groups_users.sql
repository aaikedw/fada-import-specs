-- Table: fada.groups_users

-- DROP TABLE fada.groups_users;

CREATE TABLE fada.groups_users
(
  group_id integer NOT NULL,
  user_id integer NOT NULL,
  CONSTRAINT groups_users_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES fada.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.groups_users
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.groups_users TO biofreshown;
GRANT SELECT ON TABLE fada.groups_users TO biofreshreader;
