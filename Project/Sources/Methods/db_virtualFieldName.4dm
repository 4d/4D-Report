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
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_fieldID;$Lon_parameters;$Lon_tableID;$Lon_x;$Lon_y)
C_TEXT:C284($kTxt_pattern;$Txt_structure_name;$Txt_virtual_name)

If (False:C215)
	C_TEXT:C284(db_virtualFieldName ;$0)
	C_TEXT:C284(db_virtualFieldName ;$1)
End if 

ARRAY TEXT:C222($tTxt_results;0x0000;0x0000)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_structure_name:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Txt_virtual_name:=$Txt_structure_name
	
	  //extract the table name and the field name
	$kTxt_pattern:="(?mi-s)^\\[+([^\\]]*)\\]+([^-+*/(&?>]*)$"
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Form_C_UseVirtualStructure=1)
	
	If (Rgx_ExtractText ($kTxt_pattern;$Txt_structure_name;"1 2";->$tTxt_results;0)=0)
		
		  //mapped to the virtual structure
		
		  //#ACI0093166
		  //$Lon_tableID:=Find in array(tTxt_tableNames;$tTxt_results{1}{1})
		$Lon_tableID:=Find in array:C230(report_structureDefinition{0};$tTxt_results{1}{1})
		
		If ($Lon_tableID>0)
			
			  //#ACI0093166
			  //$Lon_fieldID:=Find in array(tTxt_fieldNames{$Lon_tableID};$tTxt_results{1}{2})
			$Lon_fieldID:=Find in array:C230(report_structureDefinition{$Lon_tableID};$tTxt_results{1}{2})
			
			If ($Lon_fieldID>0)
				
				$Lon_x:=Find in array:C230(tLon_tableIDs;$Lon_tableID)
				
				If ($Lon_x>0)
					
					$Lon_y:=Find in array:C230(tLon_fieldIDs{$Lon_x};$Lon_fieldID)
					
					If ($Lon_y>0)
						
						$Txt_virtual_name:="["+tTxt_tableNames{$Lon_x}+"]"+tTxt_fieldNames{$Lon_x}{$Lon_y}
						
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Txt_virtual_name

  // ----------------------------------------------------
  // End