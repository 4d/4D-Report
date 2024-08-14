//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_Get_colum_format
// Database: 4D report
// ID[40DC8AADD82C4692A5189DA28EAAA5FC]
// Created #3-4-2014 by Vincent de Lachaux
// Updated #2-20-2023 by Dominique Delahaye
// ----------------------------------------------------
#DECLARE($area : Integer; $column : Integer; $columnType : Integer) : Text

//MARK: uppercase namming or "K" start namming mean : it's a constant
var $MIXED : Integer
$MIXED:=-1

var $count; $int : Integer
var $buffer; $format; $text; $type : Text

If ($column=0)  // Compute the columns to find a common value
	
	$count:=QR Count columns:C764($area)
	
	If ($count>0)
		
		// Get type & format of the first column
		QR GET INFO COLUMN:C766($area; 1; $text; $text; $int; $int; $int; $format)
		$columnType:=QR_Get_column_type($area; 1; True:C214)
		
		// The parse all columns
		For ($column; 2; $count; 1)
			
			QR GET INFO COLUMN:C766($area; $column; $text; $text; $int; $int; $int; $buffer)
			
			If ($buffer#$format)\
				 | ($columnType#QR_Get_column_type($area; $column; True:C214))
				
				// Not the same: stop
				$column:=MAXLONG:K35:2-1
				
			End if 
		End for 
		
		$format:=$column#MAXLONG:K35:2 ? $format : ""
		$columnType:=$column#MAXLONG:K35:2 ? $columnType : $MIXED
		
	End if 
	
Else 
	
	QR GET INFO COLUMN:C766($area; $column; $text; $text; $int; $int; $int; $format)
	
	$columnType:=$columnType=0 ? QR_Get_column_type($area; $column) : $columnType
	
End if 

If ($columnType=Is picture:K8:10)\
 | ($columnType=Is date:K8:7)\
 | ($columnType=Is time:K8:8)\
 | ($columnType=Is boolean:K8:9)
	
	$type:=Choose:C955($columnType=Is picture:K8:10; "pict_"; \
		Choose:C955($columnType=Is date:K8:7; "date_"; \
		Choose:C955($columnType=Is time:K8:8; "time_"; \
		Choose:C955($columnType=Is boolean:K8:9; "boolean_"; ""))))
	
	$format:=Get localized string:C991($type+String:C10(Character code:C91($format)))
	
End if 

return $format