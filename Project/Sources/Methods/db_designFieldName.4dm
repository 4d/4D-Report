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

C_LONGINT:C283($Lon_fieldIndex;$Lon_fieldNumber;$Lon_parameters;$Lon_tableIndex;$Lon_tableNumber)
C_TEXT:C284($Txt_formula)

If (False:C215)
	C_TEXT:C284(db_designFieldName ;$0)
	C_LONGINT:C283(db_designFieldName ;$1)
	C_LONGINT:C283(db_designFieldName ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Lon_tableNumber:=$1
	$Lon_fieldNumber:=$2
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_tableIndex:=Find in array:C230(tLon_tableIDs;$Lon_tableNumber)

If ($Lon_tableIndex#-1)
	
	$Lon_fieldIndex:=Find in array:C230(tLon_fieldIDs{$Lon_tableIndex};$Lon_fieldNumber)
	
	If ($Lon_fieldIndex#-1)
		
		$Txt_formula:="["+report_structureDefinition{0}{$Lon_tableIndex}+"]"\
			+report_structureDefinition{$Lon_tableIndex}{$Lon_fieldIndex}
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Txt_formula

  // ----------------------------------------------------
  // End