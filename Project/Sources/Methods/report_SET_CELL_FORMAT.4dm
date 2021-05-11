//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_SET_CELL_FORMAT
// Database: 4D Report
// ID[CFD1EA9A46824E22A9A35DF6541EAF89]
// Created #14-3-2014 by Vincent de Lachaux
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
C_TEXT:C284($6)
C_POINTER:C301($7)
C_LONGINT:C283($8)

C_LONGINT:C283($Lon_area; $Lon_columnHidden; $Lon_hidden; $Lon_parameters; $Lon_qrColumn; $Lon_qrRow)
C_LONGINT:C283($Lon_row)
C_POINTER:C301($Ptr_colVar)
C_TEXT:C284($Txt_colName; $Txt_content)

If (False:C215)
	C_LONGINT:C283(report_SET_CELL_FORMAT; $1)
	C_TEXT:C284(report_SET_CELL_FORMAT; $2)
	C_LONGINT:C283(report_SET_CELL_FORMAT; $3)
	C_LONGINT:C283(report_SET_CELL_FORMAT; $4)
	C_LONGINT:C283(report_SET_CELL_FORMAT; $5)
	C_TEXT:C284(report_SET_CELL_FORMAT; $6)
	C_POINTER:C301(report_SET_CELL_FORMAT; $7)
	C_LONGINT:C283(report_SET_CELL_FORMAT; $8)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=6; "Missing parameter"))
	
	$Lon_area:=$1
	
	$Txt_colName:=$2
	$Lon_row:=$3
	$Lon_qrColumn:=$4
	$Lon_qrRow:=$5
	
	$Txt_content:=$6
	$Ptr_colVar:=$7
	
	$Lon_columnHidden:=-1
	
	If ($Lon_parameters>=7)
		
		$Lon_columnHidden:=$8
		
	End if 
	
	$Lon_hidden:=$Lon_columnHidden+QR Get info row:C769($Lon_area; $Lon_qrRow)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_hidden>0)
	
	LISTBOX SET ROW COLOR:C1270(*; $Txt_colName; $Lon_row; <>report_params.headerFontColor; lk font color:K53:24)
	LISTBOX SET ROW COLOR:C1270(*; $Txt_colName; $Lon_row; OB Get:C1224(<>report_params; "header-background-color"; Is longint:K8:6); lk background color:K53:25)
	
Else 
	
	If ($Lon_qrRow=qr title:K14906:1)\
		 | ($Lon_qrRow=qr detail:K14906:2)
		
		//styled
		$Ptr_colVar->{$Lon_row}:=report_cell_styled_content($Lon_area; $Txt_content; $Lon_qrColumn; $Lon_qrRow; $Txt_colName)
		
	End if 
	
	LISTBOX SET ROW COLOR:C1270(*; $Txt_colName; $Lon_row; \
		QR Get text property:C760($Lon_area; $Lon_qrColumn; $Lon_qrRow; qr background color:K14904:8); lk background color:K53:25)
	
End if 

// ----------------------------------------------------
// End