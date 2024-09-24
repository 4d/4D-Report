//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONTROL_INIT
// Database: 4D Report
// ID[4BB978A40BC04CF7A232662F1C1DB82D]
// Created #17-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE()


var $count_parameters : Integer


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	var <>ctrl_inited : Boolean
	
	//Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Not:C34(<>ctrl_inited))\
 | (Shift down:C543)
	
	<>ctrl_inited:=True:C214
	<>ctrl_highlitColor:=0x0076A6E6  //0x005485C0  //0x002A93FB
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End