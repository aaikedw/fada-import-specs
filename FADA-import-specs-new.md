# Specifications FADA import tool
_Version 14/08/2015 - V1.1 Draft 2 – including answers to questions Sylvain_ 
_Authors: Aaike De Wever, Michel Kapel_
This document is used for launching a call for offers for developing the FADA import tool. This document is intended as a guidance for constructing the web application, but as it consists of a complex database and the reconciliation of the needs from ‘biologist’ users and the technical needs and possibilities, it is likely that specific requirements will have to be clarified and refined along the way. This version includes changes after the work of this tool was initiated.
Supporting material for this specification document can be consulted at [https://github.com/aaikedw/fada-import-specs](https://github.com/aaikedw/fada-import-specs).

## 1. General background information
### 1.1 Project status
The Freshwater Animal Diversity Assessment (FADA) database was constructed in 2009 following the publication of a special issue  of the scientific journal _Hydrobiologia_ in which taxonomic experts described the biodiversity of around 60 organism groups. This work was funded by Belspo and supported by the Belgian Biodiversity Platform.

The FADA initiative and its networking activities involving taxonomic experts led to a follow-up initiative in the form of the EU FP7 project BioFresh (Biodiversity of Freshwater Ecosystems: Status, Trends, Pressures, and Conservation Priorities; [www.freshwaterbiodiversity.eu/](http://www.freshwaterbiodiversity.eu/)), for  which RBINS was in charge of constructing a data portal. This project ended officially in April 2014, but we have recently (Spring 2015) finalised the last technical updates (including the implementation of a ‘Data Portal Import Tool’ – DPIT).

Since May 2014, we focus on the FADA database again through the BRAIN AquaRES (Aquatic Register Exchange and Services) project – [odnature.naturalsciences.be/aquares]([http://odnature.naturalsciences.be/aquares). We aim to improve the FADA database, by both streamlining the database import procedures and setting up data exchange with the World Register of Marine Species (WoRMS) and the Register of Antarctic Marine Species (RAMS). In order to implement this project, we are looking to build a web application “FADA import tool” for importing data into the FADA database.

### 1.2 Database status 
Currently (18/11/2014), taxonomic checklists for 16 organism groups are published on-line. In total these checklists contain around 47.000 names and thus represent almost 1/3 of the number of accepted names for freshwater animal species, which is estimated at roughly 150.000 species. 

### 1.3 Organisation in groups and volumetry
The organisation by organism group, corresponds to the initial organisation as was adopted for the paper publication. In fact, these groups represent an “operational unit”[^1] for which a taxonomic editor was found to produce an informed estimate of the number of known species. These organism groups may represent  different taxonomic levels, e.g. classes, orders or families.

For database purposes and/or because no taxonomic editor is found to provide a checklist for the entire group, we may subdivide the task and create a new (sub)group. While taxonomically this represents the creation of a real subgroup, we do not aim to introduce any hierarchical structure at the level of the groups themselves, as these remain “operational units” in the first place.

In terms of size, the checklist for the different groups vary from not even 100 species names to around 16.000 names for Vertebrates-Fish. Unless, at some stage we will further extend the scope at the database to non-animal freshwater groups (other than the [“Macrophytes”](http://en.wikipedia.org/wiki/Macrophyte) group, which is currently included), which is unlikely to happen within the duration of the [AquaRES project](http://odnature.naturalsciences.be/aquares/), the total number of (accepted) species names is unlikely surpass 200.000 and 16.000 for individual groups in the near future. 

Note: As DwC-A files may include non-freshwater species (which have to be filtered out at some stage), the number of records in these files can be higher.

[^1]: The “operational unit” can be referred to as “Group”, “Data source” or “Resource”. In this document the term “group” is used to stress the link with taxonomic unit, whereas “resource” is used when discussing the digital representation of such a group (e.g. as an ‘import unit’ and its associated file).

## 2. Technical background
### 2.1 Technologies used for the BioFresh and FADA database and web applications
The FADA database is managed in PostgreSQL together with the BioFresh occurrence database. The FADA website and the original import scripts were developed in Ruby. The BioFresh portal was developed in the Groovy programming language. 

### 2.2 Existing data import tools
For the BioFresh database, we developed an import tool for occurrence data in collaboration with an external developer (Sylvain Renaudier). In essence, the interface for the FADA import tool will be quite similar to that of the ‘Data Portal Import Tool’ (DPIT). See screenshots in the UI-screenshots folder (1-3).

For importing data into the FADA database, original Excel-file import scripts were developed in Ruby. With the exception of the  scripts for injecting the data into the database tables, the FADA import scripts were re-written in Groovy. Procedures and scripts for importing Darwin Core-Archive (DwC-A) data in FADA have to be developed from scratch.

### 2.3 FADA database structure and planned changes
#### SQL scripts current database structure
The definitions of the tables and views in the fada schema are included in the [./database-info](./database-info) folder. For information this folder also contains the definitions for the “importandsyncfada” schema as used for processing Excel imports. Note that this is work in progress, but I included this as it may provide inspiration on how to organise a staging area for processing the import files.

#### Description of the main database tables and background with regards to the database structure
The FADA database structure is described at the [BioFresh-wiki](http://trac.bebif.be/wiki/BioFresh/FadaDatabaseStructure). The species register (also registry) is described at [http://trac.bebif.be/wiki/BioFresh/DatabaseStructure](http://trac.bebif.be/wiki/BioFresh/DatabaseStructure) under the heading “Organisation of the central species registry”.

The original database structure was elaborated to accommodate a hierarchical browsing tool through the FADA web application (see [FADA Taxonomic Tree browser](http://fada.biodiversity.be/taxon/browse/-1?current_page=browse)). Imports were seen as a one-shot thing, where updates would be preceded by a complete deletion of the earlier data, without the need for permanent identifiers. Through BioFresh and exchange projects, the use of the database was widened, and there was a need to introduce more permanent identifiers in order to link the FADA database to the BioFresh species register (hence the _biofresh_key_ tables), and to facilitate the export of the hierarchical data into a flat, denormalised format (hence the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views).

While the organisation of the database may be improved in certain areas, we should maintain the compatibility with the original FADA website [fada.biodiversity.be/](http://fada.biodiversity.be/), as we currently have no plans to rework this application. E.g. while the tables with regards to “observations” are barely used, these correspond to an option in the FADA interface, which we don’t want to break at the moment, and thus should leave those tables untouched.

This means that potential improvements are (in addition to the modifications mentioned below) basically related to the organisation of the _biofresh_key_-tables and the flat taxon tables. The “biofresh keys” could be integrated in the taxon, species and synonym table eliminating the need for specific tables (this would require a small change in the portal app and export scripts). Instead of having a combination of the the _genus_to_family_ table and the _fst_for_genus_ and _fst_for_tribe_ views, we could opt for extending the _taxons_ table with a flat version of the complete taxonomic hierarchy (thus adding the fields: kingdom, class, order, family,… genus, specificEpithet, infraspecificEpithet).

As will be elaborated in the [./FADA-database-changes.md](./FADA-database-changes.md) document, we currently (10/08/2015) envisage 2 main types of database changes: 1) changes directly linked to the FADA import tool and 2) changes linked to improving the overall database structure and performance. The organisation of the _biofresh_key_-tables and organisation of the taxon information is considered under (2) which should be dealt with under a separate contract.

Note: On 30/07/2015 Sylvain Renaudier notified me that the keys we are using to link the tables are currently not actual “foreign keys”, which means they are not indexed. This issue can be addressed by adding constraints for the ID fields. Michel will need to test whether this has an impact on the FADA-app, if not, this change could still be applied independent of (2).

#### Planned and needed changes in terms of database structure 
In addition to expected changes due to the implementation of a FADA-import tool with its own progress and log database tables, we foresee the need for specific changes based on the required fields to implement the data exchange using the DwC-A exchange format (see 4.1) and certain requests from our editors (categories for aquatic/water dependent species). These changes include the need for the following fields/tables;
- A record level “modified” timestamp, this could be coupled to the import log timestamp
- The isFreshwater (default yes for FADA datasets), isMarine, isTerrestrial, isBrackish fields/flags (also to be added to the xls-template) and “Freshwater aquatic/water dependent” category and subcategory (in xls-template, but currently not stored in the database itself (other than in the import “distr_table”)). This could be either implemented in the species table or a separate table (cfr. the regions table).
- Need to conserve “provider IDs” for taxons and species names need to be considered. Can this be done by updating the “biofresh key”-tables or should we work out another solution?
- Extend groups table with selected metadata fields from DwC-A EML including; alternateIdentifier for datasetID/URL, keywords and keywordThesaurus, intellectualRights and bibliographicCitation for the dataset as a whole and the URL/location of full EML metadata.

In addition to the required changes described above, we identified a number of issues that merit to be considered to facilitate future developments;
- While the species table currently contains a “status_id” field and the entries in the synonyms table are by definition all invalid, subjective synonyms, this is not a straightforward solution to provide the “taxonomicStatus” in the DwC-A-export (esp. for providing the “original combination” or “objective synonym”/“basionym” or “homotypic synonym” - terms respectively used in zoology/botany). A solution for this issue should be considered while addressing the FADA database structure. The main question will be whether this issue can be solved without breaking the backward compatibility with the FADA app.
- Bibliographic references are currently organised in 2 tables, _greferences_ for references pertaining to a group and _publications_ linked to individual species (and Rotifera references to be imported are still in a separate schema). Although joining these tables at this stage may not be an option due to the need for backward compatibility, their integration will likely be considered in the future.

### 2.4 “biofresh keys” as persistent identifiers and the link between the FADA database and the BioFresh species register
As mentioned under 2.3, the “biofresh key” tables originated from the need to have a (more) permanent identifier to establish a link between the FADA database and the BioFresh species register. At this stage there are 3 tables; _biofresh_key_species_, _biofresh_key_synonyms_, _biofresh_key_taxons_, each consisting of an id (considered as “biofresh key”), the id in the respective table for species, synonyms or taxons and the scientific name and/or other crucial data to establish the link with the original tables. Currently, during each update, the ids for the original tables are removed and the new ids are re-established through name-matching. In case of changes in the spelling of the scientific name or changes in the (parentheses of) authorship, this field is updated in the _biofresh_key_ table. 
If we design the import tools so that they only update the changed records, we could eliminate the need to get rid of the deletion of the original ids. By integrating the “biofresh keys” in the _species_, _taxons_ and _synonyms_ table as discussed under 2.3, we would further eliminate the need to update those tables separately.

The link between the BioFresh species register and the FADA schema are covered by the “biofreshdatasources” table (see definition in [./database-info/register-tables](./database-info/register-tables)) where register.biofreshspeciesregistry.id = register.biofreshdatasources.fkbiofreshid AND register.biofreshdatasources.intdatasourcekey = fada.biofresh_key[_species].id. These links remain stable, except if a species name is synonymized and the  link to the fada.biofresh_key_species.id needs to be replaced by the fada.biofresh_key_synonym.id.

For new species names added to the FADA database, their presence in the BioFresh species register needs to be checked (as this register can be populated through other sources) based on the group and species name matching (both exact and phonetic). See further details under 6.2.

## 3. Overall FADA import tool specifications

### 3.1 Envisaged components of the FADA import tool
Data for import into the FADA database will either be available in one of the following formats, which each represent a different _data import module_ (corresponding to different “tabs” in the main interface);
1. Data import interface for organism group-data provided in DwC-A format (for externally managed datasets, in particular those coming from WoRMS)
2. Excel template data entry and update interface for FADA checklists (default option for FADA editors)

_Note however that, while data for a group is either present in the database as a “DwC-A” or an “Excel” resource, at some stage we may choose to “throw out” the data imported through an xls-file and import a checklist for a group in DwC-A (if this would be a more complete/trustworthy checklist for example), so there should be a mechanism to delete the data associated with a Excel/DwC-A resource and replace it by a DwC-A/Excel one (could be just creation of a new resource)._

These two modules need to be integrated in a joint interface with the following _shared components_: 
1. Resource metadata entry and edit module
2. Functions for synchronising the data imported into the FADA database/schema with the BioFresh species register table
3. Synchronise the staging database with the production database

### 3.2 General user interface
- The FADA import tool is by definition a backend tool and requires password protection. A single or fixed user/password (database managers only) should be sufficient in the framework of the current project.
- The user interface should distinguish between the two types of resources: Excel imports and DwC imports (different tab).
- The application will allow the management of data sources (Excel files and DwC-A-files).
- The import process will be independently trigger-able for each resource and associated data source .
- For each resource and associated data source a processing log will be kept, reporting at least the number of lines processed, the number of errors, status information on the processing step indicating successful completion or an error message in case of failure.
- The different import tasks have to be performed sequentially, but are actually independent tasks. The operator can stop between any of these step and resume processing at a later stage.
- During the import phase, the user will be presented with a progress bar to indicate which steps have been completed and which tasks are left.
- The previously developed Data Portal Import Tool (DPIT) uses ExtJS version 3.4, the investment of moving to a more recent version (4.2 or up) should be considered  in relation to the potential for integration with and re-use of code from the DPIT on one hand vs. the future cost of maintenance.
- General workflow: Similar to the DPIT, the FADA import tool acts on a staging database, which can easily be copied/synced with the production database. If feasible, we would opt to use the same staging database.

See the UI-screenshots-new folder for UI-mockups. The mock-up [./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg](./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg) shows the organisation of the two modules in tabs.

## 4. DwC-A processing module specifications
### 4.1 Envisaged data input format and file location
Input files for Darwin Core-Archive (DwC-A) will obviously be a zipped archive as specified by GBIF (see [here](https://code.google.com/p/gbif-ecat/wiki/DwCArchive)), but will be restricted to files with a “taxon core” and not all Darwin Core fields are intended to be imported in the database. We have selected the required fields for data exchange in the framework AquaRES and have received a sample export from VLIZ. See the [./DwC-file_processing/DwC-AquaRES_field_selection.xlsx](./DwC-file_processing/DwC-AquaRES_field_selection.xlsx) file. Selected data fields and extension files will not be mapped to the FADA database, e.g. “nomenclaturalCode” and the “vernacularName” extension. Import scripts have to be constructed. An example export from WoRMS can be provided on request.
_The DwC-A files will be posted on a web address. From our side this may be on an IPT (but these are exports from us and thus do not need to be read by the tool), but I doubt this will be the case for VLIZ. As we are still discussing this, we could of course suggest a way which would make our life easier._

### 4.2 Main processing steps
#### DwC-A specific processing
- creating resource and validating metadata (see 4.3)
- data load (see 4.4)
- validation (see 4.5)
- inject data (see 4.6)

#### Processing shared with Excel template processing (see section 6)
- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table (but ideally part of the data injection)
- propagation of changes to BioFresh species register
- synchronisation of staging and production database

### 4.3 Creating resource and validating/editing metadata
The mock-up [./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg](./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg) shows the tab for the DwC-import module. Hitting the “Add DwC-A resource should bring up a dialog to choose the concerned organism group (dropdown) and to indicate whether it concerns a new checklist (entirely new or as a (sub)group of and existing one) or an updated one. See mock-up [./UI-screenshots-new/2FADA-import_tool-mockup-create-DwC-A-resource.jpg](./UI-screenshots-new/2FADA-import_tool-mockup-create-DwC-A-resource.jpg). 
At this stage, the operator should also be able to validate that the EML metadata contains the necessary metadata for completing details in the FADA group table (check/enter for FADA specific metadata: editor, co-editor, checklist name,…). 
Once finished, the operator should be presented with an overview of the resource and the pending processing steps as in [./UI-screenshots-new/3FADA-import_tool-mockup-DwC-A-resource_created.jpg](./UI-screenshots-new/3FADA-import_tool-mockup-DwC-A-resource_created.jpg). In this window, we also envisage an “Edit resource metadata” option (along with “View import logs” and “Delete resource”) which allows the editor to edit the resource metadata at any stage. As discussed under 6.1, this metadata editor would be identical for the two modules.

### 4.4 Data load
Load data in flat taxon, speciesProfile, Reference and Distribution table in staging area.

### 4.5 Validation
#### Data in staging tables
_Note: while the validation will act on different tables and fields, and might be slightly different for the DwC-A vs. xls processing, the “business logic” and validation steps are the same, and can thus be organised in a way that the validation steps can be called by the two processing modules._
- The first “checks” are not really part of the validation process, but are rather “data cleaning’ to facilitate further processing. These modifications can be performed automatically and reported in the logs, but do not need to generate a warning or require intervention of the operator. These include;
-- Eliminate empty rows
-- Eliminate duplicate rows (keeping only first one
-- Eliminate characters ‘\n’ ‘\t’ ‘\u00A0’ and multiple blanks
-- Check for accidental use of “o” instead of “0” and vice versa. E.g. use of “o” in year (199o), use of “0” in latin-only fields (spin0sus). Replace where detected.

- Check whether mandatory fields are present (see overview of DwC-field recommendations as discussed under 4.1) - if error WARNING **mandatory field(s) missing** field_name, no further processing possible

Note: Originally the Excel overview was constructed more from the perspective of the data provider. During a discussion with Sylvain Renaudier on 6/8/15 we realised that it would not be usefull to generate warnings for every single missing field which is labeled as mandatory. This designation as “Mandatory” was therefore reviewed and updated in the Excel-file [./DwC-file_processing/DwC-AquaRES_field_selection-with_FADA_mapping-v1.1.xlsx](./DwC-file_processing/DwC-AquaRES_field_selection-with_FADA_mapping-v1.1.xlsx).

- Check whether content of fields corresponds to the expected format - if error WARNING **format error** and show line + highlight field, present dropdown menu allowing to ignore/consider empty/edit the field;
-- namePublishedInYear should be of the format 1999a, i.e. 4 digits and optionally one latin character [a-z]. The 4 digits should be >1730 and <current year + 1. 
-- The fields kingdom, family, genus, specificEpithet, infraspecificEpithet should only contain latin characters [a-z], accented characters are not permitted
-- The field subgenus should be of the form “Genus (Subgenus)”
-- The field taxonRank should correspond to the control vocabulary: “subspecies”, “varietas”, “forma”, “species”, “genus”
-- The field taxonomicStatus should correspond to the control vocabulary: “invalid”, “misapplied”, “homotypic synonym”, “accepted”
-- Check whether the field datasetID contains an URL
-- The fields isMarine, isFreshwater, isTerrestrial, isBrackish and  isExtinct, isPreferredName should contain boolean values or values that can be translated to booleans 0/1, t/f, TRUE/FALSE, y/n
-- language should correspond to the ISO 639-1 language code and countryCode should be 2-3 characters (ISO3166 alpha 2 (3 is permissable) country codes)
-- startDayOfYear and endDayOfYear should be between 1 and 365

- Checking for unique taxonIDs in taxon table - if error WARNING **non unique IDs**, show lines/list IDs, offer possibility to ignore a line or abort the import process
- Check whether acceptedNameUsageID and parentNameUsageID refer to taxonIDs present in taxon table - if error WARNING **core IDs missing from taxon table**, show lines/list IDs, offer possibility to ignore a line or abort the import process

Note: The GBIF library for processing DwC-A automatically ignores the entries in the extension files that do not match the core IDs. As this procedure also ensures the relational integrity and it would require (potentially time consuming) code forking to perform this check, we decided to skip it on 6/8/15.

- Checking whether taxonIDs/coreIDs in extension tables correspond to taxonIDs in taxon table - if error: as above
- Checking the consistency of the row, e.g.: if the “specificEpithet” field is provided, the “genus” field cannot be empty. If error WARNING **line consistency problem for** ‘taxonRank’ missing ‘higherTaxonRank’: show line and offer possibility to ignore line or edit line•. Below is a list of fields that have to be filled for a given taxon rank: 
-- 	infraspecificEpithet (taxonRank= “subspecies”, “varietas”, “forma”): specificEpithet, genus and family have to be (minimally) provided
-- 	specificEpithet (taxonRank= “species”): genus and family have to be (minimally) provided
-- genus (taxonRank= “genus”): family has to be (minimally) provided
- Check whether data for higher taxonomic levels are correctly declared; genus requires family, species requires genus, subspecies requires specificEpithet. - if error WARNING **higher taxonomy missing in input file for** taxonRank:scientificName missing taxonRank:scientificName, offer possibility to ignore or edit line
See example mock-up [./UI-screenshots-new/4FADA-import_tool-mockup-validation_format.jpg](./UI-screenshots-new/4FADA-import_tool-mockup-validation_format.jpg). The levels that have to be declared are the same as for previous check, although here it concerns the valid declaration of a specific taxonRank at line/record level. For DwC-A files this extends to the higher taxonRanks as follows (although missing content for these levels is not considered critical); 
-- family: order, class, phylum are expected
-- order: class, phylum are expected
-- class: phylum is expected
Additionally, for data provided using the Excel-template, if applicable, the intermediary taxonRanks (optional ones in square brackets) have to be checked, e.g.;
-- Subspecies: Species, [Species group], [Subgenus], Genus, [Subtribe], [Tribe], [Subfamily], Family
-- Species: [Species group], [Subgenus], Genus, [Subtribe], [Tribe], [Subfamily], Family
-- Species group: [Subgenus], Genus, [Subtribe], [Tribe], [Subfamily], Family
-- Subgenus: Genus, [Subtribe], [Tribe], [Subfamily], Family
-- …

During discussion with Sylvain on 6/8/15 we realised that the combination of record (ignore line) and field (empty, edit) level actions as envisaged in the mock-ups (Fig. 7) is not ideal and could result in potential conflicts (e.g. ignore line + edit field action for same line). As a solution, we agreed to split this up as follows; 1) report the lines with errors and the type(s) of errors per line, and offer the possibility to ignore the lines (=delete the content from the import) or act on the line = “process line” (the choice between processing individual errors on the line “as is” or act on the individual fields affected is part of step 2) and 2) provide the option to act on specific fields containing errors, providing the options ignore error, empty field and edit field.
Following this logic, the processing of the declaration errors and import conflicts also needs to be re-considered. The “line consistency errors” will be reported along with the other record level error reporting (as described in preceding sentences), while the hierarchical consistency errors require a separate interface to add the missing info (cfr. the “create from” and “create new” option in the middle pane of Fig. 7). The form for entering this info does not need to cover all DarwinCore fields, but requires most of the info from the taxon sheet to be entered/generated; _Family, Subfamily, Tribe, Subtribe, Genus, Subgenus, Species group, Species, Subspecies_ (depending on the taxonrank for which there is a hierarchical consistency error; i.e. if error is for undeclared Genus, only the rank Genus and up need to be completed), _Author(s), Date, Original genus, Original species name, Parentheses_ and _ref key_ have to be included in the form.
It was agreed that the implementation of the “validation report review” which is presented in 5 tab sheets  in Fig. 7 will be split up in 3 stages; 1) Hierarchical consistency errors (only covering the last point under 4.5 Validation), 2) Record and field level errors (itself split up in 2 steps as described earlier)  and 3) import status errors, each with its specific interface and options for dealing with the warnings/errors.
In summary, the following stages will have the processing options;
1)	Hierarchical consistency errors: ignore line, create [parent record] from [info in child record], create new [parent record]
2)	A. Record level evaluation: “Ignore/Delete” OR “Process” (the latter being the default option) B. Field level evaluation: “Ignore error” (= process “as is”), “empty” (this could also be achieved through editing of course, so if this would programmatically be easier, this option can be dropped) OR “edit”
Note: Once the report is validated, these changes will be directly be propagated at DB level on candidate DwC-A/Excel import records (delete, update…).
@Sylvain: Please let me know in case you were expecting more details “in terms of UI interaction” and “scenarios”.

#### Imported data compared to data in the database tables
Based on the groupID (entirely new group?) and (provider) taxonID/coreID > Check which data are already present in the database and compare content of fields if the provider taxonID/coreID is already present. Note that providerTaxonID is a new field that needs to be added to the database. [Aaike: note-to-self: check if sufficiently detailed elsewhere and insert reference here!]
Records can either be;
__NEW__: Alert the operator that this is new (unless it is an entirely new group - a group is considered new if no species data is associated to it. At the level of the import app, this would mean that there is no resource, either DwC-A or Excel import associated to it).
__UPDATED__: Associated information added (e.g. distribution and speciesProfile data previously not available). Alert operator, default option “Apply update”, option for operator to “ignore update” .
__POTENTIAL CONFLICT__: 
This type of error mainly applies for any name related fields including taxonID, scientificName, genus, specificEpithet, etc. covered by the next checks.
In case of errors, the operator should be presented with the options to ignore (keep former data), override (adopt new data) or edit and override (adopting newly entered data).

- Check whether records with the same provider taxonID (and resourceID or groupID) in the species and synonyms table have the same “scientificName, acceptedNameUsageID, parentNameUsageID, acceptedNameUsage, originalNameUsage, parentNameUsage, namePublishedIn, namePublishedInYear, kingdom, phylum, class, order, family, genus, subgenus, specificEpithet, infraspecificEpithet, taxonRank, scientificNameAuthorship”
Note: the resourceID is linked to the import application tables and is expected to be referenced in the groups table as a foreign key. The groups table has to be updated accordingly.
[Aaike: note-to-self: Construct overview table with DwC-terms, Excel-column names and field names in fada.species, fada.synonyms etc.]
- If the taxonID is new, check whether the “scientificName” can be found in the species or synonyms table and whether the status is “accepted” for names in the species found in the species table and “invalid” for names found in the synonyms table.
- If the scientificName is not detected, check whether the combination/concatenated names of the “genus” “specificEpithet” and “infraspecificEpithet” can be found in the species or synonyms table and whether the status is “accepted” for names in the species found in the species table and “invalid” for names found in the synonyms table.
- If the taxon/scientificName is not detected using exact matching during the 2 previous steps, repeat with phonetic matching.

- Check whether scientificNames with taxonRank =< family are new or are updated (for a new resource this should be the case, but during an update, the operator would be interested to know what’s new and what was already present in the database).

- Check whether scientificNames with taxonRank > family need to be added or are already present in the taxon table (check for conflicts) - if error WARNING **conflicting higher taxonomy**, show conflicting levels + names, provide options: ignore (keep original higher taxonomy), override (adopt new higher taxonomy) and edit and override (edit and adopt new higher taxonomy).
Currently the higher taxonomy is copied from MySQL database tables on the [annual release of the Catalogue of Life](http://www.catalogueoflife.org/annual-checklist/2015/) DVD. A more sustainable solution for this issue, using the Catalogue of Life web services should be investigated.

See example mock-up [./UI-screenshots-new/5FADA-import_tool-mockup-validation_import.jpg](./UI-screenshots-new/5FADA-import_tool-mockup-validation_import.jpg).

### 4.6 Data injection
Inject data in database tables and update biofresh_key tables. Updating the biofresh_key table requires to build an overview of the updated names (e.g spelling corrections), which need to keep their original biofresh_key, the new species, for which a new id is generated, and the deleted ones, for which the logical delete flag needs to be set. See more background details on the biofresh_key tables under 2.4.

[Sylvain-10/8/15] More details on how to:
-inject in species/synonyms/taxons tables 
-sync biofresh_key table/register 
would be great. These are complicated tasks with multiple possible scenarii based on the record import status and the actions chosen during the validation steps., the best could be to have pseudo algorithms acting on a single core record (dwca) or single excel taxon sheet line. 
[Aaike-14/08/15] Requires further discussion with Michel. My understanding that the tables need to be filled in the order taxons > species > synonyms, to allow the latter tables to reference the former.

## 5. Excel template processing
While scripts for importing data are currently available for importing Excel data, it would probably be more efficient to re-write them. Nevertheless, these scripts could provide inspiration for how to tackle specific issues. More details can be found in the “Current workflow: Excel template processing” section of an earlier version of the specifications document [FADA-import-specs.md](./FADA-import-specs.md).

### 5.1 Envisaged Excel input format
Excel-data are provided in an [excel-template](./excel-templates), for which there are currently 2 “recognised” versions. A slightly modified version (**2.1**) including the columns isFreshwater, isMarine, isTerrestrial and isBrackish will need to be prepared reflecting the planned database changes (see 2.3). While editors previously had the possibility to provide checklist data through multiple files for a single group/resource, we may choose to abort this option for simplicities sake (if necessary we can still manually join the files). 

### 5.2 Main processing steps
#### xls specific processing
- creating resource and validating metadata (see 5.3)
- checking column mapping (see 5.4)
- data load (see 5.5)
- validation (see 5.6)
- inject data (see 5.7)

#### Processing shared with DwC-A processing (see section 6)
- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table (but ideally part of the data injection)
- propagation of changes to BioFresh species register
- synchronisation of staging and production database

### 5.3 Creating resource and entering metadata
_See the UI-screenshots folder files 5 and 6 for UI-mockups_
During the creation of an Excel resource, the operator can create a resource for an organism group present in the groups table (cfr. [http://fada.biodiversity.be/group/list?current_page=groups](http://fada.biodiversity.be/group/list?current_page=groups)) or create a new (sub)group as detailed for DwC-A resources under 4.3. 
In case of an existing group for which information is currently available, the operator will be presented with a warning to highlight the fact that this resource already exists. Further processing will not create a new resource, but continue with the review of metadata and upload of an Excel file using the existing info on the resource (also allowing it to be updated). 
For a group present in the list, metadata present in the group-table will be included in the dialog and can be reviewed and completed at this stage. As the Excel-file does not contain checklist metadata, these fields will be empty and need to be filled for a new resource. With the exception of the field “co-editors”, this information is mandatory.

Note: The information on the Principal editor is stored in the users-table rather than in the groups-table. From the perspective of the import app, this means that, unless the name entered in this field exactly matches an entry in the users-table, a new user will be created. 

We propose to include file upload (from the operator’s computer) as part of resource creation. In case of file upload errors, the application should offer a retry option before closing the resource creation window and process.

Note: From a practical perspective we will split this in two stages again: 1) resource creation (only selecting the species group from a dropdown) as a separate step from 2) data download and metadata creation/upload. This roughly corresponds to Fig. 9, where the upper left dialog would represent a separate processing step.

### 5.4 Checking column mapping
The use of Excel files makes it impossible to be certain of the structure of the files that are sent to us. Contributors can make errors in data structure, field positions, start of data in excel sheets, etc. It is therefore necessary for the operator to make sure that the files comply with one of the two templates that have been agreed on. Essentially this is a check of columns and data position. The easiest solution seems a quick visual checking mechanism to validate the field mapping. This is illustrated in [./UI-screenshots/7FADA-import_tool-mockup-column_mapping.png](./UI-screenshots/7FADA-import_tool-mockup-column_mapping.png).

Note: Fig. 11 shows a multi row comparison for the visual column mapping tool. For practical reasons it was agreed (30/7/15) with Sylvain that only looking at row 3, which contains the column headers, would be sufficient. The only issue with that is that the label for RefKey is on row 2 and row 3 for this column is empty. This will be corrected in the new 2.1 template version and earlier versions of the template that are sent out before finalising this version. Nevertheless, during the check this header field is potentially empty (and should not be considered as an error).   

### 5.5 Data upload
The upload step is the reading data from Excel files and storing it in tables in a staging area.
Upload happens per group. The files to process are all located in a directory specific for the group/resource (named after the group’s name) and all loaded one by one.
The upload process looks for three sheets of data are identified based on their names, which can already be validated while checking the column mapping. Each sheet – “Taxonomy”, “Faunistic” and “References” respectively – is stored in a dedicated import table (taxa_table, distr_table, ref_table).

### 5.6 Validation
#### Data in staging tables
- For data entered in the Excel template, we do not use the notion of “mandatory fields”. Nevertheless, it would be useful to flag whether author and year are empty on specific lines. This could be flagged as **recommended data missing**: ‘year’/‘author’ not provided for line xx.
- While the data are rather different in terms of organisation, validation for **format errors** the corresponding fields is the same as 4.5.
- If present in the “References” the presence of the Refkey in the “Taxonomy” sheet has to be checked.
- As data in Excel format does not come with “Core IDs”, the appearance of the names from the “Faunistic” sheet has to be checked.
- As in 4.5, there’s a need to check the **line consistency** and wether data for **higher taxonomy is missing**. 
-- Particular for the Excel templates is that synonyms are not declared in the same format as the accepted species, but are present in dedicated columns. To be validly declared, the accepted species to which the synonym refers has to be declared on a separate line (similar to higher taxonomy levels). However, as this is a easily overlooked by the editors, I propose to implement the option to **declare species based on information on line xx** as default option.
-- Another line consistency check particular for data in the Excel-format is checking whether the “original_genus” is provided when the parentheses flag is set to “yes” and/or if “declension_species” is given. 

#### Imported data compared to data in the database tables
The validation in comparison to data already in the database is also similar to 4.5, with the exception that it cannot be done based on IDs, and can exclusively be performed through name matching.
[Note Aaike: to be double checked with Michel] This name matching is based on a concatenation of Genus, (subgenus), species, subspecies/infraspecificEpithet, author and year. I wonder whether it makes sense to have a 2 level matching, one stricter (all name elements present incl. species group and authorship details) and one less strict (only Genus + species + subspecies/infraspecificEpithet)?

### 5.7 Import
As 4.6.

## 6. Joint components
### 6.1 Resource metadata entry and edit module
Similar to metadata inspector/editor under 4.3 but including all fields from the dataset table (e.g. abstract/description) and the new ones described under 2.3.

### 6.2 Synchronise data with BioFresh species register
As a “final calculation” function, there is a need for synchronising the data imported into the FADA database/schema with the BioFresh species register table. In addition to the requirements needed for updating the biofresh_key tables, this also requires an overview of the updated “original combinations”*. In contrast to the species and synonyms, which are stored in a specific table, there is no separate table for these “original combinations”. A list has to be constructed by combining the information from the following fields; original_genus, declension_species or species (if the former is empty), year and author.

* Original combinations are “previously accepted species name” which have become “objective synonyms” because the species has been moved to another Genus. In the Halacaridae example file, the species “Halacarellus hyrcanus (Viets 1928)” has as original combination “Caspihalacarus hyrcanus Viets 1928”. For some reason, these names are not stored in the synonym table, but are only referenced through a taxonID in the species table
 
[Sylvain-10/8/15] A pseudo algorithm would be greatly welcome.
[Note Aaike] to be double checked with Michel

As mentioned under 2.4, for new species names added to the FADA database, their presence in the BioFresh species register needs to be checked (as this register can be populated through other sources) based on the group and species name matching (both exact and phonetic).

This will likely require an interface for validating the changes; (a) accept/ignore/link to existing for new entries, (b) check exact matches and accept to update “name source” to FADA, and (c) check phonetic matches and update name from FADA/add FADA name and keep name from register as synonym.

### 6.3 Synchronise the staging database with the production database
In parallel to the developments of the FADA import tools, we will work out a solution to improve the synchronisation/replication of the staging database (for both the DPIT and FADA import tool) with the production database. If successful, we will provide the code to trigger the synchronisation for use with the “sync prod DB” button in the general interface.

Note: this is not strictly part of the specifications. The production database synchronisation is indeed handled manually, nevertheless we are still looking (internally) for a better staging - sync setup to handle the database at Belspo and Gulledelle, and were wondering if the PostgreSQL replication functionality would be useful…