//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_font_color
  // Database: 4D Report
  // ID[15D241F9EFB843B2B3F50D5B817D169F]
  // Created #25-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_area;$Lon_color;$Lon_colorType;$Lon_column;$Lon_columnNumber;$Lon_parameters)
C_LONGINT:C283($Lon_row)

If (False:C215)
	C_LONGINT:C283(QR_Get_color ;$0)
	C_LONGINT:C283(QR_Get_color ;$1)
	C_LONGINT:C283(QR_Get_color ;$2)
	C_LONGINT:C283(QR_Get_color ;$3)
	C_LONGINT:C283(QR_Get_color ;$4)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_colorType:=qr text color:K14904:6
	
	If ($Lon_parameters>=2)
		
		$Lon_column:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_row:=$3
			
			If ($Lon_parameters>=4)
				
				$Lon_colorType:=$4  //{qr text color (default) | qr background color}
				
			End if 
		End if 
	End if 
	
	$Lon_color:=-1  //disparate
	
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
				
				$Lon_color:=QR Get text property:C760($Lon_area;$Lon_column;1;$Lon_colorType)
				
				For ($Lon_row;2;3;1)
					
					If ($Lon_color#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;$Lon_colorType))
						
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
					
					$Lon_color:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;$Lon_colorType)
					
					If ($Lon_color=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;$Lon_colorType))
						
						If ($Lon_color=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_colorType))
							
							For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
								
								If ($Lon_color#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;$Lon_colorType))
									
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
		
		$Lon_color:=Choose:C955($Lon_column#MAXLONG:K35:2;$Lon_color;-1)  //-1 if disparate
		
		  //________________________________________
	: ($Lon_column=0)  //compute the line to find a common value
		
		$Lon_columnNumber:=QR Count columns:C764($Lon_area)
		
		If ($Lon_columnNumber>0)
			
			$Lon_color:=QR Get text property:C760($Lon_area;1;$Lon_row;$Lon_colorType)
			
			For ($Lon_column;2;$Lon_columnNumber;1)
				
				If ($Lon_color#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;$Lon_colorType))
					
					$Lon_column:=MAXLONG:K35:2-1
					
				End if 
			End for 
			
			$Lon_color:=Choose:C955($Lon_column#MAXLONG:K35:2;$Lon_color;-1)  //-1 if disparate
			
		End if 
		
		  //________________________________________
	: ($Lon_row=0)  //compute the column to find a common style value
		
		$Lon_color:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;$Lon_colorType)
		
		If ($Lon_color=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;$Lon_colorType))
			
			If ($Lon_color=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_colorType))
				
				ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
				QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
				
				For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
					
					If ($Lon_color#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;$Lon_colorType))
						
						$Lon_row:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
			Else 
				
				$Lon_row:=MAXLONG:K35:2
				
			End if 
			
		Else 
			
			$Lon_row:=MAXLONG:K35:2
			
		End if 
		
		$Lon_color:=Choose:C955($Lon_row#MAXLONG:K35:2;$Lon_color;-1)  //-1 if disparate
		
		  //________________________________________
	Else   //get the cell value
		
		$Lon_color:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;$Lon_colorType)
		
		  //________________________________________
End case 

$0:=$Lon_color

  // ----------------------------------------------------
  // End