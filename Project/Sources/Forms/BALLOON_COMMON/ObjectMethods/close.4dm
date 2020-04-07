  // ----------------------------------------------------
  // Object method : BALLOON_COMMON.close - (4D Report)
  // ID[FDE7C648BEB743078F785D7C43AFCC49]
  // Created #25-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me;$Ptr_subformContainer)
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
		
		$Ptr_subformContainer:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		
		If (Is nil pointer:C315($Ptr_subformContainer))
			
			CANCEL:C270
			
		Else 
			
			CALL SUBFORM CONTAINER:C1086(-2)  //close
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 