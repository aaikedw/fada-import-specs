# Draft specifications FADA import tool
## 1. General background information
### 1.1 Project status
The Freshwater Animal Diversity Assessment (FADA) database was constructed in 2009 following the publication of a special issue in which taxonomic experts described the biodiversity of around 60 organism groups. This work was funded by Belspo and supported by the Belgian Biodiversity Platform.

The FADA initiative and its networking activities involving taxonomic experts led to a follow-up initiative in the form of the EU FP7 project BioFresh (Biodiversity of Freshwater Ecosystems: Status, Trends, Pressures, and Conservation Priorities; [http://www.freshwaterbiodiversity.eu/](http://www.freshwaterbiodiversity.eu/)), for  which RBINS was in charge of constructing a data portal. This project ended officially in April 2014, but we are currently (September 2014) finalising the last technical updates (including the implementation of a ‘Data Portal Import Tool’).

Since May 2014, we focus on the FADA database again through the BRAIN AquaRES (Aquatic Register Exchange and Services) project. We aim to improve the FADA database, by both streamlining the database import procedures and setting up data exchange with the World Register of Marine Species (WoRMS) and the Register of Antarctic Marine Species (RAMS). In order to implement this project, we are looking to build a web application “FADA import tool” for importing data into the FADA database.

### 1.2 Database status 
Currently (18/11/2014), taxonomic checklists for 16 organism groups are published on-line. In total these checklists contain around 47.000 names and thus represent almost 1/3 of the number of accepted names for freshwater animal species, which is estimated at roughly 150.000 species. 

### 1.3 Organisation in groups and volumetry
The organisation by organism group, corresponds to the initial organisation as was adopted for the paper publication. In fact, these groups represent an “operational unit”[^1] for which a taxonomic editor was found to produce an informed estimate of the number of known species. These organism groups may represent  different taxonomic levels, e.g. classes, orders or families.

For database purposes and/or because no taxonomic editor is found to provide a checklist for the entire group, we may subdivide the task and create a new (sub)group. While taxonomically this represents the creation of a real subgroup, we do not aim to introduce any hierarchical structure at the level of the groups themselves, as these remain “operational units” in the first place.

In terms of size, the checklist for the different groups vary from not even 100 species names to around 16.000 names for Vertebrates-Fish. Unless, at some stage we will further extend the scope at the database to non-animal freshwater groups (other than the [“Macrophytes”](http://en.wikipedia.org/wiki/Macrophyte) group, which is currently included), which is unlikely to happen within the duration of this project, the total number of (accepted) species is unlikely surpass 200.000 and 16.000 for individual groups in the near future. 

[^1]: The “operational unit” can be referred to as “Group”, “Data source” or “Resource”. In this document the term “group” is used to stress the link with taxonomic unit, whereas “resource” is used when discussing the digital representation of such a group (e.g. as an ‘import unit’ and its associated file).

## 2. Technical background
### 2.1 Technologies used for the BioFresh and FADA database and web applications
The FADA database is managed in PostgreSQL together with the BioFresh occurrence database. The FADA website and the original import scripts were developed in Ruby. The BioFresh portal was developed in the Groovy programming language. 

### 2.2 Existing data import tools
For the BioFresh database, we developed an import tool for occurrence data in collaboration with an external developer (Sylvain Renaudier). In essence, the interface for the FADA import tool will be quite similar to that of the ‘Data Portal Import Tool’. See screenshots in the UI-screenshots folder (1-3).

For importing data into the FADA database, original Excel-file import scripts were developed in Ruby. With the exception of the  scripts for injecting the data into the database tables, the FADA import scripts were re-written in Groovy. Procedures and scripts for importing Darwin Core-Archive (DwC-A) data in FADA have to be developed.

### 2.3 FADA database structure
The FADA database structure is described at the [BioFresh-wiki](http://trac.bebif.be/wiki/BioFresh/FadaDatabaseStructure). The species register (also registry) is described at [http://trac.bebif.be/wiki/BioFresh/DatabaseStructure](http://trac.bebif.be/wiki/BioFresh/DatabaseStructure) under the heading “Organisation of the central species registry”.
**Check and update** Links between the BioFresh species register and the FADA schema are covered by the “” table where xx.id = xx.id. See more info under …

**include sql description in GitHub**

### 2.4 “biofresh keys” as persistent identifiers and the link between the FADA database and the BioFresh species register

**work out description**

## 3. Overall FADA import tool specifications

### 3.1 Envisaged components of the FADA import tool
Data for import into the FADA database will either be available in one of the following formats, which each represent a different _data import module_;
1. Data import interface for organism group-data provided in DwC-A format (for externally managed datasets, in particular those coming from WoRMS)
2. Excel template data entry and update interface for FADA checklists (default option for FADA editors)

These two modules need to be integrated in a joint interface with the following _shared components_: 
1. Resource metadata entry and edit module (but called as first step in each module)
2. Functions for synchronising the data imported into the FADA database/schema with the BioFresh species register table
3. Synchronise the staging database with the production database

### 3.2 General user interface
- The FADA import tool is by definition a backend tool and requires password protection.
 — The impact of implementing a multi-user system (access for taxonomic editors) vs. single or fixed user/password (database managers only) option needs to be discussed and reviewed. The first option would require user management through the interface. (Linked to the user table currently used for the Ruby web-interface?).
- The user interface should distinguish between the two types of resources: Excel imports and DwC imports (different tab).
- The application will allow the management of data sources (Excel files and DwC-A-files).
- The import process will be independently triggerable for each resource and associated data source .
- For each resource and associated data source a processing log will be kept, reporting at least the number of lines processed, the number of errors, status information on the processing step indicating successful completion or an error message in case of failure.
- The different import tasks have to be performed sequentially, but are actually independent tasks. The operator can stop between any of these step and resume processing at a later stage.
- During the import phase, the user will be presented with a progress bar to indicate which steps have been completed and which tasks are left.
_Note: General workflow: could use the same setup as for the DPIT with staging and production database. If so preferably using same staging db._
_Note: Use of ExtJS version to be considered/discussed. Version DPIT tool vs. envisaged version?_

See the UI-screenshots-new folder for UI-mockups. The mock-up [./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg](./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg) shows the organisation of the two modules in tabs.

## 4. DwC-A processing module specifications
### 4.1 Envisaged data input format and file location
Input files for Darwin Core-Archive (DwC-A) will obviously be a zipped archive as specified by GBIF (see [here](https://code.google.com/p/gbif-ecat/wiki/DwCArchive)), but will be restricted to files with a “taxon core” and not all Darwin Core fields are intended to be imported in the database. We have selected the required fields for data exchange in the framework AquaRES and have received a sample export from VLIZ. See the [./DwC-file_processing/DwC-AquaRES_field_selection.xlsx](./DwC-file_processing/DwC-AquaRES_field_selection.xlsx) file. Import scripts have to be constructed.
**Note-to-self: add WoRMS example from http://www.marinespecies.org/export/fada/ to GitHub**
_The DwC-A files will be posted on a web address. From our side this may be on an IPT (but these are exports from us and thus do not need to be read by the tool), but I doubt this will be the case for VLIZ. As we are still discussing this, we could of course suggest a way which would make our life easier._

### 4.2 Main processing steps
- creating resource and validating metadata (see 4.3)
- data load (see 4.4)
- validation (see 4.5)
-- option to ignore errors
-- option to ignore specific lines (with errors)
- import data

**Shared with Excel template processing**
- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table
- propagation of changes to BioFresh species register

### 4.3 Creating resource and validating/editing metadata
The mock-up [./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg](./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg) shows the tab for the DwC-import module. Hitting the “Add DwC-A resource should bring up a dialog to choose the concerned organism group (dropdown) and to indicate whether it concerns a new checklist (entirely new or as a (sub)group of and existing one) or an updated one. See mock-up [./UI-screenshots-new/2FADA-import_tool-mockup-create-DwC-A-resource.jpg](./UI-screenshots-new/2FADA-import_tool-mockup-create-DwC-A-resource.jpg). 
At this stage, the operator should also be able to validate that the EML metadata contains the necessary metadata for completing details in the FADA group table (check/enter for FADA specific metadata: editor, co-editor, checklist name,…). 
Once finished, the operator should be presented with an overview of the resource and the pending processing steps as in [./UI-screenshots-new/3FADA-import_tool-mockup-DwC-A-resource_created.jpg](./UI-screenshots-new/3FADA-import_tool-mockup-DwC-A-resource_created.jpg). In this window, we also envisage an “Edit resource metadata” option (along with “View import logs” and “Delete resource”) which allows the editor to edit the resource metadata at any stage. As discussed under 6.1, this metadata editor would be identical for the two modules.

### 4.4 Data load
Load data in flat taxon, speciesProfile, Reference and Distribution table in staging area.

### 4.5 Validation
**Data in staging table**
- Check whether mandatory fields are present (see overview of DwC-field recommendations as discussed under 4.1) - if error WARNING **mandatory field(s) missing** field_name, no further processing possible
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
-- **check for others currently in place with Michel - e.g. invalid characters?**
- Checking for unique taxonIDs in taxon table - if error WARNING **non unique IDs**, show lines/list IDs, offer possibility to ignore a line or abort the import process
- Check whether acceptedNameUsageID and parentNameUsageID refer to taxonIDs present in taxon table - if error WARNING **core IDs missing from taxon table**, show lines/list IDs, offer possibility to ignore a line or abort the import process
- Checking whether taxonIDs/coreIDs in extension tables correspond to taxonIDs in taxon table - if error: as above
- Check wether data for higher taxonomic levels is correctly declared; genus requires family, species requires genus, subspecies requires specificEpithet. - if error WARNING **higher taxonomy missing in input file for** taxonRank:scientificName missing taxonRank:scientificName, offer possibility to ignore or edit line
**[Provide visual example]**

**Imported data compared to data in the database tables**
Based on the taxonID/coreID check which data are already present in the database and compare content of fields if the provider taxonID/coreID is already present. Records can either be;
__NEW__: Alert the operator that this is new (unless it is an entirely new group).
__UPDATED__: Associated information added (e.g. distribution and speciesProfile data previously not available). Alert operator, default option “Apply update”, option for operator to “ignore update” .
__POTENTIAL CONFLICT__: 
This type of error mainly applies for any name related fields including taxonID, scientificName, genus, specificEpithet, etc. covered by the next checks.
In case of errors, the operator should be presented with the options to ignore (keep former data), override (adopt new data) or edit and override (adopting newly entered data).

- Check whether records with the same provider taxonID (and resourceID) in the species and synonyms table have the same “scientificName, acceptedNameUsageID, parentNameUsageID, acceptedNameUsage, originalNameUsage, parentNameUsage, namePublishedIn, namePublishedInYear, kingdom, phylum, class, order, family, genus, subgenus, specificEpithet, infraspecificEpithet, taxonRank, scientificNameAuthorship”

- Check whether the “scientificName” can be found in the species or synonyms table and whether the status is “accepted” for names in the species found in the species table and “invalid” for names found in the synonyms table
- Check whether the combination/concatenated names of the “genus” “specificEpithet” and “infraspecificEpithet” can be found in the species or synonyms table and whether the status is “accepted” for names in the species found in the species table and “invalid” for names found in the synonyms table

- Check whether scientificNames with taxonRank =< family are new or are updated (for a new resource this should be the case, but during an update, the operator would be interested to know what’s new and what was already present in the database).

- Check whether scientificNames with taxonRank > family need to be added or are already present in the taxon table (check for conflicts) - if error WARNING **conflicting higher taxonomy**, show conflicting levels + names, provide options: ignore (keep original higher taxonomy), override (adopt new higher taxonomy) and edit and override (edit and adopt new higher taxonomy) 
**Discuss possible mechanism for adding higher taxonomy to taxa table with Michel/Sylvain: manual entry or mechanism to update this part using Catalogue of Life web services?**

### 4.6 Data injection
Inject data in database tables and update biofresh_key tables. Updating the biofresh_key table requires to build an overview of the updated names (e.g spelling corrections), which need to keep their original biofresh_key, the new species, for which a new id is generated, and the deleted ones, for which the logical delete flag needs to be set. 
**requires more detail, also refer to 2.4**

## 5. Excel template processing

Re-write text from earlier specifications document. 
**Discuss preference with Sylvain: As separate contract or in one go?**

## 6. Joint components
### 6.1 Resource metadata entry and edit module
Similar to metadata inspector/editor under 4.3 but including all fields from the dataset table. E.g. also abstract/description.
**add list of all fields**

### 6.2 Synchronise data with BioFresh species register
As a “final calculation” function, there is a need for synchronising the data imported into the FADA database/schema with the BioFresh species register table. In addition to the requirements needed for updating the biofresh_key tables, this also requires an overview of the updated “original combinations”. In contrast to the species and synonyms, which are stored in a specific table, there is no separate table for these “original combinations”. A list has to be constructed by combining the information from the following fields; original_genus, declension_species or species (if the former is empty), year and author.
**require more details**
### 6.3 Synchronise the staging database with the production database
Need for overall solution for DPIT and FADA-import tool. Is PostgreSQL replication an option/is the synchronisation/replication triggerable? **To be discussed**