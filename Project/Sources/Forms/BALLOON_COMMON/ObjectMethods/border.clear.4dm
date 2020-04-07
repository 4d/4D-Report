  // ----------------------------------------------------
  // Object method : BALLOON_COMMON.border.clear - (4D Report)
  // Created #10-10-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Declarations


C_OBJECT:C1216($Obj_caller;$obj_border)
C_TEXT:C284($Txt_buffer)
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_row)
  // ----------------------------------------------------
  // Initialisations



$Obj_caller:=OB Copy:C1225(ob_area)

$Lon_area:=report_Get_target ($Obj_caller;->$Lon_column;->$Lon_row)



$obj_border:=New object:C1471("bottom";New object:C1471("thickness";0;"color";0))
$obj_border.insideHorizontal:=New object:C1471("thickness";0;"color";0)
$obj_border.insideVertical:=New object:C1471("thickness";0;"color";0)
$obj_border.left:=New object:C1471("thickness";0;"color";0)
$obj_border.right:=New object:C1471("thickness";0;"color";0)
$obj_border.top:=New object:C1471("thickness";0;"color";0)

$obj_border.colorToSet:=0
$obj_border.thicknessToSet:=0

$obj_border.sameColor:=True:C214
$obj_border.sameThickness:=True:C214


If (Asserted:C1132(QR_is_valid_area ($Lon_area)))
	
	If (($obj_border#Null:C1517))
		
		QR_SET_BORDER_PROPERTIES ($Lon_area;$obj_border;$Lon_column;$Lon_row)
		
	End if 
End if 


  // color 
(OBJECT Get pointer:C1124(Object named:K67:5;"border.color1"))->:=0

  // thickness
(OBJECT Get pointer:C1124(Object named:K67:5;"border.style"))->:=1
$obj_border.thicknessToSet:=1

$Txt_buffer:=Get localized string:C991("menu_thickness"+String:C10(1))
(OBJECT Get pointer:C1124(Object named:K67:5;"border.style.label"))->:=$Txt_buffer

  // border selected
(OBJECT Get pointer:C1124(Object named:K67:5;"borders.controls"))->:=$obj_border
