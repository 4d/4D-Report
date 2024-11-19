

var $left; $top; $right; $bottom; $height : Integer

CALL FORM:C1391(Current form window:C827; "NQR_TOOLBAR"; "tool.templates")

If (OBJECT Get visible:C1075(*; "tool.selected"))
	
	OBJECT SET VISIBLE:C603(*; "tool.selected"; False:C215)
	
Else 
	
	OBJECT GET COORDINATES:C663(*; OBJECT Get name:C1087(Object current:K67:2); $left; $top; $right; $bottom)
	$height:=$bottom-$top
	
	OBJECT SET COORDINATES:C1248(*; "tool.selected"; $left-3; $top-5; $right+3; $bottom)
	
	OBJECT SET VISIBLE:C603(*; "tool.selected"; True:C214)
	
End if 