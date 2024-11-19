//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_CLOSE
// Database: 4D Report
// ID[40EEE0420EC647438BF9DFE9A4D14E8C]
// Created #22-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
var $count_parameters : Integer
var $message : Object

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	// NO PARAMETERS REQUIRED
	$message:=New object:C1471("src"; "quit")
	
	// Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
// Save current report if any
If (Bool:C1537(ob_area.modified))
	
	// Keep the area
	QR REPORT TO BLOB:C770(QR_area; C_QR_INITBLOB)
	
	ob_area.message:=True:C214
	
	If (Length:C16(C_QR_INITPATH)>0)
		
		$message.message:=Localized string:C991("DoYouWantToSaveChangesInThisDocument")
		
		$message.checkbox:=True:C214
		$message.checkboxLabel:=Localized string:C991("SaveInNewDocument")
		
	Else 
		
		$message.message:=Localized string:C991("doYouWantToSaveChanges")
		
		$message.checkbox:=False:C215
		
	End if 
	
	$message.doLabel:=Localized string:C991("save")
	$message.cancelLabel:=Localized string:C991("cancel")
	$message.forgetLabel:=Localized string:C991("doNotSave")
	
	mess_DISPLAY($message)
	
Else 
	
	$message.action:="none"
	
	NQR_DO_IT($message)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End