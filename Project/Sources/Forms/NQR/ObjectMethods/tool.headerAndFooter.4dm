  // ----------------------------------------------------
  // Object method : NQR.destination - (4D Report)
  // ID[C06F7D354AB5463E8FBEC2344BE84471]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_TEXT:C284($Txt_object)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_object:=OBJECT Get name:C1087(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=-1)
		
		NQR_TOOLBAR ($Txt_object)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		EXECUTE METHOD IN SUBFORM:C1085($Txt_object;"NQR_HEADER_AND_FOOTER_ON_RESIZE")
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 