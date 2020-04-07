//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : subform_SET_DYNAMIC_VARIABLES
  // Database: 4D Report
  // ID[AD0697EE830A493BAAF3FF510F9A35D1]
  // Created #2-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($1)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_type)
C_POINTER:C301($Ptr_target)
C_TEXT:C284($Txt_target)
C_OBJECT:C1216($Obj_variables)

ARRAY TEXT:C222($tTxt_properties;0)

If (False:C215)
	C_OBJECT:C1216(subform_SET_DYNAMIC_VARIABLES ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Obj_variables:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  //<none>
		
	End if 
	
	OB GET PROPERTY NAMES:C1232($Obj_variables;$tTxt_properties)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;1;Size of array:C274($tTxt_properties);1)
	
	$Txt_target:=$tTxt_properties{$Lon_i}
	$Ptr_target:=OBJECT Get pointer:C1124(Object named:K67:5;$Txt_target)
	
	If (Not:C34(Is nil pointer:C315($Ptr_target)))
		
		$Lon_type:=Type:C295($Ptr_target->)
		
		$Ptr_target->:=OB Get:C1224($Obj_variables;$Txt_target;$Lon_type)
		
	Else 
		
		ASSERT:C1129(False:C215;"unknown object: "+$Txt_target)
		
	End if 
End for 

  // ----------------------------------------------------
  // Return

  //<NONE>

  // ----------------------------------------------------
  // End