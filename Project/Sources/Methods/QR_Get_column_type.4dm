//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : QR_Get_column_type
  // Database: 4D Report
  // ID[C1017995832D4FF8B52AC8D5DF44D154]
  // Created #2-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_permissive)
C_LONGINT:C283($kLon_mixed;$kLon_stop;$kLon_undefined;$Lon_;$Lon_area;$Lon_column)
C_LONGINT:C283($Lon_columnNumber;$Lon_field;$Lon_i;$Lon_parameters;$Lon_table;$Lon_type)
C_LONGINT:C283($Lon_x)
C_TEXT:C284($Txt_;$Txt_field;$Txt_object;$Txt_table;$Txt_variableName)

If (False:C215)
	C_LONGINT:C283(QR_Get_column_type ;$0)
	C_LONGINT:C283(QR_Get_column_type ;$1)
	C_LONGINT:C283(QR_Get_column_type ;$2)
	C_BOOLEAN:C305(QR_Get_column_type ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	
	If ($Lon_parameters>=3)
		
		$Boo_permissive:=$3
		
	End if 
	
	$kLon_stop:=MAXLONG:K35:2-1
	$kLon_undefined:=Is undefined:K8:13
	$kLon_mixed:=-1
	
	$Lon_type:=$kLon_undefined
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_column=0)
	
	  //compute the columns to find a common value
	$Lon_columnNumber:=QR Count columns:C764($Lon_area)
	
	If ($Lon_columnNumber>0)
		
		$Lon_type:=QR_Get_column_type ($Lon_area;1;True:C214)  // <===== RECURSIVE
		
		For ($Lon_column;2;$Lon_columnNumber;1)
			
			If ($Lon_type#QR_Get_column_type ($Lon_area;$Lon_column;True:C214))  // <===== RECURSIVE
				
				$Lon_column:=$kLon_stop
				
			End if 
		End for 
		
		$Lon_type:=Choose:C955($Lon_column#MAXLONG:K35:2;$Lon_type;$kLon_mixed)
		
	End if 
	
Else 
	
	QR GET INFO COLUMN:C766($Lon_area;$Lon_column;\
		$Txt_;\
		$Txt_object;\
		$Lon_;\
		$Lon_;\
		$Lon_;\
		$Txt_;\
		$Txt_variableName)
	
	If (Length:C16($Txt_variableName)=0)
		
		$Lon_x:=Position:C15("]";$Txt_object)
		$Txt_table:=Substring:C12($Txt_object;2;$Lon_x-2)
		$Txt_field:=Substring:C12($Txt_object;$Lon_x+1)
		
		For ($Lon_i;1;Get last table number:C254;1)
			
			If (Is table number valid:C999($Lon_i))
				
				If ($Txt_table=Table name:C256($Lon_i))
					
					$Lon_table:=$Lon_i
					
					For ($Lon_i;1;Get last field number:C255($Lon_table);1)
						
						If (Is field number valid:C1000($Lon_table;$Lon_i))
							
							If (Field name:C257($Lon_table;$Lon_i)=$Txt_field)
								
								$Lon_field:=$Lon_i
								$Lon_i:=MAXLONG:K35:2-1
								
							End if 
						End if 
					End for 
					
					$Lon_i:=MAXLONG:K35:2-1
					
				End if 
			End if 
		End for 
		
		If ($Lon_i=MAXLONG:K35:2)\
			 & ($Lon_field#0)
			
			$Lon_type:=Type:C295(Field:C253($Lon_table;$Lon_field)->)
			
			Case of 
					
					  //……………………………………………………………………………
				: (Not:C34($Boo_permissive))
					
					  //NOTHING MORE TO DO
					
					  //……………………………………………………………………………
				: ($Lon_type=Is alpha field:K8:1)\
					 | ($Lon_type=Is string var:K8:2)
					
					$Lon_type:=Is text:K8:3
					
					  //……………………………………………………………………………
				: ($Lon_type=Is integer:K8:5)\
					 | ($Lon_type=Is integer 64 bits:K8:25)\
					 | ($Lon_type=Is real:K8:4)\
					 | ($Lon_type=Is float:K8:26)
					
					$Lon_type:=Is longint:K8:6
					
					  //……………………………………………………………………………
			End case 
		End if 
		
	Else 
		
		$Lon_type:=$kLon_undefined
		
	End if 
End if 

$0:=$Lon_type

  // ----------------------------------------------------
  // End