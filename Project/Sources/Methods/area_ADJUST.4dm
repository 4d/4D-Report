//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : area_ADJUST
  // Database: 4D Report
  // ID[35F464BA350A4BBDBC8ACDFBFEE1FF93]
  // Created #13-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // updates the area's coordinates & the filling
  // according to the size of the container subform
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_;$Lon_bottom;$Lon_height;$Lon_left;$Lon_parameters;$Lon_right)
C_LONGINT:C283($Lon_rowNumber;$Lon_top;$Lon_width)
C_TEXT:C284($kTxt_reportObject)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	OBJECT GET SUBFORM CONTAINER SIZE:C1148($Lon_width;$Lon_height)
	
	$kTxt_reportObject:=OB Get:C1224(<>report_params;"form-object";Is text:K8:3)
	
	$Lon_rowNumber:=LISTBOX Get number of rows:C915(*;$kTxt_reportObject)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //restore grid
LISTBOX SET GRID:C841(*;"nqr";True:C214;True:C214)

  //set the listbox coordinates
OBJECT SET COORDINATES:C1248(*;$kTxt_reportObject;0;0;$Lon_width;$Lon_height)

  //calculate the corrected area coordinates with the scrollbar widths
$Lon_width:=$Lon_width-\
(LISTBOX Get property:C917(*;$kTxt_reportObject;lk ver scrollbar width:K53:9)*LISTBOX Get property:C917(*;$kTxt_reportObject;_o_lk display ver scrollbar:K53:8))
$Lon_height:=$Lon_height-\
(LISTBOX Get property:C917(*;$kTxt_reportObject;lk hor scrollbar height:K53:7)*LISTBOX Get property:C917(*;$kTxt_reportObject;_o_lk display hor scrollbar:K53:6))

If (OB Get:C1224(ob_area;"reportType";Is longint:K8:6)=qr list report:K14902:1)
	
	  //right-filler
	OBJECT GET COORDINATES:C663(*;"head_filler";$Lon_left;$Lon_;$Lon_;$Lon_top)
	$Lon_top:=0  //set $Lon_top to 0 to hide the last header
	OBJECT SET COORDINATES:C1248(*;"right-filler";$Lon_left;$Lon_top;$Lon_width;$Lon_height)
	OBJECT SET VISIBLE:C603(*;"right-filler";$Lon_left<$Lon_width)
	
	  //Place the top-left filler
	OBJECT GET COORDINATES:C663(*;"head_headers";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	OBJECT SET COORDINATES:C1248(*;"top-left-filler";$Lon_left;$Lon_top;$Lon_right-2;$Lon_bottom-2)
	OBJECT SET VISIBLE:C603(*;"top-left-filler";True:C214)
	
	  //no longer necessary with the new property "Hide extra blank rows" [
	  //LISTBOX GET CELL COORDINATES(*;$kTxt_reportObject;1;$Lon_rowNumber;$Lon_;$Lon_;$Lon_;$Lon_bottom)
	  //OBJECT SET COORDINATES(*;"bottom-filler";0;$Lon_bottom;$Lon_width;$Lon_height)
	  //OBJECT SET VISIBLE(*;"bottom-filler";$Lon_bottom<$Lon_height)
	  //]
	
	  //page break
	OBJECT GET COORDINATES:C663(*;"page.break";$Lon_left;$Lon_;$Lon_;$Lon_)
	OBJECT SET COORDINATES:C1248(*;"page.break";$Lon_left;0;$Lon_left;$Lon_height)
	
	report_SELECTION ("adjust")
	
Else 
	
	OBJECT SET VISIBLE:C603(*;"top-left-filler";False:C215)
	
	OBJECT GET COORDINATES:C663(*;"filler";$Lon_left;$Lon_;$Lon_;$Lon_top)
	$Lon_top:=0  //set $Lon_top to 0 to hide the last header
	OBJECT SET COORDINATES:C1248(*;"right-filler";$Lon_left;$Lon_top;$Lon_width;$Lon_height)
	OBJECT SET VISIBLE:C603(*;"right-filler";$Lon_left<$Lon_width)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End