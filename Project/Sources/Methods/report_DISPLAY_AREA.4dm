//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_DISPLAY_AREA
// Database: 4D Report
// ID[5400289DA9EC40CABDC7BE9D94416705]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer)

//var $1 : Integer

If (False:C215)
	C_LONGINT:C283(report_DISPLAY_AREA; $1)
End if 

var $digest : Text
var $area : Integer
var $x : Blob

// ----------------------------------------------------
// Initialisations
//$area:=$1

// ----------------------------------------------------
If ($area#0)
	
	OBJECT SET VISIBLE:C603(*; "noTableAlert"; False:C215)
	
	If (Bool:C1537(ob_area.cellEdition))
		
		// NOTHING MORE TO DO
		
	Else 
		
		QR REPORT TO BLOB:C770($area; $x)
		
		$digest:=Generate digest:C1147($x; MD5 digest:K66:1)
		
		If ($digest#String:C10(ob_area._digest))
			
			ob_area._digest:=$digest
			ob_area.modified:=True:C214
			
		End if 
		
		ob_area.area:=$area
		ob_area.reportType:=QR Get report kind:C755($area)
		
		If (ob_area.reportType=qr list report:K14902:1)
			
			report_DISPLAY_LIST($area)
			
		Else 
			
			report_DISPLAY_CROSS($area)
			
		End if 
	End if 
	
Else 
	
	OBJECT SET VISIBLE:C603(*; "noTableAlert"; True:C214)
	
	// Remove all columns
	report_DISPLAY_COMMON(New object:C1471(\
		"action"; "adjustColumnNumber"; \
		"object"; Form:C1466.areaObject; \
		"columnsNumber"; 0))
	
End if 