  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.type - (4D Report)
  // ID[641F835D88F448328760E7EF06EDC65A]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_left;$Lon_right;$Lon_top;$Lon_width)
C_TEXT:C284($Txt_object)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=-1)\
		 | ($Lon_formEvent=-2)
		
		Self:C308->:=Abs:C99($Lon_formEvent)
		
		  //______________________________________________________
	: ($Lon_formEvent<0)
		
		$Txt_object:=OBJECT Get name:C1087(Object current:K67:2)
		$Lon_width:=Abs:C99($Lon_formEvent)
		OBJECT GET COORDINATES:C663(*;$Txt_object;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;$Txt_object;$Lon_left;$Lon_top;$Lon_left+$Lon_width;$Lon_bottom)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 