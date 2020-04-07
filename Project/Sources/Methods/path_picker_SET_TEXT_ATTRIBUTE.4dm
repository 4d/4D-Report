//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : path_picker_SET_TEXT_ATTRIBUTE
  // ID[2B2C8CB6DAEC4870A375A6DD4D11DAE9]
  // Created #28-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_widget)
C_TEXT:C284($Txt_name;$Txt_value;$Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_TEXT:C284(path_picker_SET_TEXT_ATTRIBUTE ;$1)
	C_TEXT:C284(path_picker_SET_TEXT_ATTRIBUTE ;$2)
	C_TEXT:C284(path_picker_SET_TEXT_ATTRIBUTE ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	$Txt_name:=$2  //name of the attribute to set
	
	  //Optional parameters
	If ($Lon_parameters>=3)
		
		$Txt_value:=$3  //{Value}
		
	End if 
	
	$Ptr_widget:=path_picker_Get_object ($Txt_widget;->$Obj_widget)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OB SET:C1220($Obj_widget;\
$Txt_name;$Txt_value)

$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)

If ($Txt_name="placeHolder")
	
	EXECUTE METHOD IN SUBFORM:C1085($Txt_widget;"path_picker_UPDATE_UI")
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End