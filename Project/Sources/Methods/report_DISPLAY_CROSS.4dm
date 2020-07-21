//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_DISPLAY_CROSS
// Database: 4D Report
// ID[36DC524B34F34592B54848B420C8C315]
// Created #11-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($kLon_bestListRowHeight; $kLon_columnNumber; $kLon_defaultColumnWidth; $kLon_rowNumber; $Lon_; $Lon_area)
C_LONGINT:C283($Lon_column; $Lon_i; $Lon_operator; $Lon_parameters; $Lon_qrDestination; $Lon_row)
C_LONGINT:C283($Lon_width)
C_POINTER:C301($Ptr_bestObectSize)
C_TEXT:C284($kTxt_fontFamily; $kTxt_reportObject; $Txt_; $Txt_data; $Txt_format; $Txt_object; $Txt_variableName; $Txt_title)
C_OBJECT:C1216($Obj_params)
C_BOOLEAN:C305($Boo_isFormula)

ARRAY BOOLEAN:C223($tBoo_visibles; 0)
ARRAY POINTER:C280($tPtr_arrays; 0)
ARRAY POINTER:C280($tPtr_columns; 0)
ARRAY POINTER:C280($tPtr_headers; 0)
ARRAY TEXT:C222($tTxt_columns; 0)
ARRAY TEXT:C222($tTxt_headers; 0)

If (False:C215)
	C_LONGINT:C283(report_DISPLAY_CROSS; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Lon_area:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$kTxt_reportObject:=OB Get:C1224(<>report_params; "form-object"; Is text:K8:3)
	$kLon_defaultColumnWidth:=OB Get:C1224(<>report_params; "default-column-width"; Is longint:K8:6)  //width for automatic size
	$kLon_bestListRowHeight:=OB Get:C1224(<>report_params; "default-row-height"; Is longint:K8:6)  //default height (pixels) for rows in the list mode
	
	$kTxt_fontFamily:=env_Substitute_font  //default font is the platform and language font
	
	//the number of columns & rows are fixed
	$kLon_rowNumber:=3
	$kLon_columnNumber:=3
	
	$Ptr_bestObectSize:=OBJECT Get pointer:C1124(Object named:K67:5; "bestobjectsize")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//adjust the number of columns, if any {
OB SET:C1220($Obj_params; \
"action"; "adjustColumnNumber"; \
"object"; $kTxt_reportObject; \
"columnsNumber"; $kLon_columnNumber)

report_DISPLAY_COMMON($Obj_params)
//}

//initialize columns {
OB SET:C1220($Obj_params; \
"action"; "createColumn"; \
"object"; $kTxt_reportObject; \
"columnName"; "QR_column_1"; \
"headerName"; "QR_header_1"; \
"columnPosition"; 2; \
"columnWidth"; $kLon_defaultColumnWidth*2)

report_DISPLAY_COMMON($Obj_params)

OB SET:C1220($Obj_params; \
"action"; "createColumn"; \
"object"; $kTxt_reportObject; \
"columnName"; "QR_column_2"; \
"headerName"; "QR_header_2"; \
"columnPosition"; 3; \
"columnWidth"; $kLon_defaultColumnWidth*2)

report_DISPLAY_COMMON($Obj_params)
//}

//add a filler (resizable), if any {
OB SET:C1220($Obj_params; \
"action"; "filler"; \
"object"; $kTxt_reportObject)

report_DISPLAY_COMMON($Obj_params)
//}

//keep 3 rows {
OB SET:C1220($Obj_params; \
"action"; "adjustRowsNumber"; \
"object"; $kTxt_reportObject; \
"rowsNumber"; $kLon_rowNumber)

report_DISPLAY_COMMON($Obj_params)
//}

//populate
LISTBOX GET ARRAYS:C832(*; $kTxt_reportObject; $tTxt_columns; $tTxt_headers; $tPtr_columns; $tPtr_headers; $tBoo_visibles; $tPtr_arrays)

$Lon_column:=1

If (True:C214)  // 1st column
	
	//unused
	$Lon_row:=1
	$tPtr_columns{$Lon_column}->{$Lon_row}:=""
	
	//rows data-source {
	$Lon_row:=2
	
	CLEAR VARIABLE:C89($Txt_variableName)
	QR GET INFO COLUMN:C766($Lon_area; $Lon_row; $Txt_; $Txt_object; $Lon_; $Lon_width; $Lon_; $Txt_format; $Txt_variableName)
	$Boo_isFormula:=(Length:C16($Txt_variableName)#0)
	
	If (Length:C16($Txt_object)>0)
		
		$Txt_title:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
		
		$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; $Txt_title; $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
		
	Else 
		
		$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_tips(Get localized string:C991("rows"))
		
		If (False:C215)  //#redmine:32417 - Remove alignment preview in edit mode.
			
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tTxt_columns{$Lon_column}; \
				QR Get text property:C760($Lon_area; $Lon_column; $Lon_row; qr justification:K14904:7)+1)
			
		End if 
	End if 
	
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	//}
	
	//last row total label {
	$Lon_row:=3
	QR GET TOTALS DATA:C768($Lon_area; $Lon_column; $Lon_row; $Lon_operator; $Txt_data)
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; $Txt_data; $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
	//}
	
	QR GET INFO COLUMN:C766($Lon_area; $Lon_column; $Txt_; $Txt_object; $Lon_; $Lon_width; $Lon_; $Txt_format)
	
	If ($Lon_width=-1)
		
		//set header column width
		OB SET:C1220($Obj_params; \
			"action"; "headercolumnWidth"; \
			"rowNumber"; $kLon_rowNumber)
		
		report_DISPLAY_COMMON($Obj_params)
		
	Else 
		
		report_SET_COLUMN_WIDTH($tTxt_columns{$Lon_column}; $Lon_width)
		
	End if 
End if 

$Lon_column:=2

If (True:C214)  // 2nd column
	
	//column data-source {
	$Lon_row:=1
	CLEAR VARIABLE:C89($Txt_variableName)
	QR GET INFO COLUMN:C766($Lon_area; $Lon_row; $Txt_; $Txt_object; $Lon_; $Lon_width; $Lon_; $Txt_format; $Txt_variableName)
	
	$Boo_isFormula:=(Length:C16($Txt_variableName)#0)
	
	If (Length:C16($Txt_object)>0)
		
		$Txt_title:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
		
		$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; $Txt_title; $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
		
	Else 
		
		$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_tips(Get localized string:C991("columns"))
		
		If (False:C215)  //#redmine:32417
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tTxt_columns{$Lon_column}; \
				QR Get text property:C760($Lon_area; $Lon_column; $Lon_row; qr justification:K14904:7)+1)
		End if 
	End if 
	
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	//}
	
	//cells data-source {
	$Lon_row:=2
	
	//beware: column = 3 !
	CLEAR VARIABLE:C89($Txt_variableName)
	QR GET INFO COLUMN:C766($Lon_area; 3; $Txt_; $Txt_object; $Lon_; $Lon_; $Lon_; $Txt_format; $Txt_variableName)
	
	$Boo_isFormula:=(Length:C16($Txt_variableName)#0)
	
	If (Length:C16($Txt_object)>0)
		
		$Txt_title:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
		
		QR GET TOTALS DATA:C768($Lon_area; $Lon_column; $Lon_row; $Lon_operator; $Txt_data)
		
		If ($Lon_operator=0)
			
			$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; $Txt_title; $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
			
		Else 
			
			$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; "<span>"+"\r"+$Txt_title+"\r\r</span>"\
				+report_cell_content($Txt_data; $Lon_operator; True:C214; True:C214); $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
			
		End if 
		
	Else 
		
		$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_tips(Get localized string:C991("cells"))
		
	End if 
	
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	//}
	
	//total cells {
	$Lon_row:=3
	QR GET TOTALS DATA:C768($Lon_area; $Lon_column; $Lon_row; $Lon_operator; $Txt_data)
	
	$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; report_cell_content($Txt_data; $Lon_operator; True:C214; True:C214); $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
	
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	//}
	
	QR GET INFO COLUMN:C766($Lon_area; $Lon_column; $Txt_; $Txt_object; $Lon_; $Lon_width; $Lon_; $Txt_format)
	report_SET_COLUMN_WIDTH($tTxt_columns{$Lon_column}; $Lon_width)
	
End if 

$Lon_column:=3

If (True:C214)  // 3rd column
	
	//lats column total label {
	$Lon_row:=1
	QR GET TOTALS DATA:C768($Lon_area; $Lon_column; 1; $Lon_operator; $Txt_data)
	
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; $Txt_data; $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
	//}
	
	//rows total {
	$Lon_row:=2
	QR GET TOTALS DATA:C768($Lon_area; $Lon_column; 2; $Lon_operator; $Txt_data)
	
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; $Lon_column; $Lon_row)
	$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; report_cell_content($Txt_data; $Lon_operator; True:C214; True:C214); $Lon_column; $Lon_row; $tTxt_columns{$Lon_column})
	//}
	
	//3rd line {
	$Lon_row:=3
	report_SET_CELL_BACKGROUND($Lon_area; $tTxt_columns{$Lon_column}; $Lon_row; 2; 3)
	
	//Data is the same as the 3rd line of the 2nd column
	QR GET TOTALS DATA:C768($Lon_area; 2; 3; $Lon_operator; $Txt_data)
	$tPtr_columns{$Lon_column}->{$Lon_row}:=report_cell_styled_content($Lon_area; report_cell_content($Txt_data; $Lon_operator; True:C214; True:C214); 2; 3; $tTxt_columns{$Lon_column})
	QR GET INFO COLUMN:C766($Lon_area; 3; $Txt_; $Txt_; $Lon_; $Lon_width; $Lon_; $Txt_format)
	//}
	
	QR GET INFO COLUMN:C766($Lon_area; $Lon_column; $Txt_; $Txt_object; $Lon_; $Lon_width; $Lon_; $Txt_format)
	report_SET_COLUMN_WIDTH($tTxt_columns{$Lon_column}; $Lon_width)
	
End if 

//set the rows hight {
OB SET:C1220($Obj_params; \
"action"; "rowHeight"; \
"object"; $kTxt_reportObject; \
"columnNumber"; $kLon_columnNumber; \
"rowNumber"; $kLon_rowNumber; \
"columnWidth"; $kLon_defaultColumnWidth; \
"rowHeight"; OB Get:C1224(<>report_params; "default-row-height"; Is longint:K8:6))

report_DISPLAY_COMMON($Obj_params)
//}

//geometry {
//static & locked columns
LISTBOX SET STATIC COLUMNS:C1153(*; $kTxt_reportObject; 4)
LISTBOX SET LOCKED COLUMNS:C1151(*; $kTxt_reportObject; 0)

//headers
OBJECT SET VISIBLE:C603(*; $tTxt_headers{1}; True:C214)
LISTBOX SET HEADERS HEIGHT:C1143(*; $kTxt_reportObject; 3; lk pixels:K53:22)  //On Mac minimum value seems to be 15px

For ($Lon_i; 1; Size of array:C274($tTxt_headers); 1)
	
	OBJECT SET TITLE:C194(*; $tTxt_headers{$Lon_i}; "")
	
End for 

//hide the scrollbars
OBJECT SET SCROLLBAR:C843(*; $kTxt_reportObject; 0; 0)
//}

//events
report_SET_EVENTS($kTxt_reportObject)

QR GET DESTINATION:C756($Lon_area; $Lon_qrDestination)

OB SET:C1220(ob_area; \
"qrColumnNumber"; 2; \
"qrRowNumber"; $kLon_rowNumber; \
"destination"; $Lon_qrDestination; \
"sortNumber"; 0)

//restore the selection
report_SELECTION("display")  //;$Lon_area)

If (OB Get:C1224(ob_area; "4d-dialog"; Is boolean:K8:9))  //NQR
	
	OB SET:C1220(ob_dialog; \
		"action"; "hide_plus")
	
	// move balloon if any
	If (OBJECT Get visible:C1075(*; "header_action"))
		
		OB SET:C1220($Obj_params; \
			"action"; "adjustBalloon"; \
			"object"; $kTxt_reportObject; \
			"column"; OB Get:C1224(ob_area; "columnIndex"; Is longint:K8:6))
		
		report_DISPLAY_COMMON($Obj_params)
		
	End if 
	
	CALL SUBFORM CONTAINER:C1086(-1)
	
End if 

OBJECT SET VISIBLE:C603(*; "page.break"; False:C215)

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End