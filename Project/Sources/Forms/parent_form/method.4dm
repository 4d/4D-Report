  // ----------------------------------------------------
  // Form method : test - (4D Report)
  // ID[4C5BEB9454924B158645C464796CF198]
  // Created #3-12-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_object)
C_OBJECT:C1216($Obj_buffer)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Ptr_object:=OBJECT Get pointer:C1124(Object named:K67:5;"dynamic-object")

SET TIMER:C645(0)

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 