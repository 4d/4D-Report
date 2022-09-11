// Object method : BALLOON_COMMON.border.color1 - (4D Report)
// Created #28-08-2019 by Adrien Cagniant
// ----------------------------------------------------
// Declarations

C_LONGINT:C283($Lon_formEvent; $Lon_column; $Lon_row; $Lon_area)
C_POINTER:C301($Ptr_caller; $Ptr_me; $Ptr_borders)
C_TEXT:C284($kTxt_key)
C_OBJECT:C1216($Obj_caller)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

$kTxt_key:="borderColor"


//$Txt_me:=OBJECT Get name(Object current)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5; "caller")
$Ptr_borders:=OBJECT Get pointer:C1124(Object named:K67:5; "borders.controls")

$Obj_caller:=JSON Parse:C1218($Ptr_caller->)

$kTxt_key:="borderColor"


If (OB Is defined:C1231($Obj_caller))
	
	If (OB Is defined:C1231($Obj_caller; "area"))
		
		//  $Lon_area:=report_Get_target ($Obj_caller;->$Lon_column;->$Lon_row)
		
		If (Not:C34($Ptr_borders->=Null:C1517))
			
			
			$Ptr_borders->colorToSet:=$Ptr_me->
			
			//QR_SET_BORDER_PROPERTIES ($Lon_area;$Ptr_borders->;$Lon_column;$Lon_row)
			
			ob_area.modified:=True:C214
			
		End if 
	End if 
End if 