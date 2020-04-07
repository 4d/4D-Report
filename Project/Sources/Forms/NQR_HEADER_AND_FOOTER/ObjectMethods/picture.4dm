  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.picture - (4D Report)
  // ID[F139E8C85D6F47CD85C907106397CD32]
  // Created #17-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		OBJECT SET VISIBLE:C603(*;"action.picture";True:C214)
		(OBJECT Get pointer:C1124(Object named:K67:5;"current_2"))->:=OBJECT Get name:C1087(Object current:K67:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Losing Focus:K2:8)
		
		OBJECT SET VISIBLE:C603(*;"action.picture";False:C215)
		
		  //______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)  //automatic drop
		
		GOTO OBJECT:C206(*;OBJECT Get name:C1087(Object current:K67:2))
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 