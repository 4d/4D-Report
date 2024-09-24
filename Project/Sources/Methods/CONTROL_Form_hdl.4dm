//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONTROL_Form_hdl
// Database: sandbox_14
// ID[2A84591689E1459E89A92122D807C6F7]
// Created #12-2-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE() : Integer

var $e : Object
var $count_parameters : Integer
var $picture : Picture



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$e:=FORM Event:C1606
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Load:K2:1)
		
		COMPILER_CONTROL
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($e.code=On Unload:K2:2)
		
		//______________________________________________________
	: ($e.code=On Timer:K2:25)
		
		If (Structure file:C489=Structure file:C489(*))\
			 & (Shift down:C543)
			
			//Create a poster for the widget
			FORM SCREENSHOT:C940($picture)
			SET PICTURE TO PASTEBOARD:C521($picture)
			
		End if 
		
		SET TIMER:C645(0)
		
		//______________________________________________________
	: ($e.code=On Bound Variable Change:K2:52)
		
		CONTROL_Area_hdl
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 

return $e.code

// ----------------------------------------------------
// End