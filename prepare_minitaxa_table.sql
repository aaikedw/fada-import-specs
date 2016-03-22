DELETE FROM importandsyncfada.minitaxa_table WHERE group_id = :group_id;

INSERT INTO importandsyncfada.minitaxa_table
(         group_id, rank, family, subfamily, tribe, subtribe, genus,
 subgenus, speciesgroup, species, subspecies, authors, date, parentheses)
SELECT
 distinct group_id, rank, family, subfamily, tribe, subtribe, genus,
 subgenus, speciesgroup, species, subspecies, authors, date, parentheses
FROM importandsyncfada.taxa_table
WHERE group_id = :group_id
ORDER BY
family,
subfamily NULLS FIRST,
tribe NULLS FIRST,
subtribe NULLS FIRST,
genus NULLS FIRST,
subgenus NULLS FIRST,
speciesgroup NULLS FIRST,
species NULLS FIRST,
subspecies NULLS FIRST,
date;
