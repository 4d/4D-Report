//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Obj_CENTER
// Created 13/10/06 by vdl
// ----------------------------------------------------
// Description
// Center position of target object relative to refernce object
// ----------------------------------------------------

#DECLARE($target : Text; $reference : Text; $alignement : Integer)

/*
C_TEXT($1)
C_TEXT($2)
C_LONGINT($3)
*/

var \
$count_parameters; \
$Lon_alignment; \
$left; $top; $right; $bottom; $middle; \
$ref_left; $ref_top; $ref_right; $ref_bottom : Integer



If (False:C215)
	C_TEXT:C284(Obj_CENTER; $1)
	C_TEXT:C284(Obj_CENTER; $2)
	C_LONGINT:C283(Obj_CENTER; $3)
End if 

// ----------------------------------------------------
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2))
	
	//$target:=$target
	//$reference:=$reference
	
	OBJECT GET COORDINATES:C663(*; $reference; $ref_left; $ref_top; $ref_right; $ref_bottom)
	
	If ($count_parameters>=3)
		
		$Lon_alignment:=$alignement  //{default = vertical and horizontal}
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_alignment=0)\
 | ($Lon_alignment>=Vertically centered:K39:4)
	
	$middle:=$ref_top+(($ref_bottom-$ref_top)/2)+Num:C11((($ref_bottom-$ref_top)%2)#0)
	
	OBJECT GET COORDINATES:C663(*; $target; $left; $top; $right; $bottom)
	OBJECT MOVE:C664(*; $target; 0; ($middle-(($bottom-$top)/2))-$top)
	
	If ($Lon_alignment#0)
		
		If ($Lon_alignment>Vertically centered:K39:4)
			
			$Lon_alignment:=$Lon_alignment-Vertically centered:K39:4
			
		End if 
	End if 
End if 

If ($Lon_alignment=0)\
 | ($Lon_alignment=Horizontally centered:K39:1)
	
	$middle:=$ref_left+(($ref_right-$ref_left)/2)-Num:C11((($ref_bottom-$ref_top)%2)#0)
	
	OBJECT GET COORDINATES:C663(*; $target; $left; $top; $right; $bottom)
	OBJECT MOVE:C664(*; $target; ($middle-(($right-$left)/2))-$left; 0)
	
End if 

// ----------------------------------------------------