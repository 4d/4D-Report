//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : path_picker_SET_TEXT_ATTRIBUTE
// ID[2B2C8CB6DAEC4870A375A6DD4D11DAE9]
// Created #28-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $attribut : Text; $value : Text)

var $count_parameters : Integer
var $widget_pointer : Pointer
var $widget : Object

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters>=3)
		
		
	End if 
	
	$widget_pointer:=path_picker_Get_object($widget_name; ->$widget)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------


$widget[$attribut]:=$value

$widget_pointer->:=JSON Stringify:C1217($widget)

If ($attribut="placeHolder")
	
	EXECUTE METHOD IN SUBFORM:C1085($widget_name; "path_picker_UPDATE_UI")
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End