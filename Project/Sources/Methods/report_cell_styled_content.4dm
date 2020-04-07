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
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_LONGINT:C283($Lon_area;$Lon_bold;$Lon_column;$Lon_italic;$Lon_offset;$Lon_parameters)
C_LONGINT:C283($Lon_row;$Lon_size;$Lon_underline)
C_TEXT:C284($Txt_buffer;$Txt_colName;$Txt_color;$Txt_content;$Txt_font)

If (False:C215)
	C_TEXT:C284(report_cell_styled_content ;$0)
	C_LONGINT:C283(report_cell_styled_content ;$1)
	C_TEXT:C284(report_cell_styled_content ;$2)
	C_LONGINT:C283(report_cell_styled_content ;$3)
	C_LONGINT:C283(report_cell_styled_content ;$4)
	C_TEXT:C284(report_cell_styled_content ;$5)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Lon_area:=$1
	
	$Txt_content:=$2
	$Lon_column:=$3
	$Lon_row:=$4
	
	  //=======================================================
	  //                      TURN AROUND
	  //=======================================================
	If ($Lon_parameters>=5)
		
		$Txt_colName:=$5
		
	End if 
	
	  //=======================================================
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_font:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font name:K14904:10)
$Lon_size:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2)
$Lon_bold:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3)
$Lon_italic:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4)
$Lon_underline:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5)
$Txt_color:=_colorToStyled (QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr text color:K14904:6))

If ($Txt_content="<span@")  //pre-styled
	
	ST SET ATTRIBUTES:C1093($Txt_buffer;ST Start text:K78:15;ST End text:K78:16;\
		Attribute font name:K65:5;$Txt_font;\
		Attribute text size:K65:6;$Lon_size;\
		Attribute bold style:K65:1;$Lon_bold;\
		Attribute italic style:K65:2;$Lon_italic;\
		Attribute underline style:K65:4;$Lon_underline;\
		Attribute text color:K65:7;$Txt_color)
	
	$Txt_content:=Replace string:C233($Txt_buffer;"</span>";$Txt_content+"</span>")
	
Else 
	
	ST SET ATTRIBUTES:C1093($Txt_content;ST Start text:K78:15;ST End text:K78:16;\
		Attribute font name:K65:5;$Txt_font;\
		Attribute text size:K65:6;$Lon_size;\
		Attribute bold style:K65:1;$Lon_bold;\
		Attribute italic style:K65:2;$Lon_italic;\
		Attribute underline style:K65:4;$Lon_underline;\
		Attribute text color:K65:7;$Txt_color)
	
End if 

If (False:C215)  //#redmine:32417 - Remove alignment preview in edit mode.
	
	  //========================================================
	  //ALIGNMENT
	
	  //#WARNING 1:
	  //   There is an offset equal to 1 between the Get and the Set
	$Lon_offset:=1
	
	  //#WARNING 2:
	  //   There is no way to set the alignment for a cell.
	  //   So the last Set is done for all the column.
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$Txt_colName;\
		QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr justification:K14904:7)+$Lon_offset)
End if 

  //=======================================================

$0:=$Txt_content

  // ----------------------------------------------------
  // End