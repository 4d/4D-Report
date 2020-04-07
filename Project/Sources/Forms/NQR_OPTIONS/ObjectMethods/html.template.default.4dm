  // ----------------------------------------------------
  // Object method : NQR_OPTIONS.html.template.default - (4D Report)
  // ID[A64115D9CAC34C58BBFEAC10BA585CB0]
  // Created #11-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  //$Txt_me:=OBJECT Get name(Object current)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		If ($Ptr_me->=1)
			
			OBJECT SET ENABLED:C1123(*;"html.browse";False:C215)
			QR SET HTML TEMPLATE:C750(QR_area;"")
			
			ob_dialog.optionHTMLtemplate:=""
			
		Else 
			
			OBJECT SET ENABLED:C1123(*;"html.browse";True:C214)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 