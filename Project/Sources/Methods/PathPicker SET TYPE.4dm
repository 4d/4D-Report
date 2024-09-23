//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker SET TYPE
// ID[52DC25E150D1413BA15300A6FAC3A94F]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $path_type : Integer)

var $count_parameters : Integer
var $widget_pointer : Pointer
var $widget : Object

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	
	$path_type:=(Count parameters:C259>1) ? $path_type : Is a document:K24:1
	
	
	ASSERT:C1129(($path_type=Is a folder:K24:2) | ($path_type=Is a document:K24:1); "The value must be 0 or 1")
	
	$widget_pointer:=path_picker_Get_object($widget_name; ->$widget)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($path_type=Is a folder:K24:2) | ($path_type=Is a document:K24:1)
	
	$widget.type:=$path_type
	
	$widget_pointer->:=JSON Stringify:C1217($widget)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End