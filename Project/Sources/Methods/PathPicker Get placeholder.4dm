//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker Get placeholder
  // ID[A2986B83A2154D3A83FD6B49AD7D340F]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_placeholder;$Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_TEXT:C284(PathPicker Get placeholder ;$0)
	C_TEXT:C284(PathPicker Get placeholder ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	path_picker_Get_object ($Txt_widget;->$Obj_widget)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Txt_placeholder:=OB Get:C1224($Obj_widget;"placeHolder";Is text:K8:3)

  // ----------------------------------------------------
  // Return
$0:=$Txt_placeholder

  // ----------------------------------------------------
  // End