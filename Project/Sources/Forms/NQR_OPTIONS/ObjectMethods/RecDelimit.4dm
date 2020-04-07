  // ----------------------------------------------------
  // Object method : NQR_OPTIONS.RecDelimit - (4D Report)
  // ID[D8C35C24795F4CF58A1A40B42939A5A3]
  // Created #28-9-2015 by Vincent de Lachaux
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
	: ($Lon_formEvent=On Data Change:K2:15)
		
		If (QR_area#0)
			
			  //#ACI0093706
			QR SET DOCUMENT PROPERTY:C772(QR_area;qr record separator:K14907:4;$Ptr_me->)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		NQR_OPTIONS_ACTION ("show")
		
		HIGHLIGHT TEXT:C210(*;$Txt_me;1;MAXLONG:K35:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		NQR_OPTIONS_ACTION ("hide")
		
		GOTO OBJECT:C206(*;"FldDelimit")
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 