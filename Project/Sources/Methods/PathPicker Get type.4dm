//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker Get type
// ID[9B2F3EC320594A1AB1E85BC49AAEBB25]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text) : Integer

var $count_parameters; $type : Integer
var $widget : Object

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$widget_name:=$1  //Name of the widget object
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
	path_picker_Get_object($widget_name; ->$widget)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$type:=Num:C11($widget.type)

// ----------------------------------------------------
// Return
return $type  //0 = folder | 1 = document

// ----------------------------------------------------
// End