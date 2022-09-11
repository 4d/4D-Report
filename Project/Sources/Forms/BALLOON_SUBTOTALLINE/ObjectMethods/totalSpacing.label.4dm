// ----------------------------------------------------
// Object method : BALLOON_SUBTOTALLINE.totalSpacing.label - (4D Report)
// Created #03-04-2019 by Adrien Cagniant
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_formEvent; $Lon_row; $lon_subtotalNumber; $lon_value; $Lon_buffer)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me; $txt_unit)
C_OBJECT:C1216($Obj_caller)

// ----------------------------------------------------
// Initialisations


$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)


If (Shift down:C543)
	TRACE:C157
End if 


// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15) | ($Lon_formEvent=On Validate:K2:3)
		
		
		If (ob_area.sortNumber>0)  // We should be in a subtotal row ... but we never know
			
			
			$Obj_caller:=JSON Parse:C1218((OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->)
			$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
			CLEAR VARIABLE:C89($Obj_caller)
			
			$lon_subtotalNumber:=ob_area.qrRow
			
			//QR GET TOTALS SPACING($Lon_area;$lon_subtotalNumber;$lon_value)
			
			$txt_unit:=(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.unit.label"))->
			
			$Lon_buffer:=$Ptr_me->
			
			If ($txt_unit="%")
				
				$Lon_buffer:=-$Lon_buffer
				
			End if 
			
			QR SET TOTALS SPACING:C761($Lon_area; $lon_subtotalNumber; $Lon_buffer)
			
			ob_area.modified:=True:C214
			
		End if 
		
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
End case 
