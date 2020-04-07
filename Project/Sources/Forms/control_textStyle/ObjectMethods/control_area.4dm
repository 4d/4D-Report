  // ----------------------------------------------------
  // Object method : Ribbons.sandbox_svg - (sandbox_14)
  // ID[2922296696B446C4A195F014042BE5C6]
  // Created #11-2-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_i;$Lon_left;$Lon_right;$Lon_top)
C_LONGINT:C283($Lon_type;$Lon_value;$Lon_x)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($Txt_me;$Txt_value)
C_OBJECT:C1216($Obj_control)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  //text values
ARRAY TEXT:C222($tTxt_values;0x0000)
APPEND TO ARRAY:C911($tTxt_values;"bold")
APPEND TO ARRAY:C911($tTxt_values;"italic")
APPEND TO ARRAY:C911($tTxt_values;"underline")

  // ----------------------------------------------------
If ($Lon_formEvent=On Load:K2:1)
	
	  //control parameters
	OBJECT GET COORDINATES:C663(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	OB SET:C1220($Obj_control;\
		"type";"segmented";\
		"source";"pict";\
		"width";(($Lon_right-$Lon_left)/3);\
		"height";$Lon_bottom-$Lon_top-1;\
		"mode";"additive")
	
	  //values
	OB SET ARRAY:C1227($Obj_control;"values";$tTxt_values)
	
	  //icons
	ARRAY TEXT:C222($tTxt_values;0x0000)
	APPEND TO ARRAY:C911($tTxt_values;"#Images/widgets/controls/style_bold.png")
	APPEND TO ARRAY:C911($tTxt_values;"#Images/widgets/controls/style_italic.png")
	APPEND TO ARRAY:C911($tTxt_values;"#Images/widgets/controls/style_underline.png")
	
	OB SET ARRAY:C1227($Obj_control;"definition";$tTxt_values)
	
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
			
			ARRAY TEXT:C222($tTxt_buffer;0x0000)
			JSON PARSE ARRAY:C1219($Txt_value;$tTxt_buffer)
			
			For ($Lon_i;1;Size of array:C274($tTxt_buffer);1)
				
				$Lon_x:=Find in array:C230($tTxt_values;$tTxt_buffer{$lon_i})
				$Lon_value:=$Lon_value ?+ ($Lon_x-1)
				
			End for 
			
			$Ptr_container->:=$Lon_value
			
			  //______________________________________________________
	End case 
End if 