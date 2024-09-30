//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : _max
// Database: 4D Report
// ID[AA8C97D7EF4B43C2B33E1D64FCD71CC8]
// Created #9-11-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($value_1 : Real; $value_2 : Real;  ...  : Real) : Real


var $i; $count_parameters : Integer

var $max : Real


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	
	
	//Optional parameters
	If ($count_parameters>=3)
		
		// <NONE>
		
	End if 
	
	$max:=$value_1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($i; 2; $count_parameters; 1)
	
	If (${$i}>$max)
		
		$max:=${$i}
		
	End if 
	
End for 

// ----------------------------------------------------
// Return
return $max

// ----------------------------------------------------
// End