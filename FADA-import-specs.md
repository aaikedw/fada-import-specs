# Draft specifications FADA import tool
## Background
The Freshwater Animal Diversity Assessment (FADA) database was constructed in 2009 following the publication of a special issue in which taxonomic experts described the biodiversity of around 60 organism groups. This work was funded by Belspo and supported by the Belgian Biodiversity Platform.
The FADA initiative and its networking activities involving taxonomic experts led to a follow-up initiative in the form of the EU FP7 project BioFresh (Biodiversity of Freshwater Ecosystems: Status, Trends, Pressures, and Conservation Priorities; http://www.freshwaterbiodiversity.eu/), for  which RBINS was in charge of constructing a data portal. This project ended officially in April 2014, but we are currently (September 2014) finalising the last technical updates (including the implementation of a ‘Data Portal Import Tool’).
Since May 2014, we focus on the FADA database again through the BRAIN AquaRES (Aquatic Register Exchange and Services) project. We aim to improve the FADA database, by both streamlining the database import procedures and setting up data exchange with the World Register of Marine Species (WoRMS) and the Register of Antarctic Marine Species (RAMS). In order to implement this project we are looking to build a web application “FADA import tool” for importing data into the FADA database.
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

[option 1: atomised processing]
- upload data [need for validating field mapping in interface?]
- upload report
-- option to ignore specific lines (with errors, empty lines)
-- option to validate suspect entries (e.g. ignore lines without author info, year 1960a) / correct common errors (e.g. 196O -with letter “O” instead of 1960)
-- option to correct errors in original Excel file and re-upload the data
- input file validation
- validation report review
-- option to ignore specific errors
-- option to correct common errors (add line for species only when info is present on line to declare synonym)
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
## DwC-A processing [Early draft, to be worked out during further discussion]
### Current status
We have selected the required fields for data exchange in the framework AquaRES and have received a sample export from VLIZ. Import scripts have to be constructed.
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