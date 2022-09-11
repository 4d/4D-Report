// ----------------------------------------------------
// Object method : BALLOON_COMMON.border - (4D Report)
// Created #2-9-2019 by Adrien Cagniant
// ----------------------------------------------------
// Declarations

C_LONGINT:C283($Lon_area; $Lon_column; $Lon_formEvent; $Lon_row; $Lon_value)
C_POINTER:C301($Ptr_caller; $Ptr_me)
C_TEXT:C284($kTxt_key; $Txt_me)
C_OBJECT:C1216($Obj_caller; $obj_value)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5; "caller")


$Obj_caller:=JSON Parse:C1218($Ptr_caller->)

If (OB Is defined:C1231($Obj_caller))
	
	If (OB Is defined:C1231($Obj_caller; "area"))
		
		$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
		
		
		
		
		// ----------------------------------------------------
		
	End if 
End if 


If ($Lon_formEvent=On Data Change:K2:15)
	
	$obj_value:=$Ptr_me->
	
	
	If ($obj_value#Null:C1517)
		
		// do nothing, set is done when modifying border thickness or color
		//QR_SET_BORDER_PROPERTIES ($Lon_area;$obj_value;$Lon_column;$Lon_row)
		
		ob_area.modified:=True:C214
		
		
	End if 
	
End if 
