  // ----------------------------------------------------
  // Object method : NQR.destination - (4D Report)
  // ID[C06F7D354AB5463E8FBEC2344BE84471]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=-1)
		
		  //auto-close the panel
		NQR_TOOLBAR ($Txt_me)
		
		  //update UI
		NQR_TOOLBAR ("update")
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 