  // ----------------------------------------------------
  // Object method : NQR.tool.templates - (4D Report)
  // ID[E7C505A8B4704EA6B0F945AF10EFA040]
  // Created #11-10-2016 by Vincent de Lachaux
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
		
		  //________________________________________
	: ($Lon_formEvent<0)  //subform call
		
		Case of 
				
				  //______________________________________________________
			: ($Lon_formEvent=-1)
				
				  //auto-close the panel
				NQR_TOOLBAR ($Txt_me)
				
				  //update UI
				NQR_TOOLBAR ("update")
				
				  //…………………………………………………………………………………………………
			Else 
				
				ASSERT:C1129(False:C215;"Unknown call from subform ("+String:C10($Lon_formEvent)+")")
				
				  //…………………………………………………………………………………………………
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 