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

C_LONGINT:C283($Lon_alignment; $Lon_Bottom; $Lon_Left; $Lon_Middle; $Lon_parameters; $Lon_refBottom)
C_LONGINT:C283($Lon_refLeft; $Lon_refRight; $Lon_refTop; $Lon_Right; $Lon_Top)
C_TEXT:C284($Txt_reference; $Txt_target)

If (False:C215)
	C_TEXT:C284(Obj_CENTER; $1)
	C_TEXT:C284(Obj_CENTER; $2)
	C_LONGINT:C283(Obj_CENTER; $3)
End if 

// ----------------------------------------------------
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2))
	
	$Txt_target:=$target
	$Txt_reference:=$reference
	
	OBJECT GET COORDINATES:C663(*; $Txt_reference; $Lon_refLeft; $Lon_refTop; $Lon_refRight; $Lon_refBottom)
	
	If ($Lon_parameters>=3)
		
		$Lon_alignment:=$alignement  //{default = vertical and horizontal}
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Lon_alignment=0)\
 | ($Lon_alignment>=Vertically centered:K39:4)
	
	$Lon_Middle:=$Lon_refTop+(($Lon_refBottom-$Lon_refTop)/2)+Num:C11((($Lon_refBottom-$Lon_refTop)%2)#0)
	
	OBJECT GET COORDINATES:C663(*; $Txt_target; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT MOVE:C664(*; $Txt_target; 0; ($Lon_Middle-(($Lon_Bottom-$Lon_Top)/2))-$Lon_Top)
	
	If ($Lon_alignment#0)
		
		If ($Lon_alignment>Vertically centered:K39:4)
			
			$Lon_alignment:=$Lon_alignment-Vertically centered:K39:4
			
		End if 
	End if 
End if 

If ($Lon_alignment=0)\
 | ($Lon_alignment=Horizontally centered:K39:1)
	
	$Lon_Middle:=$Lon_refLeft+(($Lon_refRight-$Lon_refLeft)/2)-Num:C11((($Lon_refBottom-$Lon_refTop)%2)#0)
	
	OBJECT GET COORDINATES:C663(*; $Txt_target; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
	OBJECT MOVE:C664(*; $Txt_target; ($Lon_Middle-(($Lon_Right-$Lon_Left)/2))-$Lon_Left; 0)
	
End if 

// ----------------------------------------------------