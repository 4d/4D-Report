//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker Get option
// ID[C135460FA6414D3AA834ECC6E198CB5F]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($widget_name : Text; $option/*1 = browse button | 2 = show on disk | 3 = copy path | 4 = open item*/: Integer) : Boolean

var $count_parameters : Integer
var $enabled : Boolean
var $widget : Object


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters>=3)
		
		// <NONE>
		
	End if 
	
	path_picker_Get_object($widget_name; ->$widget)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($option>0)
	
	ARRAY TEXT:C222($tTxt_tags; 4)
	$tTxt_tags{1}:="browse"
	$tTxt_tags{2}:="showOnDisk"
	$tTxt_tags{3}:="copyPath"
	$tTxt_tags{4}:="openItem"
	
	If (OB Is defined:C1231($widget))
		
		$enabled:=Bool:C1537($widget[$tTxt_tags{$option}])
		
	End if 
End if 

// ----------------------------------------------------
// Return
return $enabled

// ----------------------------------------------------
// End