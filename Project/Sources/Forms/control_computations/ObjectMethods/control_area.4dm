  // ----------------------------------------------------
  // Object method : Ribbons.sandbox_svg - (sandbox_14)
  // ID[2922296696B446C4A195F014042BE5C6]
  // Created #11-2-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_i;$Lon_left;$Lon_right;$Lon_top)
C_LONGINT:C283($Lon_type;$Lon_value)
C_POINTER:C301($Ptr_container)
C_TEXT:C284($Txt_me;$Txt_value)
C_OBJECT:C1216($Obj_control)

ARRAY TEXT:C222($tTxt_values;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

APPEND TO ARRAY:C911($tTxt_values;"0")  //sum
APPEND TO ARRAY:C911($tTxt_values;"1")  //average
APPEND TO ARRAY:C911($tTxt_values;"2")  //min
APPEND TO ARRAY:C911($tTxt_values;"3")  //max
APPEND TO ARRAY:C911($tTxt_values;"4")  //count
APPEND TO ARRAY:C911($tTxt_values;"5")  //standard deviation

  // ----------------------------------------------------
If ($Lon_formEvent=On Load:K2:1)
	
	  //control parameters
	OBJECT GET COORDINATES:C663(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
	
	OB SET:C1220($Obj_control;\
		"type";"segmented";\
		"source";"text";\
		"width";(($Lon_right-$Lon_left)/6);\
		"height";$Lon_bottom-$Lon_top-1;\
		"font-color";"black";\
		"mode";"additive")
	
	  //values
	OB SET ARRAY:C1227($Obj_control;"values";$tTxt_values)
	
	  //texts
	$tTxt_values{1}:=Char:C90(0x2211)
	$tTxt_values{2}:="n"+Char:C90(0x0305)
	$tTxt_values{3}:="<"
	$tTxt_values{4}:=">"
	$tTxt_values{5}:="N"
	$tTxt_values{6}:=Char:C90(0x03C3)
	OB SET ARRAY:C1227($Obj_control;"definition";$tTxt_values)
	
	  //tips 
	$tTxt_values{1}:=Get localized string:C991("nqr_sum")
	$tTxt_values{2}:=Get localized string:C991("nqr_average")
	$tTxt_values{3}:=Get localized string:C991("nqr_min")
	$tTxt_values{4}:=Get localized string:C991("nqr_max")
	$tTxt_values{5}:=Get localized string:C991("nqr_count")
	$tTxt_values{6}:=Get localized string:C991("nqr_standard_deviation")
	OB SET ARRAY:C1227($Obj_control;"tips";$tTxt_values)
	
	  //font-size
	ARRAY LONGINT:C221($tLon_;6)
	$tLon_{1}:=16
	$tLon_{2}:=18
	$tLon_{3}:=18
	$tLon_{4}:=18
	$tLon_{5}:=16
	$tLon_{6}:=18
	OB SET ARRAY:C1227($Obj_control;"font-size";$tLon_)
	
	  //vertical offset
	$tLon_{1}:=-8
	$tLon_{2}:=-8
	$tLon_{3}:=-8
	$tLon_{4}:=-8
	$tLon_{5}:=-7
	$tLon_{6}:=-9
	OB SET ARRAY:C1227($Obj_control;"vOffset";$tLon_)
	
	  //colors
	$tTxt_values{1}:="red"
	$tTxt_values{2}:="blue"
	$tTxt_values{3}:="orange"
	$tTxt_values{4}:="orange"
	$tTxt_values{5}:="blue"
	$tTxt_values{6}:="blue"
	OB SET ARRAY:C1227($Obj_control;"font-color";$tTxt_values)
	
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
				
				$Lon_value:=$Lon_value ?+ Num:C11($tTxt_buffer{$Lon_i})
				
			End for 
			
			$Ptr_container->:=$Lon_value
			
			  //______________________________________________________
	End case 
End if 