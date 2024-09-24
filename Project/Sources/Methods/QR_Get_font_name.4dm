//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_Get_font_name
// Database: 4D Report
// ID[A13ECEF4CC0B4392A22958AD1B993CD7]
// Created #24-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer; $column : Integer; $row : Integer)->$font_name : Text


/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$count_parameters; \
$count_columns : Integer


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//$area:=$1
	
	If ($count_parameters>=2)
		
		//$column:=$2  //{area if ommited}
		
		If ($count_parameters>=3)
			
			//$row:=$3  //{column if ommited}
			
		End if 
	End if 
	
	$font_name:="-"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//________________________________________
	: ($column=0)\
		 & ($row=0)  //compute the area to find a common value
		
		If (QR Get report kind:C755($area)=qr cross report:K14902:2)
			
			For ($column; 1; 3; 1)
				
				$font_name:=QR Get text property:C760($area; $column; 1; qr font name:K14904:10)
				
				For ($row; 2; 3; 1)
					
					If ($font_name#QR Get text property:C760($area; $column; $row; qr font name:K14904:10))
						
						$row:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
				$column:=Choose:C955($row#MAXLONG:K35:2; $column; MAXLONG:K35:2-1)  //stop ?
				
			End for 
			
		Else 
			
			$count_columns:=QR Count columns:C764($area)
			
			If ($count_columns>0)
				
				ARRAY LONGINT:C221($tLon_sortedColumns; 0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder; 0x0000)
				QR GET SORTS:C753($area; $tLon_sortedColumns; $tLon_sortOrder)
				
				For ($column; 1; $count_columns; 1)
					
					$font_name:=QR Get text property:C760($area; $column; qr title:K14906:1; qr font name:K14904:10)
					
					If ($font_name=QR Get text property:C760($area; $column; qr detail:K14906:2; qr font name:K14904:10))
						
						If ($font_name=QR Get text property:C760($area; $column; qr grand total:K14906:3; qr font name:K14904:10))
							
							For ($row; 1; Size of array:C274($tLon_sortedColumns); 1)
								
								If ($font_name#QR Get text property:C760($area; $column; $row; qr font name:K14904:10))
									
									$row:=MAXLONG:K35:2-1
									
								End if 
								
							End for 
							
						Else 
							
							$row:=MAXLONG:K35:2
							
						End if 
						
					Else 
						
						$row:=MAXLONG:K35:2
						
					End if 
					
					$column:=Choose:C955($row#MAXLONG:K35:2; $column; MAXLONG:K35:2-1)  //stop ?
					
				End for 
			End if 
		End if 
		
		$font_name:=Choose:C955($column#MAXLONG:K35:2; $font_name; "-")  //"-" if disparate
		
		//________________________________________
	: ($column=0)  //compute the line to find a common value
		
		$count_columns:=QR Count columns:C764($area)
		
		If ($count_columns>0)
			
			$font_name:=QR Get text property:C760($area; 1; $row; qr font name:K14904:10)
			
			For ($column; 2; $count_columns; 1)
				
				If ($font_name#QR Get text property:C760($area; $column; $row; qr font name:K14904:10))
					
					$column:=MAXLONG:K35:2-1
					
				End if 
			End for 
			
			$font_name:=Choose:C955($column#MAXLONG:K35:2; $font_name; "-")  //"-" if disparate
			
		End if 
		
		//________________________________________
	: ($row=0)  //compute the column to find a common value
		
		$font_name:=QR Get text property:C760($area; $column; qr title:K14906:1; qr font name:K14904:10)
		
		If ($font_name=QR Get text property:C760($area; $column; qr detail:K14906:2; qr font name:K14904:10))
			
			If ($font_name=QR Get text property:C760($area; $column; qr grand total:K14906:3; qr font name:K14904:10))
				
				ARRAY LONGINT:C221($tLon_sortedColumns; 0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder; 0x0000)
				QR GET SORTS:C753($area; $tLon_sortedColumns; $tLon_sortOrder)
				
				For ($row; 1; Size of array:C274($tLon_sortedColumns); 1)
					
					If ($font_name#QR Get text property:C760($area; $column; $row; qr font name:K14904:10))
						
						$row:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
			Else 
				
				$row:=MAXLONG:K35:2
				
			End if 
			
		Else 
			
			$row:=MAXLONG:K35:2
			
		End if 
		
		$font_name:=Choose:C955($row#MAXLONG:K35:2; $font_name; "-")  //"-" if disparate
		
		//________________________________________
	Else   //get the cell value
		
		$font_name:=QR Get text property:C760($area; $column; $row; qr font name:K14904:10)
		
		//________________________________________
End case 


// ----------------------------------------------------
// End