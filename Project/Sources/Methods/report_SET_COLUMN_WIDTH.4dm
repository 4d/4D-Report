//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : report_SET_COLUMN_WIDTH
  // Database: 4D Report
  // ID[096E0F31E44148C88A9705C71333972A]
  // Created #18-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_parameters;$Lon_width)
C_TEXT:C284($Txt_column)

If (False:C215)
	C_TEXT:C284(report_SET_COLUMN_WIDTH ;$1)
	C_LONGINT:C283(report_SET_COLUMN_WIDTH ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Txt_column:=$1
	$Lon_width:=$2  //width in pixels. -1 for automatic width
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
LISTBOX SET COLUMN WIDTH:C833(*;$Txt_column;Choose:C955($Lon_width=-1;OB Get:C1224(<>report_params;"default-column-width";Is longint:K8:6);$Lon_width))

  // ----------------------------------------------------
  // End