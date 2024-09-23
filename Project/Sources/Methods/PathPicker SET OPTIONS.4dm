//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : PathPicker SET OPTIONS
// ID[E06B5F5E36284EB28516C73B5C393676]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $enabled : Boolean; $option/* 1 = browse button | 2 = show on disk | 3 = copy path | 4 = open item | 0 = all*/: Integer;  ...  : Integer)

var $widget_pointer : Pointer
var $widget : Object
var $i; $count_parameters; $option_number : Integer
var $_parameter : Collection

// ----------------------------------------------------


// Initialisations


$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$widget_name:=$1  //Name of the widget object
	
	//Optional parameters
	If ($count_parameters>=2)
		
		//$enabled:=$2
		
		If ($count_parameters>=3)
			
			//$option:=$3  // 1 = browse button | 2 = show on disk | 3 = copy path | 4 = open item | 0 = all
			
		End if 
	End if 
	
	$widget_pointer:=path_picker_Get_object($widget_name; ->$widget)
	
	$option_number:=4
	
	ARRAY TEXT:C222($ktTxt_tags; $option_number)
	$ktTxt_tags{1}:="browse"
	$ktTxt_tags{2}:="showOnDisk"
	$ktTxt_tags{3}:="copyPath"
	$ktTxt_tags{4}:="openItem"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($option=0)
		
		For ($i; 1; Size of array:C274($ktTxt_tags); 1)
			
			//OB SET($widget; \
				$ktTxt_tags{$i}; $enabled)
			
			
			$widget[$ktTxt_tags{$i}]:=$enabled
			
		End for 
		
		$widget_pointer->:=JSON Stringify:C1217($widget)
		
		//______________________________________________________
	Else 
		
		$_parameter:=Copy parameters:C1790
		
		For ($i; 2; $_parameter.length-1; 1)
			
			$option:=$_parameter[$i]  //${$i}
			
			If ($option<=$option_number)
				
				//OB SET($widget; \
					$ktTxt_tags{$option}; $enabled)
				
				$widget[$ktTxt_tags{$option}]:=$enabled
				
			End if 
		End for 
		
		$widget_pointer->:=JSON Stringify:C1217($widget)
		
		//______________________________________________________
End case 

//update UI
EXECUTE METHOD IN SUBFORM:C1085($widget_name; "path_picker_UPDATE_UI")

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End