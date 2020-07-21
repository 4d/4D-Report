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
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)

C_LONGINT:C283($Lon_area;$Lon_column;$Lon_computation;$Lon_hidden;$Lon_i;$Lon_OPERATOR)
C_LONGINT:C283($Lon_parameters;$Lon_repeated;$Lon_row;$Lon_width)
C_TEXT:C284($Txt_;$Txt_buffer;$Txt_DATA;$Txt_format;$Txt_object;$Txt_title)

If (False:C215)
	C_LONGINT:C283(QR_SET_CELL_TEXT;$1)
	C_LONGINT:C283(QR_SET_CELL_TEXT;$2)
	C_LONGINT:C283(QR_SET_CELL_TEXT;$3)
	C_TEXT:C284(QR_SET_CELL_TEXT;$4)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4;"Missing parameter"))
	
	$Lon_area:=$1
	$Lon_column:=$2
	$Lon_row:=$3
	$Txt_DATA:=$4
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_row=qr title:K14906:1)
		
		QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_format)
		QR SET INFO COLUMN:C765($Lon_area;$Lon_column;$Txt_DATA;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_format)
		
		//______________________________________________________
	: ($Lon_row=qr detail:K14906:2)
		
		QR GET INFO COLUMN:C766($Lon_area;$Lon_column;$Txt_title;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_)
		QR SET INFO COLUMN:C765($Lon_area;$Lon_column;$Txt_title;$Txt_object;$Lon_hidden;$Lon_width;$Lon_repeated;$Txt_DATA)
		
		//______________________________________________________
	Else 
		
		ARRAY TEXT:C222($tTxt_tags;5)
		
		$tTxt_tags{0}:="##S"
		$tTxt_tags{1}:="##A"
		$tTxt_tags{2}:="##N"
		$tTxt_tags{3}:="##X"
		$tTxt_tags{4}:="##C"
		$tTxt_tags{5}:="##D"
		
		$Txt_buffer:=$Txt_DATA
		
		For ($Lon_i;0;Size of array:C274($tTxt_tags);1)
			
			If (Position:C15($tTxt_tags{$Lon_i};$Txt_buffer)>0)
				
				$Lon_computation:=$Lon_computation ?+ $Lon_i
				$Txt_buffer:=Replace string:C233($Txt_buffer;$tTxt_tags{$Lon_i};"")
				
			End if 
		End for 
		
		$Txt_buffer:=Replace string:C233($Txt_buffer;"\r";"")
		$Txt_buffer:=Replace string:C233($Txt_buffer;" ";"")
		
		If (Length:C16($Txt_buffer)=0)
			
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_computation)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;"")
			
		Else 
			
			QR GET TOTALS DATA:C768($Lon_area;$Lon_column;$Lon_row;$Lon_OPERATOR;$Txt_)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Lon_OPERATOR)
			QR SET TOTALS DATA:C767($Lon_area;$Lon_column;$Lon_row;$Txt_DATA)
			
		End if 
		
		//#redmine:31589 {
		If (QR Get report kind:C755($Lon_area)=qr cross report:K14902:2)
			
			If ($Lon_column=2)\
				 | ($Lon_column=3)//apply to line
				
				$Lon_column:=$Lon_column+(3-$Lon_column)+(2-$Lon_column)
				QR_SET_CELL_DATA_from_widget($Lon_area;$Lon_column;$Lon_row;$Lon_computation)
				
			End if 
		End if 
		//}
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// End