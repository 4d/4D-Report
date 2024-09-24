//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : mess_DISPLAY
// Database: 4D Report
// ID[93B6124780444178BBE7D302F9B13E72]
// Created #5-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($message : Object)

var $count_parameters : Integer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	// Required parameters
	
	// Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
// Adjust position
Obj_CENTER("alert.box"; "alert.mask"; Horizontally centered:K39:1)

// Show widget & mask
OBJECT SET VISIBLE:C603(*; "alert.@"; True:C214)

// Assign object to the widget
//4D_SET_OBJECT($Obj_message; "alert.box") //ACI0102649

OBJECT SET VALUE:C1742("alert.box"; $message)
// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End