//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : ALIGN_OBJECTS
// Database: 4D Report
// ID[2E27581B02674D8D953798785A3FE47D]
// Created #13-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($param : Object)


If (False:C215)
	C_OBJECT:C1216(ALIGN_OBJECTS; $1)
End if 

/*
  ----------------------------------------------------

  CONSTANTS

  ----------------------------------------------------  
*/

var \
$K_hOffset; \
$K_buttonMinWidth : Integer

//MARK: uppercase namming ok "K" start namming mean : it's a constant
$K_hOffset:=8
$K_buttonMinWidth:=45


/*
  ----------------------------------------------------

  VARIABLES

  ----------------------------------------------------
*/

var \
$is_visible : Boolean


var \
$alignment; \
$count_parameters; \
$left; $top; $right; $bottom; \
$width; $height; \
$hOffset; \
$positionLeft; \
$positionRight; \
$i : Integer


var \
$object_name; \
$type_name : Text

/*
  ----------------------------------------------------

  ARRAYS

  ----------------------------------------------------  
*/

ARRAY OBJECT:C1221($_objects; 0)


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$param:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		//<NONE>
		
	End if 
	
	OB GET ARRAY:C1229($param; "toolbar"; $_objects)
	
	$positionRight:=OB Get:C1224($param; "width"; Is longint:K8:6)
	
	//$K_hOffset:=8
	//$K_buttonMinWidth:=45
	$positionLeft:=$K_hOffset
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($i; 1; Size of array:C274($_objects); 1)
	
	$object_name:=OB Get:C1224($_objects{$i}; "object"; Is text:K8:3)
	$type_name:=OB Get:C1224($_objects{$i}; "type"; Is text:K8:3)
	$is_visible:=OB Get:C1224($_objects{$i}; "visible"; Is boolean:K8:9)
	$alignment:=OB Get:C1224($_objects{$i}; "align"; Is longint:K8:6)
	
	$hOffset:=OB Get:C1224($_objects{$i}; "offset"; Is longint:K8:6)
	
	If ($is_visible)
		
		If (Length:C16($object_name)>0)
			
			OBJECT GET COORDINATES:C663(*; $object_name; $left; $top; $right; $bottom)
			
		End if 
		
		Case of 
				
				//______________________________________________________
			: ($type_name="button")
				
				OBJECT GET BEST SIZE:C717(*; $object_name; $width; $height)
				$width:=Choose:C955($width<$K_buttonMinWidth; $K_buttonMinWidth; $width*1.2)+$hOffset
				
				If ($alignment=On the right:K39:3)
					
					$positionRight:=$positionRight-$K_hOffset
					OBJECT SET COORDINATES:C1248(*; $object_name; $positionRight-$width; $top; $positionRight; $bottom)
					
				Else 
					
					$positionLeft:=$positionLeft+$K_hOffset
					OBJECT SET COORDINATES:C1248(*; $object_name; $positionLeft; $top; $positionLeft+$width; $bottom)
					
				End if 
				
				//______________________________________________________
			: ($type_name="separator")
				
				$width:=$right-$left
				
				If ($alignment=On the right:K39:3)
					
					$positionRight:=$positionRight-$K_hOffset
					OBJECT SET COORDINATES:C1248(*; $object_name; $positionRight; $top)
					
				Else 
					
					$positionLeft:=$positionLeft+$K_hOffset
					OBJECT SET COORDINATES:C1248(*; $object_name; $positionLeft; $top)
					
				End if 
				
				//______________________________________________________
			: ($type_name="widget")
				
				$width:=$right-$left
				
				If ($alignment=On the right:K39:3)
					
					$positionRight:=$positionRight-$K_hOffset
					OBJECT SET COORDINATES:C1248(*; $object_name; $positionRight-$width; $top; $positionRight; $bottom)
					
				Else 
					
					$positionLeft:=$positionLeft+$K_hOffset
					OBJECT SET COORDINATES:C1248(*; $object_name; $positionLeft; $top; $positionLeft+$width; $bottom)
					
				End if 
				
				//______________________________________________________
			Else 
				
				//
				
				//______________________________________________________
		End case 
		
		If ($alignment=On the right:K39:3)
			
			$positionRight:=$positionRight-$width
			
		Else 
			
			$positionLeft:=$positionLeft+$width
			
		End if 
		
	Else 
		
		//put offscreen
		OBJECT SET COORDINATES:C1248(*; $object_name; -1000; -1000; -1000; -1000)
		
	End if 
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End