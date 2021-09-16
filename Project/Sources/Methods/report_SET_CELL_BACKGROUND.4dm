//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_SET_CELL_BACKGROUND
// Database: 4D Report
// ID[C8BD2B28528A4969B7BD33F3814B2032]
// Created #18-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($Lon_area; $Lon_parameters; $Lon_qrColumn; $Lon_qrRow; $Lon_row)
C_TEXT:C284($Txt_objectColumn)

If (False:C215)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND; $1)
	C_TEXT:C284(report_SET_CELL_BACKGROUND; $2)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND; $3)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND; $4)
	C_LONGINT:C283(report_SET_CELL_BACKGROUND; $5)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	$Lon_area:=$1
	
	$Txt_objectColumn:=$2
	$Lon_row:=$3
	
	$Lon_qrColumn:=$4
	$Lon_qrRow:=$5
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
LISTBOX SET ROW COLOR:C1270(*; $Txt_objectColumn; $Lon_row; \
QR Get text property:C760($Lon_area; $Lon_qrColumn; $Lon_qrRow; qr background color:K14904:8); lk background color:K53:25)

// ----------------------------------------------------
// End