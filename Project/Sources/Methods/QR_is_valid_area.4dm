//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_is_valid_area
// Database: 4D Report
// ID[BCF56E509BB949CCBCD68F65609F6E88]
// Created #1-4-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_isValid)
C_LONGINT:C283($Lon_area; $Lon_parameters; $save_error)
C_TEXT:C284($Txt_buffer; $Txt_errorHandlingMethod)

If (False:C215)
	C_BOOLEAN:C305(QR_is_valid_area; $0)
	C_LONGINT:C283(QR_is_valid_area; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lon_area:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If ($Lon_area#0)
	$save_error:=ERROR
	$Txt_errorHandlingMethod:=report_catchErrors("on")
	$Txt_buffer:=QR Get HTML template:C751($Lon_area)
	report_catchErrors("off"; $Txt_errorHandlingMethod)
	
	$Boo_isValid:=(ERROR=0)
	ERROR:=$save_error
End if 

// ----------------------------------------------------
// End

$0:=$Boo_isValid