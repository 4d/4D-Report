//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_font_style
  // Database: 4D Report
  // ID[10E6E229B5EB4166AF4B59538DC081E0]
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

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_area;$Lon_bold;$Lon_column;$Lon_columnNumber;$Lon_fontStyle;$Lon_italic)
C_LONGINT:C283($Lon_parameters;$Lon_row;$Lon_underline)

If (False:C215)
	C_LONGINT:C283(QR_Get_font_style ;$0)
	C_LONGINT:C283(QR_Get_font_style ;$1)
	C_LONGINT:C283(QR_Get_font_style ;$2)
	C_LONGINT:C283(QR_Get_font_style ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Lon_area:=$1
	
	If ($Lon_parameters>=2)
		
		$Lon_column:=$2  //{area if ommited}
		
		If ($Lon_parameters>=3)
			
			$Lon_row:=$3  //{column if ommited}
			
		End if 
	End if 
	
	$Lon_fontStyle:=-1  //disparate
	
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
				
				$Lon_bold:=QR Get text property:C760($Lon_area;$Lon_column;1;qr bold:K14904:3)
				$Lon_italic:=QR Get text property:C760($Lon_area;$Lon_column;1;qr italic:K14904:4)
				$Lon_underline:=QR Get text property:C760($Lon_area;$Lon_column;1;qr underline:K14904:5)
				
				For ($Lon_row;2;3;1)
					
					If ($Lon_bold#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3))\
						 | ($Lon_italic#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4))\
						 | ($Lon_underline#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5))
						
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
					
					$Lon_bold:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr bold:K14904:3)
					$Lon_italic:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr italic:K14904:4)
					$Lon_underline:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr underline:K14904:5)
					
					If ($Lon_bold=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr bold:K14904:3))\
						 & ($Lon_italic=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr italic:K14904:4))\
						 & ($Lon_underline=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr underline:K14904:5))
						
						If ($Lon_bold=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr bold:K14904:3))\
							 & ($Lon_italic=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr italic:K14904:4))\
							 & ($Lon_underline=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr underline:K14904:5))
							
							For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
								
								If ($Lon_bold#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3))\
									 | ($Lon_italic#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4))\
									 | ($Lon_underline#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5))
									
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
		
		$Boo_OK:=($Lon_column#MAXLONG:K35:2)
		
		  //________________________________________
	: ($Lon_column=0)  //compute the line to find a common value
		
		$Lon_columnNumber:=QR Count columns:C764($Lon_area)
		
		If ($Lon_columnNumber>0)
			
			$Lon_bold:=QR Get text property:C760($Lon_area;1;$Lon_row;qr bold:K14904:3)
			$Lon_italic:=QR Get text property:C760($Lon_area;1;$Lon_row;qr italic:K14904:4)
			$Lon_underline:=QR Get text property:C760($Lon_area;1;$Lon_row;qr underline:K14904:5)
			
			For ($Lon_column;2;$Lon_columnNumber;1)
				
				If ($Lon_bold#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3))\
					 | ($Lon_italic#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4))\
					 | ($Lon_underline#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5))
					
					$Lon_column:=MAXLONG:K35:2-1
					
				End if 
			End for 
			
			$Boo_OK:=($Lon_column#MAXLONG:K35:2)
			
		End if 
		
		  //________________________________________
	: ($Lon_row=0)  //compute the column to find a common value
		
		$Lon_bold:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr bold:K14904:3)
		$Lon_italic:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr italic:K14904:4)
		$Lon_underline:=QR Get text property:C760($Lon_area;$Lon_column;qr title:K14906:1;qr underline:K14904:5)
		
		If ($Lon_bold=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr bold:K14904:3))\
			 & ($Lon_italic=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr italic:K14904:4))\
			 & ($Lon_underline=QR Get text property:C760($Lon_area;$Lon_column;qr detail:K14906:2;qr underline:K14904:5))
			
			If ($Lon_bold=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr bold:K14904:3))\
				 & ($Lon_italic=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr italic:K14904:4))\
				 & ($Lon_underline=QR Get text property:C760($Lon_area;$Lon_column;qr grand total:K14906:3;qr underline:K14904:5))
				
				ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
				QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
				
				For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
					
					If ($Lon_bold#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3))\
						 | ($Lon_italic#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4))\
						 | ($Lon_underline#QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5))
						
						$Lon_row:=MAXLONG:K35:2-1
						
					End if 
				End for 
				
				$Boo_OK:=($Lon_row#MAXLONG:K35:2)
				
			End if 
		End if 
		
		  //________________________________________
	Else   //get the cell value
		
		$Lon_bold:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr bold:K14904:3)
		$Lon_italic:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr italic:K14904:4)
		$Lon_underline:=QR Get text property:C760($Lon_area;$Lon_column;$Lon_row;qr underline:K14904:5)
		
		$Boo_OK:=True:C214
		
		  //________________________________________
End case 

If ($Boo_OK)
	
	  //concatenate styles into one value
	$Lon_fontStyle:=$Lon_bold+($Lon_italic*2)+($Lon_underline*4)
	
End if 

$0:=$Lon_fontStyle

  // ----------------------------------------------------
  // End