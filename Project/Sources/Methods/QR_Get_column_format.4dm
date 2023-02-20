//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_Get_colum_format
// Database: 4D report
// ID[40DC8AADD82C4692A5189DA28EAAA5FC]
// Created #3-4-2014 by Vincent de Lachaux
// Updated #2-20-2023 by Dominique Delahaye
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer; $column : Integer; $column_type : Integer) : Text

If (False:C215)
	C_TEXT:C284(QR_Get_column_format; $0)
	C_LONGINT:C283(QR_Get_column_format; $1)
	C_LONGINT:C283(QR_Get_column_format; $2)
	C_LONGINT:C283(QR_Get_column_format; $3)
End if 

/* 
  ----------------------------------------------------

  CONSTANTS

  ----------------------------------------------------   
*/

var \
$MIXED : Integer

//MARK: uppercase namming ok "K" start namming mean : it's a constant
$MIXED:=-1

/* 
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------   
*/

var \
$count_columns; \
$count_parameters; \
$int : Integer

var \
$buffer; \
$format; \
$text; \
$type : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//$area:=$1
	//$column:=$2
	
	If ($count_parameters>=3)
		
		//$column_type:=$3
		
	End if 
	
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($column=0)  //compute the columns to find a common value
	
	$count_columns:=QR Count columns:C764($area)
	
	If ($count_columns>0)
		
		//get type & format of the first column
		QR GET INFO COLUMN:C766($area; 1; $text; $text; $int; $int; $int; $format)
		$column_type:=QR_Get_column_type($area; 1; True:C214)
		
		//the parse all columns
		For ($column; 2; $count_columns; 1)
			
			QR GET INFO COLUMN:C766($area; $column; $text; $text; $int; $int; $int; $buffer)
			
			If ($buffer#$format)\
				 | ($column_type#QR_Get_column_type($area; $column; True:C214))
				
				//not the same: stop
				$column:=MAXLONG:K35:2-1
				
			End if 
		End for 
		
		$format:=Choose:C955($column#MAXLONG:K35:2; $format; "")
		$column_type:=Choose:C955($column#MAXLONG:K35:2; $column_type; $MIXED)
		
	End if 
	
Else 
	
	QR GET INFO COLUMN:C766($area; $column; $text; $text; $int; $int; $int; $format)
	
	If ($column_type=0)
		
		$column_type:=QR_Get_column_type($area; $column)
		
	End if 
	
End if 

If ($column_type=Is picture:K8:10)\
 | ($column_type=Is date:K8:7)\
 | ($column_type=Is time:K8:8)\
 | ($column_type=Is boolean:K8:9)
	
	$type:=Choose:C955($column_type=Is picture:K8:10; "pict_"; \
		Choose:C955($column_type=Is date:K8:7; "date_"; \
		Choose:C955($column_type=Is time:K8:8; "time_"; \
		Choose:C955($column_type=Is boolean:K8:9; "bolean_"; ""))))
	
	$format:=Get localized string:C991($type+String:C10(Character code:C91($format)))
	
End if 

return $format

// ----------------------------------------------------
// End