//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONTROL_SET_COLORS
// ID[B5890476F0CF47D595E54D42B6A64A35]
// Created #17-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($highlight_color : Integer)

var $count_parameters : Integer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$highlight_color:=$count_parameters<1 ? 0x002A93FB : $highlight_color
	
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//$Lon_highlitColor:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
<>ctrl_highlitColor:=$highlight_color

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End