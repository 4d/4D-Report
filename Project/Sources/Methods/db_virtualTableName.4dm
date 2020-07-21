//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_virtualTableName
// Database: 4D Report
// ID[BA59074409434018BB33D9BAB8FF7E54]
// Created #16-6-2020 by Adrien Cagniant
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_parameters;$lon_Found;$lon_table_ID;$1)
C_TEXT:C284($0;$Txt_table)


// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	//Required parameters
	$lon_table_ID:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	
	
Else 
	
	ABORT:C156
	
End if 


// ----------------------------------------------------

ARRAY TEXT:C222($tTxt_tableTitle;0)
ARRAY LONGINT:C221($tLon_tableID;0)
GET TABLE TITLES:C803($tTxt_tableTitle;$tLon_tableID)

$lon_Found:=Find in array:C230($tLon_tableID;$lon_table_ID)



If ($lon_Found>0)
	
	$Txt_table:=$tTxt_tableTitle{$lon_Found}
	
Else 
	
	$Txt_table:=Table name:C256($lon_table_ID)// that's not the title when in a virtual structure. 
	
End if 


// ----------------------------------------------------
// Return
$0:=$Txt_table

// ----------------------------------------------------
// End