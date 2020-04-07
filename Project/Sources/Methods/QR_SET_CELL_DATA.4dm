//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SET_CELL_DATA
  // Database: 4D Report
  // ID[575337EEA4F54BB296B357B07FC2E199]
  // Created #26-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_data;$Lon_operator;$Lon_parameters;$Lon_row)
C_TEXT:C284($Txt_data)

If (False:C215)
	C_LONGINT:C283(QR_SET_CELL_DATA ;$1)
	C_LONGINT:C283(QR_SET_CELL_DATA ;$2)
	C_LONGINT:C283(QR_SET_CELL_DATA ;$3)
	C_LONGINT:C283(QR_SET_CELL_DATA ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	$Lon_row:=$3
	$Lon_data:=$4
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_row=0)\
		 & ($Lon_column=0)  //applies to all cells
		
		For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
			
			ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
			ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
			QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
			
			For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
				
				QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
				QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_data)
				QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Txt_data)
				
			End for 
			
			QR GET TOTALS DATA:C768($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator;$Txt_data)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator ?+ $Lon_data)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;qr grand total:K14906:3;$Txt_data)
			
		End for 
		
		  //______________________________________________________
	: ($Lon_row=0)  //applies to the column
		
		ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
		ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
		QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
		For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
			
			QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_data)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Txt_data)
			
		End for 
		
		QR GET TOTALS DATA:C768($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator;$Txt_data)
		QR SET TOTALS DATA:C767($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_operator ?+ $Lon_data)
		QR SET TOTALS DATA:C767($Lon_area;$Lon_column;qr grand total:K14906:3;$Txt_data)
		
		  //______________________________________________________
	: ($Lon_column=0)  //applies to the line
		
		For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
			
			QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_operator ?+ $Lon_data)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Txt_data)
			
		End for 
		
		  //______________________________________________________
	Else   //applies to the cell (SWITCH)
		
		QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_operator;$Txt_data)
		QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;\
			Choose:C955($Lon_operator ?? $Lon_data;$Lon_operator ?- $Lon_data;$Lon_operator ?+ $Lon_data))
		
		QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // End