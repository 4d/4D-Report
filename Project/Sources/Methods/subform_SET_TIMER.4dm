//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : subform_SET_TIMER
  // Database: 4D Report
  // ID[0D2D0ED368A54F6DA71B3B97402F8EFF]
  // Created #29-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_parameters;$Lon_timer)

If (False:C215)
	C_LONGINT:C283(subform_SET_TIMER ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //Required parameters
	$Lon_timer:=-1
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_timer:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

SET TIMER:C645($Lon_timer)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End