//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : CONTROL_DRAW_SEGMENTS
  // ID[88B76070D3AB46BE9E9724C01D0D62AE]
  // Created #11-2-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  // Draws the segments of a segmented control
  // like groups of buttons or tabs
  // ----------------------------------------------------
  // Modified by Vincent de Lachaux (22/10/14)
  // Remove the use of component 4D SVG
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
C_POINTER:C301($7)

C_LONGINT:C283($Lon_i;$Lon_id;$Lon_number;$Lon_parameters;$Lon_round;$Lon_y)
C_POINTER:C301($Ptr_values)
C_REAL:C285($Num_height;$Num_width)
C_TEXT:C284($Svg_control;$Svg_group;$Svg_unit;$Txt_data)

If (False:C215)
	C_TEXT:C284(CONTROL_DRAW_SEGMENTS ;$1)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$2)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$3)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$4)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$5)
	C_LONGINT:C283(CONTROL_DRAW_SEGMENTS ;$6)
	C_POINTER:C301(CONTROL_DRAW_SEGMENTS ;$7)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=7;"Missing parameter"))
	
	  //Required parameters
	$Svg_control:=$1
	$Lon_number:=$2
	$Lon_round:=$3
	$Num_width:=$4
	$Num_height:=$5
	$Lon_id:=$6
	$Ptr_values:=$7
	
	  //Optional parameters
	If ($Lon_parameters>=8)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //Draw buttons into a group for translation
  //move 0.5 px to disable anti-aliasing
$Svg_group:=DOM Create XML element:C865($Svg_control;"g";\
"transform";"translate(0.5,0.5)")

For ($Lon_i;1;$Lon_number;1)
	
	Case of 
			
			  //-----------------------------
		: ($Lon_i=1)  //left
			
			$Txt_data:="M0,"+String:C10($Lon_round)
			$Txt_data:=$Txt_data+" A"+String:C10($Lon_round)+","+String:C10($Lon_round)+" "\
				+"0 0,1 "\
				+String:C10($Lon_round)+",0"
			$Txt_data:=$Txt_data+" H"+String:C10($Num_width)
			$Txt_data:=$Txt_data+" L"+String:C10($Num_width)+","+String:C10($Num_height)
			$Txt_data:=$Txt_data+" L"+String:C10($Lon_round)+","+String:C10($Num_height)
			$Txt_data:=$Txt_data+" A"+String:C10($Lon_round)+","+String:C10($Lon_round)+" "\
				+"0 0,1 "\
				+"0,"+String:C10($Num_height-$Lon_round)
			
			$Txt_data:=$Txt_data+"z"
			
			$Svg_unit:=DOM Create XML element:C865($Svg_group;"path";\
				"d";$Txt_data)
			
			  //-----------------------------
		: ($Lon_i=$Lon_number)  //right
			
			$Svg_unit:=DOM Create XML element:C865($Svg_group;"path")
			
			$Txt_data:="M"+String:C10($Num_width*($Lon_i-1))+",0"
			$Txt_data:=$Txt_data+" h"+String:C10($Num_width-$Lon_round)
			$Txt_data:=$Txt_data+" a"+String:C10($Lon_round)+","+String:C10($Lon_round)+" "\
				+"0 0,1 "\
				+String:C10($Lon_round)+","+String:C10($Lon_round)
			
			$Lon_y:=$Num_height-$Lon_round
			
			$Txt_data:=$Txt_data+" l"+String:C10(0)+","+String:C10($Num_height-($Lon_round*2))
			
			$Txt_data:=$Txt_data+" A"+String:C10($Lon_round)+","+String:C10($Lon_round)+" "\
				+"0 0,1 "\
				+String:C10(($Num_width*$Lon_i)-$Lon_round)+","+String:C10($Num_height)
			
			$Txt_data:=$Txt_data+" H"+String:C10($Num_width*($Lon_i-1))
			$Txt_data:=$Txt_data+"z"
			
			DOM SET XML ATTRIBUTE:C866($Svg_unit;\
				"d";$Txt_data)
			
			  //-----------------------------
		Else 
			
			$Svg_unit:=DOM Create XML element:C865($Svg_group;"rect";\
				"x";$Num_width*($Lon_i-1);\
				"y";0;\
				"width";$Num_width;\
				"height";$Num_height)
			
			  //-----------------------------
	End case 
	
	DOM SET XML ATTRIBUTE:C866($Svg_unit;\
		"id";String:C10($Lon_i);\
		"vdl:value";$Ptr_values->{$Lon_i})
	
	If ($Lon_i=$Lon_id)
		
		DOM SET XML ATTRIBUTE:C866($Svg_unit;\
			"class";"selected")
		
	End if 
End for 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End