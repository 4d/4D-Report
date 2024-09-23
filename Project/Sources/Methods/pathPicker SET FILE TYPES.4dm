//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : pathPicker SET FILE TYPES
// ID[E6A6D14A18404D3DA7496CA99AB21BDD]
// Created #26-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_name : Text; $type : Text;  ...  : Text)


var $i; $count_parameters : Integer
var $_parameter : Collection

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters=2)
		
		
	Else 
		
		$_parameter:=Copy parameters:C1790
		
		For ($i; 2; $_parameter.length-1; 1)  // $type is initialized with $2 then start with 2 === 3
			
			//$type:=$type+${$i}+(";"*Num($i<$count_parameters))
			$type:=$type+";"+$_parameter[$i]
			
		End for 
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
path_picker_SET_TEXT_ATTRIBUTE($widget_name; "fileTypes"; $type)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End