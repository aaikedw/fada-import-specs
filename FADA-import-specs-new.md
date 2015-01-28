# Draft specifications FADA import tool
## Background
### Project status
## Background
### Project status
The Freshwater Animal Diversity Assessment (FADA) database was constructed in 2009 following the publication of a special issue in which taxonomic experts described the biodiversity of around 60 organism groups. This work was funded by Belspo and supported by the Belgian Biodiversity Platform.

The FADA initiative and its networking activities involving taxonomic experts led to a follow-up initiative in the form of the EU FP7 project BioFresh (Biodiversity of Freshwater Ecosystems: Status, Trends, Pressures, and Conservation Priorities; [http://www.freshwaterbiodiversity.eu/](http://www.freshwaterbiodiversity.eu/)), for  which RBINS was in charge of constructing a data portal. This project ended officially in April 2014, but we are currently (September 2014) finalising the last technical updates (including the implementation of a ‘Data Portal Import Tool’).

Since May 2014, we focus on the FADA database again through the BRAIN AquaRES (Aquatic Register Exchange and Services) project. We aim to improve the FADA database, by both streamlining the database import procedures and setting up data exchange with the World Register of Marine Species (WoRMS) and the Register of Antarctic Marine Species (RAMS). In order to implement this project, we are looking to build a web application “FADA import tool” for importing data into the FADA database.

### Database status
Currently (18/11/2014), taxonomic checklists for 16 organism groups are published on-line. In total these checklists contain around 47.000 names and thus represent almost 1/3 of the number of accepted names for freshwater animal species, which is estimated at roughly 150.000 species. 

### Organisation in groups
The organisation by organism group, corresponds to the initial organisation as was adopted for the paper publication. In fact, these groups represent an “operational unit”[^1] for which a taxonomic editor was found to produce an informed estimate of the number of known species. These organism groups may represent  different taxonomic levels, e.g. classes, orders or families.

For database purposes and/or because no taxonomic editor is found to provide a checklist for the entire group, we may subdivide the task and create a new (sub)group. While taxonomically this represents the creation of a real subgroup, we do not aim to introduce any hierarchical structure at the level of the groups themselves, as these remain “operational units” in the first place.

In terms of size, the checklist for the different groups vary from not even 100 species names to around 16.000 names for Vertebrates-Fish. Unless, at some stage we will further extend the scope at the database to non-animal freshwater groups (other than the [“Macrophytes”](http://en.wikipedia.org/wiki/Macrophyte) group, which is currently included), the total number of (accepted) species is unlikely surpass 200.000 and 16.000 for individual groups in the near future. 

[^1]: The “operational unit” can be referred to as “Group”, “Data source” or “Resource”. In this document the term “group” is used to stress the link with taxonomic unit, whereas “resource” is used when discussing the digital representation of such a group (e.g. as an ‘import unit’ and its associated file).

## Technical background
The FADA database is managed in PostgreSQL together with the BioFresh occurrence database. The FADA website and the original import scripts were developed in Ruby. The BioFresh portal was developed in the Groovy programming language, and the FADA import scripts were re-written in Groovy. For the BioFresh database, we developed an import tool for occurrence data in collaboration with an external developer (Sylvain Renaudier). In essence, the interface for the FADA import tool will be quite similar to that of the ‘Data Portal Import Tool’.

## Envisaged components of the FADA import tool
1. Excel template data entry and update interface for FADA checklists
2. Data import interface for groups provided in DwC-A format (for externally managed datasets)

_Note: either one of the two import mechanisms will be applicable for a specific group. Excel template import is the default option for our own editors, while DwC-A import is directed towards external datasets, in particular those managed in WoRMS._

## General user interface
- The FADA import tool is by definition a backend tool and requires password protection.
 -- The impact of implementing a multi-user system (access for taxonomic editors) vs. single or fixed user/password (database managers only) option needs to be discussed and reviewed. The first option would require user management through the interface. (Linked to the user table currently used for the Ruby web-interface?).
- The user interface should distinguish between the two types of resources: Excel imports and DwC imports (different tab).
- The application will allow the management of data sources (Excel files and DwC-A-files).
- The import process will be independently triggerable for each resource and associated data source .
- For each resource and associated data source a processing log will be kept, reporting at least the number of lines processed, the number of errors, status information on the processing step indicating successful completion or an error message in case of failure.
- The different import tasks have to be performed sequentially, but are actually independent tasks. The operator can stop between any of these step and resume processing at a later stage.
- During the import phase, the user will be presented with a progress bar to indicate which steps have been completed and which tasks are left.
_Note: General workflow: could use the same setup as for the DPIT with staging and production database. If so preferably using same staging db._
_Note: Use of ExtJS version to be considered/discussed. Version DPIT tool vs. envisaged version?_
_See the UI-screenshots-new folder for UI-mockups_

## DwC-A processing

### Current status
We have selected the required fields for data exchange in the framework AquaRES and have received a sample export from VLIZ. Import scripts have to be constructed.
_The DwC-A files will be posted on a web address. From our side this may be on an IPT (but these are exports from us and thus do not need to be read by the tool), but I doubt this will be the case for VLIZ. As we are still discussing this, we could of course suggest a way which would make our life easier._

### Main processing steps
- creating resource
- validate that the EML metadata contains the necessary metadata for completing details in the FADA group table (check/enter for FADA specific metadata: editor, co-editor, checklist name,…)
- data load
- validation
-- option to ignore errors
-- option to ignore specific lines (with errors)
- import data

**Shared with Excel template processing**
- (re)linking to ‘biofresh key’ tables and re-generation of genus-to-families table
- propagation of changes to BioFresh species register

### Overall interface

Mock-up: ./UI-screenshots-new/1FADA-import_tool-mockup-DwC-A-resources_overview.jpg

### Creating resource
choose group (dropdown) and indicate whether it concerns a new checklist or an updated one / + option to create a new (sub)group

Mock-up: ./UI-screenshots-new/2FADA-import_tool-mockup-create-DwC-A-resource.jpg

## Excel template processing

Re-write text from earlier specifications document.