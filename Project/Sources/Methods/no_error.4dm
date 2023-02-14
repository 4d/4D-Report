//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : no_error
// Database: 4D Report
// ID[B0E7EB6BA3E548CA8A61ECD7CD7E88C8]
// Created #11-12-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

var \
$count_parameters : Integer


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

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End