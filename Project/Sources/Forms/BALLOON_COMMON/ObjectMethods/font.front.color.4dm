  // ----------------------------------------------------
  // Object method : BALLOON_COMMON.font.front.color - (4D Report)
  // ID[6EC7DF1FCF9748C095C285685E64410A]
  // Created #27-10-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_color;$Lon_column;$Lon_formEvent;$Lon_row)
C_POINTER:C301($Ptr_caller;$Ptr_me)
C_TEXT:C284($kTxt_key)
C_OBJECT:C1216($Obj_caller)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  //$Txt_me:=OBJECT Get name(Object current)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)
$Ptr_caller:=OBJECT Get pointer:C1124(Object named:K67:5;"caller")

$kTxt_key:="frontColor"

$Obj_caller:=JSON Parse:C1218($Ptr_caller->)

If (OB Is defined:C1231($Obj_caller))
	
	If (OB Is defined:C1231($Obj_caller;"area"))
		
		$Lon_area:=report_Get_target ($Obj_caller;->$Lon_column;->$Lon_row)
		
		  // ----------------------------------------------------
		Case of 
				
				  //______________________________________________________
			: ($Lon_formEvent=On Data Change:K2:15)
				
				$Lon_color:=$Ptr_me->
				
				If ($Lon_color#-1)  //disparate
					
					  //#ACI0093540
					  //$Lon_color:=Choose($Lon_color=0;Background color none;$Lon_color)
					$Lon_color:=Choose:C955($Lon_color=0;0x0000;$Lon_color)
					
					If ($Lon_color#OB Get:C1224($Obj_caller;$kTxt_key;Is longint:K8:6))
						
						  //keep value
						OB SET:C1220($Obj_caller;\
							$kTxt_key;$Lon_color)
						
						$Ptr_caller->:=JSON Stringify:C1217($Obj_caller)
						
						  //update selection
						QR_SET_TEXT_PROPERTY ($Lon_area;qr text color:K14904:6;String:C10($Lon_color);$Lon_column;$Lon_row)
						
						If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
							
							If ($Lon_column=2)\
								 | ($Lon_column=3)  //apply to line
								
								$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
								QR_SET_TEXT_PROPERTY ($Lon_area;qr text color:K14904:6;String:C10($Lon_color);$Lon_column;$Lon_row)
								
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