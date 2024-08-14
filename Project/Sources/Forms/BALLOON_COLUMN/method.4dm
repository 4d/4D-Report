// ----------------------------------------------------
// Form method : BALLOON_COLUMN - (4D Report)
// ID[AE0839FF36DF46ABA43FACB47FC0849E]
// Created #25-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
var $e : Object:=FORM Event:C1606

SET TIMER:C645(0)

Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->:="{}"
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Clicked:K2:4)
		
		// Triggered for the font picker
		
		//______________________________________________________
	: ($e.code=On Activate:K2:9)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		report_BALLOON_HDL({\
			action: "update"; \
			form: Current method name:C684})
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+$e.description+")")
		
		//______________________________________________________
End case 

// Always return to the variable that allow to use the Fonts dialog to keep the sync
GOTO OBJECT:C206(*; "font.picker")