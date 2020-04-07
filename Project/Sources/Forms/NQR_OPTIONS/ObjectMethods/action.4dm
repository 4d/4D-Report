  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.action - (4D Report)
  // ID[9EB3FA452CAC41C8900232D3ED880543]
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
	: ($Lon_formEvent=On Clicked:K2:4)
		
		NQR_OPTIONS_ACTION ("menu.delimiter")
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 