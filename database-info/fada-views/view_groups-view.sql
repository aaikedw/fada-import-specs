-- View: fada.view_groups

-- DROP VIEW fada.view_groups;

CREATE OR REPLACE VIEW fada.view_groups AS 
 SELECT groups.id, groups.name, groups.metadata, groups.version
   FROM fada.groups
  WHERE groups.inputfile_published IS TRUE;

ALTER TABLE fada.view_groups
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.view_groups TO biofreshown;
GRANT SELECT ON TABLE fada.view_groups TO biofreshreader;

