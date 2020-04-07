//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : path_picker_Get_object
  // ID[54AF9A672A2847FEAE71180159E52D38]
  // Created #28-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_POINTER:C301($0)
C_TEXT:C284($1)
C_POINTER:C301($2)

C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_object;$Ptr_widget)
C_TEXT:C284($Txt_widget)

If (False:C215)
	C_POINTER:C301(path_picker_Get_object ;$0)
	C_TEXT:C284(path_picker_Get_object ;$1)
	C_POINTER:C301(path_picker_Get_object ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	$Ptr_object:=$2  //Object to populate
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Ptr_widget:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_widget";$Txt_widget)

If (Not:C34(Is nil pointer:C315($Ptr_widget)))
	
	If (Length:C16($Ptr_widget->)=0)
		
		  //default values
		$Ptr_object->:=path_picker_INIT 
		
	Else 
		
		$Ptr_object->:=JSON Parse:C1218($Ptr_widget->)
		
	End if 
	
Else 
	
	ASSERT:C1129(False:C215)
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Ptr_widget  //Pointer to the widget object

  // ----------------------------------------------------
  // End