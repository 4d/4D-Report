// ----------------------------------------------------
// Object method : BALLOON_COMMON.border.add - (4D Report)
// Created #10-10-2019 by Adrien Cagniant
// ----------------------------------------------------
// Declarations


C_OBJECT:C1216($Obj_caller; $obj_border)
C_TEXT:C284($Txt_buffer)
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_row)
// ----------------------------------------------------
// Initialisations




$Obj_caller:=OB Copy:C1225(ob_area)

$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
$obj_border:=(OBJECT Get pointer:C1124(Object named:K67:5; "borders.controls"))->

If (Asserted:C1132(QR_is_valid_area($Lon_area)))
	
	If (($obj_border#Null:C1517))
		
		QR_SET_BORDER_PROPERTIES($Lon_area; $obj_border; $Lon_column; $Lon_row)
		
	End if 
End if 

ob_area.modified:=True:C214