  // ----------------------------------------------------
  // Object method : NQR_OPTIONS.html.view - (4D Report)
  // ID[2E9114EF620843BB8F3F4FBF08F37568]
  // Created #12-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Win_hdl)
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
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Win_hdl:=Open form window:C675("NQR_CODE";Sheet form window:K39:12;Horizontally centered:K39:1;Vertically centered:K39:4;*)
		SET WINDOW TITLE:C213(Get localized string:C991("HtmlTemplate");$Win_hdl)
		DIALOG:C40("NQR_CODE")
		CLOSE WINDOW:C154($Win_hdl)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 