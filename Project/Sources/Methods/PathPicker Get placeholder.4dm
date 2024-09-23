//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker Get placeholder
// ID[A2986B83A2154D3A83FD6B49AD7D340F]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text) : Text

var $count_parameters : Integer
var $placeholder : Text
var $widget : Object


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
	path_picker_Get_object($widget_name; ->$widget)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$placeholder:=String:C10($widget.placeHolder)


// ----------------------------------------------------
// Return
return $placeholder

// ----------------------------------------------------
// End