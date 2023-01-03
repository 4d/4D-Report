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

#DECLARE($table_number : Integer; $field_number : Integer)->$field_name : Text


var \
$field_index; \
$table_index; \
$count_parameters : Integer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	// $table_number  //$1
	// $field_number  //$2
	
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
		
		
		// Mark:ACI0103579  -> var report_structureDefinition don't use index but field ID
		
		//$field_name:="["+report_structureDefinition{0}{$Lon_tableIndex}+"]"\
									+report_structureDefinition{$table_index}{$field_index}
		
		$field_name:="["+report_structureDefinition{0}{$table_number}+"]"\
			+report_structureDefinition{$table_index}{$field_number}
		
	End if 
End if 

// ----------------------------------------------------

return $field_name

// ----------------------------------------------------
// End