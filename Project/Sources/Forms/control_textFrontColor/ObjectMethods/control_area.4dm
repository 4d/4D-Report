  // ----------------------------------------------------
  // Object method : _alin_left_center_right.sandbox_svg - (sandbox_14)
  // ID[2922296696B446C4A195F014042BE5C6]
  // Created #11-2-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Lon_type)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($Txt_value)
C_OBJECT:C1216($Obj_control)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
If ($Lon_formEvent=On Load:K2:1)
	
	OB SET:C1220($Obj_control;\
		"type";"text-color";\
		"mode";"front")
	
End if 

$Txt_value:=CONTROL_Area_hdl ($Obj_control)

If ($Lon_formEvent=On Clicked:K2:4)
	
	  //Return value in accordance with the type of container
	$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	$Lon_type:=Type:C295($Ptr_container->)
	
	Case of 
			
			  //______________________________________________________
		: ($Lon_type=Is text:K8:3)
			
			$Ptr_container->:=$Txt_value
			
			  //______________________________________________________
		: ($Lon_type=Is real:K8:4)
			
			$Ptr_container->:=Num:C11($Txt_value)
			
			  //______________________________________________________
	End case 
End if 