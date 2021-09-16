//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_SET_ENABLED
// Database: 4D Report
// ID[A690FCAE07CF4785B5F1C914E30ECF8E]
// Created #23-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_TEXT:C284(${3})

C_BOOLEAN:C305($Boo_enabled)
C_LONGINT:C283($Lon_i; $Lon_parameters)
C_TEXT:C284($Txt_object)

If (False:C215)
	C_BOOLEAN:C305(Obj_SET_ENABLED; $1)
	C_TEXT:C284(Obj_SET_ENABLED; $2)
	C_TEXT:C284(Obj_SET_ENABLED; ${3})
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Boo_enabled:=$1
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; 2; $Lon_parameters; 1)
	
	$Txt_object:=${$Lon_i}
	OBJECT SET ENABLED:C1123(*; $Txt_object; $Boo_enabled)
	
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End