// ----------------------------------------------------
// Object method : BALLOON_COMMON.font.family - (4D Report)
// ID[F370EEDE38454504A8EB44EFCC0D1056]
// Created #18-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_column; $Lon_formEvent; $Lon_row)
C_POINTER:C301($Ptr_caller; $Ptr_me)
C_TEXT:C284($kTxt_key; $Mnu_main; $Txt_action; $Txt_current; $Txt_format; $Txt_me)
C_OBJECT:C1216($Obj_caller)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5; "caller")

$kTxt_key:="columnFormat"

$Obj_caller:=JSON Parse:C1218($Ptr_caller->)

If (OB Is defined:C1231($Obj_caller))
	
	// ----------------------------------------------------
	Case of 
			
			//______________________________________________________
		: ($Lon_formEvent=On Clicked:K2:4)
			
			//#ACI0095708
			//$Lon_area:=report_Get_target ($Obj_caller;->$Lon_column;->$Lon_row)
			$Lon_area:=report_Get_target($Obj_caller; ->$Lon_column; ->$Lon_row; True:C214)
			
			$Txt_current:=OB Get:C1224($Obj_caller; $kTxt_key)
			
			$Mnu_main:=menu_format(QR_Get_column_type($Lon_area; $Lon_column); $Txt_current)
			
			$Txt_action:=Dynamic pop up menu:C1006($Mnu_main)
			RELEASE MENU:C978($Mnu_main)
			
			Case of 
					
					//______________________________________________________
				: (Length:C16($Txt_action)=0)
					
					// nothing selected
					
					//______________________________________________________
				: ($Txt_action="format_@")
					
					$Txt_format:=Delete string:C232($Txt_action; 1; 7)
					
					//update UI
					(OBJECT Get pointer:C1124(Object named:K67:5; $Txt_me+".label"))->:=Choose:C955(Length:C16($Txt_format)#0; $Txt_format; Get localized string:C991("none"))
					
					If ($Txt_format#$Txt_current)
						
						//keep value
						OB SET:C1220($Obj_caller; \
							$kTxt_key; $Txt_format)
						
						$Ptr_caller->:=JSON Stringify:C1217($Obj_caller)
						
						//update selection
						QR_SET_COLUMN_FORMAT($Lon_area; $Lon_column; $Txt_format)
						//ACI0100938
/*
If (QR Get report kind($Lon_area)=qr cross report)
																			If ($Lon_column=2)\
																						 | ($Lon_column=3)  //apply to line					
$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
QR_SET_COLUMN_FORMAT($Lon_area; $Lon_column; $Txt_format)
							
End if 
End if 
*/
					End if 
					
					ob_area.modified:=True:C214
					
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