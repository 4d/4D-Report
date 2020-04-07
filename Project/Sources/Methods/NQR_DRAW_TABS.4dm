//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_DRAW_TABS
  // Database: 4D Report
  // ID[E7F72553A92E4CDCBF99C28220E54F5C]
  // Created #18-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284(${1})

C_LONGINT:C283($kLon_fontSize;$kLon_height;$Lon_bottom;$Lon_i;$Lon_left;$Lon_parameters)
C_LONGINT:C283($Lon_platform;$Lon_right;$Lon_selected;$Lon_start;$Lon_tabs;$Lon_top)
C_LONGINT:C283($Lon_width)
C_TEXT:C284($kTxt_font;$kTxt_highlightColor;$Svg_group;$Svg_groupLabels;$Svg_groupTabs;$Svg_object)
C_TEXT:C284($Svg_root;$Txt_backgroundColor;$Txt_data;$Txt_object;$Txt_value)

If (False:C215)
	C_TEXT:C284(NQR_DRAW_TABS ;${1})
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	ARRAY TEXT:C222($tTxt_label;$Lon_parameters)
	
	For ($Lon_i;1;$Lon_parameters;1)
		
		$tTxt_label{$Lon_i}:=${$Lon_i}
		
	End for 
	
Else 
	
	ABORT:C156
	
End if 

  //#ACI0095293
$Txt_object:="ribbon"

OBJECT GET COORDINATES:C663(*;"title";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
$Lon_width:=$Lon_right

OBJECT GET COORDINATES:C663(*;$Txt_object;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)

$Lon_right:=$Lon_right-$Lon_left
$Lon_bottom:=$Lon_bottom-$Lon_top
$Lon_bottom:=$Lon_bottom-1

$kLon_height:=44

_O_PLATFORM PROPERTIES:C365($Lon_platform)
$kTxt_font:=Choose:C955($Lon_platform=Windows:K25:3;"Segoe UI";"Lucida Grande")

$kLon_fontSize:=12

$kTxt_highlightColor:="dodgerblue"

$Lon_tabs:=Size of array:C274($tTxt_label)

For ($Lon_i;1;$Lon_tabs;1)
	
	SVG GET ATTRIBUTE:C1056(*;$Txt_object;"t_"+String:C10($Lon_i);\
		"visibility";$Txt_value)
	
	If ($Txt_value="visible")
		
		$Lon_selected:=$Lon_i
		$Lon_i:=MAXLONG:K35:2-1
		
	End if 
End for 

$Lon_selected:=Choose:C955($Lon_selected=0;1;$Lon_selected)

$Svg_root:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")

DOM SET XML ATTRIBUTE:C866($Svg_root;\
"xmlns:xlink";"http://www.w3.org/1999/xlink";\
"viewport-fill";"white")

$Txt_backgroundColor:="rgb(240,240,240)"

  //Define style for the tabs
$Svg_object:=DOM Create XML element:C865($Svg_root;"style";\
"type";"text/css")

DOM SET XML ELEMENT VALUE:C868($Svg_object;"path{fill:"+$Txt_backgroundColor+";stroke:"+$Txt_backgroundColor+";stroke-width:1}")

  //background
$Svg_groupTabs:=DOM Create XML element:C865($Svg_root;"g";\
"id";"background")

  //foreground
$Svg_groupLabels:=DOM Create XML element:C865($Svg_root;"g";\
"id";"foreground";\
"font-family";$kTxt_font;\
"font-size";$kLon_fontSize;\
"text-align";"center")

For ($Lon_i;1;$Lon_tabs;1)
	
	$Lon_start:=$Lon_start+$Lon_width  //first is 0
	
	  //Get the string width
	$Lon_width:=svg_Get_string_width ($tTxt_label{$Lon_i};$kTxt_font;$kLon_fontSize)+40
	
	  //Put the tab's label
	$Svg_object:=DOM Create XML element:C865($Svg_groupLabels;"textArea";\
		"id";"l_"+String:C10($Lon_i);\
		"x";$Lon_start;\
		"y";17;\
		"width";$Lon_width;\
		"height";$kLon_height;\
		"font-style";"normal";\
		"font-weight";Choose:C955($Lon_i=$Lon_selected;"bold";"normal");\
		"text-decoration";"none";\
		"fill";$kTxt_highlightColor)
	
	$Svg_object:=DOM Append XML child node:C1080($Svg_object;XML DATA:K45:12;$tTxt_label{$Lon_i})
	
	$Svg_object:=DOM Create XML element:C865($Svg_groupLabels;"rect";\
		"id";"b_"+String:C10($Lon_i);\
		"x";$Lon_start;\
		"y";0;\
		"width";$Lon_width;\
		"height";$kLon_height;\
		"stroke";"none";\
		"fill";$Txt_backgroundColor;\
		"fill-opacity";0.01)
	
	  //Draw the tab
	$Svg_group:=DOM Create XML element:C865($Svg_groupTabs;"g";\
		"id";"t_"+String:C10($Lon_i);\
		"visibility";Choose:C955($Lon_i=$Lon_selected;"visible";"hidden"))
	
	$Txt_data:="M-1,"+String:C10($Lon_bottom)\
		+" L-1,"+String:C10($kLon_height)\
		+" H"+String:C10($Lon_start-1)\
		+" L"+String:C10($Lon_start-1)+",0"\
		+" H"+String:C10($Lon_start+$Lon_width)\
		+" L"+String:C10($Lon_start+$Lon_width)+","+String:C10($kLon_height)\
		+" H"+String:C10($Lon_right+1)\
		+" L"+String:C10($Lon_right+1)+","+String:C10($Lon_bottom)\
		+"z"
	
	$Svg_object:=DOM Create XML element:C865($Svg_group;"path";\
		"d";$Txt_data)
	
End for 

SVG EXPORT TO PICTURE:C1017($Svg_root;(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_object))->)

DOM CLOSE XML:C722($Svg_root)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End