  // ----------------------------------------------------
  // Object method : Table.Fields - (label-editor)
  // ID[5FD518ED72094CF5B8C12F06E151E026]
  // Created #11-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		If (Structure file:C489=Structure file:C489(*))
			
			C_QR_MASTERTABLE:=1
			
		End if 
		
		Obj_BOUND_WITH_LIST (New list:C375)
		
		  //________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		NQR_SETTING_HANDLER ("update")
		
		  //________________________________________
	: ($Lon_formEvent=On Double Clicked:K2:5)
		
		If (FORM Get current page:C276(*)=1)
			
			NQR_SETTING_HANDLER ("add_one")
			
		Else 
			
			NQR_SETTING_HANDLER ("add_cross")
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		CLEAR LIST:C377($Ptr_me->;*)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 