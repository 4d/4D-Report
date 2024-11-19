//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SET_CELL_TEXT
// Database: 4D Report
// ID[20C335467DE64910B905372F6053A001]
// Created #26-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($area : Integer; $column : Integer; $row : Integer; $value : Text)


var \
$computation; \
$hidden; \
$i; \
$operator; \
$count_parameters; \
$repeated; \
$width : Integer

var \
$text; \
$buffer; \
$format; \
$formula; \
$title : Text



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=4; "Missing parameter"))
	
	
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($row=qr title:K14906:1)
		
		QR GET INFO COLUMN:C766($area; $column; $text; $formula; $hidden; $width; $repeated; $format)
		QR SET INFO COLUMN:C765($area; $column; $value; $formula; $hidden; $width; $repeated; $format)
		
		//______________________________________________________
	: ($row=qr detail:K14906:2)
		
		QR GET INFO COLUMN:C766($area; $column; $title; $formula; $hidden; $width; $repeated; $text)
		QR SET INFO COLUMN:C765($area; $column; $title; $formula; $hidden; $width; $repeated; $value)
		
		//______________________________________________________
	Else 
		
		ARRAY TEXT:C222($_tags; 5)
		
		$_tags{0}:="##S"
		$_tags{1}:="##A"
		$_tags{2}:="##N"
		$_tags{3}:="##X"
		$_tags{4}:="##C"
		$_tags{5}:="##D"
		
		$buffer:=$value
		
		For ($i; 0; Size of array:C274($_tags); 1)
			
			If (Position:C15($_tags{$i}; $buffer)>0)
				
				$computation:=$computation ?+ $i
				$buffer:=Replace string:C233($buffer; $_tags{$i}; "")
				
			End if 
		End for 
		
		$buffer:=Replace string:C233($buffer; "\r"; "")
		$buffer:=Replace string:C233($buffer; " "; "")
		
		If (Length:C16($buffer)=0)
			
			QR SET TOTALS DATA:C767($area; $column; $row; $computation)
			QR SET TOTALS DATA:C767($area; $column; $row; "")
			
		Else 
			
			QR GET TOTALS DATA:C768($area; $column; $row; $operator; $text)
			QR SET TOTALS DATA:C767($area; $column; $row; $operator)
			QR SET TOTALS DATA:C767($area; $column; $row; $value)
			
		End if 
		
		//#redmine:31589 {
		If (QR Get report kind:C755($area)=qr cross report:K14902:2)
			
			If ($column=2) | ($column=3)  //apply to line
				
				$column:=$column+(3-$column)+(2-$column)
				QR_SET_CELL_DATA_from_widget($area; $column; $row; $computation)
				
			End if 
		End if 
		//}
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// End