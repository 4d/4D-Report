//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : path_picker_Get_object
// ID[54AF9A672A2847FEAE71180159E52D38]
// Created #28-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $widget : Pointer)->$widget_pointer : Pointer


var $count_parameters : Integer

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
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$widget_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "ob_widget"; $widget_name)

If (Not:C34(Is nil pointer:C315($widget_pointer)))
	
	If (Length:C16($widget_pointer->)=0)
		
		//default values
		$widget->:=path_picker_INIT
		
	Else 
		
		$widget->:=JSON Parse:C1218($widget_pointer->)
		
	End if 
	
Else 
	
	ASSERT:C1129(False:C215)
	
End if 

// ----------------------------------------------------
// Return
return $widget_pointer  //Pointer to the widget object

// ----------------------------------------------------
// End