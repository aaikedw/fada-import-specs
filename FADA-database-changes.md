# Specifications FADA database schema and import template changes
## Changes to the FADA template - version 2.1

As mentioned in the FADA import specifications:

> _Quote from the FADA-import-specs:_ “Excel-data are provided in an [excel-template](./excel-templates), for which there are currently 2 “recognised” versions. A slightly modified version (**2.1**) including the columns isFreshwater, isMarine, isTerrestrial and isBrackish will need to be prepared reflecting the planned database changes…”

### Faunistic sheet “environment flags”
The following new fields were added at the end of the faunistic sheet (columns Y-AB):
- isFreshwater
- isTerrestrial
- isBrackish
- isMarine

Together I’ll refer to these fields as “environment flags”. The updated template is: [Input_FADA_File_v2.1.xls](./excel-templates/Input_FADA_File_v2.1.xls).

_Note 1:_ The Darwin Core standard also includes an _isExtinct_ flag, and it was selected as a required field for the AquaRES exchange. However, as the FADA initiative is currently not considering to include fossils, I see no need to include this flag during this update. During export, this flag will be set to “N” by default.
_Note 2:_ The specification document also mentions the field isPreferredName, but as this refers to vernacular names, which are not stored in FADA, it is not relevant to add it after all.

The following fields were present in earlier versions of the Excel sheet, but have not been processed so far:
- TDWG 3rd level codes (“, separated by comma” moved to lower row”
- lentic (for convenience the “?” was removed from the field name cfr. previous template versions)
- lotic (“?” was removed as for lentic)
- exotic
- bodyMass
- Parasitic
- Aquatic/water dependent	(spelling change dependant > dependent)
- Aquatic/water dependent-subcategory

Corresponding fields in the database will need to be created to ensure the storage of its content. **Ideally the TDWG codes should also be parsed in the regions table!**

### Updates to FADA input file guidelines
In addition to the database changes with regards to the “environment flags”, the recommendations for filling these fields is integrated in the FADA input file guidelines [FADA input file guidelines-v2.1.doc](./excel-templates/FADA%20input%20file%20guidelines-v2.1.doc). Changes include:
- Recommended control vocabulary for Aquatic/Water Dependent and its sub categories to be added.
- Recommended input for the “environment flags”. State explicitly that unless specified otherwise (so even if this columns are empty!), the checklist entries are considered as being freshwater by default. Marine (only) species which have been included in the checklist should be clearly identified as such by entering “N” in the isFreshwater column and “Y” for isMarine.

### Note on future improvements to the Excel template
To be considered for future updates: 
- Export in Excel format to update data including record IDs and timestamps?
- Include “isExtinct” flag for dealing with fossil species

## Changes in FADA tables
### “Species group” information
[Note-to-self] Reword following section
[Note-to-self 2] Need for “species group” in species table and alternative speciesName calculation method not entirely sure. **Get advise from Koen!**
### Changes which we wanted to add for some species groups.
The integration of Simuliidae species and possibly other species group requires to add another taxonomic level we will call "species group".
This new level is situated between a subgenus and a species.
The introduction of this level required a 
new record in table fada.rank 
a new field in table fada.species
a change in how a species name is calculated.

It remains to be seen what changes could be necessary to integrate this new level in our observation data import tool (DPIT) and how we will link names with speciesgroups from the registery to the taxonomic part.

### “modified” timestamp
> _Quote from the FADA-import-specs:_ “A record level “modified” timestamp, this could be coupled to the import log timestamp”

The best solution is probably to have the timestamp in the taxa, species, synonyms, regions_species and greferences table for individual records. 

### Environment flags

> _Quote from the FADA-import-specs:_ The isFreshwater (default yes for FADA datasets), isMarine, isTerrestrial, isBrackish fields/flags (also to be added to the xls-template) and “Freshwater aquatic/water dependent” category and subcategory (in xls-template, but currently not stored in the database itself (other than in the import “distr_table”)). This could be either implemented in the species table or a separate table (cfr. the regions table).

The following fields have to be added to either the species table or a speciesProfile table (the latter would have the advantage that we only specify these flags if they were provided in the source data) - **for discussion with Sylvain**. The corresponding Darwin Core terms and/or field names used in the Excel templates are given in parentheses.
- freshwater (isFreshwater)
- terrestrial (isTerrestrial)
- brackish (isBrackish)
- marine (isMarine)
- lentic
- lotic
- exotic
- body_mass (bodyMass)
- parasitic (Parasitic)
- aquatic_wd (Aquatic/water dependent)
- aquatic_wd_subcategory (Aquatic/water dependent-subcategory)

Note: The script database-info/fada-tables/species_changes.sql needs to be updated, only providing a default for isFreshwater true, while leaving other fields empty.

For these fields, the import tool should process a variety of input as booleans e.g. Y, y, T, 1, x / N, n, F, 0, -

### Faunistic regions and other geographic region data
**To be worked out**
- TDWG 3rd level codes
- DwC fields: locationID, locality, countryCode 

### “provider IDs”
> _Quote from the FADA-import-specs:_ Need to conserve “provider IDs” for taxons and species names need to be considered. Can this be done by updating the “biofresh key”-tables or should we work out another solution?

This refers to the taxonID present in Darwin Core files, for which the combination “provider” (or “resource” —which comes from a single provider anyway) and “taxonID” is unique. The main interest in conserving this provider ID is that it will allow to detect changes for individual records more easily (by comparing the record to be imported with record already in the database that carries the same (provider)ID.

As we use the biofresh_keys in a very similar way when exporting data from the FADA database, we could consider moving these IDs to the same field(s).

I guess the most logical option is to store this providerIDs in the taxons, species and synonyms table. **But for discussion with Michel and Sylvain**

### Updates to the groups table
> _Quote from the FADA-import-specs:_ Extend groups table with selected metadata fields from DwC-A EML including; alternateIdentifier for datasetID/URL, keywords and keywordThesaurus, intellectualRights and bibliographicCitation for the dataset as a whole and the URL/location of full EML metadata.

The following fields, corresponding to the DwC-terms in parentheses, need to be added to the groups table:
- access_rights (accessRights)
- rights (rights)
- rights_holder (rightsHolder)
- provider_dataset_id (datasetID)
- dataset_name (datasetName) -- This field should be used for the full and/or original name of the dataset and not the group name as used in FADA

- chapter_authors 
The field “chapter_autos” represents a new field, which is required to make the distinction between editors which contributed to the FADA-book and editors that contribute to the FADA-database. This info will be used for updating the [overview table of the groups](http://fada.biodiversity.be/group/list?current_page=groups) in the Ruby app/website.

The date fields
- created
- updated
- received_date
- validated_date
- published_date
are currently manually filled, if possible it would be useful to auto-update at least the “published_date” when finalising the resource processing  (in the updated overview table of the groups only this field will be publicly shown).

**To be discussed** 
- inputfile_publishable - does not seem to be a new field, but remember there were questions on this one?
- data_downloadable field needed??

### Updates to the greferences table
**integration of greferences and publications table and linking of references with taxa/species**
Currently the greferences table is the one and only table containing bibliographic references in the FADA database that is used in the FADA app/website. Moreover, the links with individual taxa, species or faunistic info is not stored, although editor can potentially provide this information by using the refkey-field. This is an omission that absolutely needs to be corrected.

Adding:
- bibliographicCitation !!
Parsing info from it probably won’t work very well…

The publications (and import_publications) table were added by Michel to process new bibliographic data for the Rotifera group. Ideally these info should have been stored in the greference table, but the info in the publications table is more atomised. The following fields are present in the publications table, but not in the greferences one:
- publisher
- volume
- issue
- pages
- editor
- publisherlocation
- sereditor
- sertitle
The easiest solution for transferring this info to the greference table is to concatenate this info into the source field.
 

### Changes due to our exchanges with WORMS
Original text Michel - section not needed as such, but see notes for discussion!

In order to implement our goals about the software assisted updating of the FADA backbone we are going to bring some changes to the database FADA schema of the BioFresh database.

Adding a timestamp which will show when a group/species has been changed.

A timestamp field already exists for the 
fada.group table
— Note Aaike: Is not really a timestamp actually
adding one to table
fada.species 
would allow us to monitor changes at this level.
A basic level of monitoring would be to tell us effectively when a species has been added or last modified in the FADA taxonomic backbone.
However trying to monitor changes on the fada.taxons table or the fada.synonyms table would prove more difficult and probably not so interesting anyway.
— **Note Aaike:** Not sure why Michel??

[Changes on the species table are also required to alow us to store the specie's habitat type.
We want to known if a species lives rather on land, in brackish water, in freshwater or marine waters. 
These cases are not mutually exclusive since a species can be adaptable to many habitats or even changes habitats during it's life cycle (Salmon, Eel).
These fields will have to be added to tables 
fada.species ]

## Changes/Consequences in application behaviour
### FADA Application
The FADA app could possibly show non aquatic species. 
If this is not desired the code of the FADA application will have to be adapted.
— > **Note Aaike:** Not a problem, but flagging the (few) marine representatives would be appropriate (in the longer term)
- Excel imported groups allowed to contain non-fw representatives
- DwC-A imports non-fw species to be filtered out

Is there any of this information that we would like to show in the FADA application?
Clearly the application ruby code would have to be adapted.
— > **Note Aaike:** Not in the short term

### BioFresh application
The BioFresh data-portal will retrieve species info from the taxonomic backbone and then be able to use the habitat type.
If the reverse capability is wished (consult taxonomic backbone only for specific of a specific habitat type), the information will have to be copied in the 
register.biofreshspeciesregistry table to allow a choice beforehand.

— > **Note Aaike:** Not sure what you mean here. We should filter out the non-fw species when syncing with the register!!

Another foreseable sideeffect is the change in the structure of our downloadable data. The information donwloadable on a species should be adpated to contain the same type of data that will be used in our echanges with WORMS.
— > **Note Aaike:** Yes this needs to be reviewed one difficulty might be that WoRMS might prefer the data to be non-downloadable… 

## FADA database refactoring

### Foreign keys and indexes
Remark from Sylvain Renaudier on 30/07/2015

### biofresh_key tables, IDs and link to the BioFresh species register
> _From the specs:_ “… potential improvements are (in addition to the modifications mentioned below) basically related to the organisation of the _biofresh_key_-tables and the flat taxon tables. The “biofresh keys” could be integrated in the taxon, species and synonym table eliminating the need for specific tables (this would require a small change in the portal app and export scripts).”
### Database changes to facilitate dealing with hierarchical data and creating (denormalized) data exports

- cfr. the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views 

> _From the specs:_ “Instead of having a combination of the the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views, we could opt for extending the _taxons_ table with a flat version of the complete taxonomic hierarchy (thus adding the fields: kingdom, class, order, family,… genus, specificEpithet, infraspecificEpithet).”



In addition to the required changes described above, we identified a number of issues that merit to be considered to facilitate future developments;

- While the species table currently contains a “status_id” field and the entries in the synonyms table are by definition all invalid, subjective synonyms, this is not a straightforward solution to provide the “taxonomicStatus” in the DwC-A-export (esp. for providing the “original combination” or “objective synonym”/“basionym” or “homotypic synonym” - terms respectively used in zoology/botany). A solution for this issue should be considered while addressing the FADA database structure. The main question will be whether this issue can be solved without breaking the backward compatibility with the FADA app.

- Bibliographic references are currently organised in 2 tables, _greferences_ for references pertaining to a group and _publications_ linked to individual species (and Rotifera references to be imported are still in a separate schema). Although joining these tables at this stage may not be an option due to the need for backward compatibility, their integration will likely be considered in the future.

The following is not necessarily a database refactoring task, but should be considered all along;

> _Quote from the FADA-import-specs:_ Currently the higher taxonomy is copied from MySQL database tables on the [annual release of the Catalogue of Life](http://www.catalogueoflife.org/annual-checklist/2015/) DVD. A more sustainable solution for this issue, using the Catalogue of Life web services should be investigated.

> _Quote from the FADA-import-specs:_ In parallel to the developments of the FADA import tools, we will work out a solution to improve the synchronisation/replication of the staging database (for both the DPIT and FADA import tool) with the production database. If successful, we will provide the code to trigger the synchronisation for use with the “sync prod DB” button in the general interface.

