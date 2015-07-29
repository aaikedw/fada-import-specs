# Processing of a Taxon data row
## Steps
Correcting if field "genus" actually contains a "genus (subgenus)" pattern.
Content is split between two fields

Calculate rank of record (family, subfamily, etc)

Check if record content is consistent with rank
- if "species", "genus" must be present
- if "subgenus", "genus" must be present
- if "subtribe", "tribe" must be present
- if "subspecies", "genus" and "species" must be present
- "family" must always be present (So checking in case of subfamily is not necessary)
- from "genus" onwards all superior levels may be blank EXCEPT family

Fill parenthese automatically to "N" if the row describes something not in ranks [GENUS, SUBGENUS, SPECIESGROUP, SPECIES, SUBSPECIES]

Checking if declension species is only alpha and space

Check parentheses for rows describing a rank in [GENUS, SUBGENUS, SPECIESGROUP, SPECIES, SUBSPECIES]
Calculate what parentheses should be.
Compare with actual values. Issue warning if something looks wrong. 
Set value if clear but not provided by expert.

Check name patterns for the case of accepted name elements.<br/>
Check name patterns for synonym element<br/>
Check author field<br/>
Check publication year field

##Error messages
Rank missing error
MISSINGMSG = "Taxon element '%s' is missing" 

Author content error
AUTHORNUMERIC = "'%s' value '%s' is no author name "
    
## Warning messages

PARENTHESESCORRECTION = "parenthesis was empty and now set to 'Y', genus : '%s', species : '%s', original genus : '%s', declension species is : '%s'"

PARENTHESESWANRING = "user has set parenthesis to 'N' but this seems wrong, values are, genus : '%s', species : '%s', original genus : '%s', declension species : '%s'."

NOAUTHORS = "No author info."
        
NOPUBLYEAR = "No publication year info."

MOVEDTOSYNORIGINALGENUS = "Moved value to syn_original_genus "

NOT ALPHABETIC = "'%s' value '%s' is non alphabetic "

ILLEGALNONAPLHA = "'%s' value '%s' is non alphabetic or contains any of illegal characters in RExpression '%s' "
Where third %s is ".*[*+/=%<>;:?!,_(){}\[\]&#].*" 

PATTERNBREACH = "'%s' value '%s' does not match pattern '%s'"

## Other messages
IDENTICAL  = "TAXA excel rows : %d and %d are identical."
Two rows are beign considered as identical.
The second one will not be stored in DB.

BADCHAR = "Text in field '%s' has only one meaningless character : '%s' "

TOOLONG = "Text in field '%s' is longer that %d characters : '%s' "

BADDATE = "'%s is no valid publication year"