//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : _max
// Database: 4D Report
// ID[AA8C97D7EF4B43C2B33E1D64FCD71CC8]
// Created #9-11-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_REAL:C285($0)
C_REAL:C285($1)
C_REAL:C285($2)
C_REAL:C285(${3})

C_LONGINT:C283($Lon_i; $Lon_parameters)
C_REAL:C285($Num_max; $Num_value_1; $Num_value_2)

If (False:C215)
	C_REAL:C285(_max; $0)
	C_REAL:C285(_max; $1)
	C_REAL:C285(_max; $2)
	C_REAL:C285(_max; ${3})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Num_value_1:=$1
	$Num_value_2:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
	$Num_max:=$Num_value_1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 2; $Lon_parameters; 1)
	
	If (${$Lon_i}>$Num_max)
		
		$Num_max:=${$Lon_i}
		
	End if 
	
End for 

// ----------------------------------------------------
// Return
$0:=$Num_max

// ----------------------------------------------------
// End