-- Table: fada.genus_to_family

-- DROP TABLE fada.genus_to_family;

CREATE TABLE fada.genus_to_family
(
  genusid integer NOT NULL,
  subtribeid integer,
  tribeid integer,
  subfamilyid integer,
  familyid integer,
  CONSTRAINT genusid PRIMARY KEY (genusid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE fada.genus_to_family
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.genus_to_family TO biofreshown;
GRANT SELECT ON TABLE fada.genus_to_family TO biofreshreader;
