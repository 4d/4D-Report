  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.heightUnit - (4D Report)
  // ID[885C347CC9B2492BAAC983A42BEF5BE2]
  // Created #20-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_fontSize;$kLon_height;$kLon_maxWidth;$kLon_offset;$kLon_verticalResolution;$Lon_bottom)
C_LONGINT:C283($Lon_buffer;$Lon_formEvent;$Lon_height;$Lon_i;$Lon_left;$Lon_point)
C_LONGINT:C283($Lon_right;$Lon_top;$Lon_unit;$Lon_width)
C_POINTER:C301($Ptr_unit)
C_TEXT:C284($Dom_g;$kTxt_font;$kTxt_highlightColor;$kTxt_textColor;$Svg_object;$Svg_root)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  //#ACI0095293
  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		$kTxt_font:="'Lucida Grande','Segoe UI'"
		$kLon_fontSize:=12
		$kLon_height:=18
		$kLon_offset:=10
		$kLon_maxWidth:=90
		$kTxt_textColor:="darkgray"
		$kTxt_highlightColor:="dodgerblue"
		
		ARRAY TEXT:C222($tTxt_labels;0x0000)
		APPEND TO ARRAY:C911($tTxt_labels;Get localized string:C991("points"))
		APPEND TO ARRAY:C911($tTxt_labels;Get localized string:C991("inches"))
		APPEND TO ARRAY:C911($tTxt_labels;Get localized string:C991("centimeters"))
		
		  //calculate the object width
		For ($Lon_i;1;Size of array:C274($tTxt_labels);1)
			
			$Lon_buffer:=svg_Get_string_width ($tTxt_labels{$Lon_i};$kTxt_font;$kLon_fontSize)+$kLon_offset
			$Lon_width:=Choose:C955($Lon_buffer>$Lon_width;$Lon_buffer;$Lon_width)
			
		End for 
		
		$Lon_width:=Choose:C955($Lon_width>$kLon_maxWidth;$kLon_maxWidth;$Lon_width)
		
		  //set the object width
		OBJECT GET COORDINATES:C663(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT MOVE:C664(*;$Txt_me;0;0;$Lon_width-($Lon_right-$Lon_left))
		
		  //draw the control
		  //$Svg_root:=SVG_New ($Lon_width;$kLon_height)
		$Svg_root:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")
		
		DOM SET XML ATTRIBUTE:C866($Svg_root;\
			"width";String:C10($Lon_width;"&xml");\
			"height";String:C10($kLon_height;"&xml"))
		
		  //$Svg_object:=SVG_New_rect ($Svg_root;1;1;$Lon_width-2;$kLon_height-2;0;0;$kTxt_highlightColor;"none";1)
		  //SVG_SET_ID ($Svg_object;"select")
		  //SVG_SET_VISIBILITY ($Svg_object;False)
		$Svg_object:=DOM Create XML element:C865($Svg_root;"rect";\
			"x";1;\
			"y";1;\
			"width";String:C10($Lon_width-2;"&xml");\
			"height";String:C10($kLon_height-2;"&xml");\
			"stroke";$kTxt_highlightColor;\
			"fill";"none";\
			"stroke-width";1;\
			"id";"select";\
			"visibility";"hidden")
		
		$Dom_g:=DOM Create XML element:C865($Svg_root;"g";\
			"font-family";$kTxt_font;\
			"font-size";$kLon_fontSize;\
			"text-anchor";"start";\
			"fill";$kTxt_highlightColor)
		
		For ($Lon_i;1;Size of array:C274($tTxt_labels);1)
			
			  //$Svg_object:=SVG_New_text ($Svg_root;$tTxt_labels{$Lon_i};5;1;$kTxt_font;$kLon_fontSize;0;2;$kTxt_highlightColor)
			  //SVG_SET_ID ($Svg_object;String($Lon_i))
			  //SVG_SET_VISIBILITY ($Svg_object;$Lon_i=1)
			$Svg_object:=DOM Create XML element:C865($Dom_g;"text";\
				"x";5;\
				"y";1+$kLon_fontSize;\
				"id";$Lon_i;\
				"visibility";Choose:C955($Lon_i=1;"visible";"hidden"))
			
			$Svg_object:=DOM Create XML element:C865($Svg_object;"tspan")
			
			DOM SET XML ELEMENT VALUE:C868($Svg_object;$tTxt_labels{$Lon_i})
			
		End for 
		
		  //(OBJECT Get pointer(Object named;$Txt_me))->:=SVG_Export_to_picture ($Svg_root)
		SVG EXPORT TO PICTURE:C1017($Svg_root;(OBJECT Get pointer:C1124(Object named:K67:5;$Txt_me))->)
		
		  //SVG_CLEAR ($Svg_root)
		DOM CLOSE XML:C722($Svg_root)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Enter:K2:33)
		
		  //show the highlight rect
		SVG SET ATTRIBUTE:C1055(*;$Txt_me;"select";\
			"visibility";"visible")
		
		  //______________________________________________________
	: ($Lon_formEvent=On Mouse Leave:K2:34)
		
		  //hide the highlight rect
		SVG SET ATTRIBUTE:C1055(*;$Txt_me;"select";\
			"visibility";"hidden")
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Ptr_unit:=OBJECT Get pointer:C1124(Object named:K67:5;"height.unit")
		$Lon_unit:=$Ptr_unit->
		
		  //hide current
		SVG SET ATTRIBUTE:C1055(*;$Txt_me;String:C10($Lon_unit);\
			"visibility";"hidden")
		
		  //change unit
		$Lon_unit:=Choose:C955($Lon_unit=3;1;$Lon_unit+1)
		$Ptr_unit->:=$Lon_unit
		
		  //show current
		SVG SET ATTRIBUTE:C1055(*;$Txt_me;String:C10($Lon_unit);\
			"visibility";"visible")
		
		  //calculations
		$kLon_verticalResolution:=72
		
		$Lon_height:=(OBJECT Get pointer:C1124(Object named:K67:5;"height"))->
		
		  //convert height in points according to the selected unit
		$Lon_point:=Choose:C955($Lon_unit;\
			$Lon_height;\
			$Lon_height;\
			$Lon_height*$kLon_verticalResolution;\
			$Lon_height*($kLon_verticalResolution/2.54))
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"height.points"))->:=$Lon_point
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 