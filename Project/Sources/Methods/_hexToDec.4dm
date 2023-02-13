//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : _hexToDec
// Database: 4D Report
// ID[F884C8FA4B13465E97BA16F4A332BA2B]
// Created #25-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($hexa : Text)->$int : Integer

var \
$digit; \
$i; \
$length; \
$count_parameters : Integer

If (False:C215)
	C_LONGINT:C283(_hexToDec; $0)
	C_TEXT:C284(_hexToDec; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	$length:=Length:C16($hexa)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($i; $length; 1; -1)
	
	$digit:=Position:C15($hexa[[$i]]; "0123456789ABCDEF")-1
	
	If ($digit>0)
		
		$int:=$int+(($digit)*(16^($length-$i)))
		
	End if 
	
End for 

//$0:=$int

// ----------------------------------------------------
// End