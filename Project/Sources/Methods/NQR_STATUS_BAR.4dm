//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_STATUS_BAR
  // Database: 4D Report
  // ID[E38951CC852C470CA7B20E3B5767EE8B]
  // Created #11-7-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_table)
C_TEXT:C284($Txt_action)

If (False:C215)
	C_TEXT:C284(NQR_STATUS_BAR ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_action:=$1  //values: "update"
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Txt_action="update")
		
		If (C_QR_MASTERTABLE#0)
			
			$Ptr_table:=Table:C252(C_QR_MASTERTABLE)
			
			  //#redmine:11389 - Only the number of the current selection will be displayed
			  //This label will be updated to Number of records XX Where: XX is the munber of record in the current selection
			  //If (Form_C_UseVirtualStructure=1)
			  //$Lon_x:=Find in array(tLon_tableIDs;C_QR_MASTERTABLE)
			  //$Txt_tableName:=tTxt_tableNames{$Lon_x}
			  //Else
			  //$Txt_tableName:=Table name($Ptr_table)
			  //End if
			  //OBJECT SET TITLE(*;"status.records";Replace string(Replace string(Replace string(Get localized string("stb_selection");"{sel}";String(Records in selection($Ptr_table->)));"{all}";String(Records in table($Ptr_table->)));"{table}";$Txt_tableName))
			OBJECT SET TITLE:C194(*;"status.records";\
				Replace string:C233(Get localized string:C991("stb_numberOfRecords");\
				"{sel}";String:C10(Records in selection:C76($Ptr_table->))))
			
		Else 
			
			OBJECT SET TITLE:C194(*;"status.records";"")
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		  //______________________________________________________
End case 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End