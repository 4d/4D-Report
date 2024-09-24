//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): AdrienCagniant
// Date and time: 03/09/19, 18:31:08
// ----------------------------------------------------
// Method: CONTROL_BorderHdl
// Description
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($border_type : Integer)


var $count_parameters; $thickness; $color : Integer
var $is_color_scheme_light : Boolean
var $Ptr_container : Pointer
var $button_format : Text

var $e : Object



// Initialisations
$count_parameters:=Count parameters:C259
$e:=FORM Event:C1606


If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//Required parameters
	
	//$txt_buttonName:=OBJECT Get name(Object current)
	
Else 
	
	ABORT:C156
	
End if 

Case of 
		
	: ($e.code=On Load:K2:1)
		
		
		$button_format:=OBJECT Get format:C894(*; OBJECT Get name:C1087(Object current:K67:2))
		$is_color_scheme_light:=(FORM Get color scheme:C1761="light")
		$button_format:=Replace string:C233($button_format; \
			".png"; Choose:C955($is_color_scheme_light; ".png"; "_dark.png"))
		OBJECT SET FORMAT:C236(*; OBJECT Get name:C1087(Object current:K67:2); $button_format)
		
	Else 
		
		$button_format:=OBJECT Get format:C894(*; OBJECT Get name:C1087(Object current:K67:2))
		
		
		If (Self:C308->=1)
			
			$button_format:=Replace string:C233($button_format; "Off"; "On")
			
		Else 
			
			$button_format:=Replace string:C233($button_format; "On"; "Off")
			
		End if 
		
		OBJECT SET FORMAT:C236(*; OBJECT Get name:C1087(Object current:K67:2); $button_format)
		
		$button_format:=OBJECT Get format:C894(*; OBJECT Get name:C1087(Object current:K67:2))
		
		
		$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		
		If ($Ptr_container->#Null:C1517)
			
			
			
			$Ptr_container->right.thickness:=0
			$Ptr_container->right.color:=0
			$Ptr_container->left.thickness:=0
			$Ptr_container->left.color:=0
			$Ptr_container->top.thickness:=0
			$Ptr_container->top.color:=0
			$Ptr_container->bottom.thickness:=0
			$Ptr_container->bottom.color:=0
			$Ptr_container->insideHorizontal.thickness:=0
			$Ptr_container->insideHorizontal.color:=0
			$Ptr_container->insideVertical.thickness:=0
			$Ptr_container->insideVertical.color:=0
			
			
			$thickness:=Choose:C955($Ptr_container->thicknessToSet=0; 1; $Ptr_container->thicknessToSet)
			$color:=$Ptr_container->colorToSet
			
			
			// All
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bAll")->)=1)
				// set the thickness and color to set 
				$thickness:=Choose:C955($Ptr_container->thicknessToSet=0; 1; $Ptr_container->thicknessToSet)
				$color:=$Ptr_container->colorToSet
				
				$Ptr_container->right.thickness:=$thickness
				$Ptr_container->right.color:=$color
				$Ptr_container->left.thickness:=$thickness
				$Ptr_container->left.color:=$color
				$Ptr_container->top.thickness:=$thickness
				$Ptr_container->top.color:=$color
				$Ptr_container->bottom.thickness:=$thickness
				$Ptr_container->bottom.color:=$color
				$Ptr_container->insideHorizontal.thickness:=$thickness
				$Ptr_container->insideHorizontal.color:=$color
				$Ptr_container->insideVertical.thickness:=$thickness
				$Ptr_container->insideVertical.color:=$color
				
			End if 
			
			
			// ----------------------------------------------------
			
			// Inside
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bInside")->)=1)
				
				$Ptr_container->insideHorizontal.thickness:=$thickness
				$Ptr_container->insideHorizontal.color:=$color
				$Ptr_container->insideVertical.thickness:=$thickness
				$Ptr_container->insideVertical.color:=$color
				
			End if 
			
			// ----------------------------------------------------
			
			// Outside
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bOutside")->)=1)
				
				$Ptr_container->right.thickness:=$thickness
				$Ptr_container->right.color:=$color
				$Ptr_container->left.thickness:=$thickness
				$Ptr_container->left.color:=$color
				$Ptr_container->top.thickness:=$thickness
				$Ptr_container->top.color:=$color
				$Ptr_container->bottom.thickness:=$thickness
				$Ptr_container->bottom.color:=$color
				
			End if 
			
			
			// ----------------------------------------------------
			
			//top
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bTop")->)=1)
				
				$Ptr_container->top.thickness:=$thickness
				$Ptr_container->top.color:=$color
				
			End if 
			
			// ----------------------------------------------------
			
			// bottom
			
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bBottom")->)=1)
				
				$Ptr_container->bottom.thickness:=$thickness
				$Ptr_container->bottom.color:=$color
				
			End if 
			
			// ----------------------------------------------------
			
			// right
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bRight")->)=1)  // right
				
				$Ptr_container->right.thickness:=$thickness
				$Ptr_container->right.color:=$color
				
			End if 
			
			// ----------------------------------------------------
			
			// left
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bLeft")->)=1)
				
				$Ptr_container->left.thickness:=$thickness
				$Ptr_container->left.color:=$color
				
			End if 
			
			
			// ----------------------------------------------------
			// horizontal
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bHorizontal")->)=1)
				
				$Ptr_container->insideHorizontal.thickness:=$thickness
				$Ptr_container->insideHorizontal.color:=$color
				
			End if 
			
			
			// ----------------------------------------------------
			
			// vertical
			
			If ((OBJECT Get pointer:C1124(Object named:K67:5; "bVertical")->)=1)
				
				$Ptr_container->insideVertical.thickness:=$thickness
				$Ptr_container->insideVertical.color:=$color
				
			End if 
			
			
		End if 
		
		//generate on data change event
		CALL SUBFORM CONTAINER:C1086(On Data Change:K2:15)
		
		
End case 