// ----------------------------------------------------
// Object method : Ribbons.sandbox_svg - (sandbox_14)
// ID[2922296696B446C4A195F014042BE5C6]
// Created #11-2-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_bottom; $Lon_formEvent; $Lon_left; $Lon_right; $Lon_top; $Lon_type)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($Txt_me; $Txt_value)
C_OBJECT:C1216($Obj_control)
C_BOOLEAN:C305($boo_isColorSchemeLight)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

ARRAY TEXT:C222($tTxt_values; 0x0000)
APPEND TO ARRAY:C911($tTxt_values; "default")  //0
APPEND TO ARRAY:C911($tTxt_values; "left")  //1
APPEND TO ARRAY:C911($tTxt_values; "center")  //2
APPEND TO ARRAY:C911($tTxt_values; "right")  //3

// ----------------------------------------------------
If ($Lon_formEvent=On Load:K2:1)
	
	//control parameters
	OBJECT GET COORDINATES:C663(*; $Txt_me; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
	OB SET:C1220($Obj_control; \
		"type"; "segmented"; \
		"source"; "pict"; \
		"width"; (($Lon_right-$Lon_left)/4); \
		"height"; $Lon_bottom-$Lon_top-1; \
		"pictWidth"; 19; \
		"pictHeight"; 18; \
		"offset"; 1)
	
	//values
	OB SET ARRAY:C1227($Obj_control; "values"; $tTxt_values)
	
	//icons
	ARRAY TEXT:C222($tTxt_values; 0x0000)
	
	$boo_isColorSchemeLight:=(FORM Get color scheme:C1761="light")
	APPEND TO ARRAY:C911($tTxt_values; "#Images/widgets/controls/align_both"+Choose:C955($boo_isColorSchemeLight; ".png"; "_dark.png"))
	APPEND TO ARRAY:C911($tTxt_values; "#Images/widgets/controls/align_left"+Choose:C955($boo_isColorSchemeLight; ".png"; "_dark.png"))
	APPEND TO ARRAY:C911($tTxt_values; "#Images/widgets/controls/align_center"+Choose:C955($boo_isColorSchemeLight; ".png"; "_dark.png"))
	APPEND TO ARRAY:C911($tTxt_values; "#Images/widgets/controls/align_right"+Choose:C955($boo_isColorSchemeLight; ".png"; "_dark.png"))
	
	OB SET ARRAY:C1227($Obj_control; "definition"; $tTxt_values)
	
End if 

$Txt_value:=CONTROL_Area_hdl($Obj_control)

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
			
			$Ptr_container->:=Find in array:C230($tTxt_values; $Txt_value)-1
			
			//______________________________________________________
	End case 
End if 