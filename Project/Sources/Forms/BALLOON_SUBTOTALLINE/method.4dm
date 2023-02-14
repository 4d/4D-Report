// ----------------------------------------------------
// Form method : BALLOON_SUBTOTALLINE - (4D Report)
//  // Created #28-03-2019 by Adrien cagniant
// ----------------------------------------------------
// Declarations

var \
$form_event; \
$parameter : Object


// ----------------------------------------------------
// Initialisations
$form_event:=FORM Event:C1606
SET TIMER:C645(0)

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($form_event.code=On Load:K2:1)
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->:="{}"
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($form_event.code=On Clicked:K2:4)
		
		//triggered for the font picker
		
		//______________________________________________________
	: ($form_event.code=On Activate:K2:9)
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($form_event.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$parameter:=New object:C1471(\
			"action"; "update"; \
			"form"; Current method name:C684)
		
		report_BALLOON_HDL($parameter)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($form_event.code)+")")
		
		//______________________________________________________
End case 

//Always return to the variable that allow to use the Fonts dialog to keep the sync
//GOTO OBJECT(*;"font.picker")