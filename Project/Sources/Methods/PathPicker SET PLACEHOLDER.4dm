//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker SET PLACEHOLDER
// ID[378E3848209F46F6954883C001F9F137]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $placeholder : Text)

var $count_parameters : Integer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters>=2)
		
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
path_picker_SET_TEXT_ATTRIBUTE($widget_name; "placeHolder"; $placeholder)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End