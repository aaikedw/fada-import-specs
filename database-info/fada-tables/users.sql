-- Table: fada.users

-- DROP TABLE fada.users;

CREATE TABLE fada.users
(
  nlogin character varying(64),
  title character varying(15),
  familyname character varying(64) NOT NULL,
  givenname character varying(64) NOT NULL,
  phone character varying(64),
  email character varying(64),
  address text,
  zip_code character varying(15),
  city character varying(64),
  country character varying(64),
  hashed_password character varying(64),
  salt character varying(64),
  role_id integer NOT NULL DEFAULT 3,
  id serial NOT NULL,
  CONSTRAINT users_pkey1 PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.users
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.users TO biofreshown;
GRANT SELECT ON TABLE fada.users TO biofreshreader;
