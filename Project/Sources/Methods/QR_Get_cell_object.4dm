//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_Get_cell_object
// Database: 4D Report
// ID[349C65F3AE1D4D3B9B0CE346AE21A0E8]
// Created #25-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer; $column : Integer; $row : Integer)->$cell_object : Object


If (False:C215)
	C_OBJECT:C1216(QR_Get_cell_object; $0)
	C_LONGINT:C283(QR_Get_cell_object; $1)
	C_LONGINT:C283(QR_Get_cell_object; $2)
	C_LONGINT:C283(QR_Get_cell_object; $3)
End if 

/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$count_parameters; \
$operator : Integer

var \
$content : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//$area:=$1
	//$column:=$2
	//$row:=$3
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

$cell_object:=New object:C1471

OB SET:C1220($cell_object; \
"back_color"; QR Get text property:C760($area; $column; $row; qr background color:K14904:8); \
"alternate_color"; QR Get text property:C760($area; $column; $row; qr alternate background color:K14904:9); \
"text_color"; QR Get text property:C760($area; $column; $row; qr text color:K14904:6); \
"style_bold"; QR Get text property:C760($area; $column; $row; qr bold:K14904:3); \
"style_italic"; QR Get text property:C760($area; $column; $row; qr italic:K14904:4); \
"style_underline"; QR Get text property:C760($area; $column; $row; qr underline:K14904:5); \
"text_justification"; QR Get text property:C760($area; $column; $row; qr justification:K14904:7); \
"font"; QR Get text property:C760($area; $column; $row; qr font name:K14904:10); \
"font_size"; QR Get text property:C760($area; $column; $row; qr font size:K14904:2))

If ($row>0) | ($row=qr grand total:K14906:3)
	
	QR GET TOTALS DATA:C768($area; $column; $row; $operator; $content)
	OB SET:C1220($cell_object; \
		"data_operator"; $operator; \
		"data_content"; $content)
	
End if 

return $cell_object
// ----------------------------------------------------
// End