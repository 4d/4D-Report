//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : 4D_MainProcess
// Database: 4D Report
// ID[A826F7A9634F4E96A98DC67A06A5C284]
// Created #13-8-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($processNumber : Integer) : Boolean

var \
$visible : Boolean

var \
$origin; \
$count_parameters; \
$state; \
$uid : Integer

var \
$gmt_time : Time

var \
$name : Text


If (False:C215)
	C_BOOLEAN:C305(4D_MainProcess; $0)
	C_LONGINT:C283(4D_MainProcess; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//$processNumber:=$1
		
	Else 
		
		$processNumber:=Current process:C322
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
PROCESS PROPERTIES:C336($processNumber; $name; $state; $gmt_time; $visible; $uid; $origin)

// ----------------------------------------------------
// Return
return ($origin=Main process:K36:10)

// ----------------------------------------------------
// End