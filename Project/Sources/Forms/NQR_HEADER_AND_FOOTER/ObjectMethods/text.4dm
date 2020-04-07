  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.heightUnit - (4D Report)
  // ID[885C347CC9B2492BAAC983A42BEF5BE2]
  // Created #20-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($kLon_offset;$kLon_pictureWidth;$Lon_bottom;$Lon_fontSize;$Lon_formEvent;$Lon_height)
C_LONGINT:C283($Lon_left;$Lon_platform;$Lon_right;$Lon_selector;$Lon_target;$Lon_top)
C_LONGINT:C283($Lon_width)
C_TEXT:C284($kTxt_highlightColor;$Mnu_pop;$Svg_group;$Svg_object;$Svg_root;$Txt_action)
C_TEXT:C284($Txt_buffer;$Txt_font;$Txt_me;$Txt_URL)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  //#ACI0095293
  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		$kLon_offset:=2
		$kTxt_highlightColor:="dodgerblue"
		$kLon_pictureWidth:=20
		
		  //set the object width
		OBJECT GET COORDINATES:C663(*;"pangram";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;$Txt_me;$Lon_left-($kLon_offset*2);$Lon_top-$kLon_offset;$Lon_right+$kLon_offset;$Lon_bottom+($kLon_offset*2))
		
		$Lon_width:=($Lon_right-$Lon_left)+($kLon_offset*2)
		$Lon_height:=($Lon_bottom-$Lon_top)+($kLon_offset*2)
		
		  //create the control
		  //$Svg_root:=SVG_New ($Lon_width;$Lon_height)
		$Svg_root:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")
		
		DOM SET XML ATTRIBUTE:C866($Svg_root;\
			"width";String:C10($Lon_width;"&xml");\
			"height";String:C10($Lon_height;"&xml");\
			"xmlns:xlink";"http://www.w3.org/1999/xlink")
		
		  //$Svg_group:=SVG_New_group ($Svg_root;"select")
		  //SVG_SET_VISIBILITY ($Svg_group;False)
		$Svg_group:=DOM Create XML element:C865($Svg_root;"g";\
			"id";"select";\
			"visibility";"hidden")
		
		  //$Svg_object:=SVG_New_image ($Svg_group;"#Images/downArrow.png";$Lon_width-20-$kLon_offset;0)
		_O_PLATFORM PROPERTIES:C365($Lon_platform)
		$Txt_URL:="file://"\
			+Choose:C955($Lon_platform=Windows:K25:3;"/";"")\
			+Convert path system to POSIX:C1106(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"downArrow.png";*)
		
		$Svg_object:=DOM Create XML element:C865($Svg_group;"image";\
			"xlink:href";$Txt_URL;\
			"x";$Lon_width-$kLon_pictureWidth-$kLon_offset;\
			"y";0;\
			"width";$kLon_pictureWidth;\
			"height";$kLon_pictureWidth)
		
		  //$Svg_object:=SVG_New_rect ($Svg_group;1;1;$Lon_width-$kLon_offset;$Lon_height-$kLon_offset;0;0;$kTxt_highlightColor;"none";1)
		$Svg_object:=DOM Create XML element:C865($Svg_group;"rect";\
			"x";1;\
			"y";1;\
			"width";String:C10($Lon_width-$kLon_offset;"&xml");\
			"height";String:C10($Lon_height-$kLon_offset;"&xml");\
			"stroke";$kTxt_highlightColor;\
			"fill";"none";\
			"stroke-width";1)
		
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
		
		  //display font menu
		$Mnu_pop:=mnu_Font 
		$Txt_action:=Dynamic pop up menu:C1006($Mnu_pop)
		RELEASE MENU:C978($Mnu_pop)
		
		Case of 
				
				  //………………………………………………………………
			: (Length:C16($Txt_action)=0)
				
				  //NOTHING MORE TO DO
				
				  //………………………………………………………………
			: ($Txt_action="font_picker")
				
				  //open the font picker
				GOTO OBJECT:C206(*;"pangram")
				OPEN FONT PICKER:C1303(1)
				
				  //………………………………………………………………
			: ($Txt_action="font_@")
				
				$Txt_font:=Replace string:C233($Txt_action;"font_";"")
				
				  //set the area
				$Lon_selector:=(OBJECT Get pointer:C1124(Object named:K67:5;"selector"))->
				$Lon_target:=Choose:C955($Lon_selector=1;qr header:K14906:4;qr footer:K14906:5)
				QR SET TEXT PROPERTY:C759(QR_area;1;$Lon_target;qr font name:K14904:10;$Txt_font)
				
				  //update UI
				OBJECT SET FONT:C164(*;"text.style";$Txt_font)
				
				$Lon_fontSize:=OBJECT Get font size:C1070(*;"text.style")
				$Txt_buffer:=Replace string:C233($Txt_font;".Lucida Grande UI";"Lucida Grande")+" "+String:C10($Lon_fontSize)+Get localized string:C991("pts")
				(OBJECT Get pointer:C1124(Object named:K67:5;"pangram"))->:=$Txt_buffer
				
				  //………………………………………………………………
			Else 
				
				TRACE:C157  //error
				
				  //………………………………………………………………
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 