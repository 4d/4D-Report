//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker SET PLACEHOLDER
  // ID[378E3848209F46F6954883C001F9F137]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_placeHolder;$Txt_widget)

If (False:C215)
	C_TEXT:C284(PathPicker SET PLACEHOLDER ;$1)
	C_TEXT:C284(PathPicker SET PLACEHOLDER ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_placeHolder:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
path_picker_SET_TEXT_ATTRIBUTE ($Txt_widget;"placeHolder";$Txt_placeHolder)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End