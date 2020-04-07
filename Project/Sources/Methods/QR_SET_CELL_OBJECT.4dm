//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SET_CELL_OBJECT
  // Database: 4D Report
  // ID[4C80C9C446E8475EBAE98C6FF9291F56]
  // Created #26-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_OBJECT:C1216($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_parameters;$Lon_row)
C_OBJECT:C1216($Obj_cellObject)

If (False:C215)
	C_LONGINT:C283(QR_SET_CELL_OBJECT ;$1)
	C_OBJECT:C1216(QR_SET_CELL_OBJECT ;$2)
	C_LONGINT:C283(QR_SET_CELL_OBJECT ;$3)
	C_LONGINT:C283(QR_SET_CELL_OBJECT ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	$Lon_area:=$1
	
	$Obj_cellObject:=$2
	$Lon_column:=$3
	$Lon_row:=$4
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr background color:K14904:8;OB Get:C1224($Obj_cellObject;"back_color";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr alternate background color:K14904:9;OB Get:C1224($Obj_cellObject;"alternate_color";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr text color:K14904:6;OB Get:C1224($Obj_cellObject;"text_color";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3;OB Get:C1224($Obj_cellObject;"style_bold";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4;OB Get:C1224($Obj_cellObject;"style_italic";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr justification:K14904:7;OB Get:C1224($Obj_cellObject;"style_underline";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr justification:K14904:7;OB Get:C1224($Obj_cellObject;"text_justification";Is longint:K8:6))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr font name:K14904:10;OB Get:C1224($Obj_cellObject;"font";Is text:K8:3))
QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2;OB Get:C1224($Obj_cellObject;"font_size";Is longint:K8:6))

If ($Lon_row>0)\
 | ($Lon_row=qr grand total:K14906:3)
	
	QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;OB Get:C1224($Obj_cellObject;"data_operator";Is longint:K8:6))
	QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;OB Get:C1224($Obj_cellObject;"data_content";Is text:K8:3))
	
End if 

  // ----------------------------------------------------
  // End