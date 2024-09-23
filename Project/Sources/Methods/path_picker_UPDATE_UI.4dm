//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : path_picker_UPDATE_UI
// ID[6684F017FD004A4A90E60CEC1033E961]
// Created #28-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

var $count_parameters : Integer


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
SET TIMER:C645(-1)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End