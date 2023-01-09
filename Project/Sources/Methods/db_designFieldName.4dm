//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_structureFieldName
// Database: 4D Report
// ID[C9850124F13143E8AC61BE566292DB59]
// Created #9-12-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($field_index; $field_number; $count_parameters; $table_index; $table_number)
C_TEXT:C284($field_name)

If (False:C215)
	C_TEXT:C284(db_designFieldName; $0)
	C_LONGINT:C283(db_designFieldName; $1)
	C_LONGINT:C283(db_designFieldName; $2)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$table_number:=$1
	$field_number:=$2
	
	//Optional parameters
	If ($count_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$table_index:=Find in array:C230(tLon_tableIDs; $table_number)

If ($table_index#-1)
	
	$field_index:=Find in array:C230(tLon_fieldIDs{$table_index}; $field_number)
	
	If ($field_index#-1)
		
		$field_name:="["+report_structureDefinition{0}{$table_index}+"]"\
			+report_structureDefinition{$table_index}{$field_index}
		
		// Mark:ACI0103579  -> var report_structureDefinition don't use index but field ID
		
		//$field_name:="["+report_structureDefinition{0}{$Lon_tableIndex}+"]"\
			+report_structureDefinition{$table_index}{$field_index}
		
		$field_name:="["+report_structureDefinition{0}{$table_number}+"]"\
			+report_structureDefinition{$table_index}{$field_number}
		
		
		
		
	End if 
End if 

// ----------------------------------------------------
// Return
$0:=$field_name

// ----------------------------------------------------
// End