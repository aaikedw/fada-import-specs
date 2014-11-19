# Draft specifications FADA import tool
## Background
### Project status
The Freshwater Animal Diversity Assessment (FADA) database was constructed in 2009 following the publication of a special issue in which taxonomic experts described the biodiversity of around 60 organism groups. This work was funded by Belspo and supported by the Belgian Biodiversity Platform.
The FADA initiative and its networking activities involving taxonomic experts led to a follow-up initiative in the form of the EU FP7 project BioFresh (Biodiversity of Freshwater Ecosystems: Status, Trends, Pressures, and Conservation Priorities; http://www.freshwaterbiodiversity.eu/), for  which RBINS was in charge of constructing a data portal. This project ended officially in April 2014, but we are currently (September 2014) finalising the last technical updates (including the implementation of a ‘Data Portal Import Tool’).
Since May 2014, we focus on the FADA database again through the BRAIN AquaRES (Aquatic Register Exchange and Services) project. We aim to improve the FADA database, by both streamlining the database import procedures and setting up data exchange with the World Register of Marine Species (WoRMS) and the Register of Antarctic Marine Species (RAMS). In order to implement this project we are looking to build a web application “FADA import tool” for importing data into the FADA database.
### Database status
Currently (18/11/2014), taxonomic checklists for 16 organism groups are published on-line. In total these checklists contain around 47.000 names and thus represent almost 1/3 of the freshwater animal species, which is estimated at roughly 150.000 species. 
### Organisation in groups
The organisation by organism group, corresponds to the initial organisation as was adopted for the paper publication. In fact, these groups represent an “operational unit” for which a taxonomic editor was found to produce an (informed) estimate of the number of known species. These organism groups may represent  different taxonomic levels, e.g. classes, orders or families.<br/>
For database purposes and/or because no taxonomic editor is found to provide a checklist, we may subdivide the task and create a new (sub)group. While taxonomically this represents the creation of a real subgroup, we do not aim to introduce any hierarchical structure at the level of the groups themselves, as these remain “operational units” in the first place.
In terms of size the checklist for the different groups vary from not even 100 species names to around 16.000 names for Vertebrates-Fish. Unless, at some stage we will extend the scope at the database to non-animal freshwater groups, the total number of (accepted) species is unlikely surpass 200.000 and 16.000 for individual groups. 
## Technical background
The FADA database is managed in PostgreSQL together with the BioFresh occurrence database. The FADA website and the original import scripts were developed in Ruby. The BioFresh portal was developed in the Groovy programming language, and the FADA import scripts were re-written in Groovy. For the BioFresh database, we developed an import tool for occurrence data in collaboration with an external developer (Sylvain Renaudier). In essence, the interface for the FADA import tool will be quite similar to that of the ‘Data Portal Import Tool’ for which I include a number of screenshots below.
## Components of the FADA import tool
1. Excel template data entry and update interface for FADA checklists
2. Data import interface for groups provided in DwC-A format (for externally managed datasets)
_Note: either one of the two import mechanisms will be applicable for a specific group. Excel template import is the default option for our own editors, while DwC-A import is directed towards external datasets, in particular those managed in WoRMS._
## General user interface
- The FADA import tool is by definition a backend tool and requires password protection
- The user interface should distinguish between the two types of resources: Excel imports and DwC imports (different tab)
- The application will allow the management of data sources (Excel files and DwC-A-files)
- The import process will be independently triggerable for each data source 
- For each data source a log will be kept
- The different import tasks have to be performed sequentially, but are actually independent tasks. The operator can stop between any of these step and resume processing at a later stage
- During the import phase, the user will be presented with a progress bar to indicate which steps have been completed and which tasks are left
_Note: General workflow: could use the same setup as for the DPIT with staging and production database. If so preferably using same staging db._
## Excel template processing
### Current status
- Groovy scripts for the following steps are available
1) data upload (including line by line checking), 
2) input file validation (including checking of relations), 
3) import preview, 
4) data import into normalised database tables (incl. re-linking with the ‘biofresh key’, which acts as a stable identifier) + script for re-generating genus-to-families table 
5) synchronisation with BioFresh register
- [Michel & Aaike] to be checked what needs to be improved, e.g.
-- re-write of data import in Groovy taking into account the changes detected during the import preview
-- possibility to process upload and validation (and import preview) errors in one step in interface
-- improvements to store faunistic details (incl. freshwater, terrestrial and marine flags) 
-- improvements to database structure to accommodate interface development incl. record level timestamp, history (“latest taxonomic scrutiny”)
### Interface
- [new] choose group (dropdown) and indicate whether it concerns a new checklist or an updated one 
-- [new] option to create a new (sub)group and enter the group metadata
_While semantically, a group may represent a subgroup, this does not represent the need for introducing a hierarchical structure in the groups themselves._
_Group metadata represents all information present in the fada schema's groups-table. Currently this information is editable through the FADA web interface and includes:
> Name	
> Created	
> Updated	
> Authorization to publish	
> description	
> Meta data	(this field is used for the suggested citation)
> Principal Editor	
> family name:  
> given name:  
> email:   
> Co-Editors	
> Input file update date	
> Input file received	date:    
> Input file validated	date:    
> input file published	date:    
> Number of species	
> Distribution Level

It seems logic to enter these metadata at the time of the creation of a resource, unless it would represent a considerable development effort. If so, the metadata could be restricted to the name, while other metadata can still be completed/edited through the on-line web-interface.
What is more crucial however is that any processing, publication, etc. dates are currently entered manually (an thus do not necessarily represent the actual dates these processes were executed). With this new tool, the date fields should be auto-populated where possible.
[option 1: atomised processing]
_Note: both options still need to be evaluated in detail, but eventually one has to be chosen. At this stage I am inclined to go for option 2, but details need to be worked out._
- upload data [need for validating field mapping in interface?]
_Note: Currently the mapping is purely done based on the position. Editors are not supposed to change the templates (there are 2 available), but some have done so by error or not realising the importance of the problem, so a quick visual check for comparing the header with the expected fields will always be necessary to confirm the correct mapping._
- upload report
-- option to ignore specific lines (with errors, empty lines)
-- option to validate suspect entries (e.g. ignore lines without author info, year 1960a) / correct common errors (e.g. 196O -with letter “O” instead of 1960)
-- option to correct errors in original Excel file and re-upload the data
- input file validation
- validation report review
-- option to ignore specific errors
-- option to correct common errors (add line for species only when info is present on line to declare synonym)
_Note: this would indeed require a possibility to edit species properties in a grid, however, I believe we should clearly define which fields we may want to edit through the interface and which ones we don’t (and would thus require editing in Excel). For this, we definitely need to document the most common cases. I don’t expect the need for this functionality for the DwC-A import as these data should already be validated during the import in the parent database, but it would be worthwhile to consider in case the same rules could be applied._
-- option to correct errors in original Excel file and re-upload the data [option to download file in Excel format with already committed changes during upload report review]
- import preview
- import preview review
-- option “agree”
-- option to correct errors in original Excel file and re-upload the data [option to download file in Excel format with already committed changes during upload and validation report review]

[option 2: joint processing of reports]
- upload data
- input file validation
- import preview
- overall report review
-- option all-fine -> futher processing without any changes
-- option small issues - correction of (common) errors in interface
-- option “needs work on Excel file” - off-line editing and re-upload

- injection in FADA database
- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table
- propagation of changes to BioFresh species register

_Question Sylvain: -further devs?
  to allow to have a package structure which fits well all code
  for example, now, only import but there should be a Web Service for VLIZ shouldn't it?_
_Answer Aaike: Not entirely sure about this question. But the exchange of the data with VLIZ is outside the scope of this tool._

## Current workflow
###Foreword
The workflow as mentionned reflects the current working of FADA import procedure based on the reading of Excel files and the processing of the information through independent Groovy/Ruby apps. It is divided into a number of steps which have to be checked by an operator. The point of the web-application will be to integrate theses steps and add functionalities.
### Data upload
The use of Excel files makes it impossible to be certain of the structure of the files that are sent to us. Contributors can make errors in data structure, field positions, start of data in excel sheets, etc. It is therefore necessary for the operator to make sure that the files comply with one of the two templates that have been agreed on. Essentially this is a check of columns and data position.

The upload step is the reading data from Excel files and storing it in tables in a staging area.

Upload happens per group. The files to process are all located in a directory specific of the group (actually named after the group's name) and all loaded one by one.
The upload process looks for three sheets of data which have specific names. To each sheet corresponds a specific storing and checking process. The data of each sheet is stored in a specific table. <br/>
During the upload each field is checked for basic errors (number, boolean, dates, empty strings, unwanted characters, use of formulas, etc) but the consistency of the row is also checked (ex : Species with no Genus part). For each row, it's rank (Family, SubFamily, ...) is calculated and added to the row data. Whatever the result the row will be stored in the work tables with the exception of : 
- Empty rows, which are ignored. 
- Duplicate rows, for which only the first element will be kept and a message for subsequent rows will be generated. 

Error messages during this step are stored in a table. The error table can store a number of errors per excel file row. 
The error data mentions :
- Which excel file has a problem
- The excel file row of the problem 
- The field which has the problem
- The nature of the problem 
Using this table through a web application will probably require adding some kind of status field for the error.

### Changes in data upload
Some fields are to be added to upload tables and error tables.
Mapping and processing will have to be added.
New error correction, replacing "O" by 0 in date fields "196Oa" => "1960a". 

Since the excel data is being stored whatever the result of the checks it makes sense to have the checks performed on the data in the tables instead of the data being loaded. This change of operations will allow corrections of database data and subsequent checks to be done straight on database data without reloading.

However this is a significant change in upload procedure. Processing the duplicates correctly might have to change.
### Input file validation
Validation processes are applied to the taxonomic and distribution data that have been loaded in the staging area.
####Validation of taxonomic data
The taxonomic data is organised in rows for declarations per taxonomic level. A row will declare the family F-A. Another row will declare a subfamily SF-A from the family F-A and so on down to the subspecies. So if a record declares species S-A of a genus G-A, there must be some record declaring the existence of the genus G-A. The validation of taxonomic data checks that all of the necessary declaration are there and generates the error messages for cases to be handled by the operator.
####Changes to validation of taxonomic data
Could a validation of taxonomic data be performed immediately after Upload?
The validation process has been designed to be executed as many times as necessary on the Upload data so a call immediately after Upload should not be problematic. Indeed one of the points of the web interface will be for the operator to be able to inject or correct records and perform the validation immediately afterwards.
####Validation of distribution data
Distribution data is related to the species declared in taxonomic data. The validation of the distribution data makes sure that the species for which a distribution is mentioned actually exists in the species declared in the taxonomic sheet. Error messages are stored and handled by the operator.
####Changes to validation of distribution data
If any changes occur in the taxonomic data to which distribution data is linked they must be reflected in the distribution data. This will not always be easy as the link was up to now established on name comparison and was prone to errors.<br/>
Can the graphical interface help us with that?
### Import preview
The preview consists of a few steps which provide a simulation of injection in the fada schema. Simulation of injection also prepares some data that will be used during injection and has greatly diminished the complexity of the Ruby code. The Preview must be applied to the complete content of data available for a group, data of a number of excel files of the same group will be processed in this step.
####Checking the new authors
Authors present in the uploaded data are looked for in the fada database.
####Changes in checking the new authors
New authors are never a problem. Authors should be inserted immediately.
####Checking the synonyms
Checks which synonyms are new. No changes necessary except maybe adapting the code to a more grailish way.
####Checking accepted names and original genuses
In order to do this we start with building a "summary" of the data copied during upload. Actually we build a summary using the part of the uploaded data that matters in the accepted name. The resulting data is also ordered by rank and alphabetically which makes it easier to deal with in further processes.
Then a species tree is reconstructed and compared to what is present in the fada schema.
At present the output of this analysis is a text file.
####Changes in checking accepted names and original genuses
The main change is that the output of this process will be stored in the staging area.
This means new tables. The point of this is to use the stored output which mentions differences during the import step. See next step for details.
### Import
### Synchronisation between fada and repository

### List of data validation rules and common errors to be corrected through the interface
**To be worked out**

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