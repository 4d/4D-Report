//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONTROL_Area_hdl
// ID[052C7A9168CF4185AB509483EFEDEDC8]
// Created #11-2-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Manages drawing (if the parameter $1 is passed) and events of the controls
// ----------------------------------------------------
// Modified by Vincent de Lachaux (24/10/14)
// Remove the link to component 4D SVG
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_OBJECT:C1216($1)

C_BOOLEAN:C305($Boo_selected; $boo_isBorder; $boo_isColorSchemeLight)
C_LONGINT:C283($Lon_color; $Lon_fontSize; $Lon_formEvent; $Lon_i; $Lon_id; $Lon_number)
C_LONGINT:C283($Lon_offset; $Lon_parameters; $Lon_pictHeight; $Lon_pictWidth; $Lon_platform; $Lon_round)
C_LONGINT:C283($Lon_size; $Lon_state; $Lon_type; $Lon_x; $Lon_y)
C_POINTER:C301($Ptr_container)
C_REAL:C285($kNum_highlithOpacity; $Num_buffer; $Num_height; $Num_unit; $Num_width)
C_TEXT:C284($Dir_resources; $Dom_style; $File_icon; $kTxt_defaultColor; $kTxt_highlithColor; $Svg_back)
C_TEXT:C284($Svg_control; $Svg_defs; $Svg_main; $Svg_root; $Svg_unit; $Txt_buffer)
C_TEXT:C284($Txt_color; $Txt_fontColor; $Txt_fontFamily; $Txt_hightlight; $Txt_id; $Txt_me)
C_TEXT:C284($Txt_mode; $Txt_path; $Txt_result; $Txt_stroke; $Txt_type; $Txt_URL)
C_OBJECT:C1216($Obj_definition)

ARRAY TEXT:C222($tTxt_definition; 0)

If (False:C215)
	C_TEXT:C284(CONTROL_Area_hdl; $0)
	C_OBJECT:C1216(CONTROL_Area_hdl; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	COMPILER_CONTROL
	
	If ($Lon_parameters>=1)
		
		$Obj_definition:=$1  //{object definition} Omitted for the object's script
		
	End if 
	
	$Txt_me:="control_area"
	$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	
	//constants
	$kTxt_highlithColor:=Replace string:C233("rgb({red},{green},{blue})"; "{red}"; String:C10((<>ctrl_highlitColor & 0x00FF0000) >> 16))
	$kTxt_highlithColor:=Replace string:C233($kTxt_highlithColor; "{green}"; String:C10((<>ctrl_highlitColor & 0xFF00) >> 8))
	$kTxt_highlithColor:=Replace string:C233($kTxt_highlithColor; "{blue}"; String:C10((<>ctrl_highlitColor & 0x00FF)))
	
	If (True:C214)
		
		$kTxt_defaultColor:=Choose:C955((FORM Get color scheme:C1761="light"); "black"; "white")
	Else 
		//$kTxt_defaultColor:="black"
	End if 
	
	$kNum_highlithOpacity:=0.4  //opacity of a selected item
	
	_O_PLATFORM PROPERTIES:C365($Lon_platform)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (OB Is defined:C1231($Obj_definition))  //draw
	
	//Get the preset value
	$Lon_type:=Type:C295($Ptr_container->)
	
	$Txt_hightlight:=Choose:C955(OB Is defined:C1231($Obj_definition; "highlight"); \
		OB Get:C1224($Obj_definition; "highlight"; Is text:K8:3); \
		$kTxt_highlithColor)
	
	$Txt_stroke:=Choose:C955(OB Is defined:C1231($Obj_definition; "stroke"); \
		OB Get:C1224($Obj_definition; "stroke"; Is text:K8:3); \
		"darkgray")
	
	$Txt_fontFamily:=Choose:C955(OB Is defined:C1231($Obj_definition; "font-family"); \
		OB Get:C1224($Obj_definition; "font-family"; Is text:K8:3); \
		"'Lucida Grande','Segoe UI','Arial',sans-serif")
	
	$Txt_type:=OB Get:C1224($Obj_definition; "type"; Is text:K8:3)
	
	If (OB Is defined:C1231($Obj_definition; "offset"))
		
		$Lon_offset:=OB Get:C1224($Obj_definition; "offset"; Is longint:K8:6)
		
	End if 
	
	//$Svg_root:=SVG_New
	$Svg_root:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")
	DOM SET XML ATTRIBUTE:C866($Svg_root; \
		"xmlns:xlink"; "http://www.w3.org/1999/xlink"; \
		"viewport-fill"; "none"; \
		"viewport-fill-opacity"; 0; \
		"vdl"; "vincent@de-lachaux.net")
	
	$Svg_defs:=DOM Create XML element:C865($Svg_root; "defs")
	
	//Define the styles
	$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
		"type"; "text/css")
	DOM SET XML ELEMENT VALUE:C868($Dom_style; "path,rect,circle{fill: "+$Txt_hightlight+"; fill-opacity: 0.01; stroke: "+$Txt_stroke+"; stroke-width: 1}")
	
	//Control is defined in a group which keeps the useful attributes in a private namespace (see below)
	$Svg_control:=DOM Create XML element:C865($Svg_root; "g"; \
		"id"; "controls"; \
		"vdl:type"; $Txt_type; \
		"vdl:offset"; $Lon_offset)
	
	$Dir_resources:=Get 4D folder:C485(Current resources folder:K5:16)
	
	Case of 
			
			//______________________________________________________
		: ($Txt_type="checkbox")\
			 | ($Txt_type="checkcircle")
			
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "path.check-mark{fill: none; stroke: "+$Txt_hightlight+"; stroke-width: 2}")
			
			//The controls are drawn in a main group
			//Move 0.5 px to disable anti-aliasing
			$Svg_main:=DOM Create XML element:C865($Svg_control; "g"; \
				"transform"; "translate(0.5,0.5)")
			
			//Prepare a group, in the background, for the check mark
			$Svg_back:=DOM Create XML element:C865($Svg_main; "g")
			
			$Lon_size:=Choose:C955(OB Is defined:C1231($Obj_definition; "width"); OB Get:C1224($Obj_definition; "width"; Is longint:K8:6); 14)  //default is 14px
			
			If ($Txt_type="checkcircle")
				
				//radius = side/2
				$Svg_unit:=DOM Create XML element:C865($Svg_main; "circle"; \
					"cx"; $Lon_size/2; \
					"cy"; $Lon_size/2; \
					"r"; $Lon_size/2)
				
			Else 
				
				$Svg_unit:=DOM Create XML element:C865($Svg_main; "rect"; \
					"x"; 0; \
					"y"; 0; \
					"width"; $Lon_size; \
					"height"; $Lon_size; \
					"rx"; 1; \
					"fill"; "white")
				
			End if 
			
			DOM SET XML ATTRIBUTE:C866($Svg_unit; \
				"id"; "cb")
			
			Case of 
					
					//…………………………………………
				: ($Lon_type=Is text:K8:3)
					
					$Boo_selected:=($Ptr_container->="1")
					
					//…………………………………………
				: ($Lon_type=Is real:K8:4)
					
					$Boo_selected:=($Ptr_container->=1)
					
					//…………………………………………
			End case 
			
			DOM SET XML ATTRIBUTE:C866($Svg_control; \
				"vdl:value"; Num:C11($Boo_selected))
			
			//Draw the check mark
			$Num_unit:=$Lon_size/4
			
			$Txt_buffer:="M"+String:C10($Num_unit; "&xml")+","+String:C10($Num_unit*2; "&xml")\
				+" L"+String:C10($Num_unit*2; "&xml")+","+String:C10($Num_unit*3; "&xml")\
				+" L"+String:C10($Num_unit*3; "&xml")+","+String:C10($Num_unit; "&xml")
			
			$Svg_unit:=DOM Create XML element:C865($Svg_back; "path"; \
				"d"; $Txt_buffer; \
				"id"; "check"; \
				"class"; "check-mark"; \
				"visibility"; Choose:C955($Boo_selected; "visible"; "hidden"); \
				"stroke-linecap"; "round"; \
				"stroke-linejoin"; "round"; \
				"stroke-width"; "2"; \
				"fill"; "none")
			
			//______________________________________________________
		: ($Txt_type="text-color")
			
			$Txt_mode:=OB Get:C1224($Obj_definition; "mode"; Is text:K8:3)
			
			
			$boo_isBorder:=OB Get:C1224($Obj_definition; "isBorder"; Is boolean:K8:9)
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "rect.color{fill: "+Choose:C955($Txt_mode="back"; "white"; "black")+"; fill-opacity: 1; stroke: none}")
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "rect.none{fill: none; fill-opacity: 0}")
			
			//The controls are drawn in a main group
			//Move 0.5 px to disable anti-aliasing
			
			//control
			$Svg_unit:=DOM Create XML element:C865($Svg_control; "rect"; \
				"x"; 0; \
				"y"; 0; \
				"width"; 36; \
				"height"; 24; \
				"rx"; 4; \
				"class"; "none")
			
			//sample color
			$Svg_unit:=DOM Create XML element:C865($Svg_control; "rect"; \
				"x"; 7; \
				"y"; 19; \
				"width"; 24; \
				"height"; 3; \
				"class"; "color"; \
				"id"; "sample")
			
			
			$boo_isColorSchemeLight:=(FORM Get color scheme:C1761="light")
			
			//place icon - /!\ the relative paths don't operate from a component
			If ($boo_isBorder)
				$File_icon:=Get 4D folder:C485(Current resources folder:K5:16)\
					+"Images"+Folder separator:K24:12\
					+"widgets"+Folder separator:K24:12\
					+"controls"+Folder separator:K24:12\
					+"typo_border"+Choose:C955($boo_isColorSchemeLight; ".png"; "_dark.png")
			Else 
				$File_icon:=Get 4D folder:C485(Current resources folder:K5:16)\
					+"Images"+Folder separator:K24:12\
					+"widgets"+Folder separator:K24:12\
					+"controls"+Folder separator:K24:12\
					+"typo_"+Choose:C955($Txt_mode="back"; "back"; "front")+Choose:C955($boo_isColorSchemeLight; ".png"; "_dark.png")
			End if 
			
			
			DOM SET XML ATTRIBUTE:C866(DOM Get root XML element:C1053($Svg_control); \
				"xmlns:xlink"; "http://www.w3.org/1999/xlink")
			$Svg_unit:=DOM Create XML element:C865($Svg_control; "image"; \
				"xlink:href"; "file:///"+Convert path system to POSIX:C1106($File_icon; *); \
				"x"; 9; \
				"y"; 2; \
				"width"; 19; \
				"height"; 16)
			
			Case of 
					
					//…………………………………………
				: ($Lon_type=Is real:K8:4)
					
					$Lon_color:=$Ptr_container->
					
					//----------------------------------------
				Else 
					
					ASSERT:C1129(False:C215; "TBD")
					
					//…………………………………………
			End case 
			
			DOM SET XML ATTRIBUTE:C866($Svg_control; \
				"vdl:value"; $Lon_color; \
				"vdl:mode"; $Txt_mode)
			
			$Txt_color:=Replace string:C233("rgb({red},{green},{blue})"; "{red}"; String:C10(($Lon_color & 0x00FF0000) >> 16))
			$Txt_color:=Replace string:C233($Txt_color; "{green}"; String:C10(($Lon_color & 0xFF00) >> 8))
			$Txt_color:=Replace string:C233($Txt_color; "{blue}"; String:C10(($Lon_color & 0x00FF)))
			DOM SET XML ATTRIBUTE:C866($Svg_unit; \
				"fill"; $Txt_color)
			
			//______________________________________________________
		: ($Txt_type="color-picker")
			
			$Txt_mode:=OB Get:C1224($Obj_definition; "mode"; Is text:K8:3)
			
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "rect.color{fill: "+Choose:C955($Txt_mode="back"; "white"; "black")+"; fill-opacity: 1; stroke: "+$Txt_stroke+"}")
			
			//The controls are drawn in a main group
			//Move 0.5 px to disable anti-aliasing
			$Svg_main:=DOM Create XML element:C865($Svg_control; "g"; \
				"transform"; "translate(0.5,0.5)")
			
			$Svg_unit:=DOM Create XML element:C865($Svg_main; "rect"; \
				"x"; 0; \
				"y"; 0; \
				"width"; 50; \
				"height"; 22; \
				"rx"; 3)
			
			$Svg_unit:=DOM Create XML element:C865($Svg_main; "rect"; \
				"x"; 4; \
				"y"; 4; \
				"width"; 42; \
				"height"; 14; \
				"class"; "color"; \
				"id"; "sample")
			
			Case of 
					
					//…………………………………………
				: ($Lon_type=Is real:K8:4)
					
					$Lon_color:=$Ptr_container->
					
					//----------------------------------------
				Else 
					
					ASSERT:C1129(False:C215; "TBD")
					
					//…………………………………………
			End case 
			
			DOM SET XML ATTRIBUTE:C866($Svg_control; \
				"vdl:value"; $Lon_color; \
				"vdl:mode"; $Txt_mode)
			
			$Txt_color:=Replace string:C233("rgb({red},{green},{blue})"; "{red}"; String:C10(($Lon_color & 0x00FF0000) >> 16))
			$Txt_color:=Replace string:C233($Txt_color; "{green}"; String:C10(($Lon_color & 0xFF00) >> 8))
			$Txt_color:=Replace string:C233($Txt_color; "{blue}"; String:C10(($Lon_color & 0x00FF)))
			DOM SET XML ATTRIBUTE:C866($Svg_unit; \
				"fill"; $Txt_color)
			
			//______________________________________________________
		: ($Txt_type="tabs")
			
			$Num_width:=OB Get:C1224($Obj_definition; "width"; Is real:K8:4)
			$Num_height:=OB Get:C1224($Obj_definition; "height"; Is real:K8:4)
			
			$Lon_round:=Choose:C955(OB Is defined:C1231($Obj_definition; "round"); OB Get:C1224($Obj_definition; "round"; Is longint:K8:6); 5)
			
			OB GET ARRAY:C1229($Obj_definition; "definition"; $tTxt_definition)
			$Lon_number:=Size of array:C274($tTxt_definition)
			
			ARRAY TEXT:C222($tTxt_values; 0x0000)
			OB GET ARRAY:C1229($Obj_definition; "values"; $tTxt_values)
			ARRAY TEXT:C222($tTxt_values; $Lon_number)
			
			Case of 
					
					//…………………………………………
				: ($Lon_type=Is text:K8:3)
					
					$Lon_id:=Find in array:C230($tTxt_values; $Ptr_container->)
					
					//…………………………………………
				: ($Lon_type=Is real:K8:4)
					
					$Lon_id:=$Ptr_container->
					
					//…………………………………………
			End case 
			
			//Keep the useful parameters into the svg
			DOM SET XML ATTRIBUTE:C866($Svg_control; \
				"vdl:number"; $Lon_number; \
				"vdl:values"; JSON Stringify array:C1228($tTxt_values))
			
			$Lon_fontSize:=Choose:C955(OB Is defined:C1231($Obj_definition; "font-size"); OB Get:C1224($Obj_definition; "font-size"; Is longint:K8:6); 13)
			
			$Txt_fontColor:=Choose:C955(OB Is defined:C1231($Obj_definition; "font-color"); OB Get:C1224($Obj_definition; "font-color"; Is text:K8:3); $kTxt_highlithColor)
			
			$Lon_x:=0
			$Lon_y:=($Num_height/2)-($Lon_fontSize\2)-1
			
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "textArea{font-family: "+$Txt_fontFamily+"; font-size: "+String:C10($Lon_fontSize)+"px; fill: "+$Txt_fontColor+"}")
			
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "textArea.selected{font-family: "+$Txt_fontFamily+"; font-size: "+String:C10($Lon_fontSize)+"px; fill: white}")
			
			$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
				"type"; "text/css")
			DOM SET XML ELEMENT VALUE:C868($Dom_style; "path{fill: "+$Txt_hightlight+"; fill-opacity: 0.01; stroke: "+$Txt_hightlight+"; stroke-width: 0.8}")
			
			For ($Lon_i; 1; $Lon_number; 1)
				
				$Svg_unit:=DOM Create XML element:C865($Svg_control; "textArea"; \
					"x"; $Lon_x; \
					"y"; $Lon_y; \
					"width"; $Num_width; \
					"text-align"; "center"; \
					"id"; "l"+String:C10($Lon_i))
				DOM SET XML ELEMENT VALUE:C868($Svg_unit; $tTxt_definition{$Lon_i})
				
				If ($Lon_i=$Lon_id)
					
					DOM SET XML ATTRIBUTE:C866($Svg_unit; "class"; "selected"; \
						"4D-bringToFront"; True:C214)
					
				End if 
				
				$Lon_x:=$Lon_x+$Num_width
				
			End for 
			
			CONTROL_DRAW_SEGMENTS($Svg_control; $Lon_number; $Lon_round; $Num_width; $Num_height; $Lon_id; ->$tTxt_values)
			
			//______________________________________________________
		: ($Txt_type="segmented")
			
			$Num_width:=OB Get:C1224($Obj_definition; "width"; Is real:K8:4)
			$Num_height:=OB Get:C1224($Obj_definition; "height"; Is real:K8:4)
			
			$Lon_round:=Choose:C955(OB Is defined:C1231($Obj_definition; "round"); OB Get:C1224($Obj_definition; "round"; Is longint:K8:6); \
				Choose:C955($Lon_platform=Windows:K25:3; 0; 4))
			
			OB GET ARRAY:C1229($Obj_definition; "definition"; $tTxt_definition)
			$Lon_number:=Size of array:C274($tTxt_definition)
			
			ARRAY TEXT:C222($tTxt_values; 0x0000)
			OB GET ARRAY:C1229($Obj_definition; "values"; $tTxt_values)
			ARRAY TEXT:C222($tTxt_values; $Lon_number)
			
			Case of 
					
					//…………………………………………
				: ($Lon_type=Is text:K8:3)
					
					$Lon_id:=Find in array:C230($tTxt_values; $Ptr_container->)
					
					//…………………………………………
				: ($Lon_type=Is real:K8:4)
					
					$Lon_id:=$Ptr_container->
					
					//…………………………………………
			End case 
			
			//Keep the useful parameters into the svg
			//#ACI0097108 {
			//DOM SET XML ATTRIBUTE($Svg_control;
			//"vdl:number";$Lon_number;
			//"vdl:values";JSON Stringify array($tTxt_values);
			//"vdl:mode";OB Get($Obj_definition;"mode"))
			DOM SET XML ATTRIBUTE:C866($Svg_control; \
				"vdl:number"; $Lon_number; \
				"vdl:values"; JSON Stringify array:C1228($tTxt_values); \
				"vdl:mode"; OB Get:C1224($Obj_definition; "mode"; Is text:K8:3))
			//}
			
			If (OB Is defined:C1231($Obj_definition; "tips"))
				
				ARRAY TEXT:C222($tTxt_buffer; 0x0000)
				OB GET ARRAY:C1229($Obj_definition; "tips"; $tTxt_buffer)
				DOM SET XML ATTRIBUTE:C866($Svg_control; \
					"vdl:tips"; JSON Stringify array:C1228($tTxt_buffer))
				
			Else 
				
				DOM SET XML ATTRIBUTE:C866($Svg_control; \
					"vdl:tips"; "")
				
			End if 
			
			$Txt_buffer:=OB Get:C1224($Obj_definition; "source"; Is text:K8:3)
			
			Case of 
					
					//………………………………………………………………………………………………………………
				: ($Txt_buffer="text")
					
					//font size
					ARRAY LONGINT:C221($tLon_fontSizes; 0x0000)
					
					If (OB Is defined:C1231($Obj_definition; "font-size"))
						
						If (OB Get type:C1230($Obj_definition; "font-size")=Object array:K8:28)
							
							OB GET ARRAY:C1229($Obj_definition; "font-size"; $tLon_fontSizes)
							
						Else 
							
							$Lon_fontSize:=OB Get:C1224($Obj_definition; "font-size"; Is longint:K8:6)
							
						End if 
					End if 
					
					$Lon_fontSize:=Choose:C955($Lon_fontSize=0; 13; $Lon_fontSize)
					
					//missing are set to default
					ARRAY LONGINT:C221($tLon_fontSizes; $Lon_number)
					
					For ($Lon_i; 1; $Lon_number; 1)
						
						$tLon_fontSizes{$Lon_i}:=Choose:C955($tLon_fontSizes{$Lon_i}=0; $Lon_fontSize; $tLon_fontSizes{$Lon_i})
						
					End for 
					
					//font color
					ARRAY TEXT:C222($tTxt_fontColors; 0x0000)
					
					If (OB Is defined:C1231($Obj_definition; "font-color"))
						
						If (OB Get type:C1230($Obj_definition; "font-color")=Is collection:K8:32)
							
							OB GET ARRAY:C1229($Obj_definition; "font-color"; $tTxt_fontColors)
							
						Else 
							
							$Txt_fontColor:=OB Get:C1224($Obj_definition; "font-color"; Is text:K8:3)
							
						End if 
					End if 
					
					$Txt_fontColor:=Choose:C955(Length:C16($Txt_fontColor)=0; $kTxt_defaultColor; $Txt_fontColor)
					
					$Lon_x:=0
					$Lon_y:=($Num_height/2)-($Lon_fontSize\2)-1
					
					//missing are set to default
					ARRAY TEXT:C222($tTxt_fontColors; $Lon_number)
					
					For ($Lon_i; 1; $Lon_number; 1)
						
						$tTxt_fontColors{$Lon_i}:=Choose:C955(Length:C16($tTxt_fontColors{$Lon_i})=0; $Txt_fontColor; $tTxt_fontColors{$Lon_i})
						
					End for 
					
					//vertical offset
					ARRAY LONGINT:C221($tLon_vOffsets; 0x0000)
					
					If (OB Is defined:C1231($Obj_definition; "vOffset"))
						
						If (OB Get type:C1230($Obj_definition; "vOffset")=Object array:K8:28)
							
							OB GET ARRAY:C1229($Obj_definition; "vOffset"; $tLon_vOffsets)
							
						Else 
							
							$Lon_fontSize:=OB Get:C1224($Obj_definition; "vOffset"; Is longint:K8:6)
							
						End if 
					End if 
					
					ARRAY LONGINT:C221($tLon_vOffsets; $Lon_number)  //missing are set to 0
					
					$Dom_style:=DOM Create XML element:C865($Svg_defs; "style"; \
						"type"; "text/css")
					
					DOM SET XML ELEMENT VALUE:C868($Dom_style; "textArea{font-family: "+$Txt_fontFamily)
					
					For ($Lon_i; 1; $Lon_number; 1)
						
						DOM SET XML ELEMENT VALUE:C868(DOM Create XML element:C865($Svg_control; "textArea"; \
							"x"; $Lon_x; \
							"y"; $Lon_y+$tLon_vOffsets{$Lon_i}; \
							"width"; $Num_width; \
							"font-size"; $tLon_fontSizes{$Lon_i}; \
							"fill"; $tTxt_fontColors{$Lon_i}; \
							"text-align"; "center"; \
							"font-weight"; "bold"); \
							$tTxt_definition{$Lon_i})
						
						$Lon_x:=$Lon_x+$Num_width
						
					End for 
					
					//………………………………………………………………………………………………………………
				: ($Txt_buffer="pict")
					
					//Put the pictures in the background
					$Lon_pictWidth:=Choose:C955(OB Is defined:C1231($Obj_definition; "pictWidth"); OB Get:C1224($Obj_definition; "pictWidth"; Is longint:K8:6); 16)
					$Lon_pictHeight:=Choose:C955(OB Is defined:C1231($Obj_definition; "pictHeight"); OB Get:C1224($Obj_definition; "pictHeight"; Is longint:K8:6); $Lon_pictWidth)
					
					$Lon_x:=($Num_width/2)-($Lon_pictWidth/2)
					$Lon_y:=($Num_height/2)-($Lon_pictHeight/2)
					
					For ($Lon_i; 1; $Lon_number; 1)
						
						$Txt_URL:=Delete string:C232($tTxt_definition{$Lon_i}; 1; 1)
						
						$Txt_path:=$Dir_resources\
							+Replace string:C233($Txt_URL; "/"; Folder separator:K24:12)
						
						$Txt_URL:="file:///"\
							+Convert path system to POSIX:C1106($Txt_path; *)
						
						DOM SET XML ATTRIBUTE:C866(DOM Create XML element:C865($Svg_control; "image"; \
							"xlink:href"; $Txt_URL; \
							"x"; $Lon_x; \
							"y"; $Lon_y; \
							"width"; $Lon_pictWidth; \
							"height"; $Lon_pictWidth); \
							"id"; "p_"+String:C10($Lon_i))
						
						$Lon_x:=$Lon_x+$Num_width
						
					End for 
					
					//………………………………………………………………………………………………………………
				Else 
					
					ASSERT:C1129(False:C215; "TBD")
					
					//………………………………………………………………………………………………………………
			End case 
			
			CONTROL_DRAW_SEGMENTS($Svg_control; $Lon_number; $Lon_round; $Num_width; $Num_height; $Lon_id; ->$tTxt_values)
			
			//______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215; "TBD")
			
			//______________________________________________________
	End case 
	
	SVG EXPORT TO PICTURE:C1017($Svg_root; (OBJECT Get pointer:C1124(Object named:K67:5; $Txt_me))->; Copy XML data source:K45:17)
	DOM CLOSE XML:C722($Svg_root)
	
Else 
	
	$Lon_formEvent:=Form event code:C388
	
	$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)
	$Lon_type:=Type:C295($Ptr_container->)
	
	Case of 
			
			//-----------------------------------------
		: ($Lon_formEvent=On Clicked:K2:4)\
			 | ($Lon_formEvent=On Mouse Move:K2:35)
			
			$Txt_id:=SVG Find element ID by coordinates:C1054(*; $Txt_me; MouseX; MouseY)
			
			//-----------------------------------------
	End case 
	
	SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:type"; $Txt_type)
	
	Case of 
			
			//______________________________________________________
		: ($Txt_type="checkbox")\
			 | ($Txt_type="checkcircle")
			
			Case of 
					
					//-----------------------------------------
				: ($Lon_formEvent=On Clicked:K2:4)  //user action
					
					SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:value"; $Lon_state)
					
					$Boo_selected:=($Lon_state=0)
					
					//-----------------------------------------
				: ($Lon_formEvent=On Bound Variable Change:K2:52)  //language assignment
					
					Case of 
							
							//………………………………………………
						: ($Lon_type=Is text:K8:3)
							
							$Boo_selected:=($Ptr_container->="1")
							
							//………………………………………………
						: ($Lon_type=Is real:K8:4)
							
							$Boo_selected:=($Ptr_container->=1)
							
							//………………………………………………
					End case 
					
					//-----------------------------------------
			End case 
			
			SVG SET ATTRIBUTE:C1055(*; $Txt_me; "check"; \
				"visibility"; Choose:C955($Boo_selected; "visible"; "hidden"); *)
			
			SVG SET ATTRIBUTE:C1055(*; $Txt_me; "controls"; \
				"vdl:value"; Num:C11($Boo_selected); *)
			
			$Txt_result:=Choose:C955($Boo_selected; "1"; "0")
			
			//______________________________________________________
		: ($Txt_type="color-picker")\
			 | ($Txt_type="text-color")
			
			Case of 
					
					//-----------------------------------------
				: ($Lon_formEvent=On Clicked:K2:4)  //user action
					
					SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:value"; $Lon_color)
					SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:mode"; $Txt_mode)
					
					$Lon_color:=CONTROL_Get_color($Lon_color; $Txt_mode)
					
					//-----------------------------------------
				: ($Lon_formEvent=On Bound Variable Change:K2:52)  //language assignment
					
					Case of 
							
							//………………………………………………
						: ($Lon_type=Is real:K8:4)
							
							$Lon_color:=$Ptr_container->
							
							//........................................
						Else 
							
							ASSERT:C1129(False:C215)
							
							//………………………………………………
					End case 
					
					//-----------------------------------------
			End case 
			
			//keep value
			SVG SET ATTRIBUTE:C1055(*; $Txt_me; "controls"; \
				"vdl:value"; $Lon_color)
			
			//set result
			$Txt_result:=Choose:C955($Lon_color=-1; "none"; String:C10($Lon_color))  //none if disparate
			
			//update UI
			Case of 
					
					//-----------------------------------------
				: ($Lon_color=-1)
					
					$Txt_color:="none"
					
					//-----------------------------------------
				: ($Lon_color=0)
					
					$Txt_color:=Choose:C955($Txt_mode="back"; "white"; "black")
					
					//-----------------------------------------
				Else 
					
					$Txt_color:=Replace string:C233("rgb({red},{green},{blue})"; "{red}"; String:C10(($Lon_color & 0x00FF0000) >> 16))
					$Txt_color:=Replace string:C233($Txt_color; "{green}"; String:C10(($Lon_color & 0xFF00) >> 8))
					$Txt_color:=Replace string:C233($Txt_color; "{blue}"; String:C10(($Lon_color & 0x00FF)))
					
					//-----------------------------------------
			End case 
			
			SVG SET ATTRIBUTE:C1055(*; $Txt_me; "sample"; \
				"fill"; $Txt_color)
			
			//______________________________________________________
		: ($Txt_type="tabs")
			
			SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:number"; $Lon_number)
			
			Case of 
					
					//-----------------------------------------
				: ($Lon_formEvent=On Clicked:K2:4)  //user action
					
					$Lon_id:=Num:C11($Txt_id)
					
					//-----------------------------------------
				: ($Lon_formEvent=On Bound Variable Change:K2:52)  //language assignment
					
					Case of 
							
							//………………………………………………
						: ($Lon_type=Is text:K8:3)
							
							SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:values"; $Txt_buffer)
							JSON PARSE ARRAY:C1219($Txt_buffer; $tTxt_values)
							
							$Lon_id:=Find in array:C230($tTxt_values; $Ptr_container->)
							
							//………………………………………………
						: ($Lon_type=Is real:K8:4)
							
							$Lon_id:=$Ptr_container->
							
							//………………………………………………
					End case 
					
					//-----------------------------------------
			End case 
			
			If ($Lon_id#0)  //-1 to unselect all
				
				$Txt_fontColor:=Choose:C955(OB Is defined:C1231($Obj_definition; "font-color"); OB Get:C1224($Obj_definition; "font-color"; Is text:K8:3); $kTxt_highlithColor)
				
				//Update the control
				For ($Lon_i; 1; $Lon_number; 1)
					
					If ($Lon_i=$Lon_id)
						
						SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
							"fill-opacity"; $kNum_highlithOpacity)
						
						SVG SET ATTRIBUTE:C1055(*; $Txt_me; "l"+String:C10($Lon_i); \
							"fill"; "white"; \
							"4D-bringToFront"; True:C214)
						
						//Retrieve the selected value to return
						SVG GET ATTRIBUTE:C1056(*; $Txt_me; String:C10($Lon_i); "vdl:value"; $Txt_result)
						$Txt_result:=Choose:C955($Txt_result=""; String:C10($Lon_i); $Txt_result)
						
					Else 
						
						SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
							"fill-opacity"; 0.01; *)
						
						SVG SET ATTRIBUTE:C1055(*; $Txt_me; "l"+String:C10($Lon_i); \
							"fill"; $Txt_fontColor; *)
						
					End if 
				End for 
			End if 
			
			//______________________________________________________
		: ($Txt_type="segmented")
			
			ARRAY TEXT:C222($tTxt_values; 0x0000)
			ARRAY LONGINT:C221($tLon_values; 0x0000)
			
			SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:number"; $Lon_number)
			SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:mode"; $Txt_mode)
			
			Case of 
					
					//-----------------------------------------
				: ($Lon_formEvent=On Mouse Leave:K2:34)
					
					$Lon_id:=-1
					
					OBJECT SET HELP TIP:C1181(*; $Txt_me; "")
					
					//-----------------------------------------
				: ($Lon_formEvent=On Clicked:K2:4)  //user action
					
					$tLon_values{0}:=Num:C11($Txt_id)
					
					//-----------------------------------------
				: ($Lon_formEvent=On Mouse Move:K2:35)
					
					SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:tips"; $Txt_buffer)
					
					If (Length:C16($Txt_buffer)>0)
						
						JSON PARSE ARRAY:C1219($Txt_buffer; $tTxt_values)
						OBJECT SET HELP TIP:C1181(*; $Txt_me; $tTxt_values{Num:C11($Txt_id)})
						
					End if 
					
					//-----------------------------------------
				: ($Lon_formEvent=On Bound Variable Change:K2:52)  //language assignment
					
					SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:values"; $Txt_buffer)
					SVG GET ATTRIBUTE:C1056(*; $Txt_me; "controls"; "vdl:offset"; $Lon_offset)
					JSON PARSE ARRAY:C1219($Txt_buffer; $tTxt_values)
					
					Case of 
							
							//………………………………………………
						: ($Lon_type=Is text:K8:3)
							
							If ($Txt_mode="additive")
								
								ASSERT:C1129(False:C215; "TBD")
								
							Else 
								
								$Lon_id:=Find in array:C230($tTxt_values; $Ptr_container->)
								
							End if 
							
							//………………………………………………
						: ($Lon_type=Is real:K8:4)
							
							$tLon_values{0}:=$Ptr_container->
							
							If ($Txt_mode="additive")
								
								For ($Lon_i; 1; $Lon_number; 1)
									
									If ($tLon_values{0} ?? ($Lon_i-1))
										
										APPEND TO ARRAY:C911($tLon_values; $Lon_i)
										
									End if 
								End for 
								
							Else 
								
								$tLon_values{0}:=$Ptr_container->+$Lon_offset
								
							End if 
							
							//………………………………………………
					End case 
					
					//-----------------------------------------
			End case 
			
			//Update UI & compute result
			If ($tLon_values{0}<=0)  //unselect all
				
				For ($Lon_i; 1; $Lon_number; 1)
					
					SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
						"fill-opacity"; 0.01)
					
					SVG SET ATTRIBUTE:C1055(*; $Txt_me; "p_"+String:C10($Lon_i); \
						"4D-bringToFront"; False:C215)
					
				End for 
				
			Else 
				
				If ($Txt_mode="additive")
					
					ARRAY TEXT:C222($tTxt_values; 0x0000)
					
					For ($Lon_i; 1; $Lon_number; 1)
						
						SVG GET ATTRIBUTE:C1056(*; $Txt_me; String:C10($Lon_i); "fill-opacity"; $Num_buffer)
						
						If (Size of array:C274($tLon_values)=0)
							
							If ($Lon_i=$tLon_values{0})
								
								$Num_buffer:=Choose:C955($Num_buffer=$kNum_highlithOpacity; 0.01; $kNum_highlithOpacity)  //invert
								
								SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
									"fill-opacity"; $Num_buffer)
								
								SVG SET ATTRIBUTE:C1055(*; $Txt_me; "p_"+String:C10($Lon_i); \
									"4D-bringToFront"; $Num_buffer=$kNum_highlithOpacity)
								
							End if 
							
						Else 
							
							$Num_buffer:=Choose:C955(Find in array:C230($tLon_values; $Lon_i)>0; $kNum_highlithOpacity; 0.01)
							
							SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
								"fill-opacity"; $Num_buffer)
							
							SVG SET ATTRIBUTE:C1055(*; $Txt_me; "p_"+String:C10($Lon_i); \
								"4D-bringToFront"; $Num_buffer=$kNum_highlithOpacity)
							
						End if 
						
						//Retrieve the selected values to return
						If ($Num_buffer=$kNum_highlithOpacity)
							
							SVG GET ATTRIBUTE:C1056(*; $Txt_me; String:C10($Lon_i); "vdl:value"; $Txt_buffer)
							APPEND TO ARRAY:C911($tTxt_values; $Txt_buffer)
							
						End if 
					End for 
					
					//return the array of selected values
					$Txt_result:=JSON Stringify array:C1228($tTxt_values)
					
				Else 
					
					For ($Lon_i; 1; $Lon_number; 1)
						
						If ($Lon_i=$tLon_values{0})
							
							SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
								"fill-opacity"; $kNum_highlithOpacity)
							
							SVG SET ATTRIBUTE:C1055(*; $Txt_me; "p_"+String:C10($Lon_i); \
								"4D-bringToFront"; True:C214)
							
							//Retrieve the selected value to return
							SVG GET ATTRIBUTE:C1056(*; $Txt_me; String:C10($Lon_i); "vdl:value"; $Txt_result)
							
							//return the selected value
							$Txt_result:=Choose:C955(Length:C16($Txt_result)=0; String:C10($Lon_i); $Txt_result)
							
						Else 
							
							SVG SET ATTRIBUTE:C1055(*; $Txt_me; String:C10($Lon_i); \
								"fill-opacity"; "0.01")
							
						End if 
					End for 
				End if 
			End if 
			
			//______________________________________________________
	End case 
	
	$0:=$Txt_result
	
End if 

// ----------------------------------------------------
// End