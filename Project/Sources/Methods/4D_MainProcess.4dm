//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : 4D_MainProcess
  // Database: 4D Report
  // ID[A826F7A9634F4E96A98DC67A06A5C284]
  // Created #13-8-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_visible)
C_LONGINT:C283($Lon_origin;$Lon_parameters;$Lon_process;$Lon_state;$Lon_UID)
C_TIME:C306($Gmt_time)
C_TEXT:C284($Txt_name)

If (False:C215)
	C_BOOLEAN:C305(4D_MainProcess ;$0)
	C_LONGINT:C283(4D_MainProcess ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_process:=$1
		
	Else 
		
		$Lon_process:=Current process:C322
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
PROCESS PROPERTIES:C336($Lon_process;$Txt_name;$Lon_state;$Gmt_time;$Boo_visible;$Lon_UID;$Lon_origin)

  // ----------------------------------------------------
  // Return
$0:=($Lon_origin=Main process:K36:10)

  // ----------------------------------------------------
  // End