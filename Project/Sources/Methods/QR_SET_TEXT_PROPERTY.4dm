//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_SET_TEXT_PROPERTY
  // Database: 4D Report
  // ID[15A97CCE1E9544E6B66EB8A851D0050C]
  // Created #24-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_parameters;$Lon_property;$Lon_row)
C_TEXT:C284($Txt_value)

If (False:C215)
	C_LONGINT:C283(QR_SET_TEXT_PROPERTY ;$1)
	C_LONGINT:C283(QR_SET_TEXT_PROPERTY ;$2)
	C_TEXT:C284(QR_SET_TEXT_PROPERTY ;$3)
	C_LONGINT:C283(QR_SET_TEXT_PROPERTY ;$4)
	C_LONGINT:C283(QR_SET_TEXT_PROPERTY ;$5)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=3;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_property:=$2
	$Txt_value:=$3
	
	If ($Lon_parameters>=4)
		
		$Lon_column:=$4
		
		If ($Lon_parameters>=5)
			
			$Lon_row:=$5
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //________________________________________
	: (Not:C34(QR_is_valid_area ($Lon_area)))
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Lon_column=0)\
		 & ($Lon_row=0)  //applies to all cells
		
		For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
			
			If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
				
				For ($Lon_row;1;3;1)
					
					If ($Lon_property=qr font name:K14904:10)
						
						QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;$Txt_value)
						
					Else 
						
						QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;Num:C11($Txt_value))
						
					End if 
				End for 
				
			Else 
				
				If ($Lon_property=qr font name:K14904:10)
					
					QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr title:K14906:1;$Lon_property;$Txt_value)
					
				Else 
					
					QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr title:K14906:1;$Lon_property;Num:C11($Txt_value))
					
				End if 
				
				If ($Lon_property=qr font name:K14904:10)
					
					QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr detail:K14906:2;$Lon_property;$Txt_value)
					
				Else 
					
					QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr detail:K14906:2;$Lon_property;Num:C11($Txt_value))
					
				End if 
				
				ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
				ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
				QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
				
				For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
					
					If ($Lon_property=qr font name:K14904:10)
						
						QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;$Txt_value)
						
					Else 
						
						QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;Num:C11($Txt_value))
						
					End if 
				End for 
				
				If ($Lon_property=qr font name:K14904:10)
					
					QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_property;$Txt_value)
					
				Else 
					
					QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_property;Num:C11($Txt_value))
					
				End if 
			End if 
		End for 
		
		  //______________________________________________________
	: ($Lon_column=0)  //applies to the line
		
		For ($Lon_column;1;QR Count columns:C764($Lon_area);1)
			
			If ($Lon_property=qr font name:K14904:10)
				
				QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;$Txt_value)
				
			Else 
				
				QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;Num:C11($Txt_value))
				
			End if 
		End for 
		
		  //______________________________________________________
	: ($Lon_row=0)  //applies to the column
		
		If ($Lon_property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr title:K14906:1;$Lon_property;$Txt_value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr title:K14906:1;$Lon_property;Num:C11($Txt_value))
			
		End if 
		
		If ($Lon_property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr detail:K14906:2;$Lon_property;$Txt_value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr detail:K14906:2;$Lon_property;Num:C11($Txt_value))
			
		End if 
		
		ARRAY LONGINT:C221($tLon_sortedColumns;0x0000)
		ARRAY LONGINT:C221($tLon_sortOrder;0x0000)
		QR GET SORTS:C753($Lon_area;$tLon_sortedColumns;$tLon_sortOrder)
		
		For ($Lon_row;1;Size of array:C274($tLon_sortedColumns);1)
			
			If ($Lon_property=qr font name:K14904:10)
				
				QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;$Txt_value)
				
			Else 
				
				QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;Num:C11($Txt_value))
				
			End if 
		End for 
		
		If ($Lon_property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_property;$Txt_value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;qr grand total:K14906:3;$Lon_property;Num:C11($Txt_value))
			
		End if 
		
		  //______________________________________________________
	Else   //applies to the cell
		
		If ($Lon_property=qr font name:K14904:10)
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;$Txt_value)
			
		Else 
			
			QR SET TEXT PROPERTY:C759($Lon_area;$Lon_column;$Lon_row;$Lon_property;Num:C11($Txt_value))
			
		End if 
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // End