//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : subform_SET_DYNAMIC_VARIABLES
// Database: 4D Report
// ID[AD0697EE830A493BAAF3FF510F9A35D1]
// Created #2-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($variables : Object)

var $i; $count_parameters; $type : Integer
var $target_name : Text
var $target_pointer : Pointer

ARRAY TEXT:C222($_properties; 0)



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$variables:=$1
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//<none>
		
	End if 
	
	OB GET PROPERTY NAMES:C1232($variables; $_properties)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($i; 1; Size of array:C274($_properties); 1)
	
	$target_name:=$_properties{$i}
	$target_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; $target_name)
	
	If (Not:C34(Is nil pointer:C315($target_pointer)))
		
		$type:=Type:C295($target_pointer->)
		
		$target_pointer->:=OB Get:C1224($variables; $target_name; $type)
		
	Else 
		
		ASSERT:C1129(False:C215; "unknown object: "+$target_name)
		
	End if 
End for 

// ----------------------------------------------------
// Return

//<NONE>

// ----------------------------------------------------
// End