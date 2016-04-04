# FADA Excel data injection process
## How to construct a scientific_name
This is how to construct the scientific_name from the information present in a ExcelTaxonomyRecords instance
* If present the value present in subgenus must be surrounded by parentheses and contcatenated to the value of genus.
giving a string of characters like
"Genus (Subgenus)" or just "Genus" if no subgenus part exists
Note that the elements must start with a capital letter, something that must have been taken care of during earlier stages.
* The species, subspecies elements will be concatenated to this giving a character string like
"Genus (Subgenus) species subspecies"
* If it exsists the year of publication will be adapted by eliminating trailing alphabetic characters, so "1852a" becomes "1852"
* The author name and adapted year of publication will be concatenated to form an authorship text like
"author, year"
* If there is no year of publication "author" will be kept as authorship text
* If the parenthesis field is true for this record then the authorship text will be surrounded by parenthesis, like
"(author, year)" or "(author)"
* The authorship part is then contatenated to the name part like
* "Genus (Subgenus) species subspecies (author, year)" or
* "Genus (Subgenus) species subspecies author, year" or
* "Genus species subspecies author, year" or
* "Genus species author, year" etc<br/>
This is the scientific_name

## Process the information in the following order
### Process authors information
* Gather all author names, from the ExcelTaxonomyRecords concerning the group being processed.<br/>
That is, author information from accepted name part and from the synonym part.
* For each author info found try to find a matching author instance (name) from the fada schema.
* If the author is not found, create it.

### Process reference information
* For each ExcelReferenceRecord found try to find a matching reference instance from the fada schema.
* If the reference is not found, create it.
It is quite possible that references could be created twice since the way to use references in the excel sheets involve a user given key and this key might be different from one file to the other.
There is nothing much we can do about it unless this situation has been dealt with previously by the operator.

So now we have up to date author and reference information.

### Process new regions information.
* For each ExcelFaunisticRecord, if there are new regions found in the TDWG type info, add them now.

### Delete elements to be deleted (synonyms, species, taxons)
* Deleting synonyms requires deleting records from the synonyms table (of course) and the biofresh_key_synonyms table (yes, at this point, really delete it).
* Deleting species requires deleting records from tables regions_species_all, biofresh_key_species (yes, at this pont, really delete it), species and species_profile (which are actually part of the same entity). No other tables are being used.
* Deleting taxons requires deleting records from tables biofresh_key_taxons (yes, at this point really delete it), taxons_faunisticreferences, taxons_taxoreferences (which are the links between the taxon instances and the references),
group_taxons (unlikely but possible)

### Add/Update taxons
#### Using a subset of the information
In order to handle the taxons of rank 'family' to 'speciesgroup' more easily it is preferable to use a subset of this information.<br/>
Really what we are interested in the the beginning is a subset prepared such as file <br/>
./prepare_minitaxa_table.sql
<br/>
would do it.<br/>
This makes things somewhat easier after.<br/>
Off course it does add a step as far as the link to references is concerned but it does help.

#### Families down to SpecieGroup
* Add/Update the taxons following a hierachical order. <br/>
Start by adding the Families, then Subfamilies and so on until the SpeciesGroup.<br/>
The Families are a special case because we try to link then back to higher taxonomical definitions contributed by catalog of life.
* When adding a family you must try to find what taxonomical path it relates to according to COL.
This is done using the following selection on the table.
<pre>
SELECT distinct kingdom, phylum, cclass, oorder
FROM col.families
WHERE family = theFamilyName;
</pre>
For each element of the path you will, if necessary create a taxon instance which will just have : a name, a group and a parent.
The Family will be linked to the 'lowest' ranking instance created, most probably of rank 'order'.<br/>
It does happen that families are unkown to COL. <br/>
Then you add the family, with no parent. Notify it, we cant correct that later.<br/>

* Be careful, when creating taxons. Any alphabetical character ending the year value must be truncated. Example '1952a' => '1952'
* If the taxon existed and has been updated find the matching taxon in biofresh_key_taxons and update it.
* If the taxons are new, create biofresh_key_taxon instances
* Look through the ExcelTaxonomyRecords for this taxonomic level and for this name, collect all reference id that point to
ExcelReferenceRecord instances.
* Create the link between the fada taxon instances and the fada gereference instances using table fada.taxons_taxoreferences

#### original_genus, declension_species, syn_original_genus
* For this part we will use ExcelTaxonomyRecords
with a search condition.
<pre>
group_id=theGroup
( parentheses='Y' OR syn_original_genus IS NOT NULL)
</pre>

* When the original_genus is blank, use the genus value of the name as original genus.
Look for this (name,group,rank) in the fada taxon instances. If it is not found create it without a link to the higher element but with it's group number set.
* Original genus taxon instances are not linked to a parent taxon. Declension species taxon instances must be linked to their original genus parent.
* syn_original_genus are processed like original genus but syn_original_genus must be analysed for the presence of a Subgenus element.
* If the value of syn_original_genus is of type 'Genus (SubGenus)' the name parts have to be separated to search for a
genus and a subgenus fada taxon instance, not synonyms.<br/>
The RegEx used for that is<pre>
/^[A-Z][a-z]\*\s\([A-Z][a-z]*\)$/
</pre>
If not found the name elements are used to create taxon instances, not synonyms.
* If the taxon existed and has been updated find the matching taxon in biofresh_key_taxons and update.
* If the taxons are new, create biofresh_key_taxons instances

### Species and SubSpecies
* For this part we will use ExcelTaxonomyRecords, ExcelFaunisticRecords and ExcelReferenceRecords
* Create/Update the taxon instances for species and subspecies the same way you have created the other accepted
name taxon instances.
* When updating a taxon instance find the matching taxon in biofresh_key_taxons and update it.
* Then Create/Update a species instance.<br/>
The taxon instances that make up a species or subspecies must be linked to the species instance.<br/>
This is cumbersome but not too complicated with the accepted name taxon instances.<br/>
With the original_genus and declension species taxon instances you must rely on name, group and rank
which are usually enough.<br/>
The ExcelTaxonomyRecords instance declaring the species or subspecies may also indicate connections
to references which will have to be added.
* You can set the parentheses value and calculate the scientific_name value.
* You can add connections to regions by looking for them in the ExcelFaunisticRecords (
  mapped regions_all table not the view)
ExcelFaunisticRecords may also indicate connections to references which will be added, not to the Species
instance but to the taxon instance by using table fada taxons_faunisticreferences.
* The taxon instance used in the taxon/reference relationship will be the one of the rank of the species object being created (species or subspecies)
* If the species instance existed as a biofresh_key_species instance and then update it.

### Processing synonyms
Go through the ExcelTaxonomyRecords using condition
<pre>
group_id=theGroup AND
NOT (syn_genus_subgenus IS NULL AND
syn_species_subspecies IS NULL AND
syn_original_genus IS NULL) AND
syn_authors IS NOT NULL AND
syn_date IS NOT NULL
</pre>
* Find the taxon instance to which the synonym will be linked to.
* Look for the synonym to create or update. (Is it linked to the taxon?)
* If there is no such synonym, create it.
* Remember, the genus_species_name is a concatenation of genus, species separated by a tab character, take out a trailing alpha character in the the year of creation.
* If the synonym existed and has been updated, update biofresh_key_synonyms.

### Updating group_taxons for the group
Actually this is a relationship between the concept taxon and the concept Group.<br/>
Where a Group has a taxon which is a starting point to recover the accepted names tree.<br/>
So it should be the taxon element with a group number which has the smallest rank_id.<br/>
Unfortunately it's not always that easy and you can go a little higher to find a suitable taxon instance.<br/>
So basically start with the taxon instances of this group with the smallest rank_id.
Then from there, find one that would top them all.
