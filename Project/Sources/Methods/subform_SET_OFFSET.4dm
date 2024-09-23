//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : subform_SET_OFFSET
// Database: 4D Report
// ID[0DB924DBB3D24F8C8701B8A010320FBC]
// Created #11-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($name : Text; $left_offset : Integer; $right_offset : Integer)

var $count_parameters : Integer
var $left; $top; $long : Integer
var $param : Object


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	
	//Optional parameters
	If ($count_parameters>=2)
		
		If ($count_parameters>=3)
			
			
		End if 
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
OBJECT GET COORDINATES:C663(*; $name; $left; $top; $long; $long)


$param:={\
left: $left+$left_offset; \
top: $top+$right_offset\
}


//Pass the values to the subform
EXECUTE METHOD IN SUBFORM:C1085($name; "subform_SET_DYNAMIC_VARIABLES"; *; $param)
CLEAR VARIABLE:C89($param)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End