//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_cell_styled_content
// Database: 4D Report
// ID[9FD7D461FE8C4F109B5756D82043CFC8]
// Created #17-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer; $content : Text; $column : Integer; $row : Integer; $col_name : Text) : Text

var $bold; $italic; $offset; $count_parameters : Integer
var $size; $underline : Integer
var $buffer; $color; $font : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//$area:=$1
	
	//$content:=$2
	//$column:=$3
	//$row:=$4
	
	//=======================================================
	//                      TURN AROUND
	//=======================================================
	If ($count_parameters>=5)
		
		//$col_name:=$5
		
	End if 
	
	//=======================================================
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$font:=QR Get text property:C760($area; $column; $row; qr font name:K14904:10)
$size:=QR Get text property:C760($area; $column; $row; qr font size:K14904:2)
$bold:=QR Get text property:C760($area; $column; $row; qr bold:K14904:3)
$italic:=QR Get text property:C760($area; $column; $row; qr italic:K14904:4)
$underline:=QR Get text property:C760($area; $column; $row; qr underline:K14904:5)
$color:=_colorToStyled(QR Get text property:C760($area; $column; $row; qr text color:K14904:6))

If ($content="<span@")  //pre-styled
	
	ST SET ATTRIBUTES:C1093($buffer; ST Start text:K78:15; ST End text:K78:16; \
		Attribute font name:K65:5; $font; \
		Attribute text size:K65:6; $size; \
		Attribute bold style:K65:1; $bold; \
		Attribute italic style:K65:2; $italic; \
		Attribute underline style:K65:4; $underline; \
		Attribute text color:K65:7; $color)
	
	$content:=Replace string:C233($buffer; "</span>"; $content+"</span>")
	
Else 
	
	ST SET ATTRIBUTES:C1093($content; ST Start text:K78:15; ST End text:K78:16; \
		Attribute font name:K65:5; $font; \
		Attribute text size:K65:6; $size; \
		Attribute bold style:K65:1; $bold; \
		Attribute italic style:K65:2; $italic; \
		Attribute underline style:K65:4; $underline; \
		Attribute text color:K65:7; $color)
	
End if 

If (False:C215)  //#redmine:32417 - Remove alignment preview in edit mode.
	
	//========================================================
	//ALIGNMENT
	
	//#WARNING 1:
	//   There is an offset equal to 1 between the Get and the Set
	$offset:=1
	
	//#WARNING 2:
	//   There is no way to set the alignment for a cell.
	//   So the last Set is done for all the column.
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $col_name; \
		QR Get text property:C760($area; $column; $row; qr justification:K14904:7)+$offset)
End if 

//=======================================================

return $content

// ----------------------------------------------------
// End