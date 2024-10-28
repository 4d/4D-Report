//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_virtualFieldName
// Database: 4D Report
// ID[BA59074409434018BB33D9BAB8FF7E54]
// Created #15-7-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($structure_name : Text) : Text

//_O_C_TEXT($0)
//_O_C_TEXT($1)

var $field_ID; $count_parameters; $table_ID; $x; $y : Integer
var $pattern; $virtual_name : Text

//If (False)
//_O_C_TEXT(db_virtualFieldName; $0)
//_O_C_TEXT(db_virtualFieldName; $1)
//End if 

ARRAY TEXT:C222($_results; 0x0000; 0x0000)

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$structure_name:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$virtual_name:=$structure_name
	
	//extract the table name and the field name
	$pattern:="(?mi-s)^\\[+([^\\]]*)\\]+([^-+*/(&?>]*)$"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (boo_useVirtualStructure)
	
	If (Rgx_ExtractText($pattern; $structure_name; "1 2"; ->$_results; 0)=0)
		
		//mapped to the virtual structure
		
		//#ACI0093166
		//$Lon_tableID:=Find in array(tTxt_tableNames;$tTxt_results{1}{1})
		$table_ID:=Find in array:C230(report_structureDefinition{0}; $_results{1}{1})
		
		If ($table_ID>0)
			
			//#ACI0093166
			//$Lon_fieldID:=Find in array(tTxt_fieldNames{$Lon_tableID};$tTxt_results{1}{2})
			$field_ID:=Find in array:C230(report_structureDefinition{$table_ID}; $_results{1}{2})
			
			If ($field_ID>0)
				
				$x:=Find in array:C230(tLon_tableIDs; $table_ID)
				
				If ($x>0)
					
					$y:=Find in array:C230(tLon_fieldIDs{$x}; $field_ID)
					
					If ($y>0)
						
						$virtual_name:="["+tTxt_tableNames{$x}+"]"+tTxt_fieldNames{$x}{$y}
						
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

// ----------------------------------------------------
// Return
return $virtual_name

// ----------------------------------------------------
// End