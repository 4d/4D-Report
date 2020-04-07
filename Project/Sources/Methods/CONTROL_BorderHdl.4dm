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


C_LONGINT:C283($Lon_borderType;$Lon_parameters;$lon_thickness;$lon_color)
C_BOOLEAN:C305($boo_borderPushed)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($txt_buttonFormat)

If (False:C215)
	C_LONGINT:C283(CONTROL_BorderHdl ;$1)
End if 



  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //Required parameters
	$Lon_borderType:=$1
	
	  //$txt_buttonName:=OBJECT Get name(Object current)
	
Else 
	
	ABORT:C156
	
End if 


$txt_buttonFormat:=OBJECT Get format:C894(*;OBJECT Get name:C1087(Object current:K67:2))
If (Self:C308->=1)
	
	$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"off";"on")
Else 
	$txt_buttonFormat:=Replace string:C233($txt_buttonFormat;"on";"off")
End if 
OBJECT SET FORMAT:C236(*;OBJECT Get name:C1087(Object current:K67:2);$txt_buttonFormat)



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
	
	
	$lon_thickness:=Choose:C955($Ptr_container->thicknessToSet=0;1;$Ptr_container->thicknessToSet)
	$lon_color:=$Ptr_container->colorToSet
	
	
	  // All
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bAll")->)=1)
		  // set the thickness and color to set 
		$lon_thickness:=Choose:C955($Ptr_container->thicknessToSet=0;1;$Ptr_container->thicknessToSet)
		$lon_color:=$Ptr_container->colorToSet
		
		$Ptr_container->right.thickness:=$lon_thickness
		$Ptr_container->right.color:=$lon_color
		$Ptr_container->left.thickness:=$lon_thickness
		$Ptr_container->left.color:=$lon_color
		$Ptr_container->top.thickness:=$lon_thickness
		$Ptr_container->top.color:=$lon_color
		$Ptr_container->bottom.thickness:=$lon_thickness
		$Ptr_container->bottom.color:=$lon_color
		$Ptr_container->insideHorizontal.thickness:=$lon_thickness
		$Ptr_container->insideHorizontal.color:=$lon_color
		$Ptr_container->insideVertical.thickness:=$lon_thickness
		$Ptr_container->insideVertical.color:=$lon_color
		
	End if 
	
	
	  // ----------------------------------------------------
	
	  // Inside
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bInside")->)=1)
		
		$Ptr_container->insideHorizontal.thickness:=$lon_thickness
		$Ptr_container->insideHorizontal.color:=$lon_color
		$Ptr_container->insideVertical.thickness:=$lon_thickness
		$Ptr_container->insideVertical.color:=$lon_color
		
	End if 
	
	  // ----------------------------------------------------
	
	  // Outside
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bOutside")->)=1)
		
		$Ptr_container->right.thickness:=$lon_thickness
		$Ptr_container->right.color:=$lon_color
		$Ptr_container->left.thickness:=$lon_thickness
		$Ptr_container->left.color:=$lon_color
		$Ptr_container->top.thickness:=$lon_thickness
		$Ptr_container->top.color:=$lon_color
		$Ptr_container->bottom.thickness:=$lon_thickness
		$Ptr_container->bottom.color:=$lon_color
		
	End if 
	
	
	  // ----------------------------------------------------
	
	  //top
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bTop")->)=1)
		
		$Ptr_container->top.thickness:=$lon_thickness
		$Ptr_container->top.color:=$lon_color
		
	End if 
	
	  // ----------------------------------------------------
	
	  // bottom
	
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bBottom")->)=1)
		
		$Ptr_container->bottom.thickness:=$lon_thickness
		$Ptr_container->bottom.color:=$lon_color
		
	End if 
	
	  // ----------------------------------------------------
	
	  // right
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bRight")->)=1)  // right
		
		$Ptr_container->right.thickness:=$lon_thickness
		$Ptr_container->right.color:=$lon_color
		
	End if 
	
	  // ----------------------------------------------------
	
	  // left
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bLeft")->)=1)
		
		$Ptr_container->left.thickness:=$lon_thickness
		$Ptr_container->left.color:=$lon_color
		
	End if 
	
	
	  // ----------------------------------------------------
	  // horizontal
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bHorizontal")->)=1)
		
		$Ptr_container->insideHorizontal.thickness:=$lon_thickness
		$Ptr_container->insideHorizontal.color:=$lon_color
		
	End if 
	
	
	  // ----------------------------------------------------
	
	  // vertical
	
	If ((OBJECT Get pointer:C1124(Object named:K67:5;"bVertical")->)=1)
		
		$Ptr_container->insideVertical.thickness:=$lon_thickness
		$Ptr_container->insideVertical.color:=$lon_color
		
	End if 
	
	
End if 

  //generate on data change event
CALL SUBFORM CONTAINER:C1086(On Data Change:K2:15)


