# Rules applied on fields when reading excel data
## Different checks
Excel cell type are checked. 
Anything that is not STRING, NUMERIC OR BLANK is refused 
(a date is a NUMERIC)

In "str" fields 
Eliminate characters '\n' '\t' '\u00A0'
Eliminate multiple blanks
Put any string that is one char long to null if the char is part of list [*+\-=%<>.;:?!,\/_(){}\[\]&#']

Distribution values are adapted to a/p.
Parasitic, values are upper cased and values checked
Parentheses, values are upper cased and values checked
YesNo values are adapted to capital letters and values checked
AquaticWaterDependent values are adapted to capital letters and values checked

PublicationYears are checked

##Error messages
BADPUBLICATIONYEAR = " '%d' is no valid publication year"
BADPUBLICATIONYEARSTRING = " '%s' is no valid \
publication year"
SHOULDNOTBESTRING = "CellType of type STRING \
with content : %s ???"
BADDISTRIBUTIONVALUE = "Distribution value '%s' \
is not acepted (any of pP/xX/yY/1/aA/nN/0 or empty)."
BADPARENTHESISVALUE = "Parenthesis value '%s' \
is not acepted (any of nN/yY or empty)."
BADPARASITICVALUE = "Parasitic value '%s' \
is not acepted (any of nN/yY or empty)."
BADAQUATICWDVALUE = "Aquatic water dependent value '%s' \
is not acepted (any of aA/WD/wd or empty)."
BADYESNOVALUE = "Yes/No value '%s' \
is not acepted (any of nN/yY or empty)."
BADCELLTYPE = "CellType for field %s \
is neither STRING nor NUMERIC nor BLANK"
BADCHARTXT = "Text in field '%s' \
has only one meaningless character : '%s' "
