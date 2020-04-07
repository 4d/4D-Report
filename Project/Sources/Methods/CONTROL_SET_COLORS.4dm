//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : CONTROL_SET_COLORS
  // ID[B5890476F0CF47D595E54D42B6A64A35]
  // Created #17-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_highlitColor;$Lon_parameters)

If (False:C215)
	C_LONGINT:C283(CONTROL_SET_COLORS ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_highlitColor:=0x002A93FB
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_highlitColor:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
<>ctrl_highlitColor:=$Lon_highlitColor

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End