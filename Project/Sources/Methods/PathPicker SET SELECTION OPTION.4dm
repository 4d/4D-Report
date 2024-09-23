//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker SET SELECTION OPTION
// ID[353E31F11B474F3981E6DAB1BE1C3AE7]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $options : Integer)


var $count_parameters : Integer

var $widget_pointer : Pointer
var $widget : Object

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	$widget_pointer:=path_picker_Get_object($widget_name; ->$widget)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------


$widget.options:=$options

$widget_pointer->:=JSON Stringify:C1217($widget)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End