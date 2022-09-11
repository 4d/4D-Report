// ----------------------------------------------------
// Object method : BALLOON_SUBTOTALLINE.totalSpacing.unit.button - (4D Report)
// Created #26-03-2019 by Adrien Cagniant
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_formEvent; $Lon_row; $lon_subtotalNumber; $lon_value; $Lon_buffer)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Mnu_main; $Txt_action; $Txt_me; $txt_unit)
C_OBJECT:C1216($Obj_caller)
C_BOOLEAN:C305($boo_isInPoint)



// ----------------------------------------------------
// Initialisations


$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)




// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		
		If (ob_area.sortNumber>0)  // We should be in a subtotal row ... but we never know
			
			
			$Obj_caller:=JSON Parse:C1218((OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->)
			$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
			CLEAR VARIABLE:C89($Obj_caller)
			
			$lon_subtotalNumber:=ob_area.qrRow
			
			
			QR GET TOTALS SPACING:C762($Lon_area; $lon_subtotalNumber; $lon_value)
			
			If ($lon_value<0)
				
				$boo_isInPoint:=False:C215
				
			Else 
				$boo_isInPoint:=True:C214
				
			End if 
			
			
			$Mnu_main:=Create menu:C408
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_subtotalSpacingPercent")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "percent")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11(Not:C34($boo_isInPoint)))
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_subtotalSpacingPoint")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "point")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($boo_isInPoint))
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
			RELEASE MENU:C978($Mnu_main)
			
			
			$Lon_buffer:=(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.label"))->
			
			If (Length:C16($Txt_action)>0)
				
				Case of 
						
						//______________________________________________________
					: ($Txt_action="point")
						
						$lon_value:=$Lon_buffer
						$txt_unit:=Get localized string:C991("menu_subtotalSpacingPoint")
						
						//------------------------------------
					: ($Txt_action="percent")
						
						$lon_value:=-($Lon_buffer)
						//$lon_value:=-100
						$txt_unit:=Get localized string:C991("menu_subtotalSpacingPercent")
						
						//------------------------------------
				End case 
				
				QR SET TOTALS SPACING:C761($Lon_area; $lon_subtotalNumber; $lon_value)
				(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.unit.label"))->:=$txt_unit
				
				ob_area.modified:=True:C214
				
			End if 
		End if 
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 
