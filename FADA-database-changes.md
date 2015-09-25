# Specifications FADA database schema and import template changes
_Version 24/09/2015 - Draft 1_
_Authors: Aaike De Wever, Michel Kapel_

## About this document
The aim of this document is to provide an overview of all changes that should be considered in parallel to the development of the FADA import tool. This document covers the changes to the FADA template, new fields and tables, changes to existing tables required to support the exchange of data in the framework of the [AquaRES project](http://odnature.naturalsciences.be/aquares/) and optimisations for improving the performance and logic of the database.

## 1. Changes to the FADA template - version 2.1

As mentioned in the FADA import specifications:

> _Quote from the FADA-import-specs:_ “Excel-data are provided in an [excel-template](./excel-templates), for which there are currently 2 “recognised” versions. A slightly modified version (**2.1**) including the columns isFreshwater, isMarine, isTerrestrial and isBrackish will need to be prepared reflecting the planned database changes…”

### 1.1 Faunistic sheet “environment flags”
The following new fields were added at the end of the faunistic sheet (columns Y-AB):
- isFreshwater
- isTerrestrial
- isBrackish
- isMarine

Together I’ll refer to these fields as “environment flags”. The updated template is: [Input_FADA_File_v2.1.xls](./excel-templates/Input_FADA_File_v2.1.xls).

_Note 1:_ The Darwin Core standard also includes an _isExtinct_ flag, and it was selected as a required field for the AquaRES exchange. However, as the FADA initiative is currently not considering to include fossils, I see no need to include this flag during this update. During export, this flag will be set to “N” by default.
_Note 2:_ The specification document also mentions the field isPreferredName, but as this refers to vernacular names, which are not stored in FADA, it is not relevant to add it after all.

The following fields were present in earlier versions of the Excel sheet, but have not been processed so far:
- TDWG 3rd level codes (“, separated by comma” moved to lower row” during the version 2.1 update)
- lentic (for convenience the “?” was removed from the field name cfr. previous template versions)
- lotic (“?” was removed as for lentic)
- exotic
- bodyMass
- Parasitic
- Aquatic/water dependent	(spelling change dependant > dependent)
- Aquatic/water dependent-subcategory

Corresponding fields in the database will need to be created to ensure the storage of its content (see 2.3 and 2.4). Ideally the TDWG codes should also be parsed in the regions table. This will be discussed under 3.5.

### 1.2 Updates to FADA input file guidelines
In addition to the database changes with regards to the “environment flags”, the recommendations for filling these fields is integrated in the FADA input file guidelines [FADA input file guidelines-v2.1.doc](./excel-templates/FADA%20input%20file%20guidelines-v2.1.doc). Changes include:
- Recommended control vocabulary for Aquatic/Water Dependent and its sub categories to be added.
- Recommended input for the “environment flags”. State explicitly that unless specified otherwise (so even if this columns are empty!), the checklist entries are considered as being freshwater by default. Marine (only) species which have been included in the checklist should be clearly identified as such by entering “N” in the isFreshwater column and “Y” for isMarine.

### 1.3 Note on future improvements to the Excel template
To be considered for future updates: 
- Include “isExtinct” flag for dealing with fossil species
- Offering the possibility to export data from the FADA database in the FADA-Excel-template format would allow to include record IDs and timestamps straight in the Excel file.

## 2. New fields and types of information
### 2.1 “Species group” information
**Note: Please disregard this section for the time being.** This section requires rewording, but I am currently waiting for feedback from Koen, as I am not entirely sure whether there is a need for including “species group” in species table and implementing an alternative speciesName calculation method. 


[temp]The integration of Simuliidae species and possibly other species group requires to add another taxonomic level we will call "species group".
This new level is situated between a subgenus and a species.
The introduction of this level required a 
new record in table fada.rank 
a new field in table fada.species
a change in how a species name is calculated.[temp]

[temp]It remains to be seen what changes could be necessary to integrate this new level in our observation data import tool (DPIT) and how we will link names with speciesgroups from the registery to the taxonomic part.[temp]

### 2.2 “modified” timestamp
> _Quote from the FADA-import-specs:_ “A record level “modified” timestamp, this could be coupled to the import log timestamp”

The best solution is probably to have the timestamp representing the last modification date in the taxa, species, synonyms, regions_species and greferences table for individual records. See the description of the “Changes to FADA tables” for further information.

### 2.3 Environment flags

> _Quote from the FADA-import-specs:_ The isFreshwater (default yes for FADA datasets), isMarine, isTerrestrial, isBrackish fields/flags (also to be added to the xls-template) and “Freshwater aquatic/water dependent” category and subcategory (in xls-template, but currently not stored in the database itself (other than in the import “distr_table”)). This could be either implemented in the species table or a separate table (cfr. the regions table).

The following fields have to be added to either the species table or a separate, new “speciesProfile” table (the latter would have the advantage that we only specify these flags if they were provided in the source data) - **for discussion with Sylvain**. The corresponding Darwin Core terms and/or field names used in the Excel templates are given in parentheses.
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

For these fields, the import tool should process a variety of input as booleans e.g. Y, y, T, 1, x / N, n, F, 0, -

### 2.4 Faunistic regions and other geographic region data
The following information, which can be provided through respectively the FADA-templates and the Darwin Core-Archive format are currently not stored in the FADA-database. The regions table will need to be adapted to store the information in these fields.
- FADA-template: TDWG 3rd level codes
- DwC fields: locationID, locality, countryCode 

The TDWG Geographic Region classification matches the TDWG-standard “World Geographical Scheme for Recording Plant Distributions”. It identifies geographic units worldwide in a four-level hierarchy, incorporating continents, regions, “botanical countries” and basic recording units. FADA editors providing data through the Excel template have the possibility to enter TDWG 3rd level codes in the faunistic sheet as a comma separated list.

The Darwin Core field locationID is defined as “A code for the named area this distribution record is about. Use a prefix for each code to indicate the source of the code, see http://rs.gbif.org/areas/ for list of coding schemes and their recommended prefix. see also http://rs.gbif.org/areas/”. The idea would be to store the area prefix and the code separately in the regions table. See 3.5 for further details.

### 2.5 “provider IDs”
> _Quote from the FADA-import-specs:_ Need to conserve “provider IDs” for taxons and species names need to be considered. Can this be done by updating the “biofresh key”-tables or should we work out another solution?

This refers to the taxonID present in Darwin Core files, for which the combination “provider” (or “resource” —which comes from a single provider anyway) and “taxonID” is unique. The main interest in conserving this provider ID is that it will allow to detect changes for individual records more easily by comparing the record to be imported with record already in the database that carries the same (provider)ID.

During discussion with Michel, we identified two possible approaches: 1) store the providerID only in the import schema and perform the comparison with previously imported data which is retained in this schema or 2) (also) store the providerIDs in the taxons, species and synonyms table. **For discussion with Sylvain**

In case we opt for the 2nd option, this will probably need to be stored in two fields: a) provider and b) providerID who’s combination should be unique. This would mean that the providerIDs are used in a very similar way to the biofresh_keys when exporting data from the FADA database. If so, we could consider moving these IDs to the same field(s).


## 3. Corresponding changes to FADA tables
### 3.1 Updates to the taxon table
Changes in the taxon table depend on the choices with regards to the implementation of timestamps (2.2) and providerIDs (2.5). 

### 3.2 Updates to the species table
Changes to the species table include the addition of a timestamp (2.2). The inclusion of the “species_group” field and the change in the calculation of the scientific_name field has to be decided (2.1). The inclusion of the environment flags (2.3) depends on the choice whether to store this in this table or a separate “speciesProfile” table. If included in the fada-schema, the providerID field(s) (2.5) also need to be added to the species table. 

_Note: The script database-info/fada-tables/species_changes.sql needs to be updated to reflect these choices. For the environment flags, only isFreshwater should be set to TRUE by default, while leaving other fields empty._

### 3.3 Updates to the synonyms table
Similar to the taxon table, the changes to the synonym table depend on the choices with regards to the implementation of timestamps (2.2) and providerIDs (2.5).

### 3.4 Updates to the groups table
> _Quote from the FADA-import-specs:_ Extend groups table with selected metadata fields from DwC-A EML including; alternateIdentifier for datasetID/URL, keywords and keywordThesaurus, intellectualRights and bibliographicCitation for the dataset as a whole and the URL/location of full EML metadata.

The following fields, corresponding to the DwC-terms in parentheses, need to be added to the groups table in order to store data imported from Darwin Core-Archive files:
- access_rights (accessRights)
- rights (rights)
- rights_holder (rightsHolder)
- provider_dataset_id (datasetID)
- dataset_name (datasetName) -- This field should be used for the full and/or original name of the dataset and not the group name as used in FADA (e.g. World Checklist of *groupname* vs. FADA-*groupname*)

In parallel, we want to add the field:
- chapter_authors
- data_downloadable
The field “chapter_authors” represents a new field, which is required to make the distinction between editors which contributed to the FADA-book and editors that contribute to the FADA-database. This info will be used for updating the [overview table of the groups](http://fada.biodiversity.be/group/list?current_page=groups) in the Ruby app/website.
The “data_downloadable” field is a new field in which we want to document whether data should not be offered for download. To respect this option, we would obviously also need to adapt the code of the FADA and BioFresh portal app, but we already want to foresee the case so this does not require database changes at a later stage. 

The date fields
- created
- updated
- received_date
- validated_date
- published_date
are currently manually filled through the web interface, if possible it would be useful to auto-update at least the “published_date” when finalising the resource processing  (in the updated overview table of the groups only this field will be publicly shown). Otherwise, the other option would be to include another “modified” timestamp (2.2) as done for the previous tables.

### 3.5 Updates to the regions table
The current regions table consists of the fields: id, code, name, parent_id and distribution. To accommodate storing other types of area/region names, we would need a new field to store the region_type/area_prefix, which could be used to store TDWG codes as well as other codes provided through the DwC _locationID_ which has the format prefix:code.
In addition, as the DwC-A files can both contain a locationID and a countryCode, the latter field would need to be added to the regions table as well.

In terms of organisation of the tables, Michel proposed to rename the extended table as “regions_all” and create a view “regions” corresponding to the current content of this table, which would still allow the FADA-app to only call this overview which only contains the FADA-faunistic zone info. Similarly we could create a regions_tdwg table in case this would be needed. 

### 3.6 Updates to the greferences table
Currently the greferences table is the one and only table containing bibliographic references in the FADA database that is used in the FADA app/website. Moreover, the links with individual taxa, species or faunistic info is not stored, although editor can potentially provide this information by using the refkey-field. This is an omission that absolutely needs to be corrected.

Adding:
- bibliographic_citation (bibliographicCitation)
- linking with species, taxa and faunistic info (through new species_references, taxa_references and faunistic_references?)

The new “bibliographic_citation” field is meant to store the full citation for a species or taxon as provided in the Darwin Core-Archive files as parsing the field is likely to be very complex. For the current content and references coming from Excel-template data, this field would need to be constructed by concatenating author, year (to be put between parentheses), title and source.

#### Integration the publications table [to be handled by RBINS team]
The publications (and import_publications) table were added by Michel to process new bibliographic data for the Rotifera group. Ideally these info should have been stored in the greference table, but the info in the publications table is more atomised. The following fields are present in the publications table, but not in the greferences one:
- publisher
- volume
- issue
- pages
- editor
- publisherlocation
- sereditor
- sertitle
The easiest solution for transferring this info to the greference table is to concatenate this info into the source field, while establishing/maintaining the link to the species through the species_references table.


## 4. FADA database refactoring

### 4.1 Foreign keys and indexes
On 30/07/2015, Sylvain Renaudier remarked that the current keys are not correctly defined as foreign keys and that indexes which would improve the database performance are missing. This should be corrected.

### 4.2 biofresh_key tables, IDs and link to the BioFresh species register
> _From the specs:_ “… potential improvements are (in addition to the modifications mentioned below) basically related to the organisation of the _biofresh_key_-tables and the flat taxon tables. The “biofresh keys” could be integrated in the taxon, species and synonym table eliminating the need for specific tables (this would require a small change in the portal app and export scripts).”

As mentioned under 2.5 a joint mechanism to store the providerIDs and the biofresh keys should be considered (in this case with “provider” FADA). 

### 4.3 Database changes to facilitate dealing with hierarchical data and creating (denormalized) data exports

- cfr. the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views 

> _From the specs:_ “Instead of having a combination of the the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views, we could opt for extending the _taxons_ table with a flat version of the complete taxonomic hierarchy (thus adding the fields: kingdom, class, order, family,… genus, specificEpithet, infraspecificEpithet).”

The possibility and advantages/disadvantages of this proposed approach (or any alternative solution) should be evaluated in detail.

### 4.4 Other potential improvements
In addition to the required changes described above, we identified a number of issues that merit to be considered to facilitate future developments;

- While the species table currently contains a “status_id” field and the entries in the synonyms table are by definition all invalid, subjective synonyms, this is not a straightforward solution to provide the “taxonomicStatus” in the DwC-A-export (esp. for providing the “original combination” or “objective synonym”/“basionym” or “homotypic synonym” - terms respectively used in zoology/botany). A solution for this issue should be considered while addressing the FADA database structure. The main question will be whether this issue can be solved without breaking the backward compatibility with the FADA app.

The following is not necessarily a database refactoring task, but should be considered all along;

> _Quote from the FADA-import-specs:_ Currently the higher taxonomy is copied from MySQL database tables on the [annual release of the Catalogue of Life](http://www.catalogueoflife.org/annual-checklist/2015/) DVD. A more sustainable solution for this issue, using the Catalogue of Life web services should be investigated.

> _Quote from the FADA-import-specs:_ In parallel to the developments of the FADA import tools, we will work out a solution to improve the synchronisation/replication of the staging database (for both the DPIT and FADA import tool) with the production database. If successful, we will provide the code to trigger the synchronisation for use with the “sync prod DB” button in the general interface.


## 5. Changes/Consequences in application behaviour
### 5.1 FADA Application
The FADA app could possibly show non aquatic species. This is not a problem, but flagging the (few) marine representatives would be appropriate (in the longer term). The number of non-freshwater representatives should remain low as only Excel imported groups are allowed to contain non-freshwater representatives, while these entries have to be filtered out when processing DwC-A file.

### 5.2 BioFresh application
An **important issue** we overlooked during in de FADA import tool specs is the fact that non-freshwater representatives should be filtered out when synchronising data with the BioFresh species register. This change in the specs should still be considered for the development of the import tool, if necessary to be covered as part of the database refactoring work. **Sylvain, please take note!**

In the longer term, the format of the data downloaded through BioFresh should be reviewed to ensure all data includes correct credits, we can offer complete information (e.g. also offering DwC-format data) and data that may not be offered for download is excluded.