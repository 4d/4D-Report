  // ----------------------------------------------------
  // Object method : BALLOON_COMMON.font.style - (4D Report)
  // ID[393BE7AB15D344D99EA2B9962224AE4B]
  // Created #18-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_formEvent;$Lon_row;$Lon_styles)
C_POINTER:C301($Ptr_caller;$Ptr_me)
C_TEXT:C284($kTxt_key;$Txt_me)
C_OBJECT:C1216($Obj_caller)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5;"caller")

$kTxt_key:="fontStyle"

$Obj_caller:=JSON Parse:C1218($Ptr_caller->)

If (OB Is defined:C1231($Obj_caller))
	
	If (OB Is defined:C1231($Obj_caller;"area"))
		
		$Lon_area:=report_Get_target ($Obj_caller;->$Lon_column;->$Lon_row)
		
		  // ----------------------------------------------------
		Case of 
				
				  //______________________________________________________
			: ($Lon_formEvent=On Data Change:K2:15)
				
				$Lon_styles:=$Ptr_me->
				
				If ($Lon_styles#-1)  //disparate
					
					  //update UI
					OBJECT SET FONT STYLE:C166(*;"font.picker";$Lon_styles)
					
					If ($Lon_styles#OB Get:C1224($Obj_caller;$kTxt_key;Is longint:K8:6))
						
						  //keep value
						OB SET:C1220($Obj_caller;\
							$kTxt_key;$Lon_styles)
						
						$Ptr_caller->:=JSON Stringify:C1217($Obj_caller)
						
						  //update selection
						QR_SET_TEXT_PROPERTY ($Lon_area;qr underline:K14904:5;String:C10(Num:C11($Lon_styles>=4));$Lon_column;$Lon_row)
						
						If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
							
							If ($Lon_column=2)\
								 | ($Lon_column=3)  //apply to line
								
								$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
								QR_SET_TEXT_PROPERTY ($Lon_area;qr underline:K14904:5;String:C10(Num:C11($Lon_styles>=4));$Lon_column;$Lon_row)
								
							End if 
						End if 
						
						$Lon_styles:=Choose:C955($Lon_styles>=4;$Lon_styles-4;$Lon_styles)
						QR_SET_TEXT_PROPERTY ($Lon_area;qr italic:K14904:4;String:C10(Num:C11($Lon_styles>=2));$Lon_column;$Lon_row)
						
						If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
							
							If ($Lon_column=2)\
								 | ($Lon_column=3)  //apply to line
								
								$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
								QR_SET_TEXT_PROPERTY ($Lon_area;qr italic:K14904:4;String:C10(Num:C11($Lon_styles>=2));$Lon_column;$Lon_row)
								
							End if 
						End if 
						
						$Lon_styles:=Choose:C955($Lon_styles>=2;$Lon_styles-2;$Lon_styles)
						QR_SET_TEXT_PROPERTY ($Lon_area;qr bold:K14904:3;String:C10(Num:C11($Lon_styles=1));$Lon_column;$Lon_row)
						
						If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
							
							If ($Lon_column=2)\
								 | ($Lon_column=3)  //apply to line
								
								$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
								QR_SET_TEXT_PROPERTY ($Lon_area;qr bold:K14904:3;String:C10(Num:C11($Lon_styles=1));$Lon_column;$Lon_row)
								
							End if 
						End if 
					End if 
				End if 
				
				  //______________________________________________________
			Else 
				
				ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
				
				  //______________________________________________________
		End case 
	End if 
End if 