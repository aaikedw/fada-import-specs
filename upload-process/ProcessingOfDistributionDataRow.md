# Processing of a Distribution data row
## Steps
Calculate rank of record (family, subfamily, etc)

Check if record content is consistent with rank

Check name patterns for the case of accepted name elements.
No 'ILLEGALNONAPLHA' here? Strange, maybe it should be added.
Check author field. Also corrects case when the content of 'author' is actually a publication year.

##Error messages
Rank missing error<br/>
MISSINGMSG = "Distribution element '%s' is missing" 
    
Something is wrong with taxo element content.<br/>
PATTERNBREACH = "Value '%s' of field '%s' does not match pattern '%s'"

Author content error<br/>
AUTHORNUMERIC = "'%s' value '%s' is no author name "
    
## Warning messages
WARNINGGENUSLEVEL = "Rank GENUS is suspect in this sheet "
WARNINGSUBGENUSLEVEL = "Rank SUBGENUS is suspect in this sheet "
