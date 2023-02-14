//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_Get_cell_text
// Database: 4D Report
// ID[2DBD7F123CED4F2EACB7EF8CE16E7B71]
// Created #1-4-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($area : Integer; $column : Integer; $row : Integer)->$content : Text

If (False:C215)
	C_LONGINT:C283(QR_Get_cell_text; $1)
	C_LONGINT:C283(QR_Get_cell_text; $2)
	C_LONGINT:C283(QR_Get_cell_text; $3)
	C_TEXT:C284(QR_Get_cell_text; $0)
End if 

var \
$t : Text

var \
$l; \
$operator : Integer

Case of 
		
		//______________________________________________________
	: ($column=0)
		
		ASSERT:C1129(False:C215)
		
		//______________________________________________________
	: ($row=qr title:K14906:1)
		
		QR GET INFO COLUMN:C766($area; $column; $content; $t; $l; $l; $l; $t)
		
		//______________________________________________________
	: ($row=qr detail:K14906:2)
		
		QR GET INFO COLUMN:C766($area; $column; $t; $t; $l; $l; $l; $content)
		
		//______________________________________________________
	Else 
		
		QR GET TOTALS DATA:C768($area; $column; $row; $operator; $content)
		
		// #14-10-2014 - convert operator to text
		If (Length:C16($content)=0)
			
			$content:=(String:C10(Form:C1466.dataTags[0])*Num:C11($operator ?? 0))\
				+(String:C10(Form:C1466.dataTags[1])*Num:C11($operator ?? 1))\
				+(String:C10(Form:C1466.dataTags[2])*Num:C11($operator ?? 2))\
				+(String:C10(Form:C1466.dataTags[3])*Num:C11($operator ?? 3))\
				+(String:C10(Form:C1466.dataTags[4])*Num:C11($operator ?? 4))\
				+(Form:C1466.dataTags[5]*Num:C11($operator ?? 5))
			
			// Remove the last CR if any
			$content:=Split string:C1554($content; "\r").join("\r")
			
		End if 
		
		//______________________________________________________
End case 
