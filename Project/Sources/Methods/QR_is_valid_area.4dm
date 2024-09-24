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

#DECLARE($area_reference : Integer)->$is_valid : Boolean


/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$count_parameters; \
$save_error : Integer


var \
$qr_html_template; \
$save_Method_Error_Handler : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If ($area_reference#0)
	
	$save_error:=ERROR
	$save_Method_Error_Handler:=report_catchErrors("on")
	
	$qr_html_template:=QR Get HTML template:C751($area_reference)
	report_catchErrors("off"; $save_Method_Error_Handler)
	
	$is_valid:=(ERROR=0)
	
	ERROR:=$save_error
	
End if 

// ----------------------------------------------------
// End
