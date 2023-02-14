//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : subform_SET_TIMER
// Database: 4D Report
// ID[0D2D0ED368A54F6DA71B3B97402F8EFF]
// Created #29-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($timer : Integer)

var \
$count_parameters : Integer

If (False:C215)
	C_LONGINT:C283(subform_SET_TIMER; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//Required parameters
	
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//$timer:=$1
		
	Else 
		$timer:=-1
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

SET TIMER:C645($timer)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End