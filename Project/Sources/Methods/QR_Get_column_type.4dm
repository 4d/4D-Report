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


#DECLARE($area : Integer; $column_number : Integer; $permissive : Boolean)->$column_type : Integer

/* 
  ----------------------------------------------------

  CONSTANTS

  ----------------------------------------------------   
*/

var \
$MAX_LONGINT; \
$MIXED_TYPE : Integer

//MARK: uppercase namming mean : it's a constant
$MAX_LONGINT:=MAXLONG:K35:2-1
$MIXED_TYPE:=-1

/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$count_parameters; \
$count_columns; \
$int; \
$i; \
$index; \
$table_number; \
$field_number : Integer

var \
$text; \
$table_name; \
$field_name; \
$variable_name; \
$column_object : Text

var \
$is_permissive : Boolean

// ----------------------------------------------------

If (False:C215)
	C_LONGINT:C283(QR_Get_column_type; $0)
	C_LONGINT:C283(QR_Get_column_type; $1)
	C_LONGINT:C283(QR_Get_column_type; $2)
	C_BOOLEAN:C305(QR_Get_column_type; $3)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//$area_reference:=$1
	//$column_number:=$2
	
	If ($count_parameters>=3)
		
		$is_permissive:=$permissive
		
	End if 
	
	
	
	$column_type:=Is undefined:K8:13
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($column_number=0)
	
	//compute the columns to find a common value
	$count_columns:=QR Count columns:C764($area)
	
	If ($count_columns>0)
		
		$column_type:=QR_Get_column_type($area; 1; True:C214)  // <===== RECURSIVE
		
		For ($column_number; 2; $count_columns; 1)
			
			If ($column_type#QR_Get_column_type($area; $column_number; True:C214))  // <===== RECURSIVE
				
				$column_number:=$MAX_LONGINT
				
			End if 
		End for 
		
		$column_type:=Choose:C955($column_number#MAXLONG:K35:2; $column_type; $MIXED_TYPE)
		
	End if 
	
Else 
	
	QR GET INFO COLUMN:C766($area; $column_number; \
		$text; \
		$column_object; \
		$int; \
		$int; \
		$int; \
		$text; \
		$variable_name)
	
	If (Length:C16($variable_name)=0)
		
		$index:=Position:C15("]"; $column_object)
		$table_name:=Substring:C12($column_object; 2; $index-2)
		$field_name:=Substring:C12($column_object; $index+1)
		
		//todo: #DD may be optimize this using "ds" 
		
		For ($i; 1; Get last table number:C254; 1)
			
			If (Is table number valid:C999($i))
				
				If ($table_name=Table name:C256($i))
					
					$table_number:=$i
					
					For ($i; 1; Get last field number:C255($table_number); 1)
						
						If (Is field number valid:C1000($table_number; $i))
							
							If (Field name:C257($table_number; $i)=$field_name)
								
								$field_number:=$i
								$i:=$MAX_LONGINT
								
							End if 
						End if 
					End for 
					
					$i:=$MAX_LONGINT
					
				End if 
			End if 
		End for 
		
		If ($i=MAXLONG:K35:2)\
			 & ($field_number#0)
			
			$column_type:=Type:C295(Field:C253($table_number; $field_number)->)
			
			Case of 
					
					//……………………………………………………………………………
				: (Not:C34($is_permissive))
					
					//NOTHING MORE TO DO
					
					//……………………………………………………………………………
				: ($column_type=Is alpha field:K8:1)\
					 | ($column_type=Is string var:K8:2)
					
					$column_type:=Is text:K8:3
					
					//……………………………………………………………………………
				: ($column_type=Is integer:K8:5)\
					 | ($column_type=Is integer 64 bits:K8:25)\
					 | ($column_type=Is real:K8:4)\
					 | ($column_type=_o_Is float:K8:26)
					
					$column_type:=Is longint:K8:6
					
					//……………………………………………………………………………
			End case 
		End if 
		
	Else 
		
		$column_type:=Is undefined:K8:13
		
	End if 
End if 

//$0:=$column_type

// ----------------------------------------------------
// End