//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : NQR_SET_DESTINATION
// Database: 4D Report
// ID[BC361AE365E847C28AA606A683BA8B3A]
// Created #11-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_; $Lon_destination; $Lon_parameters)
C_TEXT:C284($Txt_specific; $Txt_templateName)

If (False:C215)
	C_LONGINT:C283(NQR_SET_DESTINATION; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Lon_destination:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 


//ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it. 
$Txt_templateName:=QR Get HTML template:C751(QR_area)
If (($Txt_templateName="") & Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517))
	$Txt_templateName:=ob_dialog.optionHTMLtemplate
End if 

// ----------------------------------------------------
QR GET DESTINATION:C756(QR_area; $Lon_; $Txt_specific)
QR SET DESTINATION:C745(QR_area; $Lon_destination; $Txt_specific)

QR SET HTML TEMPLATE:C750(QR_area; $Txt_templateName)

ob_area.modified:=True:C214

CALL SUBFORM CONTAINER:C1086(-1)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End