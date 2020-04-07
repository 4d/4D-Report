  // ----------------------------------------------------
  // Object method : 01_onglets.tabs - (studio.4DB)
  // Created 05/11/10 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_tabs;$Lon_formEvent;$Lon_i;$Lon_id)
C_TEXT:C284($kTxt_highlightColor;$kTxt_normalColor;$Txt_id;$Txt_me;$Txt_value)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Txt_id:=SVG Find element ID by coordinates:C1054(*;$Txt_me;MouseX;MouseY)

If ($Txt_id="b_@")
	
	$Lon_id:=Num:C11($Txt_id)
	
End if 

$kTxt_highlightColor:="dodgerblue"
$kTxt_normalColor:="dodgerblue"

$kLon_tabs:=2

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Move:K2:35)
		
		For ($Lon_i;1;$kLon_tabs;1)
			
			SVG GET ATTRIBUTE:C1056(*;$Txt_me;"t_"+String:C10($Lon_i);\
				"visibility";$Txt_value)
			
			If ($Lon_i=$Lon_id)\
				 & ($Txt_value#"visible")
				
				SVG SET ATTRIBUTE:C1055(*;$Txt_me;"l_"+String:C10($Lon_i);\
					"fill";$kTxt_highlightColor)
				
			Else 
				
				SVG SET ATTRIBUTE:C1055(*;$Txt_me;"l_"+String:C10($Lon_i);\
					"fill";Choose:C955($Txt_value="visible";$kTxt_highlightColor;$kTxt_normalColor))
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Leave:K2:34)
		
		For ($Lon_i;1;$kLon_tabs;1)
			
			SVG GET ATTRIBUTE:C1056(*;$Txt_me;"t_"+String:C10($Lon_i);\
				"visibility";$Txt_value)
			
			SVG SET ATTRIBUTE:C1055(*;$Txt_me;"l_"+String:C10($Lon_i);\
				"fill";Choose:C955($Txt_value="visible";$kTxt_highlightColor;$kTxt_normalColor))
			
		End for 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)  //goto page
		
		If ($Lon_id#0)
			
			For ($Lon_i;1;$kLon_tabs;1)
				
				If ($Lon_i=$Lon_id)
					
					SVG SET ATTRIBUTE:C1055(*;$Txt_me;"t_"+String:C10($Lon_i);\
						"visibility";"visible")
					
					SVG SET ATTRIBUTE:C1055(*;$Txt_me;"l_"+String:C10($Lon_i);\
						"font-weight";"bold";\
						"fill";$kTxt_highlightColor)
					
				Else 
					
					SVG SET ATTRIBUTE:C1055(*;$Txt_me;"t_"+String:C10($Lon_i);\
						"visibility";"hidden")
					
					SVG SET ATTRIBUTE:C1055(*;$Txt_me;"l_"+String:C10($Lon_i);\
						"font-weight";"normal";\
						"fill";$kTxt_normalColor)
					
				End if 
			End for 
			
			FORM GOTO PAGE:C247($Lon_id;*)
			GOTO OBJECT:C206(*;Choose:C955($Lon_id=1;"box.left";"height"))
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unnecessarily activated form event")
		
		  //______________________________________________________
End case 