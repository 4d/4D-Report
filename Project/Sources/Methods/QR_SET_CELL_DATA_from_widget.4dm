//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SET_CELL_DATA_from_widget
  // Database: 4D Report
  // ID[575337EEA4F54BB296B357B071C2E199]
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

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_computation;$Lon_data;$Lon_i;$Lon_parameters)
C_LONGINT:C283($Lon_row)
C_TEXT:C284($Txt_data)

If (False:C215)
	C_LONGINT:C283(QR_SET_CELL_DATA_from_widget ;$1)
	C_LONGINT:C283(QR_SET_CELL_DATA_from_widget ;$2)
	C_LONGINT:C283(QR_SET_CELL_DATA_from_widget ;$3)
	C_LONGINT:C283(QR_SET_CELL_DATA_from_widget ;$4)
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
		
		  //NOT USED
		
		  //______________________________________________________
	: ($Lon_row=0)  //applies to the column
		
		  //NOT USED
		
		  //______________________________________________________
	: ($Lon_column=0)  //applies to the line
		
		For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
			
			QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_computation;$Txt_data)
			
			For ($Lon_i;0;5;1)
				
				If ($Lon_data ?? $Lon_i)
					
					$Lon_computation:=$Lon_computation ?+ $Lon_i
					
				Else 
					
					$Lon_computation:=$Lon_computation ?- $Lon_i
					
				End if 
			End for 
			
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_computation)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Txt_data)
			
		End for 
		
		  //______________________________________________________
	Else   //applies to the cell
		
		QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_computation;$Txt_data)
		
		For ($Lon_i;0;5;1)
			
			If ($Lon_data ?? $Lon_i)
				
				$Lon_computation:=$Lon_computation ?+ $Lon_i
				
			Else 
				
				$Lon_computation:=$Lon_computation ?- $Lon_i
				
			End if 
		End for 
		
		QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_computation)
		QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // End