# FADA schema changes

## Changes in FADA tables
### Changes which we wanted to add for some species groups.
The integration of Simuliidae species and possibly other species group requires to add another taxonomic level we will call "species group".
This new level is situated between a subgenus and a species.
The introduction of this level required a new record in the rank table but also a reorganisation of how a species name is calculated.
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
###FADA Application
The FADA app could possibly show non aquatic species. 
If this is not desired the code of the FADA application will have to be adapted.
Is there any of this information that we would like to show in the FADA application?
Clearly the application ruby code would have to be adapted.

###BioFresh application
The BioFresh data-portal will retrieve species info from the taxonomic backbone and then be able to use the habitat type.
If the reverse capability is wished (consult taxonomic backbone only for specific of a specific habitat type), the information will have to be copied in the 
register.biofreshspeciesregistry table to allow a choice beforehand.

Another foreseable sideeffect is the change in the structure of our downloadable data. The information donwloadable on a species should be adpated to contain the same type of data that will be used in our echanges with WORMS.



