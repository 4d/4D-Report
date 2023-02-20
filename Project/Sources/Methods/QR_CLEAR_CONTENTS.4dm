//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_CLEAR_CONTENTS
// Database: 4D Report
// ID[9C4A11B09C88464EA49259D7275F8EF3]
// Created #26-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer; $column : Integer; $row : Integer)


If (False:C215)
	C_LONGINT:C283(QR_CLEAR_CONTENTS; $1)
	C_LONGINT:C283(QR_CLEAR_CONTENTS; $2)
	C_LONGINT:C283(QR_CLEAR_CONTENTS; $3)
End if 

var \
$count_parameters : Integer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=3; "Missing parameter"))
	
	//$area:=$1
	//$column:=$2
	//$row:=$3
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($row=0)\
		 & ($column=0)  //applies to all cells
		
		//For ($Lon_column;1;QR Count columns($Lon_area);1)
		
		//ARRAY LONGINT($tLon_sortedColumns;0x0000)
		//ARRAY LONGINT($tLon_sortOrder;0x0000)
		//QR GET SORTS($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
		//For ($Lon_row;1;Size of array($tLon_sortedColumns);1)
		
		//QR GET TOTALS DATA($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;$Lon_row;$Txt_data)
		
		//End for
		
		//QR GET TOTALS DATA($Lon_area;$Lon_column;qr grand total;$Lon_operator;$Txt_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;qr grand total;$Lon_operator ?+ $Lon_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;qr grand total;$Txt_data)
		
		//End for
		
		//______________________________________________________
	: ($row=0)  //applies to the column
		
		//ARRAY LONGINT($tLon_sortedColumns;0x0000)
		//ARRAY LONGINT($tLon_sortOrder;0x0000)
		//QR GET SORTS($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
		//For ($Lon_row;1;Size of array($tLon_sortedColumns);1)
		
		//QR GET TOTALS DATA($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;$Lon_row;$Txt_data)
		
		//End for
		
		//QR GET TOTALS DATA($Lon_area;$Lon_column;qr grand total;$Lon_operator;$Txt_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;qr grand total;$Lon_operator ?+ $Lon_data)
		//QR SET TOTALS DATA($Lon_area;$Lon_column;qr grand total;$Txt_data)
		
		//______________________________________________________
	: ($column=0)  //applies to the line
		
		For ($column; 1; QR Count columns:C764($area); 1)
			
			QR SET TOTALS DATA:C767($area; $column; $row; 0)
			QR SET TOTALS DATA:C767($area; $column; $row; "")
			
		End for 
		
		//______________________________________________________
	Else   //applies to the cell
		
		QR SET TOTALS DATA:C767($area; $column; $row; 0)
		QR SET TOTALS DATA:C767($area; $column; $row; "")
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// End