C_TEXT:C284($Txt_styled)

$Txt_styled:="C_BOOLÉEN"

ST SET ATTRIBUTES:C1093($Txt_styled;ST Start text:K78:15;ST End text:K78:16;\
Attribute bold style:K65:1;1)

ST SET ATTRIBUTES:C1093($Txt_styled;ST End text:K78:16;ST End text:K78:16;\
Attribute bold style:K65:1;0)

$Txt_styled:=$Txt_styled+" ( "


ST SET ATTRIBUTES:C1093($Txt_styled;Length:C16(ST Get plain text:C1092($Txt_styled));ST End text:K78:16;Attribute text color:K65:7;0x00FF0000)

ST SET TEXT:C1115($Txt_styled;"$OK_b ";ST End text:K78:16)

ST SET ATTRIBUTES:C1093($Txt_styled;Length:C16(ST Get plain text:C1092($Txt_styled));ST End text:K78:16;Attribute text color:K65:7;0x0000)

$Txt_styled:=$Txt_styled+")"

(OBJECT Get pointer:C1124(Object named:K67:5;"test"))->:=$Txt_styled
(OBJECT Get pointer:C1124(Object named:K67:5;"test1"))->:=ST Get text:C1116($Txt_styled)

ALERT:C41(ST Get text:C1116($Txt_styled))

