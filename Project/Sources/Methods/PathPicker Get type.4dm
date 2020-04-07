//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker Get type
  // ID[9B2F3EC320594A1AB1E85BC49AAEBB25]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Lon_type)
C_TEXT:C284($Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_LONGINT:C283(PathPicker Get type ;$0)
	C_TEXT:C284(PathPicker Get type ;$1)
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
$Lon_type:=OB Get:C1224($Obj_widget;"type";Is longint:K8:6)

  // ----------------------------------------------------
  // Return
$0:=$Lon_type  //0 = folder | 1 = document

  // ----------------------------------------------------
  // End