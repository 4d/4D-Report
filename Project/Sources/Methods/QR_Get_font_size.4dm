//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_font_size
  // Database: 4D Report
  // ID[FF3EE05E495E436EBB23939F67F37934]
  // Created #24-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_columnNumber;$Lon_fontSize;$Lon_parameters;$Lon_row)

If (False:C215)
	C_LONGINT:C283(QR_Get_font_size ;$0)
	C_LONGINT:C283(QR_Get_font_size ;$1)
	C_LONGINT:C283(QR_Get_font_size ;$2)
	C_LONGINT:C283(QR_Get_font_size ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Lon_area:=$1
	
	If ($Lon_parameters>=2)
		
		$Lon_column:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_row:=$3
			
		End if 
	End if 
	
	$Lon_fontSize:=-1  //disparate
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //________________________________________
	: ($Lon_column=0)\
		 & ($Lon_row=0)  //compute the area to find a common value
		
		If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
			
			For ($Lon_column;1;3;1)
				
				$Lon_fontSize:=QR Get text property:C760($Lon_area;$Lon_column;1;qr font size:K14904:2)
				
				For ($Lon_row;2;3;1)
					
					If ($Lon_fontSize#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2))
						
						$Lon_row:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
				$Lon_column:=Choose:C955($Lon_row#MAXLONG:K35:2;$Lon_column;MAXLONG:K35:2-1)  //stop ?
				
			End for 
			
		Else 
			
			$Lon_columnNumber:=QR Count columns:C764($Lon_area)
			
			If ($Lon_columnNumber>0)
				
				ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
				QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
				
				For ($Lon_column;1;$Lon_columnNumber;1)
					
					$Lon_fontSize:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr font size:K14904:2)
					
					If ($Lon_fontSize=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr font size:K14904:2))
						
						If ($Lon_fontSize=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr font size:K14904:2))
							
							For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
								
								If ($Lon_fontSize#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2))
									
									$Lon_row:=MAXLONG:K35:2-1
									
								End if 
							End for 
							
						Else 
							
							$Lon_row:=MAXLONG:K35:2
							
						End if 
						
					Else 
						
						$Lon_row:=MAXLONG:K35:2
						
					End if 
					
					$Lon_column:=Choose:C955($Lon_row#MAXLONG:K35:2;$Lon_column;MAXLONG:K35:2-1)  //stop ?
					
				End for 
			End if 
		End if 
		
		$Lon_fontSize:=Choose:C955($Lon_column#MAXLONG:K35:2;$Lon_fontSize;-1)  //-1 if disparate
		
		  //________________________________________
	: ($Lon_column=0)  //compute the line to find a common value
		
		$Lon_columnNumber:=QR Count columns:C764($Lon_area)
		
		If ($Lon_columnNumber>0)
			
			$Lon_fontSize:=QR Get text property:C760($Lon_area;1;$Lon_row;qr font size:K14904:2)
			
			For ($Lon_column;2;$Lon_columnNumber;1)
				
				If ($Lon_fontSize#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2))
					
					$Lon_column:=MAXLONG:K35:2-1
					
				End if 
			End for 
			
			$Lon_fontSize:=Choose:C955($Lon_column#MAXLONG:K35:2;$Lon_fontSize;-1)  //-1 if disparate
			
		End if 
		
		  //________________________________________
	: ($Lon_row=0)  //compute the column to find a common style value
		
		$Lon_fontSize:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr font size:K14904:2)
		
		If ($Lon_fontSize=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr font size:K14904:2))
			
			If ($Lon_fontSize=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr font size:K14904:2))
				
				ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
				QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
				
				For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
					
					If ($Lon_fontSize#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2))
						
						$Lon_row:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
			Else 
				
				$Lon_row:=MAXLONG:K35:2
				
			End if 
			
		Else 
			
			$Lon_row:=MAXLONG:K35:2
			
		End if 
		
		$Lon_fontSize:=Choose:C955($Lon_row#MAXLONG:K35:2;$Lon_fontSize;-1)  //-1 if disparate
		
		  //________________________________________
	Else   //get the cell value
		
		$Lon_fontSize:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr font size:K14904:2)
		
		  //________________________________________
End case 

$0:=$Lon_fontSize

  // ----------------------------------------------------
  // End