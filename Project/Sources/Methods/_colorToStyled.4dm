//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : _colorToStyled
// Database: 4D Report
// ID[DAE4F58313C540FA8EA472B0E217CCD9]
// Created #8-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($color : Integer)->$css_color : Text

var \
$count_parameters : Integer



If (False:C215)
	C_TEXT:C284(_colorToStyled; $0)
	C_LONGINT:C283(_colorToStyled; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($count_parameters>=1)
		
		//$Lon_color:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

$css_color:=String:C10($color; "&x")

//delete "0x"
$css_color:=Delete string:C232($css_color; 1; 2)

If (Length:C16($css_color)>6)
	
	//delete"00" from start
	$css_color:=Delete string:C232($css_color; 1; 2)
	
Else 
	
	//add "00" at the beginning
	$css_color:="00"+$css_color
	
End if 

$css_color:="#"+$css_color

// ----------------------------------------------------
// Return
//$0:=$css_color

// ----------------------------------------------------
// End