  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.box.center - (4D Report)
  // ID[FE360F41910246C290EDFC4BDE29AF5D]
  // Created #12-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)

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
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		NQR_HEADER_AND_FOOTER_ACTION ("hide")
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		GOTO OBJECT:C206(*;OBJECT Get name:C1087(Object current:K67:2))
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 