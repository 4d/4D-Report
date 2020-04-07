//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : db_Get_field_pointer
  // Database: 4D Labels
  // ID[DC1D85263D1A47D8811D05994446324A]
  // Created #20-2-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Return a pointer for the string "[table]field"
  // or nil if the expression does not match a field
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_backupCaseSensitivity;$Lon_field;$Lon_parameters;$Lon_table)
C_POINTER:C301($Ptr_fieldPointer)
C_TEXT:C284($Txt_expression;$Txt_field;$Txt_table)

ARRAY LONGINT:C221($tLon_lengths;0)
ARRAY LONGINT:C221($tLon_positions;0)

If (False:C215)
	C_POINTER:C301(_o_db_Get_field_pointer ;$0)
	C_TEXT:C284(_o_db_Get_field_pointer ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_expression:=$1  //expression to evaluate. Valid if = "[table]field"
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Match regex:C1019("\\[([^]]+)\\](.+)";$Txt_expression;1;$tLon_positions;$tLon_lengths))
	
	$Txt_table:=Substring:C12($Txt_expression;$tLon_positions{1};$tLon_lengths{1})
	$Txt_field:=Substring:C12($Txt_expression;$tLon_positions{2};$tLon_lengths{2})
	
	If (Asserted:C1132(Get last table number:C254#0))
		
		$Lon_backupCaseSensitivity:=Get database parameter:C643(SQL engine case sensitivity:K37:43)
		SET DATABASE PARAMETER:C642(SQL engine case sensitivity:K37:43;0)
		
		Begin SQL
			
			SELECT TABLE_ID,COLUMN_ID
			FROM _USER_COLUMNS
			WHERE TABLE_NAME = :$Txt_table
			AND COLUMN_NAME = :$Txt_field
			INTO :$Lon_table,:$Lon_field
			
		End SQL
		
		SET DATABASE PARAMETER:C642(SQL engine case sensitivity:K37:43;$Lon_backupCaseSensitivity)
		
	End if 
	
	If (Asserted:C1132(($Lon_table#0)\
		 & ($Lon_field#0)))
		
		$Ptr_fieldPointer:=Field:C253($Lon_table;$Lon_field)
		
	End if 
End if 

  // ----------------------------------------------------
  // Return
$0:=$Ptr_fieldPointer

  // ----------------------------------------------------
  // End