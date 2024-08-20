//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SET_TEXT_PROPERTY
// Database: 4D Report
// ID[15A97CCE1E9544E6B66EB8A851D0050C]
// Created #24-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE($area : Integer; $property : Integer; $value : Text; $column : Integer; $row : Integer)

var $count_parameters; $column_number; $row_number : Integer

$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=3; "Missing parameter"))
	
	If ($count_parameters>=4)
		
		$column_number:=$column
		
		If ($count_parameters>=5)
			
			$row_number:=$row
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

Case of 
		
		//________________________________________
	: (Not:C34(QR_is_valid_area($area)))
		
		//NOTHING MORE TO DO
		
		//______________________________________________________
	: ($column_number=0)\
		 & ($row_number=0)  // Applies to all cells
		
		For ($column_number; 1; QR Count columns:C764($area); 1)
			
			If (QR Get report kind:C755($area)=qr cross report:K14902:2)
				
				For ($row_number; 1; 3; 1)
					
					If ($property=qr font name:K14904:10)
						
						QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; $value)
						
					Else 
						
						QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; Num:C11($value))
						
					End if 
				End for 
				
			Else 
				
				If ($property=qr font name:K14904:10)
					
					QR SET TEXT PROPERTY:C759($area; $column_number; qr title:K14906:1; $property; $value)
					
				Else 
					
					QR SET TEXT PROPERTY:C759($area; $column_number; qr title:K14906:1; $property; Num:C11($value))
					
				End if 
				
				If ($property=qr font name:K14904:10)
					
					QR SET TEXT PROPERTY:C759($area; $column_number; qr detail:K14906:2; $property; $value)
					
				Else 
					
					QR SET TEXT PROPERTY:C759($area; $column_number; qr detail:K14906:2; $property; Num:C11($value))
					
				End if 
				
				ARRAY LONGINT:C221($_sortedColumns; 0x0000)
				ARRAY LONGINT:C221($_sortOrder; 0x0000)
				
				QR GET SORTS:C753($area; $_sortedColumns; $_sortOrder)
				
				For ($row_number; 1; Size of array:C274($_sortedColumns); 1)
					
					If ($property=qr font name:K14904:10)
						
						QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; $value)
						
					Else 
						
						QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; Num:C11($value))
						
					End if 
				End for 
				
				If ($property=qr font name:K14904:10)
					
					QR SET TEXT PROPERTY:C759($area; $column_number; qr grand total:K14906:3; $property; $value)
					
				Else 
					
					QR SET TEXT PROPERTY:C759($area; $column_number; qr grand total:K14906:3; $property; Num:C11($value))
					
				End if 
			End if 
		End for 
		
		//______________________________________________________
	: ($column_number=0)  // Applies to the line
		
		For ($column_number; 1; QR Count columns:C764($area); 1)
			
			If ($property=qr font name:K14904:10)
				
				QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; $value)
				
			Else 
				
				QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; Num:C11($value))
				
			End if 
		End for 
		
		//______________________________________________________
	: ($row_number=0)  // Applies to the column
		
		If ($property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($area; $column_number; qr title:K14906:1; $property; $value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($area; $column_number; qr title:K14906:1; $property; Num:C11($value))
			
		End if 
		
		If ($property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($area; $column_number; qr detail:K14906:2; $property; $value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($area; $column_number; qr detail:K14906:2; $property; Num:C11($value))
			
		End if 
		
		ARRAY LONGINT:C221($_sortedColumns; 0x0000)
		ARRAY LONGINT:C221($_sortOrder; 0x0000)
		QR GET SORTS:C753($area; $_sortedColumns; $_sortOrder)
		
		For ($row_number; 1; Size of array:C274($_sortedColumns); 1)
			
			If ($property=qr font name:K14904:10)
				
				QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; $value)
				
			Else 
				
				QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; Num:C11($value))
				
			End if 
		End for 
		
		If ($property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($area; $column_number; qr grand total:K14906:3; $property; $value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($area; $column_number; qr grand total:K14906:3; $property; Num:C11($value))
			
		End if 
		
		//______________________________________________________
	Else   // Applies to the cell
		
		If ($property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; $value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($area; $column_number; $row_number; $property; Num:C11($value))
			
		End if 
		
		//______________________________________________________
End case 