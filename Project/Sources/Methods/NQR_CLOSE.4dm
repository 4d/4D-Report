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
C_LONGINT:C283($Lon_parameters)
C_OBJECT:C1216($Obj_message)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	// NO PARAMETERS REQUIRED
	$Obj_message:=New object:C1471(\
		"src"; "quit")
	
	// Optional parameters
	If ($Lon_parameters>=1)
		
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
		
		$Obj_message.message:=Get localized string:C991("DoYouWantToSaveChangesInThisDocument")
		
		$Obj_message.checkbox:=True:C214
		$Obj_message.checkboxLabel:=Get localized string:C991("SaveInNewDocument")
		
	Else 
		
		$Obj_message.message:=Get localized string:C991("doYouWantToSaveChanges")
		
		$Obj_message.checkbox:=False:C215
		
	End if 
	
	$Obj_message.doLabel:=Get localized string:C991("save")
	$Obj_message.cancelLabel:=Get localized string:C991("cancel")
	$Obj_message.forgetLabel:=Get localized string:C991("doNotSave")
	
	mess_DISPLAY($Obj_message)
	
Else 
	
	$Obj_message.action:="none"
	
	NQR_DO_IT($Obj_message)
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End