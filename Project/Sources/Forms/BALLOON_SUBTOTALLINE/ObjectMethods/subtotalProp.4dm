// ----------------------------------------------------
// Object method : BALLOON_SUBTOTALLINE.subtotalProp - (4D Report)
// Created #26-03-2019 by Adrien Cagniant
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_formEvent; $Lon_row; $lon_subtotalNumber; \
$lon_value; $lon_left; $lon_top; $lon_right; $lon_bottom; $Lon_buffer)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Mnu_main; $Txt_action; $Txt_me; $txt_unit)
C_OBJECT:C1216($Obj_caller)
C_BOOLEAN:C305($boo_isTotalSpacing)




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
			
			If ($lon_value=32000)
				
				$boo_isTotalSpacing:=False:C215
				
			Else 
				$boo_isTotalSpacing:=True:C214
				
			End if 
			
			
			$Mnu_main:=Create menu:C408
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_subtotalSpacingBreak")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "pageBreak")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11(Not:C34($boo_isTotalSpacing)))
			APPEND MENU ITEM:C411($Mnu_main; ":xliff:menu_subtotalSpacingValue")
			SET MENU ITEM PARAMETER:C1004($Mnu_main; -1; "extraSpace")
			SET MENU ITEM MARK:C208($Mnu_main; -1; Char:C90(18)*Num:C11($boo_isTotalSpacing))
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
			RELEASE MENU:C978($Mnu_main)
			
			
			
			If (Length:C16($Txt_action)>0)
				
				Case of 
						
						//______________________________________________________
					: ($Txt_action="pageBreak")
						
						QR SET TOTALS SPACING:C761($Lon_area; $lon_subtotalNumber; 32000)
						
						//update UI
						(OBJECT Get pointer:C1124(Object named:K67:5; $Txt_me+".label"))->:=Get localized string:C991("menu_subtotalSpacingBreak")
						
						OBJECT GET COORDINATES:C663(*; "subtotalProp"; $lon_left; $lon_top; $lon_right; $lon_bottom)
						OBJECT SET COORDINATES:C1248(*; "subtotalProp"; $lon_left; $lon_top; 262; $lon_bottom)
						
						OBJECT GET COORDINATES:C663(*; "subtotalProp.back"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
						OBJECT SET COORDINATES:C1248(*; "subtotalProp.back"; $lon_left; $lon_top; 263; $lon_bottom)
						
						OBJECT GET COORDINATES:C663(*; "subtotalProp.label"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
						OBJECT SET COORDINATES:C1248(*; "subtotalProp.label"; $lon_left; $lon_top; 260; $lon_bottom)
						
						OBJECT SET VISIBLE:C603(*; "totalSpacing@"; False:C215)
						
						
						
						//------------------------------------
					: ($Txt_action="extraSpace")
						
						//update UI
						(OBJECT Get pointer:C1124(Object named:K67:5; $Txt_me+".label"))->:=Get localized string:C991("menu_subtotalSpacingValue")
						
						OBJECT GET COORDINATES:C663(*; "subtotalProp"; $lon_left; $lon_top; $lon_right; $lon_bottom)
						OBJECT SET COORDINATES:C1248(*; "subtotalProp"; $lon_left; $lon_top; 193; $lon_bottom)
						
						OBJECT GET COORDINATES:C663(*; "subtotalProp.back"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
						OBJECT SET COORDINATES:C1248(*; "subtotalProp.back"; $lon_left; $lon_top; 194; $lon_bottom)
						
						OBJECT GET COORDINATES:C663(*; "subtotalProp.label"; $lon_left; $lon_top; $lon_rightNew; $lon_bottom)
						OBJECT SET COORDINATES:C1248(*; "subtotalProp.label"; $lon_left; $lon_top; 190; $lon_bottom)
						
						
						OBJECT SET VISIBLE:C603(*; "totalSpacing@"; True:C214)
						//totalSpacing.label
						//totalSpacing.popup
						//totalSpacing.back
						
						If (Not:C34(Is nil pointer:C315(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.label"))))
							(OBJECT Get pointer:C1124(Object named:K67:5; "totalSpacing.label"))->:=0
							
							QR SET TOTALS SPACING:C761($Lon_area; $lon_subtotalNumber; 0)
							
						End if 
						
				End case   //______________________________________________________
				
			End if 
			
		End if 
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 
