//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : no_error
  // Database: 4D Report
  // ID[B0E7EB6BA3E548CA8A61ECD7CD7E88C8]
  // Created #11-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End