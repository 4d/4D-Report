C_LONGINT:C283($Lon_bottom;$Lon_height;$Lon_left;$Lon_right;$Lon_top)

CALL FORM:C1391(Current form window:C827;"NQR_TOOLBAR";"tool.templates")

If (OBJECT Get visible:C1075(*;"tool.selected"))
	
	OBJECT SET VISIBLE:C603(*;"tool.selected";False:C215)
	
Else 
	
	OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object current:K67:2);$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	$Lon_height:=$Lon_bottom-$Lon_top
	
	OBJECT SET COORDINATES:C1248(*;"tool.selected";$Lon_left-3;$Lon_top-5;$Lon_right+3;$Lon_bottom)
	
	OBJECT SET VISIBLE:C603(*;"tool.selected";True:C214)
	
End if 