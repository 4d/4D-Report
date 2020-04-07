  // ----------------------------------------------------
  // Object method : test.Variable - (4D Report)
  // ID[21AF20738D5A49D4895F7ADF21F8A1DB]
  // Created #14-1-2015 by Vincent de Lachaux
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
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		  //ON ERR CALL("no_error")
		MESSAGES OFF:C175
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		  //ON ERR CALL("")
		MESSAGES ON:C181
		
		  //______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)
		
		If (Date:C102(String:C10($Ptr_me->))#$Ptr_me->)
			
			ALERT:C41("C'est pas bon")
			
		Else 
			
			ALERT:C41("C'est bon")
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 