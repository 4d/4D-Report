//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : subform_SET_OFFSET
  // Database: 4D Report
  // ID[0DB924DBB3D24F8C8701B8A010320FBC]
  // Created #11-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($Lon_;$Lon_left;$Lon_leftOffset;$Lon_parameters;$Lon_rightOffset;$Lon_top)
C_TEXT:C284($Txt_subform)
C_OBJECT:C1216($Obj_param)

If (False:C215)
	C_TEXT:C284(subform_SET_OFFSET ;$1)
	C_LONGINT:C283(subform_SET_OFFSET ;$2)
	C_LONGINT:C283(subform_SET_OFFSET ;$3)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_subform:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Lon_leftOffset:=$2
		
		If ($Lon_parameters>=3)
			
			$Lon_rightOffset:=$3
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
OBJECT GET COORDINATES:C663(*;$Txt_subform;$Lon_left;$Lon_top;$Lon_;$Lon_)

OB SET:C1220($Obj_param;\
"left";$Lon_left+$Lon_leftOffset;\
"top";$Lon_top+$Lon_rightOffset)

  //Pass the values to the subform
EXECUTE METHOD IN SUBFORM:C1085($Txt_subform;"subform_SET_DYNAMIC_VARIABLES";*;$Obj_param)
CLEAR VARIABLE:C89($Obj_param)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End