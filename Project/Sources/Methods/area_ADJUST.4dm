//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : area_ADJUST
// Database: 4D Report
// ID[35F464BA350A4BBDBC8ACDFBFEE1FF93]
// Created #13-11-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Updates the area's coordinates & the filling
// According to the size of the container subform
// ----------------------------------------------------
// Declarations
var $horizontal; $vertical : Boolean
var $bottom; $dummy; $height; $left; $right; $rowNumber : Integer
var $top; $width : Integer

// ----------------------------------------------------
// Initialisations
OBJECT GET SUBFORM CONTAINER SIZE:C1148($width; $height)
$rowNumber:=LISTBOX Get number of rows:C915(*; Form:C1466.areaObject)

// ----------------------------------------------------
// Restore grid
LISTBOX SET GRID:C841(*; Form:C1466.areaObject; True:C214; True:C214)

// Set the listbox coordinates
OBJECT SET COORDINATES:C1248(*; Form:C1466.areaObject; 0; 0; $width; $height)

// Calculate the corrected area coordinates with the scrollbar widths
OBJECT GET SCROLLBAR:C1076(*; Form:C1466.areaObject; $horizontal; $vertical)
$width:=$width-(LISTBOX Get property:C917(*; Form:C1466.areaObject; lk ver scrollbar width:K53:9)*Num:C11($vertical))
$height:=$height-(LISTBOX Get property:C917(*; Form:C1466.areaObject; lk hor scrollbar height:K53:7)*Num:C11($horizontal))

If (Num:C11(ob_area.reportType)=qr list report:K14902:1)
	
	// Right-filler
	OBJECT GET COORDINATES:C663(*; "head_filler"; $left; $dummy; $dummy; $top)
	$top:=0  //set $top to 0 to hide the last header
	OBJECT SET COORDINATES:C1248(*; "right-filler"; $left; $top; $width; $height)
	OBJECT SET VISIBLE:C603(*; "right-filler"; $left<$width)
	
	// Place the top-left filler
	OBJECT GET COORDINATES:C663(*; "head_headers"; $left; $top; $right; $bottom)
	OBJECT SET COORDINATES:C1248(*; "top-left-filler"; $left; $top; $right-2; $bottom-2)
	OBJECT SET VISIBLE:C603(*; "top-left-filler"; True:C214)
	
	// Page break
	OBJECT GET COORDINATES:C663(*; "page.break"; $left; $dummy; $dummy; $dummy)
	OBJECT SET COORDINATES:C1248(*; "page.break"; $left; 0; $left; $height)
	
	report_SELECTION("adjust")
	
Else 
	
	OBJECT SET VISIBLE:C603(*; "top-left-filler"; False:C215)
	
	OBJECT GET COORDINATES:C663(*; "filler"; $left; $dummy; $dummy; $top)
	$top:=0  // Set $top to 0 to hide the last header
	OBJECT SET COORDINATES:C1248(*; "right-filler"; $left; $top; $width; $height)
	OBJECT SET VISIBLE:C603(*; "right-filler"; $left<$width)
	
End if 