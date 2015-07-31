# Specifications FADA database schema and import template changes
## Changes to the FADA template - version 2.1

As mentioned in the FADA import specifications:

> “Excel-data are provided in an [excel-template](./excel-templates), for which there are currently 2 “recognised” versions. A slightly modified version (**2.1**) including the columns isFreshwater, isMarine, isTerrestrial and isBrackish will need to be prepared reflecting the planned database changes…”

### Faunistic sheet “environment flags”
The following new fields were added at the end of the faunistic sheet (columns Y-AA):
- isFreshwater
- isTerrestrial
- isBrackish
- isMarine
	Together I’ll refer to these fields as “environment flags”.
<!--The Darwin Core standard also includes an isExtinct flag, as the FADA initiative is currently not considering to include fossils, I see no need to include this flag during this update.-->
<!--The specification document also mentions the field isPreferredName, but as this refers to vernacular names, it is not relevant to add it after all.-->

### Updates to FADA input file guidelines

[Note-to-self] To be added in document:
- Recommended control vocabulary for Aquatic/Water Dependent and its sub categories to be added.
- Recommended input for the “environment flags”. State explicitly that unless specified otherwise (so even if this columns are empty!), the checklist entries are considered as being freshwater by default. Marine (only) species which have been included in the checklist should be clearly identified as such by entering “N” in the isFreshwater column and “Y” for isMarine.

### Note on future improvements to the Excel template
To be considered for future updates: 
- Export in Excel format to update data including record IDs and timestamps?

## Changes in FADA tables
### “Species group” information

[Note-to-self] Reword following sections

### Changes which we wanted to add for some species groups.
The integration of Simuliidae species and possibly other species group requires to add another taxonomic level we will call "species group".
This new level is situated between a subgenus and a species.
The introduction of this level required a 
new record in table fada.rank 
a new field in table fada.species
a change in how a species name is calculated.

It remains to be seen what changes could be necessary to integrate this new level in our observation data import tool (DPIT) and how we will link names with speciesgroups from the registery to the taxonomic part.

### “modified” timestamp

> “A record level “modified” timestamp, this could be coupled to the import log timestamp”

### Environment flags

> The isFreshwater (default yes for FADA datasets), isMarine, isTerrestrial, isBrackish fields/flags (also to be added to the xls-template) and “Freshwater aquatic/water dependent” category and subcategory (in xls-template, but currently not stored in the database itself (other than in the import “distr_table”)). This could be either implemented in the species table or a separate table (cfr. the regions table).

Defaults > isFreshwater “Y”, other fields empty!

Import tool should process a variety of input as booleans e.g. Y, y, T, 1, x / N, n, F, 0, -

Changes to ensure all information entered in the templates is stored in the database…


### “provider IDs”
Need to conserve “provider IDs” for taxons and species names need to be considered. Can this be done by updating the “biofresh key”-tables or should we work out another solution?

### Updates to the groups table
Extend groups table with selected metadata fields from DwC-A EML including; alternateIdentifier for datasetID/URL, keywords and keywordThesaurus, intellectualRights and bibliographicCitation for the dataset as a whole and the URL/location of full EML metadata.

### Changes due to our exchanges with WORMS
In order to implement our goals about the software assisted updating of the FADA backbone we are going to bring some changes to the database FADA schema of the BioFresh database.

Adding a timestamp which will show when a group/species has been changed.

A timestamp field already exists for the 
fada.group table
adding one to table
fada.species 
would allow us to monitor changes at this level.
A basic level of monitoring would be to tell us effectively when a species has been added or last modified in the FADA taxonomic backbone.
However trying to monitor changes on the fada.taxons table or the fada.synonyms table would prove more difficult and probably not so interesting anyway.

Changes on the species table are also required to alow us to store the specie's habitat type.
We want to known if a species lives rather on land, in brackish water, in freshwater or marine waters. 
These cases are not mutually exclusive since a species can be adaptable to many habitats or even changes habitats during it's life cycle (Salmon, Eel).
These fields will have to be added to tables 
fada.species 

### Changes that have been waiting in the excel files
Some fields have been present in the faunistic sheet for some time and have never been added to the species table.
It would be an opportunity to add them if we want to.
Fields
lentic
lotic
exotic
bodyMass
Parasitic
Aquatic/water dependant
Aquatic/water dependant- subcategory
are clearly linked to a species and should added to this table if we so wish.
None of these fields points to a concept other than "species" so this is clearly the table to add them to.
Adding fields to a table never is a problem to our applications.

## Changes/Consequences in application behaviour
### FADA Application
The FADA app could possibly show non aquatic species. 
If this is not desired the code of the FADA application will have to be adapted.
Is there any of this information that we would like to show in the FADA application?
Clearly the application ruby code would have to be adapted.

### BioFresh application
The BioFresh data-portal will retrieve species info from the taxonomic backbone and then be able to use the habitat type.
If the reverse capability is wished (consult taxonomic backbone only for specific of a specific habitat type), the information will have to be copied in the 
register.biofreshspeciesregistry table to allow a choice beforehand.

Another foreseable sideeffect is the change in the structure of our downloadable data. The information donwloadable on a species should be adpated to contain the same type of data that will be used in our echanges with WORMS.

## FADA database refactoring

### Foreign keys and indexes
Remark from Sylvain Renaudier on 30/07/2015

### biofresh_key tables, IDs and link to the BioFresh species register
From the specs: “… potential improvements are (in addition to the modifications mentioned below) basically related to the organisation of the _biofresh_key_-tables and the flat taxon tables. The “biofresh keys” could be integrated in the taxon, species and synonym table eliminating the need for specific tables (this would require a small change in the portal app and export scripts).”
### Database changes to facilitate dealing with hierarchical data and creating (denormalized) data exports

- cfr. the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views 

From the specs: “Instead of having a combination of the the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views, we could opt for extending the _taxons_ table with a flat version of the complete taxonomic hierarchy (thus adding the fields: kingdom, class, order, family,… genus, specificEpithet, infraspecificEpithet).”



In addition to the required changes described above, we identified a number of issues that merit to be considered to facilitate future developments;

- While the species table currently contains a “status_id” field and the entries in the synonyms table are by definition all invalid, subjective synonyms, this is not a straightforward solution to provide the “taxonomicStatus” in the DwC-A-export (esp. for providing the “original combination” or “objective synonym”/“basionym” or “homotypic synonym” - terms respectively used in zoology/botany). A solution for this issue should be considered while addressing the FADA database structure. The main question will be whether this issue can be solved without breaking the backward compatibility with the FADA app.

- Bibliographic references are currently organised in 2 tables, _greferences_ for references pertaining to a group and _publications_ linked to individual species (and Rotifera references to be imported are still in a separate schema). Although joining these tables at this stage may not be an option due to the need for backward compatibility, their integration will likely be considered in the future.

The following is not necessarily a database refactoring task, but should be considered all along;

> Currently the higher taxonomy is copied from MySQL database tables on the [annual release of the Catalogue of Life](http://www.catalogueoflife.org/annual-checklist/2015/) DVD. A more sustainable solution for this issue, using the Catalogue of Life web services should be investigated.

> In parallel to the developments of the FADA import tools, we will work out a solution to improve the synchronisation/replication of the staging database (for both the DPIT and FADA import tool) with the production database. If successful, we will provide the code to trigger the synchronisation for use with the “sync prod DB” button in the general interface.

