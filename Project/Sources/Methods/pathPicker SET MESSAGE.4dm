//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : pathPicker SET MESSAGE
  // ID[A5D95D40CFD6461CA50862466531CD28]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_message;$Txt_widget)

If (False:C215)
	C_TEXT:C284(pathPicker SET MESSAGE ;$1)
	C_TEXT:C284(pathPicker SET MESSAGE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_message:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
path_picker_SET_TEXT_ATTRIBUTE ($Txt_widget;"message";$Txt_message)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End