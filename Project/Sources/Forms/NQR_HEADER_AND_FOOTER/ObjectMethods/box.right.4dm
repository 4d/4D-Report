  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.box.right - (4D Report)
  // ID[3ECC8B588975449480C2284A489746EE]
  // Created #12-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_buton;$Lon_button;$Lon_formEvent;$Lon_x;$Lon_y)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		NQR_HEADER_AND_FOOTER_ACTION ("show")
		
		HIGHLIGHT TEXT:C210(*;OBJECT Get name:C1087(Object current:K67:2);1;MAXLONG:K35:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		GOTO OBJECT:C206(*;OBJECT Get name:C1087(Object current:K67:2))
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		GET MOUSE:C468($Lon_x;$Lon_y;$Lon_buton)
		
		NQR_HEADER_AND_FOOTER_ACTION ("hide")
		
		If ($Lon_button=0)  //key event
			
			GOTO OBJECT:C206(*;"box.left")
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 