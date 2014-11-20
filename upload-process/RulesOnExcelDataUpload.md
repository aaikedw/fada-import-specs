# Rules applied on fields when reading excel data
## Different checks
Excel cell type are checked. <br/>
Anything that is not STRING, NUMERIC OR BLANK is refused (a date is a NUMERIC)

In "str" fields <br/>
Eliminate characters '\n' '\t' '\u00A0' <br/>
Eliminate multiple blanks <br/>
Put any string that is one char long to null if the char is part of list [*+\-=%<>.;:?!,\/_(){}\[\]&#']

Distribution values are adapted to a/p. <br/>
Parasitic, values are upper cased and values are checked <br/>
Parentheses, values are upper cased and values are checked <br/>
YesNo values are adapted to capital letters and values are checked <br/>
AquaticWaterDependent values are adapted to capital letters and values are checked

PublicationYears are checked

##Error messages
BADPUBLICATIONYEAR = " '%d' is no valid publication year" <br/>
BADPUBLICATIONYEARSTRING = " '%s' is no valid publication year"<br/>
SHOULDNOTBESTRING = "CellType of type STRING with content : %s ???"<br/>
BADDISTRIBUTIONVALUE = "Distribution value '%s' is not acepted (any of pP/xX/yY/1/aA/nN/0 or empty)."<br/>
BADPARENTHESISVALUE = "Parenthesis value '%s' is not acepted (any of nN/yY or empty)."<br/>
BADPARASITICVALUE = "Parasitic value '%s' is not acepted (any of nN/yY or empty)."<br/>
BADAQUATICWDVALUE = "Aquatic water dependent value '%s' is not acepted (any of aA/WD/wd or empty)."<br/>
BADYESNOVALUE = "Yes/No value '%s' is not acepted (any of nN/yY or empty)."<br/>
BADCELLTYPE = "CellType for field %s is neither STRING nor NUMERIC nor BLANK"<br/>
BADCHARTXT = "Text in field '%s' has only one meaningless character : '%s' "
