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
C_BOOLEAN:C305($Boo_;$Boo_design;$Boo_invisible)
C_LONGINT:C283($Lon_;$Lon_count;$Lon_i;$Lon_ii;$Lon_maxField;$Lon_maxTable)
C_LONGINT:C283($Lon_origin;$Lon_parameters;$Lon_tableID;$Lon_x)
C_POINTER:C301($Ptr_table)
C_TEXT:C284($Txt_)

ARRAY LONGINT:C221($tLon_fields;0)
ARRAY LONGINT:C221($tLon_IDs;0)
ARRAY LONGINT:C221($tLon_tableIDs;0)
ARRAY TEXT:C222($tTxt_fields;0)
ARRAY TEXT:C222($tTxt_structure;0)
ARRAY TEXT:C222($tTxt_tableNames;0)
ARRAY TEXT:C222($tTxt_tables;0)

ARRAY TEXT:C222(report_structureDefinition;0;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  // NO PARAMETERS REQUIRED
	
	  // Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	COMPILER_db 
	
	  //#ACI0097715 [
	PROCESS PROPERTIES:C336(Current process:C322;$Txt_;$Lon_;$Lon_;$Lon_;$Lon_;$Lon_origin)
	$Boo_design:=($Lon_origin<0)  // Main process or design process
	  //]
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  // Loads the complete structure definition
  // Report_structureDefinition{0} stores the table names (index is the table ID)
  // Report_structureDefinition{1-n} stores the field names (index is the field ID)
$Lon_maxTable:=Get last table number:C254

ARRAY TEXT:C222(report_structureDefinition;$Lon_maxTable;0)
ARRAY TEXT:C222(report_structureDefinition{0};$Lon_maxTable)

For ($Lon_i;1;$Lon_maxTable;1)
	
	If (Is table number valid:C999($Lon_i))
		
		report_structureDefinition{0}{$Lon_i}:=Table name:C256($Lon_i)
		
		$Lon_maxField:=Get last field number:C255($Lon_i)
		
		ARRAY TEXT:C222(report_structureDefinition{$Lon_i};$Lon_maxField)
		
		For ($Lon_ii;1;$Lon_maxField;1)
			
			If (Is field number valid:C1000($Lon_i;$Lon_ii))
				
				report_structureDefinition{$Lon_i}{$Lon_ii}:=Field name:C257($Lon_i;$Lon_ii)
				
			End if 
		End for 
	End if 
End for 

  //Loads the virtual/exposed structure

  //#ACI0094098+
ARRAY TEXT:C222(tTxt_tableNames;$Lon_maxTable)
ARRAY LONGINT:C221(tLon_tableIDs;$Lon_maxTable)

If (Form_C_UseVirtualStructure=1)
	
	  //#ACI0094098+ {
	  // GET TABLE TITLES(tTxt_tableNames;tLon_tableIDs)
	GET TABLE TITLES:C803($tTxt_tableNames;$tLon_tableIDs)
	
	For ($Lon_i;1;Size of array:C274($tLon_tableIDs);1)
		
		$Lon_x:=$tLon_tableIDs{$Lon_i}
		
		tTxt_tableNames{$Lon_x}:=$tTxt_tableNames{$Lon_i}
		tLon_tableIDs{$Lon_x}:=$Lon_x
		
	End for 
	  //}
	
Else 
	
	For ($Lon_i;1;$Lon_maxTable;1)
		
		If (Is table number valid:C999($Lon_i))
			
			GET TABLE PROPERTIES:C687($Lon_i;$Boo_invisible)
			
			  //#ACI0097715
			  //If (Not($Boo_invisible))
			If (Not:C34($Boo_invisible) | $Boo_design)
				
				  //#ACI0094098 {
				  //APPEND TO ARRAY(tTxt_tableNames;Table name($Lon_i))
				  //APPEND TO ARRAY(tLon_tableIDs;$Lon_i)
				tTxt_tableNames{$Lon_i}:=Table name:C256($Lon_i)
				tLon_tableIDs{$Lon_i}:=$Lon_i
				  //}
				
			End if 
		End if 
	End for 
End if 

$Lon_count:=Size of array:C274(tLon_tableIDs)
ARRAY TEXT:C222(tTxt_fieldNames;$Lon_count;0)
ARRAY LONGINT:C221(tLon_fieldIDs;$Lon_count;0)


For ($Lon_i;1;$Lon_count;1)
	
	$Lon_tableID:=tLon_tableIDs{$Lon_i}
	
	If ($Lon_tableID#0)  //#ACI0094098
		
		$Lon_maxField:=Get last field number:C255($Lon_tableID)
		
		$Ptr_table:=Table:C252($Lon_tableID)
		
		If (Form_C_UseVirtualStructure=1)
			
			ARRAY TEXT:C222($tTxt_fieldNames;$Lon_maxField)
			ARRAY LONGINT:C221($tLon_fieldIDs;$Lon_maxField)
			
			GET FIELD TITLES:C804($Ptr_table->;$tTxt_fields;$tLon_fields)
			
			For ($Lon_ii;1;Size of array:C274($tLon_fields);1)
				
				$Lon_x:=$tLon_fields{$Lon_ii}
				
				$tTxt_fieldNames{$Lon_x}:=$tTxt_fields{$Lon_ii}
				$tLon_fieldIDs{$Lon_x}:=$Lon_x
				
			End for 
			
		Else 
			
			ARRAY TEXT:C222($tTxt_fieldNames;0x0000)
			ARRAY LONGINT:C221($tLon_fieldIDs;0x0000)
			
			For ($Lon_ii;1;$Lon_maxField;1)
				
				  //ACI0099768 : We don't test if the field number is valid because it skips deleted fields 
				If (Is field number valid:C1000($Lon_tableID;$Lon_ii))
					
					GET FIELD PROPERTIES:C258($Lon_tableID;$Lon_ii;$Lon_;$Lon_;$Boo_;$Boo_;$Boo_invisible)
					  //{
				Else 
					
					$Boo_invisible:=False:C215
				End if 
				
				  //#ACI0097715
				  //If (Not($Boo_invisible))
				If (Not:C34($Boo_invisible) | $Boo_design)
					
					APPEND TO ARRAY:C911($tTxt_fieldNames;Field name:C257($Lon_tableID;$Lon_ii))
					APPEND TO ARRAY:C911($tLon_fieldIDs;$Lon_ii)
					
				End if 
				  //end if}
				
			End for 
		End if 
		
		  // Copy the fields array corresponding to the table in the 2D arrays
		$Lon_x:=Find in array:C230(tLon_tableIDs;$Lon_tableID)
		COPY ARRAY:C226($tTxt_fieldNames;tTxt_fieldNames{$Lon_x})
		COPY ARRAY:C226($tLon_fieldIDs;tLon_fieldIDs{$Lon_x})
		
	End if 
End for 



  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End