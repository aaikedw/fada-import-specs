-- View: fada.families_with_no_htaxa

-- DROP VIEW fada.families_with_no_htaxa;

CREATE OR REPLACE VIEW fada.families_with_no_htaxa AS 
 SELECT fg.id AS gid, fg.name AS gname, ft.id AS tid, ft.name AS tname
   FROM fada.groups fg, fada.taxons ft
  WHERE ft.parent_id IS NULL AND ft.group_id = fg.id AND ft.rank_id = 7
  ORDER BY fg.id, ft.name;

ALTER TABLE fada.families_with_no_htaxa
  OWNER TO biofreshown;
GRANT ALL ON TABLE fada.families_with_no_htaxa TO biofreshown;
GRANT SELECT ON TABLE fada.families_with_no_htaxa TO biofreshreader;

