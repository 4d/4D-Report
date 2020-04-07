//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : report_EDIT_COLUMN_FORMULA
  // Database: 4D Report
  // ID[1E8F9ED66DDB4085ACF57A5E8A304BE4]
  // Created #7-7-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_hidden;$Lon_parameters;$Lon_repeated;$Lon_width)
C_TEXT:C284($Txt_format;$Txt_object;$Txt_title;$Txt_variableName)

If (False:C215)
	C_LONGINT:C283(report_EDIT_COLUMN_FORMULA ;$1)
	C_LONGINT:C283(report_EDIT_COLUMN_FORMULA ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_area:=$1
	$Lon_column:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_title;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_format;$Txt_variableName)

If (Length:C16($Txt_variableName)=0)
	
	$Txt_object:=db_virtualFieldName ($Txt_object)
	
End if 

EDIT FORMULA:C806(Table:C252(QR Get report table:C758($Lon_area))->;$Txt_object)

If (OK=1)
	
	QR SET INFO COLUMN:C765($Lon_area;$Lon_column;$Txt_title;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_format)
	
	OB SET:C1220(ob_dialog;\
		"action";"update")
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End