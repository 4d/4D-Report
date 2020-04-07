  // ----------------------------------------------------
  // Form method : TEMPLATES - (4D Report)
  // ID[A5576B77470342A7B85362228841C742]
  // Created #5-10-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*;"subform_@";Not:C34(Is nil pointer:C315(OBJECT Get pointer:C1124(Object subform container:K67:4))))
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		CLEAR LIST:C377((OBJECT Get pointer:C1124(Object named:K67:5;"list"))->)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		template_LOAD ("list")
		GOTO OBJECT:C206(*;"list")
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Resize:K2:27)
		
		If (Selected list items:C379(*;"list")#0)
			
			template_DRAW 
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		If (Selected list items:C379(*;"list")#0)
			
			template_DRAW 
			
		Else 
			
			CLEAR VARIABLE:C89((OBJECT Get pointer:C1124(Object named:K67:5;"preview"))->)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 