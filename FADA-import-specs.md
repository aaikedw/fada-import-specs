# Draft specifications FADA import tool
## Background
### Project status
The Freshwater Animal Diversity Assessment (FADA) database was constructed in 2009 following the publication of a special issue in which taxonomic experts described the biodiversity of around 60 organism groups. This work was funded by Belspo and supported by the Belgian Biodiversity Platform.

The FADA initiative and its networking activities involving taxonomic experts led to a follow-up initiative in the form of the EU FP7 project BioFresh (Biodiversity of Freshwater Ecosystems: Status, Trends, Pressures, and Conservation Priorities; http://www.freshwaterbiodiversity.eu/), for  which RBINS was in charge of constructing a data portal. This project ended officially in April 2014, but we are currently (September 2014) finalising the last technical updates (including the implementation of a ‘Data Portal Import Tool’).

Since May 2014, we focus on the FADA database again through the BRAIN AquaRES (Aquatic Register Exchange and Services) project. We aim to improve the FADA database, by both streamlining the database import procedures and setting up data exchange with the World Register of Marine Species (WoRMS) and the Register of Antarctic Marine Species (RAMS). In order to implement this project we are looking to build a web application “FADA import tool” for importing data into the FADA database.

### Database status
Currently (18/11/2014), taxonomic checklists for 16 organism groups are published on-line. In total these checklists contain around 47.000 names and thus represent almost 1/3 of the freshwater animal species, which is estimated at roughly 150.000 species. 

### Organisation in groups
The organisation by organism group, corresponds to the initial organisation as was adopted for the paper publication. In fact, these groups represent an “operational unit”[^1] for which a taxonomic editor was found to produce an (informed) estimate of the number of known species. These organism groups may represent  different taxonomic levels, e.g. classes, orders or families.

For database purposes and/or because no taxonomic editor is found to provide a checklist for the entire group, we may subdivide the task and create a new (sub)group. While taxonomically this represents the creation of a real subgroup, we do not aim to introduce any hierarchical structure at the level of the groups themselves, as these remain “operational units” in the first place.

In terms of size the checklist for the different groups vary from not even 100 species names to around 16.000 names for Vertebrates-Fish. Unless, at some stage we will further extend the scope at the database to non-animal freshwater groups (other than the [“Macrophytes”](http://en.wikipedia.org/wiki/Macrophyte) group which is currently included), the total number of (accepted) species is unlikely surpass 200.000 and 16.000 for individual groups in the near future. 

[^1]: The “operational unit” can be referred to as “Group”, “Data source” or “Resource”. **@Aaike - Note-to-Self: need to homogenise this throughout the document?**

## Technical background
The FADA database is managed in PostgreSQL together with the BioFresh occurrence database. The FADA website and the original import scripts were developed in Ruby. The BioFresh portal was developed in the Groovy programming language, and the FADA import scripts were re-written in Groovy. For the BioFresh database, we developed an import tool for occurrence data in collaboration with an external developer (Sylvain Renaudier). In essence, the interface for the FADA import tool will be quite similar to that of the ‘Data Portal Import Tool’ for which I include a number of screenshots in the UI-screenshots folder (1-3).

## Envisaged components of the FADA import tool
1. Excel template data entry and update interface for FADA checklists
2. Data import interface for groups provided in DwC-A format (for externally managed datasets)

_Note: either one of the two import mechanisms will be applicable for a specific group. Excel template import is the default option for our own editors, while DwC-A import is directed towards external datasets, in particular those managed in WoRMS._

## General user interface
- The FADA import tool is by definition a backend tool and requires password protection
 -- The impact of implementing a multi-user system (access for taxonomic editors) vs. single or fixed user/password (database managers only) option needs to be discussed and reviewed. The first option would require user management through the interface. (Linked to the user table currently used for the Ruby web-interface?)
- The user interface should distinguish between the two types of resources: Excel imports and DwC imports (different tab)
- The application will allow the management of data sources (Excel files and DwC-A-files)
- The import process will be independently trigger-able for each data source 
- For each data source a log will be kept
- The different import tasks have to be performed sequentially, but are actually independent tasks. The operator can stop between any of these step and resume processing at a later stage
- During the import phase, the user will be presented with a progress bar to indicate which steps have been completed and which tasks are left
_Note: General workflow: could use the same setup as for the DPIT with staging and production database. If so preferably using same staging db._
_Note: Use of ExtJS version to be considered/discussed. Version DPIT tool vs. envisaged version?_

## Current workflow: Excel template processing
### Processing steps
The workflow described here reflects the current FADA import procedure for reading of Excel files. The information in these files is processed through independent Groovy (1-3; 5)/Ruby (4) apps, which represent different processing steps as mentioned below. At present, an operator is required to check the process at each of these steps. The aim of the web-application will be to integrate these steps and add functionalities to speed up the overall processing.

1) Data upload (including line by line checking), 
2) Input file validation (including checking of relations), 
3) Import preview, 
4) Data import into normalised database tables (incl. re-linking with the ‘biofresh key’, which acts as a stable identifier) + script for re-generating genus-to-families table
5) Synchronisation with BioFresh register

Each of these steps involves a number of data quality control rules which are described in detail in the files linked below. The following paragraphs focus on the rationale for each of the steps and discusses the current implementation and potential improvements which need to be considered during the development of the web-application.
**@Aaike - Note-to-Self: Produce graph to illustrate the typical processing if errors are returned at each step**

Files detailing the business rules:
- [Rules for validation of cells read from the excel file](./upload-process/RulesOnExcelDataUpload.md)
- [Processing of taxon rows from the excel file](./upload-process/ProcessingOfTaxonDataRow.md)
- [Processing of distribution rows from the excel file](./upload-process/ProcessingOfDistributionDataRow.md)

**@Aaike - Note-to-Self - To Do:**
- compare business rules in files with what’s below
- Aaike 12/12: quickly scanned docs, probably need more detail, currently not including actual rules...
- check business rules with FauEur tool rules

### 0) Excel files: versions and anticipated database changes
#### Description of the Excel template and its versions
**@Aaike - Note-to-Self: Refer to manual, fix versions and make these available on-line (update doc with reference to the versions)**
- Needed updates (**version 2.1?**): isMarine, isTerrestrial, isBrackish flag

#### Possibility to have multiple files for a single group
**@Aaike - Note-to-Self: work out**
- How do they need to be processed? Same metadata, data just split up. Few cases…

#### Changes anticipated for AquaRES exchange
- record level timestamp
- isMarine, isTerrestrial, isBrackish flag
- “Freshwater category”
- Changes to citation data??
- Others? … **@Aaike - Note-to-Self: to be completed**

#### Changes related to expected design choices
- New staging tables: …
- How to deal with BioFresh-key tables??

The tool will import validate and prepare data in a staging area. A schema 'fadaimport' is added in the database to fit this purpose. _Note Michel: Database change – I had named this schema 'importandsyncfada' but it is a long and ugly name. The current name of the schema is 'fadaimport'_

### 1) Data upload
The use of Excel files makes it impossible to be certain of the structure of the files that are sent to us. Contributors can make errors in data structure, field positions, start of data in excel sheets, etc. It is therefore necessary for the operator to make sure that the files comply with one of the two templates that have been agreed on. Essentially this is a check of columns and data position. 
**@Aaike: Describe new functionality - Checking header rows with expected header rows through interface**

The upload step is the reading data from Excel files and storing it in tables in a staging area.

Upload happens per group. The files to process are all located in a directory specific of the group (actually named after the group's name) and all loaded one by one.
The upload process looks for three sheets of data which have specific names. To each sheet corresponds a specific storing and checking process. The data of each sheet is stored in a specific table.

During the upload each field is checked for basic errors (number, boolean, dates, empty strings, unwanted characters, use of formulas, etc) but the consistency of the row is also checked (ex : Species with no Genus part). For each row, it's rank (Family, SubFamily, ...) is calculated and added to the row data. Whatever the result the row will be stored in the work tables with the exception of : 
- Empty rows, which are ignored. 
- Duplicate rows, for which only the first element will be kept and a message for subsequent rows will be generated. 

Error messages during this step are stored in a table (**name**). The error table can store a number of errors per excel file row. 
The error data mentions :
- Which excel file has a problem
- The excel file sheet and row of the problem 
- The field which has the problem
- The nature of the problem **@Aaike - Note-to-Self: add categories**

En export of this table is provided to the operator to check whether it is safe to ignore the returned warning messages and update the original Excel file as needed.
 
Using this table through a web application will probably require adding some kind of status field for the error.
**@Aaike: Adapt Message_type field present but to be reviewed**

#### Changes in data upload to be considered during web-application development

Some fields are to be added to upload tables and error tables.
**Expected database changes (not necessarily related to upload only) - Refer to earlier**

**@Aaike - Note-to-Self: Needs further rewording, restructuring**
New error correction, replacing "O" by 0 in date fields "196Oa" => "1960a". 

Since the excel data is being stored whatever the result of the checks it makes sense to have the checks performed on the data in the tables instead of the data being loaded. This change of operations will allow corrections of database data and subsequent checks to be done straight on database data without reloading.

However this is a significant change in upload procedure. Processing the duplicates correctly might have to change.


### 2) Input file validation
Validation processes are applied to the taxonomic and distribution data that have been loaded in the staging area.

#### Validation of taxonomic data
The taxonomic data is organised in rows for declarations per taxonomic level. A row will declare the family F-A. Another row will declare a subfamily SF-A from the family F-A and so on down to the subspecies. So if a record declares species S-A of a genus G-A, there must be some record declaring the existence of the genus G-A. The validation of taxonomic data checks that all of the necessary declarations are there and generates the error messages for cases to be handled by the operator.
**Stored in a table: - errs_validation**
These types of errors require interference by the operator, but on the other hand, with the exception of author synonym information, the higher level information is replicated on the lines declaring a lower taxonomic level.
**@Aaike - Note-to-Self: Provide visual example / Example rows**

#### Changes to validation of taxonomic data
**@Aaike - Note-to-Self: reflected in UI choices? Move discussion there…**
Could a validation of taxonomic data be performed immediately after Upload?
The validation process has been designed to be executed as many times as necessary on the Upload data so a call immediately after Upload should not be problematic. Indeed one of the points of the web interface will be for the operator to be able to inject or correct records and perform the validation immediately afterwards.

#### Validation of distribution data
Distribution data is related to the species declared in taxonomic data. The validation of the distribution data makes sure that the species for which a distribution is mentioned actually exists in the species declared in the taxonomic sheet. Error messages are stored and handled by the operator.

#### Changes to validation of distribution data
**@Aaike - Note-to-Self: Example of typical error… Needs some rewording/clarification**
If any changes occur in the taxonomic data to which distribution data is linked they must be reflected in the distribution data. This will not always be easy as the link was up to now established on name comparison and was prone to errors.

Can the graphical interface help us with that?

### 3) Import preview
The preview consists of a few steps which provide a simulation of injection in the fada schema. Simulation of injection also prepares some data that will be used during injection and has greatly diminished the complexity of the Ruby code. 
_Note: If data for a group is distributed over multiple files, the Preview (and earlier processing) must be applied for all files at once in this step._

#### Checking the new authors
Authors present in the uploaded data are looked for in the fada database.
#### Changes in checking the new authors
New authors are never a problem. Authors should be inserted immediately.
**Currently done semi-manually outside of Ruby code - Import preview generates list -> used for INSERT**

#### Checking the synonyms
Checks which synonyms are new. No changes necessary except maybe adapting the code to a more grailish way.
**@Aaike - Note-to-Self: …and which ones have been removed?**

#### Checking accepted names and original genuses
In order to do this we start with building a "summary" of the data copied during upload. Actually we build a summary using the part of the uploaded data that matters in the accepted name. **Summary =! full scientific name / all info on Accepted names - unique way taxo columns A-N, lines for synonyms removed- minitaxatable (sorted on rank, name: a-z)** 
The resulting data is also ordered by rank and alphabetically which makes it easier to deal with in further processes.
Then a species tree is reconstructed and compared to what is present in the fada schema. **@Aaike - Note-to-Self: CHECK cfr. taxon table??**
At present the output of this analysis is a text file.

#### Changes in checking accepted names and original genuses
The main change is that the output of this process will be stored in the staging area.
This means new tables. The point of this is to use the stored output which mentions differences during the import step. See next step for details.

### 4) Import
**@Michel: to be written, currently in Ruby - changed using minitaxatable**
**Potential changes to be discussed: move a way from delete group data, inject and relink to stable identifier tables (the BioFesh-key ones, but use import preview info to update instead.**
**@Michel, Sylvain: Re-write of Ruby code by Michel or by Sylvain as part of outsourcing? - to be written by Sylvain**

### 5) Synchronisation with BioFresh register

_Could roughly be considered as a ‘final calculations’ step cfr. DPIT_
**@Michel, Sylvain: to be written**


### Envisaged User Interface for Excel template processing
_Note: move business rules to earlier section_
#### Group/resource metadata management
Here we should discuss whether this functionality can be (partially or fully) covered during resource creation or requires a separate metadata management module.

As mentioned under the heading “Organisation in groups”, a group may –semantically- represent a subgroup, this does not represent the need for introducing a hierarchical structure in the groups themselves.
- [new] choose group (dropdown) and indicate whether it concerns a new checklist or an updated one 
-- [new] option to create a new (sub)group and enter the group metadata

> Group metadata represents all information present in the fada schema's groups-table. Currently this information is editable through the FADA web interface and includes:
> Name	, Created, Updated	, Authorization to publish, description,  Meta data	(this field is used for the suggested citation), Principal Editor	, family name, given name, email, Co-Editors, Input file update date, Input file received	date, Input file validated	date, input file published	date, Number of species,  Distribution Level
_Note that these ‘fields’ as shown here, reflect how they are shown/called in the web interface. This has to be crosschecked with the naming in the groups table in the database._ 

It seems logic to enter these metadata at the time of the creation of a resource, unless it would represent a considerable development effort. If so, the metadata could be restricted to the name, while other metadata can still be completed/edited through the on-line web-interface.

What is more crucial however is that any processing, publication, etc. dates are currently entered manually (an thus do not necessarily represent the actual dates these processes were executed). With this new tool, the date fields should be auto-populated where possible.

#### Overall workflow
The current workflow requires frequent interaction with a scientific operator after almost each of the steps. An important consideration for planning the web-app development is to consider the impact of either keeping this “atomised approach” vs. “combined processing”.
_Note: both options still need to be evaluated in detail, but eventually one has to be chosen. At this stage I am inclined to go for option 2, but details need to be worked out._

**@Aaike - Note-to-Self: To be worked out further. Reorganised text first by step, then by option**
**Create mock-ups for each of these processing steps??**

#### Visual check of data files through the interface [new]
**@Aaike - Note-to-Self: Remove overlap with earlier mention** _Note: Currently the field mapping is purely done based on the position. Editors are not supposed to change the templates (there are 2 “recognised” versions in use), but some have done so by error or not realising the importance maintaining the original field order, so a quick visual check for comparing the header with the expected fields will always be necessary to confirm the correct mapping._
Interface showing header rows of the excel sheets which will be considered during the upload and the corresponding positional mapping.
Operator has the choice to “Proceed” with the data upload into the staging area or “Select corrected file” for upload.

**see also fada-import-specs/upload-process/MappingOfExcelSheets.txt**

#### Upload report generation
#### upload report review [as separate step in atomised approach or as part of the report review for the combined processing]
-- [auto-correct, just show report, no need to add interactive capabilities for this] option to ignore specific lines (with errors, empty lines)
-- [auto-correct or interactive?] option to validate suspect entries (e.g. ignore lines without author info, year 1960a) / correct common errors (e.g. 196O -with letter “O” instead of 1960)

-- option to correct errors in original Excel file and re-upload the data

#### input file validation report generation
#### input file validation report review [as separate step in atomised approach or as part of the report review for the combined processing]
-- option to ignore specific errors
-- option to correct common errors (add line for species only when info is present on line to declare synonym)
_Note: this would indeed require a possibility to edit species properties in a grid, however, I believe we should clearly define which fields we may want to edit through the interface and which ones we don’t (and would thus require editing in Excel). For this, we definitely need to document the most common cases. I don’t expect the need for this functionality for the DwC-A import as these data should already be validated during the import in the parent database, but it would be worthwhile to consider in case the same rules could be applied._
-- option to correct errors in original Excel file and re-upload the data [option to download file in Excel format with already committed changes during upload report review]

#### import preview report generation
#### import preview review review [as separate step in atomised approach or as part of the report review for the combined processing]
-- option “agree”
-- option to correct errors in original Excel file and re-upload the data [option to download file in Excel format with already committed changes during upload and validation report review]

#### Combined report review
-- option all-fine -> futher processing without any changes
-- option small issues - correction of (common) errors in interface
-- option “needs work on Excel file” - off-line editing and re-upload

- injection in FADA database
- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table
- propagation of changes to BioFresh species register

_Question Sylvain: -further devs?_
**@Aaike - Note-to-Self: to be clarified**  
to allow to have a package structure which fits well all code
  for example, now, only import but there should be a Web Service for VLIZ shouldn't it?_
_Answer Aaike: Not entirely sure about this question. But the exchange of the data with VLIZ is outside the scope of this tool._



## DwC-A processing [Early draft, to be worked out during further discussion]
### Current status
We have selected the required fields for data exchange in the framework AquaRES and have received a sample export from VLIZ. Import scripts have to be constructed.
_The DwC-A files will be posted on a website. From our side this may be on an IPT (but these are exports from us and thus do not need to be read by the tool), but I doubt this will be the case for VLIZ. As we are still discussing this, we could of course suggest a way which would make our life easier._
### Interface
- choose group (dropdown) and indicate whether it concerns a new checklist or an updated one / + option to create a new (sub)group
- validate EML metadata (check/enter for FADA specific metadata: editor, co-editor, checklist name,…)
- data load
- validation
-- option to ignore errors
-- option to ignore specific lines (with errors)
- import data

- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table
- propagation of changes to BioFresh species register
