//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker Get message
// ID[4C754CB98E0E4BE290EA0C08EF4A7DCC]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($widget_name : Text) : Text

var $count_parameters : Integer
var $message : Text
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
$message:=String:C10($widget.message)

// ----------------------------------------------------
// Return
return $message

// ----------------------------------------------------
// End