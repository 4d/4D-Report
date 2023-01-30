//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_DISPLAY_LIST
// Database: 4D Report
// ID[9774F2AE45D74A02B0850A2E9AEFCE1F]
// Created #11-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer)


var \
$is_formula : Boolean

var \
$Lon_bottom; \
$Lon_columnType; \
$Lon_height; \
$Lon_hidden; \
$Lon_i; $Lon_j; \
$Lon_left; \
$Lon_operator; \
$Lon_parameters; \
$Lon_qrColumnNumber; \
$Lon_qrDestination; \
$Lon_repeated; \
$Lon_right; \
$Lon_row; \
$Lon_rowNumber; \
$Lon_sortNumber; \
$Lon_top; \
$Lon_width; \
$kLon_headerColor : Integer

var \
$Ptr_bestObectSize; \
$Ptr_column : Pointer

var \
$kTxt_fontFamily; \
$Txt_buffer; \
$Txt_column; \
$Txt_data; \
$Txt_format; \
$Txt_header; \
$Txt_object; \
$Txt_title; \
$Txt_type; \
$Txt_variableName : Text

var \
$Obj_params : Object

ARRAY BOOLEAN:C223($tBoo_visibles; 0)
ARRAY POINTER:C280($tPtr_arrays; 0)
ARRAY POINTER:C280($tPtr_columns; 0)
ARRAY POINTER:C280($tPtr_headers; 0)
ARRAY TEXT:C222($tTxt_columns; 0)
ARRAY TEXT:C222($tTxt_headers; 0)

If (False:C215)
	C_LONGINT:C283(report_DISPLAY_LIST; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$Lon_row:=3  //minimum number of rows
	
	$kTxt_fontFamily:=env_Substitute_font  //default font is the platform and language font
	
	$Ptr_bestObectSize:=OBJECT Get pointer:C1124(Object named:K67:5; "bestobjectsize")
	
	$Lon_qrColumnNumber:=QR Count columns:C764($area)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//adjust the number of columns, if any {
$Obj_params:=New object:C1471(\
"action"; "adjustColumnNumber"; \
"object"; Form:C1466.areaObject; \
"columnsNumber"; $Lon_qrColumnNumber+1)

report_DISPLAY_COMMON($Obj_params)
//}

//create columns
For ($Lon_i; 1; $Lon_qrColumnNumber; 1)
	
	$Txt_column:="QR_column_"+String:C10($Lon_i)
	$Txt_header:="QR_header_"+String:C10($Lon_i)
	
	OB SET:C1220($Obj_params; \
		"action"; "createColumn"; \
		"object"; Form:C1466.areaObject; \
		"columnName"; $Txt_column; \
		"headerName"; $Txt_header; \
		"columnPosition"; $Lon_i+1)
	
	report_DISPLAY_COMMON($Obj_params)
	
	QR GET INFO COLUMN:C766($area; $Lon_i; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format; $Txt_variableName)
	
	//mark: ACI0103452/ACI0103541
	
	If (Length:C16($Txt_variableName)=0)
		
		If (boo_useVirtualStructure)
			$Txt_object:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
		End if 
		OBJECT SET TITLE:C194(*; $Txt_header; $Txt_object)
	Else 
		//mark:ACI0103452
		//#DD
		// erreur de copier coller $Txt_object
		// note: dans la version v18, on testait la validité du nom de la variable :
		// si nom vide, -> on evaluait txt_object pour afficher la formule avec gestion du virtual structure
		// vu avec vdl, il ne sert à rien d'afficher des formules, si c'est pour les tronquer... à suivre
		
		//OBJECT SET TITLE(*; $Txt_header; $Txt_object)
		OBJECT SET TITLE:C194(*; $Txt_header; $Txt_variableName)
	End if 
End for 

//add a filler (resizable) column, if any
OB SET:C1220($Obj_params; \
"action"; "filler"; \
"object"; Form:C1466.areaObject)

report_DISPLAY_COMMON($Obj_params)

//populate
ARRAY LONGINT:C221($tLon_sortedColumns; 0x0000)
ARRAY LONGINT:C221($tLon_sortOrder; 0x0000)
QR GET SORTS:C753($area; $tLon_sortedColumns; $tLon_sortOrder)

$Lon_sortNumber:=Size of array:C274($tLon_sortedColumns)

$Lon_rowNumber:=$Lon_row+$Lon_sortNumber

//create rows {
OB SET:C1220($Obj_params; \
"action"; "adjustRowsNumber"; \
"object"; Form:C1466.areaObject; \
"rowsNumber"; $Lon_rowNumber)

report_DISPLAY_COMMON($Obj_params)
//}

LISTBOX GET ARRAYS:C832(*; Form:C1466.areaObject; $tTxt_columns; $tTxt_headers; $tPtr_columns; $tPtr_headers; $tBoo_visibles; $tPtr_arrays)

//geometry {
//default column width
LISTBOX SET COLUMN WIDTH:C833(*; Form:C1466.areaObject; Form:C1466.defaultColumWidth; 0; MAXTEXTLENBEFOREV11:K35:3)


//static & locked columns
LISTBOX SET STATIC COLUMNS:C1153(*; Form:C1466.areaObject; 1)
LISTBOX SET LOCKED COLUMNS:C1151(*; Form:C1466.areaObject; 1)

//headers
OBJECT SET VISIBLE:C603(*; $tTxt_headers{1}; True:C214)
LISTBOX SET HEADERS HEIGHT:C1143(*; Form:C1466.areaObject; Form:C1466.headerHeight)

//default row height
LISTBOX SET ROWS HEIGHT:C835(*; Form:C1466.areaObject; Form:C1466.defaultRowHeight)

//automatic scrollbar
OBJECT SET SCROLLBAR:C843(*; Form:C1466.areaObject; 2; 2)
//}

//events
report_SET_EVENTS(Form:C1466.areaObject)



//mark:c'est dans la boucle en dessous que se calcul la colonne de titre
//__________________________ 1st column

$Txt_column:=$tTxt_columns{1}
$Ptr_column:=$tPtr_columns{1}
$Ptr_column->{1}:=Get localized string:C991("head_title")
ST SET ATTRIBUTES:C1093($Ptr_column->{1}; \
ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; Choose:C955(QR Get info row:C769($area; qr title:K14906:1); Bold:K14:2; Plain:K14:1); Attribute font name:K65:5; $kTxt_fontFamily)

LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 1; Choose:C955(QR Get info row:C769($area; qr title:K14906:1); lk inherited:K53:26; 0x007F7F7F); lk font color:K53:24)
LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 1; Form:C1466.headerBackgroundColor; lk background color:K53:25)

$Ptr_column->{2}:=Get localized string:C991("head_details")
ST SET ATTRIBUTES:C1093($Ptr_column->{2}; \
ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; Choose:C955(QR Get info row:C769($area; qr detail:K14906:2); Bold:K14:2; Plain:K14:1); Attribute font name:K65:5; $kTxt_fontFamily)

LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 2; Choose:C955(QR Get info row:C769($area; qr detail:K14906:2); lk inherited:K53:26; 0x007F7F7F); lk font color:K53:24)
LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 2; Form:C1466.headerBackgroundColor; lk background color:K53:25)

//the sort order is inverted !
If ($Lon_sortNumber>0)
	
	ARRAY LONGINT:C221($tLon_order; $Lon_sortNumber)
	
	For ($Lon_i; 1; $Lon_sortNumber; 1)
		
		$tLon_order{$Lon_i}:=$Lon_i
		
	End for 
	
	SORT ARRAY:C229($tLon_order; $tLon_sortOrder; $tLon_sortedColumns; <)
	
	
	//mark:ACI0103541
	//DD : OBJECT Get title(*; $Txt_header) is not reliable because recalculating without taking into account the order of creation of the column.
	
	
	For ($Lon_i; 1; $Lon_sortNumber; 1)
		
		//mark:ACI0103541--BEGIN
		QR GET INFO COLUMN:C766($area; $tLon_sortedColumns{$Lon_i}; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format; $Txt_variableName)
		
		If (Length:C16($Txt_variableName)=0)
			
			If (boo_useVirtualStructure)
				$Txt_object:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
			End if 
			
			$Txt_header:=$Txt_object
		Else 
			$Txt_header:=$Txt_variableName
		End if 
		
		
		
		//$Txt_header:=$tTxt_headers{$tLon_sortedColumns{$Lon_i}+1}
		
		$Txt_buffer:=Replace string:C233(Get localized string:C991("head_subtotal"); "{field}"; $Txt_header)  // OBJECT Get title(*; $Txt_header))
		//mark:ACI0103541--END
		
		$Ptr_column->{2+$Lon_i}:=$Txt_buffer
		$Lon_hidden:=QR Get info row:C769($area; $Lon_i)
		ST SET ATTRIBUTES:C1093($Ptr_column->{2+$Lon_i}; \
			ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; Choose:C955($Lon_hidden=0; Bold:K14:2; Plain:K14:1); Attribute font name:K65:5; $kTxt_fontFamily)
		
		LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 2+$Lon_i; Choose:C955($Lon_hidden=0; lk inherited:K53:26; 0x007F7F7F); lk font color:K53:24)
		LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 2+$Lon_i; Form:C1466.headerBackgroundColor; lk background color:K53:25)
		
		$Lon_row:=$Lon_row+1
		
	End for 
End if 

//last line
$Ptr_column->{$Lon_rowNumber}:=Get localized string:C991("head_grand_total")
ST SET ATTRIBUTES:C1093($Ptr_column->{$Lon_rowNumber}; ST Start text:K78:15; ST End text:K78:16; Attribute bold style:K65:1; \
Choose:C955(QR Get info row:C769($area; qr grand total:K14906:3); Bold:K14:2; Plain:K14:1); Attribute font name:K65:5; $kTxt_fontFamily)





//1st column unvisible lines
OBJECT SET RGB COLORS:C628(*; $Txt_column; Foreground color:K23:1; Form:C1466.headerBackgroundColor)

//set header column width
OB SET:C1220($Obj_params; \
"action"; "headercolumnWidth"; \
"rowNumber"; $Lon_rowNumber)

report_DISPLAY_COMMON($Obj_params)



//var $columnWidth; $minWidth; $maxWidth : Integer
//$columnWidth:=LISTBOX Get column width(*; $tTxt_columns{1}; $minWidth; $maxWidth)


OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tTxt_columns{1}; Align left:K42:2)

//__________________________ the others columns
For ($Lon_i; 1; $Lon_qrColumnNumber; 1)
	
	$Txt_column:=$tTxt_columns{$Lon_i+1}
	$Txt_header:=$tTxt_headers{$Lon_i+1}
	$Ptr_column:=$tPtr_columns{$Lon_i+1}
	
	//[ACI0094247] the variable name is NOT cleared by the command if this is not a column formula
	CLEAR VARIABLE:C89($Txt_variableName)
	QR GET INFO COLUMN:C766($area; $Lon_i; $Txt_title; $Txt_object; $Lon_hidden; $Lon_width; $Lon_repeated; $Txt_format; $Txt_variableName)
	
	$is_formula:=(Length:C16($Txt_variableName)#0)
	
	$Lon_columnType:=QR_Get_column_type($area; $Lon_i)
	
	If ($Lon_columnType=Is picture:K8:10)\
		 | ($Lon_columnType=Is date:K8:7)\
		 | ($Lon_columnType=Is time:K8:8)\
		 | ($Lon_columnType=Is boolean:K8:9)
		
		$Txt_type:=Choose:C955($Lon_columnType=Is picture:K8:10; "pict_"; \
			Choose:C955($Lon_columnType=Is date:K8:7; "date_"; \
			Choose:C955($Lon_columnType=Is time:K8:8; "time_"; \
			Choose:C955($Lon_columnType=Is boolean:K8:9; "bolean_"; ""))))
		
		$Txt_format:=Get localized string:C991($Txt_type+String:C10(Character code:C91($Txt_format)))
		
	End if 
	
	If (boo_useVirtualStructure)
		$Txt_object:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
	End if 
	
	If ($is_formula)
		
		OBJECT SET TITLE:C194(*; $Txt_header; $Txt_variableName)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $Txt_header; Align center:K42:3)
		
	Else 
		
		OBJECT SET TITLE:C194(*; $Txt_header; $Txt_object)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $Txt_header; Align left:K42:2)
		
	End if 
	
	OBJECT SET FONT STYLE:C166(*; $Txt_header; Choose:C955($Lon_hidden; Bold:K14:2; Plain:K14:1))
	
	OBJECT SET RGB COLORS:C628(*; $Txt_header; Choose:C955($Lon_hidden; Foreground color:K23:1; 0x007F7F7F); Background color:K23:2)  // /!\ background color is ignored
	
	
	LISTBOX SET COLUMN WIDTH:C833(*; $Txt_column; Choose:C955($Lon_width=-1; Form:C1466.defaultColumWidth; $Lon_width))
	
	
	LISTBOX SET ROW COLOR:C1270(*; $Txt_column; 0; $kLon_headerColor; lk background color:K53:25)
	
	//====================================== TITLES ======================================
	report_SET_CELL_FORMAT($area; $Txt_column; 1; $Lon_i; qr title:K14906:1; $Txt_title; $Ptr_column; $Lon_hidden)
	
	//====================================== DETAIL ======================================
	report_SET_CELL_FORMAT($area; $Txt_column; 2; $Lon_i; qr detail:K14906:2; $Txt_format; $Ptr_column; $Lon_hidden)
	
	//======================================= SORTS ======================================
	For ($Lon_j; 1; $Lon_sortNumber; 1)
		
		$Lon_row:=$Lon_j+2
		QR GET TOTALS DATA:C768($area; $Lon_i; $Lon_j; $Lon_operator; $Txt_data)
		
		$Ptr_column->{$Lon_row}:=report_cell_styled_content($area; report_cell_content($Txt_data; $Lon_operator; True:C214; True:C214); $Lon_i; $Lon_j; $Txt_column)
		report_SET_CELL_FORMAT($area; $Txt_column; $Lon_row; $Lon_i; $Lon_j; ""; $Ptr_column; $Lon_hidden)
		
	End for 
	
	//==================================== GRAND TOTAL ===================================
	QR GET TOTALS DATA:C768($area; $Lon_i; qr grand total:K14906:3; $Lon_operator; $Txt_data)
	$Ptr_column->{$Lon_rowNumber}:=report_cell_styled_content($area; report_cell_content($Txt_data; $Lon_operator; True:C214; True:C214); $Lon_i; qr grand total:K14906:3; $Txt_column)
	report_SET_CELL_FORMAT($area; $Txt_column; $Lon_rowNumber; $Lon_i; qr grand total:K14906:3; $Txt_title; $Ptr_column; $Lon_hidden)
	
End for 

//set the rows hight {
OB SET:C1220($Obj_params; \
"action"; "rowHeight"; \
"object"; Form:C1466.areaObject; \
"columnNumber"; $Lon_qrColumnNumber; \
"rowNumber"; $Lon_rowNumber; \
"columnWidth"; Form:C1466.defaultColumWidth; \
"rowHeight"; Form:C1466.defaultRowHeight)

report_DISPLAY_COMMON($Obj_params)
//}

//•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••

QR GET DESTINATION:C756($area; $Lon_qrDestination)

OB SET:C1220(ob_area; \
"qrColumnNumber"; $Lon_qrColumnNumber; \
"qrRowNumber"; $Lon_rowNumber; \
"destination"; $Lon_qrDestination; \
"sortNumber"; $Lon_sortNumber)

//display printable area {
If ($Lon_qrDestination=qr printer:K14903:1)
	
	GET PRINTABLE AREA:C703($Lon_height; $Lon_width)
	GET PRINTABLE MARGIN:C711($Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
	
	$Lon_width:=$Lon_width-$Lon_right-$Lon_left
	
	//keep the width of the printable area
	OB SET:C1220(ob_area; \
		"pageBreak"; $Lon_width)
	
	OBJECT GET COORDINATES:C663(*; Form:C1466.areaObject; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
	$Lon_width:=$Lon_width+LISTBOX Get column width:C834(*; "headers")
	OBJECT SET COORDINATES:C1248(*; "page.break"; $Lon_width; $Lon_top; $Lon_width; $Lon_bottom)
	
	If (Not:C34(OBJECT Get visible:C1075(*; "page.break")))
		
		OBJECT SET VISIBLE:C603(*; "page.break"; True:C214)
		
	End if 
	
Else 
	
	OBJECT SET VISIBLE:C603(*; "page.break"; False:C215)
	
End if   //}

If (OB Get:C1224(ob_area; "4d-dialog"; Is boolean:K8:9))  //NQR
	
	// #13-11-2014
	// move balloon if any
	If (OBJECT Get visible:C1075(*; "header_action"))
		
		If (OB Get:C1224(ob_area; "rowIndex"; Is longint:K8:6)=-1)\
			 & (OB Get:C1224(ob_area; "columnIndex"; Is longint:K8:6)>0)
			
			OB SET:C1220($Obj_params; \
				"action"; "adjustBalloon"; \
				"object"; Form:C1466.areaObject; \
				"column"; OB Get:C1224(ob_area; "columnIndex"; Is longint:K8:6))
			
			report_DISPLAY_COMMON($Obj_params)
			
		End if 
	End if 
	
	//Show the Add button if no column
	If ($Lon_qrColumnNumber=0)
		
		If (Not:C34(OB Get:C1224(ob_area; "stop"; Is boolean:K8:9)))
			
			OB SET:C1220(ob_dialog; \
				"action"; "show_plus"; \
				"middle"; LISTBOX Get column width:C834(*; "headers"))
			
		End if 
	End if 
	
	CALL SUBFORM CONTAINER:C1086(-1)
	
End if 

//display the selection
report_SELECTION("display")

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End