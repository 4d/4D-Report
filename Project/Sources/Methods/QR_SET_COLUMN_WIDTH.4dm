//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SET_COLUMN_WIDTH
// Database: 4D Report
// ID[3558BBA036B84306A021FDB854CC8FE9]
// Created #18-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_;$Lon_area;$Lon_column;$Lon_hidden;$Lon_parameters;$Lon_repeated;$Lon_width)
C_TEXT:C284($Txt_format;$Txt_formula;$Txt_object;$Txt_title)

If (False:C215)
	C_LONGINT:C283(QR_SET_COLUMN_WIDTH;$1)
	C_LONGINT:C283(QR_SET_COLUMN_WIDTH;$2)
	C_LONGINT:C283(QR_SET_COLUMN_WIDTH;$3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	$Lon_width:=$3//width in pixels. -1 for automatic width
	
Else 
	
	ABORT:C156
	
End if 


// ----------------------------------------------------
QR GET INFO COLUMN:C766($Lon_area;\
$Lon_column;\
$Txt_title;\
$Txt_object;\
$Lon_hidden;\
$Lon_;\
$Lon_repeated;\
$Txt_format;\
$Txt_formula)

//ACI0099744
//QR SET INFO COLUMN($Lon_area;\
$Lon_column;\
$Txt_title;\
Choose(Length($Txt_formula)=0;$Txt_object;$Txt_formula);\
$Lon_hidden;\
$Lon_width;\
$Lon_repeated;\
$Txt_format)

QR SET INFO COLUMN:C765($Lon_area;\
$Lon_column;\
$Txt_title;\
Choose:C955(Length:C16($Txt_formula)#0;$Txt_object;$Txt_formula);\
$Lon_hidden;\
$Lon_width;\
$Lon_repeated;\
$Txt_format)

// ----------------------------------------------------
// End