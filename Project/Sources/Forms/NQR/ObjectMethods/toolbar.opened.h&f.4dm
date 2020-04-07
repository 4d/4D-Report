  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.h&f - (4D Report)
  // ID[641F835D88F448328760E7EF06EDC65A]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_left;$Lon_right;$Lon_top;$Lon_width)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=-1)\
		 | ($Lon_formEvent=-2)  //open
		
		NQR_TOOLBAR (Choose:C955($Lon_formEvent=-1;"tool.header";"tool.footer"))
		
		  //______________________________________________________
	: ($Lon_formEvent<0)  //set coordinates
		
		$Lon_width:=Abs:C99($Lon_formEvent)
		
		OBJECT GET COORDINATES:C663(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;$Txt_me;$Lon_left;$Lon_top;$Lon_left+$Lon_width;$Lon_bottom)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 