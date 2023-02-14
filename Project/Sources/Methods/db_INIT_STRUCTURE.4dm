//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_INIT_STRUCTURE
// Database: 4D Report
// ID[EA9B918AD77A411F92F0278FAFB72F5D]
// Created #15-7-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Populating arrays to be able to manage the virtual structure
// ----------------------------------------------------
// Declarations


var \
$count_parameters; \
$int; \
$size; \
$i; \
$j; \
$count_fields; \
$count_tables; \
$origin; \
$table_id; $index : Integer

var \
$bool; \
$in_design; \
$is_invisible : Boolean

var \
$table : Pointer

var \
$text : Text

// ARRAYS

ARRAY LONGINT:C221($_table_id; 0)
ARRAY TEXT:C222($_table_name; 0)

ARRAY LONGINT:C221($_field_id; 0)
ARRAY TEXT:C222($_field_name; 0)

//ARRAY TEXT($tTxt_structure; 0)
//ARRAY TEXT($tTxt_tables; 0)

ARRAY TEXT:C222(report_structureDefinition; 0; 0)

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	// NO PARAMETERS REQUIRED
	
	// Optional parameters
	If ($count_parameters>=1)
		
		// <NONE>
		
	End if 
	
	COMPILER_db
	
	//#ACI0097715 [
	PROCESS PROPERTIES:C336(Current process:C322; $text; $int; $int; $int; $int; $origin)
	$in_design:=($origin<0)  // Main process or design process
	//]
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
// Loads the complete structure definition
// Report_structureDefinition{0} stores the table names (index is the table ID)
// Report_structureDefinition{1-n} stores the field names (index is the field ID)
$count_tables:=Get last table number:C254

ARRAY TEXT:C222(report_structureDefinition; $count_tables; 0)
ARRAY TEXT:C222(report_structureDefinition{0}; $count_tables)

For ($i; 1; $count_tables; 1)
	
	If (Is table number valid:C999($i))
		
		report_structureDefinition{0}{$i}:=Table name:C256($i)
		
		$count_fields:=Get last field number:C255($i)
		
		ARRAY TEXT:C222(report_structureDefinition{$i}; $count_fields)
		
		For ($j; 1; $count_fields; 1)
			
			If (Is field number valid:C1000($i; $j))
				
				report_structureDefinition{$i}{$j}:=Field name:C257($i; $j)
				
			End if 
		End for 
	End if 
End for 

//Loads the virtual/exposed structure

//#ACI0094098+
ARRAY TEXT:C222(tTxt_tableNames; $count_tables)
ARRAY LONGINT:C221(tLon_tableIDs; $count_tables)

If (boo_useVirtualStructure)
	
	//#ACI0094098+ {
	// GET TABLE TITLES(tTxt_tableNames;tLon_tableIDs)
	GET TABLE TITLES:C803($_table_name; $_table_id)
	
	For ($i; 1; Size of array:C274($_table_id); 1)
		
		$index:=$_table_id{$i}
		
		tTxt_tableNames{$index}:=$_table_name{$i}
		tLon_tableIDs{$index}:=$index
		
	End for 
	//}
	
Else 
	
	For ($i; 1; $count_tables; 1)
		
		If (Is table number valid:C999($i))
			
			GET TABLE PROPERTIES:C687($i; $is_invisible)
			
			//#ACI0097715
			//If (Not($Boo_invisible))
			If (Not:C34($is_invisible) | $in_design)
				
				//#ACI0094098 {
				//APPEND TO ARRAY(tTxt_tableNames;Table name($Lon_i))
				//APPEND TO ARRAY(tLon_tableIDs;$Lon_i)
				tTxt_tableNames{$i}:=Table name:C256($i)
				tLon_tableIDs{$i}:=$i
				//}
				
			End if 
		End if 
	End for 
End if 

$size:=Size of array:C274(tLon_tableIDs)
ARRAY TEXT:C222(tTxt_fieldNames; $size; 0)
ARRAY LONGINT:C221(tLon_fieldIDs; $size; 0)


For ($i; 1; $size; 1)
	
	$table_id:=tLon_tableIDs{$i}
	
	If ($table_id#0)  //#ACI0094098
		
		$count_fields:=Get last field number:C255($table_id)
		
		$table:=Table:C252($table_id)
		
		If (boo_useVirtualStructure)
			
			ARRAY TEXT:C222($tTxt_fieldNames; $count_fields)
			ARRAY LONGINT:C221($tLon_fieldIDs; $count_fields)
			
			GET FIELD TITLES:C804($table->; $_field_name; $_field_id)
			
			For ($j; 1; Size of array:C274($_field_id); 1)
				
				$index:=$_field_id{$j}
				
				$tTxt_fieldNames{$index}:=$_field_name{$j}
				$tLon_fieldIDs{$index}:=$index
				
			End for 
			
		Else 
			
			ARRAY TEXT:C222($tTxt_fieldNames; 0x0000)
			ARRAY LONGINT:C221($tLon_fieldIDs; 0x0000)
			
			For ($j; 1; $count_fields; 1)
				
				//ACI0099768 : We don't test if the field number is valid because it skips deleted fields
				If (Is field number valid:C1000($table_id; $j))
					
					GET FIELD PROPERTIES:C258($table_id; $j; $int; $int; $bool; $bool; $is_invisible)
					//{
				Else 
					
					$is_invisible:=False:C215
				End if 
				
				//#ACI0097715
				//If (Not($Boo_invisible))
				If (Not:C34($is_invisible) | $in_design)
					
					APPEND TO ARRAY:C911($tTxt_fieldNames; Field name:C257($table_id; $j))
					APPEND TO ARRAY:C911($tLon_fieldIDs; $j)
					
				End if 
				//end if}
				
			End for 
		End if 
		
		// Copy the fields array corresponding to the table in the 2D arrays
		$index:=Find in array:C230(tLon_tableIDs; $table_id)
		COPY ARRAY:C226($tTxt_fieldNames; tTxt_fieldNames{$index})
		COPY ARRAY:C226($tLon_fieldIDs; tLon_fieldIDs{$index})
		
	End if 
End for 



// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End