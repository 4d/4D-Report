//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : PathPicker SET TYPE
  // ID[52DC25E150D1413BA15300A6FAC3A94F]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_parameters;$Lon_type)
C_POINTER:C301($Ptr_widget)
C_TEXT:C284($Txt_widget)
C_OBJECT:C1216($Obj_widget)

If (False:C215)
	C_TEXT:C284(PathPicker SET TYPE ;$1)
	C_LONGINT:C283(PathPicker SET TYPE ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	$Lon_type:=Is a document:K24:1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_type:=$2  //0 = folder | 1 (default) = document
		
	End if 
	
	ASSERT:C1129(($Lon_type=Is a folder:K24:2) | ($Lon_type=Is a document:K24:1);"The value must be 0 or 1")
	
	$Ptr_widget:=path_picker_Get_object ($Txt_widget;->$Obj_widget)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If ($Lon_type=Is a folder:K24:2)\
 | ($Lon_type=Is a document:K24:1)
	
	OB SET:C1220($Obj_widget;\
		"type";$Lon_type)
	
	$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End