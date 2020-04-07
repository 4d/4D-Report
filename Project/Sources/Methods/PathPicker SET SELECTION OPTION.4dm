//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker SET SELECTION OPTION
  // ID[353E31F11B474F3981E6DAB1BE1C3AE7]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_options;$Lon_parameters)
C_POINTER:C301($Ptr_widget)
C_TEXT:C284($Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_TEXT:C284(PathPicker SET SELECTION OPTION ;$1)
	C_LONGINT:C283(PathPicker SET SELECTION OPTION ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_options:=$2
		
	End if 
	
	$Ptr_widget:=path_picker_Get_object ($Txt_widget;->$Obj_widget)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220($Obj_widget;\
"options";$Lon_options)

$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End