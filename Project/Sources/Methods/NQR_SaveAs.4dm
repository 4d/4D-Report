//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_SAVEAS
// Database: 4D Report
//
// Created #18-03-2019 by Adrien Cagniant
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE()->$OK : Boolean


var $count_parameters : Integer
var $document_name : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	// NO PARAMETERS REQUIRED
	
	// Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

QR REPORT TO BLOB:C770(QR_area; C_QR_INITBLOB)

$document_name:=Select document:C905(8858; \
".4qr"; \
Localized string:C991("save_the_report_as"); \
File name entry:K24:17+Use sheet window:K24:11+Package open:K24:8)

$OK:=(OK=1)

If ($OK)
	
	C_QR_INITPATH:=DOCUMENT
	
	BLOB TO DOCUMENT:C526(C_QR_INITPATH; C_QR_INITBLOB)
	
	$OK:=(OK=1)
	
End if 

If ($OK)
	
	ob_area.modified:=False:C215
	
End if 

// ----------------------------------------------------
// Return
//$0:=$OK

// ----------------------------------------------------
// End