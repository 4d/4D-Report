//%attributes = {"invisible":true}
  //  // ----------------------------------------------------
  //  // Project method : template_DRAW
  //  // Database: 4D Report
  //  // ID[DFE731EF1E2F48A48783A6FBF45ED341]
  //  // Created #7-10-2016 by Vincent de Lachaux
  //  // ----------------------------------------------------
  //  // Description:
  //  //
  //  // ----------------------------------------------------
  //  // Declarations
  //C_OBJECT($1)

  //C_LONGINT($kLon_hOffset;$kLon_vOffset;$Lon_bottom;$Lon_buffer;$Lon_column;$Lon_count)
  //C_LONGINT($Lon_fontSize;$Lon_height;$Lon_i;$Lon_left;$Lon_line;$Lon_lineHeight)
  //C_LONGINT($Lon_parameters;$Lon_right;$Lon_top;$Lon_width;$Lon_x;$Lon_y)
  //C_REAL($Num_thickness)
  //C_TEXT($Dom_background;$Svg_root;$Txt_buffer;$Txt_color;$Txt_currencySymbol;$Txt_format)
  //C_TEXT($Txt_thousandSeparator)
  //C_OBJECT($Obj_borders;$Obj_buffer;$Obj_default;$Obj_line;$Obj_params;$Obj_template)

  //ARRAY OBJECT($tObj_buffer;0)

  //If (False)
  //C_OBJECT(template_DRAW ;$1)
  //End if 

  //  // ----------------------------------------------------
  //  // Initialisations
  //$Lon_parameters:=Count parameters

  //If (Asserted($Lon_parameters>=0;"Missing parameter"))

  //  //NO PARAMETERS REQUIRED

  //  //Optional parameters
  //If ($Lon_parameters>=1)

  //$Obj_params:=$1

  //End if 

  //$kLon_vOffset:=12
  //$kLon_hOffset:=3

  //Else 

  //ABORT

  //End if 

  //  // ----------------------------------------------------
  //Case of 

  //  //______________________________________________________
  //: (OB Is defined($Obj_params))

  //$Svg_root:=OB Get($Obj_params;"root";Is text)

  //$Obj_buffer:=OB Get($Obj_params;"template";Is object)

  //$Lon_x:=OB Get($Obj_params;"x";Is longint)
  //$Lon_y:=OB Get($Obj_params;"y";Is longint)

  //$Lon_height:=OB Get($Obj_params;"height";Is longint)

  //$Lon_column:=OB Get($Obj_params;"column";Is longint)

  //ARRAY LONGINT($tLon_width;0x0000)
  //OB GET ARRAY($Obj_params;"widths";$tLon_width)
  //$tLon_width{0}:=$tLon_width{$Lon_column}

  //ARRAY TEXT($tTxt_data;0x0000)
  //OB GET ARRAY($Obj_params;"datas";$tTxt_data)
  //$tTxt_data{0}:=$tTxt_data{$Lon_column}

  //$Lon_line:=OB Get($Obj_params;"line";Is longint)

  //SVG_Define_style (SVG_New_rect ($Svg_root;$Lon_x;$Lon_y;$tLon_width{0};$Lon_height;0;0;"";"";1);
  //template_Get_style ($Obj_buffer;"rect";$Lon_column;$Lon_line))
  //SVG_Define_style (SVG_New_textArea ($Svg_root;$tTxt_data{0};$Lon_x+$kLon_hOffset;$Lon_y;$tLon_width{0}-(2*$kLon_hOffset);$Lon_height;"";-1;-1;-1);template_Get_style ($Obj_buffer;"text";$Lon_column))\


  //$Obj_borders:=OB Get($Obj_buffer;"borders";Is object)

  //If (OB Is defined($Obj_borders;"all"))

  //$Obj_line:=OB Get($Obj_borders;"all";Is object)
  //$Num_thickness:=OB Get($Obj_line;"thickness";Is real)
  //$Txt_color:=OB Get($Obj_line;"color";Is text)

  //If ($Num_thickness#0) & ($Txt_color#"none")\


  //SVG_New_rect ($Svg_root;$Lon_x;$Lon_y;$tLon_width{0};$Lon_height;0;0;$Txt_color;"none";$Num_thickness)

  //End if 

  //Else 

  //If (OB Is defined($Obj_borders;"left"))

  //$Obj_line:=OB Get($Obj_borders;"left";Is object)
  //$Num_thickness:=OB Get($Obj_line;"thickness";Is real)
  //$Txt_color:=OB Get($Obj_line;"color";Is text)

  //If ($Num_thickness#0) & ($Txt_color#"none")\


  //SVG_New_line ($Svg_root;$Lon_x;$Lon_y;$Lon_x;$Lon_y+$Lon_height;$Txt_color;$Num_thickness)

  //End if 
  //End if 

  //If (OB Is defined($Obj_borders;"top"))

  //$Obj_line:=OB Get($Obj_borders;"top";Is object)
  //$Num_thickness:=OB Get($Obj_line;"thickness";Is real)
  //$Txt_color:=OB Get($Obj_line;"color";Is text)

  //If ($Num_thickness#0) & ($Txt_color#"none")\


  //SVG_New_line ($Svg_root;$Lon_x;$Lon_y;$Lon_x+$tLon_width{0};$Lon_y;$Txt_color;$Num_thickness)

  //End if 
  //End if 

  //If (OB Is defined($Obj_borders;"right"))

  //$Obj_line:=OB Get($Obj_borders;"right";Is object)
  //$Num_thickness:=OB Get($Obj_line;"thickness";Is real)
  //$Txt_color:=OB Get($Obj_line;"color";Is text)

  //If ($Num_thickness#0) & ($Txt_color#"none")\


  //SVG_New_line ($Svg_root;$Lon_x+$tLon_width{0};$Lon_y;$Lon_x+$tLon_width{0};$Lon_y+$Lon_height;$Txt_color;$Num_thickness)

  //End if 
  //End if 

  //If (OB Is defined($Obj_borders;"bottom"))

  //$Obj_line:=OB Get($Obj_borders;"bottom";Is object)
  //$Num_thickness:=OB Get($Obj_line;"thickness";Is real)
  //$Txt_color:=OB Get($Obj_line;"color";Is text)

  //If ($Num_thickness#0) & ($Txt_color#"none")\


  //SVG_New_line ($Svg_root;$Lon_x;$Lon_y+$Lon_height;$Lon_x+$tLon_width{0};$Lon_y+$Lon_height;$Txt_color;$Num_thickness)

  //End if 
  //End if 
  //End if 

  //OB SET($Obj_params;"x";$Lon_x+$tLon_width{0})\


  //  //______________________________________________________
  //Else 

  //GET SYSTEM FORMAT(Currency symbol;$Txt_currencySymbol)
  //GET SYSTEM FORMAT(Thousand separator;$Txt_thousandSeparator)
  //$Txt_format:="000"+$Txt_thousandSeparator+"000 "+$Txt_currencySymbol

  //GET LIST ITEM PARAMETER(*;"list";*;"template";$Txt_buffer)

  //If (Length($Txt_buffer)#0)

  //$Obj_template:=JSON Parse($Txt_buffer)

  //If (Structure file=Structure file(*))

  //SVG_SET_OPTIONS (SVG_Get_options  ?+ 5)

  //End if 

  //$Svg_root:=SVG_New 
  //SVG_SET_SHAPE_RENDERING ($Svg_root;"crispEdges")

  //$Dom_background:=SVG_New_group ($Svg_root)

  //OB SET($Obj_params;"root";$Svg_root)\


  //ARRAY LONGINT($tLon_width;4)

  //OBJECT GET COORDINATES(*;"preview";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
  //$tLon_width{0}:=$Lon_right-$Lon_left
  //$tLon_width{1}:=Int($tLon_width{0}*0.18)
  //$tLon_width{2}:=Int($tLon_width{0}*0.2)
  //$tLon_width{3}:=Int($tLon_width{0}*0.35)
  //$tLon_width{4}:=Int($tLon_width{0}*0.15)

  //OB SET ARRAY($Obj_params;"widths";$tLon_width)

  //If (True)  //default values

  //If (OB Is defined($Obj_template;"default"))

  //$Obj_default:=OB Get($Obj_template;"default";Is object)

  //End if 
  //End if 

  //If (True)  //tittles

  //OB SET($Obj_params;"x";10;"y";10;"line";1)\




  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=Get localized string("title_1")
  //$tTxt_data{2}:=Get localized string("title_2")
  //$tTxt_data{3}:=Get localized string("title_3")
  //$tTxt_data{4}:=Get localized string("title_4")

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //If (OB Is defined($Obj_template;"titles"))

  //OB GET ARRAY($Obj_template;"titles";$tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_height:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_height)\


  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //column 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //column 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //column 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End if 

  //If (True)  //details 1

  //If (OB Is defined($Obj_template;"details"))

  //OB GET ARRAY($Obj_template;"details";$tObj_buffer)

  //Else 

  //CLEAR VARIABLE($tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_lineHeight:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_lineHeight)\


  //For ($Lon_line;1;3;1)

  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=Choose($Lon_line;"";Get localized string("person_1");Get localized string("person_2");Get localized string("person_3"))\



  //$tTxt_data{2}:=Get localized string("service")
  //$tTxt_data{3}:=Get localized string("sector_1")
  //$tTxt_data{4}:=String(Choose($Lon_line;0;130893;241197;300600);$Txt_format)

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_y:=Choose($Lon_line=1;10+$Lon_height;$Lon_y+$Lon_lineHeight)

  //OB SET($Obj_params;"x";10;"y";$Lon_y;"line";$Lon_line)\




  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //colum 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //colum 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //colum 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End for 
  //End if 

  //If (True)  //breaking level 1

  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=""
  //$tTxt_data{2}:=""
  //$tTxt_data{3}:=Replace string(Get localized string("sector");"{sector}";Get localized string("sector_1"))
  //$tTxt_data{4}:=String(672690;$Txt_format)

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_y:=$Lon_y+$Lon_lineHeight

  //OB SET($Obj_params;"x";10;"y";$Lon_y;"line";1)\




  //If (OB Is defined($Obj_template;"subtotal_1"))

  //OB GET ARRAY($Obj_template;"subtotal_1";$tObj_buffer)

  //Else 

  //CLEAR VARIABLE($tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_height:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_height)\


  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //colum 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //colum 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //colum 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End if 

  //If (True)  //details 2

  //If (OB Is defined($Obj_template;"details"))

  //OB GET ARRAY($Obj_template;"details";$tObj_buffer)

  //Else 

  //CLEAR VARIABLE($tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_lineHeight:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_lineHeight)\


  //For ($Lon_line;1;2;1)

  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=Choose($Lon_line;"";Get localized string("person_4");Get localized string("person_5"))\


  //$tTxt_data{2}:=Get localized string("service")
  //$tTxt_data{3}:=Get localized string("sector_2")
  //$tTxt_data{4}:=String(Choose($Lon_line;0;80858;241162);$Txt_format)

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_y:=OB Get($Obj_params;"y";Is longint)+Choose($Lon_line=1;$Lon_height;$Lon_lineHeight)

  //OB SET($Obj_params;"x";10;"y";$Lon_y;"line";$Lon_line)\




  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //colum 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //colum 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //colum 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End for 
  //End if 

  //If (True)  //breaking level 1

  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=""
  //$tTxt_data{2}:=""
  //$tTxt_data{3}:=Replace string(Get localized string("sector");"{sector}";Get localized string("sector_2"))
  //$tTxt_data{4}:=String(322020;$Txt_format)

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_y:=$Lon_y+$Lon_lineHeight

  //OB SET($Obj_params;"x";10;"y";$Lon_y;"line";1)\




  //If (OB Is defined($Obj_template;"subtotal_1"))

  //OB GET ARRAY($Obj_template;"subtotal_1";$tObj_buffer)

  //Else 

  //CLEAR VARIABLE($tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_height:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_height)\


  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //colum 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //colum 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //colum 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End if 

  //If (True)  //breaking level 2

  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=""
  //$tTxt_data{2}:=""
  //$tTxt_data{3}:=Replace string(Get localized string("departement");"{service}";Get localized string("service"))
  //$tTxt_data{4}:=String(994710;$Txt_format)

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_y:=$Lon_y+$Lon_height

  //OB SET($Obj_params;"x";10;"y";$Lon_y;"line";1)\




  //If (OB Is defined($Obj_template;"subtotal_2"))

  //OB GET ARRAY($Obj_template;"subtotal_2";$tObj_buffer)

  //Else 

  //CLEAR VARIABLE($tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_height:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_height)\


  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //colum 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //colum 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //colum 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End if 

  //If (True)  //Grand Total

  //ARRAY TEXT($tTxt_data;4)
  //$tTxt_data{1}:=""
  //$tTxt_data{2}:=""
  //$tTxt_data{3}:=Get localized string("head_grand_total")
  //$tTxt_data{4}:=String(994710;$Txt_format)

  //OB SET ARRAY($Obj_params;"datas";$tTxt_data)

  //$Lon_y:=$Lon_y+$Lon_height

  //OB SET($Obj_params;"x";10;"y";$Lon_y;"line";1)\




  //If (OB Is defined($Obj_template;"grandTotal"))

  //OB GET ARRAY($Obj_template;"grandTotal";$tObj_buffer)

  //Else 

  //CLEAR VARIABLE($tObj_buffer)

  //End if 

  //$Lon_count:=Size of array($tObj_buffer)

  //$Lon_fontSize:=OB Get($Obj_default;"fontSize";Is longint)

  //For ($Lon_i;1;$Lon_count;1)

  //$Lon_buffer:=OB Get($tObj_buffer{$Lon_i};"fontSize";Is longint)

  //If ($Lon_buffer>$Lon_fontSize)

  //$Lon_fontSize:=$Lon_buffer

  //End if 
  //End for 

  //$Lon_height:=$Lon_fontSize+$kLon_vOffset

  //OB SET($Obj_params;"height";$Lon_height)\


  //  //column 1
  //If ($Lon_count>=1)

  //$Obj_buffer:=$tObj_buffer{1}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //Else 

  //$Obj_buffer:=OB Copy($Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer)\


  //OB SET($Obj_params;"column";1)\

  //template_DRAW ($Obj_params)

  //  //colum 2
  //If ($Lon_count>=2)

  //$Obj_buffer:=$tObj_buffer{2}
  //ob_GATHER ($Obj_buffer;$Obj_default)

  //End if 

  //OB SET($Obj_params;"template";$Obj_buffer;"column";2)\


  //template_DRAW ($Obj_params)

  //  //colum 3
  //If ($Lon_count>=3)

  //$Obj_buffer:=$tObj_buffer{3}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";3)\

  //template_DRAW ($Obj_params)

  //  //colum 4
  //If ($Lon_count>=4)

  //$Obj_buffer:=$tObj_buffer{4}
  //ob_GATHER ($Obj_buffer;$Obj_default)
  //OB SET($Obj_params;"template";$Obj_buffer)\


  //End if 

  //OB SET($Obj_params;"column";4)\

  //template_DRAW ($Obj_params)

  //End if 

  //  //padding {
  //$Lon_width:=$tLon_width{1}+$tLon_width{2}+$tLon_width{3}+$tLon_width{4}+20
  //$Lon_height:=$Lon_y+$Lon_height+10
  //SVG_New_rect ($Dom_background;0;1;$Lon_width;$Lon_height;0;0;"lightgrey";"white")
  //  //)

  //If (Shift down & (Structure file=Structure file(*)))

  //SVGTool_SHOW_IN_VIEWER ($Svg_root;"sources")

  //End if 

  //(OBJECT Get pointer(Object named;"preview"))->:=SVG_Export_to_picture ($Svg_root)

  //SVG_CLEAR ($Svg_root)

  //Else 

  //CLEAR VARIABLE((OBJECT Get pointer(Object named;"preview"))->)

  //End if 

  //  //______________________________________________________
  //End case 

  //  // ----------------------------------------------------
  //  // Return
  //  // <NONE>
  //  // ----------------------------------------------------
  //  // End