//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_OPEN
// Database: 4D Report
// ID[1C46A8D8DFE04121B23AE97E5ADCEC9C]
// Created #11-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($param : Object)

//C_OBJECT($1)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_name)
C_OBJECT:C1216($Obj_in)

ARRAY TEXT:C222($tTxt_files; 0)

If (False:C215)
	C_OBJECT:C1216(NQR_OPEN; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	// NO PARAMETERS REQUIRED
	
	OK:=0
	
	// Optional parameters
	If ($Lon_parameters>=1)
		
		$Obj_in:=$param
		
		OK:=Num:C11(Length:C16(String:C10($Obj_in.target))#0)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (OK=0)
	
	// Display a standard open document dialog box
	$Txt_name:=Select document:C905(8858; \
		".4qr"; \
		Get localized string:C991("select_a_report_definition_document"); \
		Use sheet window:K24:11+Package open:K24:8)
	
Else 
	
	DOCUMENT:=String:C10($Obj_in.target)
	
End if 

If (OK=1)
	
	// Load the document
	DOCUMENT TO BLOB:C525(DOCUMENT; $Blb_buffer)
	
	If (OK=1)
		
		//LOG EVENT(Into 4D debug message; "4D report - OPEN")
		
		// Clear selection
		NQR_SET_SELECTION("none")
		
		// Keep the document path if it's not a template
		C_QR_INITPATH:=(DOCUMENT*Num:C11(Not:C34(Bool:C1537($Obj_in.template))))
		
		// Place the report in the area
		QR BLOB TO REPORT:C771(QR_area; $Blb_buffer)
		
		// Update the hash
		//NQR_DIGEST
		
		ob_area.modified:=False:C215
		
		// Update UI
		NQR_TOOLBAR("update")
		
		NQR_AREA_HANDLE(New object:C1471("action"; "update"))
		
	End if 
End if 