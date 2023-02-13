//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_cell_tips
// Database: 4D Report
// ID[DD061C7E0F3E43978C2128EDE02A7046]
// Created #8-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($label : Text) : Text

var \
$count_parameters : Integer

If (False:C215)
	C_TEXT:C284(report_cell_tips; $0)
	C_TEXT:C284(report_cell_tips; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$label:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
ST SET ATTRIBUTES:C1093($label; ST Start text:K78:15; ST End text:K78:16; \
Attribute text color:K65:7; "grey")

// ----------------------------------------------------
// Return
return $label

// ----------------------------------------------------
// End