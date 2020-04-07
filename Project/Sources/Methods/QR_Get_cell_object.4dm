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
C_OBJECT:C1216($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_operator;$Lon_parameters;$Lon_row)
C_TEXT:C284($Txt_content)
C_OBJECT:C1216($Obj_cellObject)

If (False:C215)
	C_OBJECT:C1216(QR_Get_cell_object ;$0)
	C_LONGINT:C283(QR_Get_cell_object ;$1)
	C_LONGINT:C283(QR_Get_cell_object ;$2)
	C_LONGINT:C283(QR_Get_cell_object ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Lon_area:=$1
	
	$Lon_column:=$2
	$Lon_row:=$3
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

OB SET:C1220($Obj_cellObject;\
"back_color";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr background color:K14904:8);\
"alternate_color";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr alternate background color:K14904:9);\
"text_color";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr text color:K14904:6);\
"style_bold";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3);\
"style_italic";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4);\
"style_underline";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5);\
"text_justification";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr justification:K14904:7);\
"font";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font name:K14904:10);\
"font_size";QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2))

If ($Lon_row>0) | ($Lon_row=qr grand total:K14906:3)
	
	QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_content)
	OB SET:C1220($Obj_cellObject;\
		"data_operator";$Lon_operator;\
		"data_content";$Txt_content)
	
End if 

$0:=$Obj_cellObject
  // ----------------------------------------------------
  // End