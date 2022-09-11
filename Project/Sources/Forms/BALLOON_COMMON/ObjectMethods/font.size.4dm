// ----------------------------------------------------
// Object method : BALLOON_COMMON.font.size - (4D Report)
// ID[0BC4AA9F79084D179F83EB0CC1848F9A]
// Created #18-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_current; $Lon_fontSize; $Lon_formEvent; $Lon_row)
C_POINTER:C301($Ptr_caller; $Ptr_me)
C_TEXT:C284($kTxt_key; $Mnu_main; $Txt_action; $Txt_me; $Txt_size)
C_OBJECT:C1216($Obj_caller)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5; "caller")

$kTxt_key:="fontSize"

$Obj_caller:=JSON Parse:C1218($Ptr_caller->)

If (OB Is defined:C1231($Obj_caller))
	
	// ----------------------------------------------------
	Case of 
			
			//______________________________________________________
		: ($Lon_formEvent=On Clicked:K2:4)
			
			$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row)
			
			$Lon_current:=OB Get:C1224($Obj_caller; $kTxt_key)
			
			$Mnu_main:=mnu_FontSize($Lon_current)
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
			RELEASE MENU:C978($Mnu_main)
			
			Case of 
					
					//______________________________________________________
				: (Length:C16($Txt_action)=0)
					
					// nothing selected
					
					//______________________________________________________
				: ($Txt_action="fontSize_@")
					
					$Txt_size:=Delete string:C232($Txt_action; 1; 9)
					$Lon_fontSize:=Num:C11($Txt_size)
					
					//update UI
					(OBJECT Get pointer:C1124(Object named:K67:5; $Txt_me+".label"))->:=$Txt_size
					OBJECT SET FONT SIZE:C165(*; "font.picker"; $Lon_fontSize)
					
					If ($Lon_fontSize#$Lon_current)
						
						//keep value
						OB SET:C1220($Obj_caller; \
							$kTxt_key; $Lon_fontSize)
						
						$Ptr_caller->:=JSON Stringify:C1217($Obj_caller)
						
						//update selection
						QR_SET_TEXT_PROPERTY($Lon_area; qr font size:K14904:2; $Txt_size; $Lon_column; $Lon_row)
						
						If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
							
							If ($Lon_column=2)\
								 | ($Lon_column=3)  //apply to line
								
								$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
								QR_SET_TEXT_PROPERTY($Lon_area; qr font size:K14904:2; $Txt_size; $Lon_column; $Lon_row)
								
							End if 
						End if 
						
						ob_area.modified:=True:C214
						
					End if 
					
					//______________________________________________________
				Else 
					
					ASSERT:C1129(False:C215; "Unknown menu action ("+$Txt_action+")")
					
					//______________________________________________________
			End case 
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
			
			//______________________________________________________
	End case 
End if 