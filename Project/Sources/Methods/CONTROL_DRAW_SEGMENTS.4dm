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
#DECLARE($control : Text; $number : Integer; $round : Integer; $width : Integer; $height : Integer; $id : Integer; $Ptr_values : Pointer)


var $i; $count_parameters; $y : Integer

var $Svg_group; $Svg_unit; $Txt_data : Text



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=7; "Missing parameter"))
	
	//Required parameters
	
	
	//Optional parameters
	If ($count_parameters>=8)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
//Draw buttons into a group for translation
//move 0.5 px to disable anti-aliasing
$Svg_group:=DOM Create XML element:C865($control; "g"; \
"transform"; "translate(0.5,0.5)")

For ($i; 1; $number; 1)
	
	Case of 
			
			//-----------------------------
		: ($i=1)  //left
			
			$Txt_data:="M0,"+String:C10($round)
			$Txt_data:=$Txt_data+" A"+String:C10($round)+","+String:C10($round)+" "\
				+"0 0,1 "\
				+String:C10($round)+",0"
			$Txt_data:=$Txt_data+" H"+String:C10($width)
			$Txt_data:=$Txt_data+" L"+String:C10($width)+","+String:C10($height)
			$Txt_data:=$Txt_data+" L"+String:C10($round)+","+String:C10($height)
			$Txt_data:=$Txt_data+" A"+String:C10($round)+","+String:C10($round)+" "\
				+"0 0,1 "\
				+"0,"+String:C10($height-$round)
			
			$Txt_data:=$Txt_data+"z"
			
			$Svg_unit:=DOM Create XML element:C865($Svg_group; "path"; \
				"d"; $Txt_data)
			
			//-----------------------------
		: ($i=$number)  //right
			
			$Svg_unit:=DOM Create XML element:C865($Svg_group; "path")
			
			$Txt_data:="M"+String:C10($width*($i-1))+",0"
			$Txt_data:=$Txt_data+" h"+String:C10($width-$round)
			$Txt_data:=$Txt_data+" a"+String:C10($round)+","+String:C10($round)+" "\
				+"0 0,1 "\
				+String:C10($round)+","+String:C10($round)
			
			$y:=$height-$round
			
			$Txt_data:=$Txt_data+" l"+String:C10(0)+","+String:C10($height-($round*2))
			
			$Txt_data:=$Txt_data+" A"+String:C10($round)+","+String:C10($round)+" "\
				+"0 0,1 "\
				+String:C10(($width*$i)-$round)+","+String:C10($height)
			
			$Txt_data:=$Txt_data+" H"+String:C10($width*($i-1))
			$Txt_data:=$Txt_data+"z"
			
			DOM SET XML ATTRIBUTE:C866($Svg_unit; \
				"d"; $Txt_data)
			
			//-----------------------------
		Else 
			
			$Svg_unit:=DOM Create XML element:C865($Svg_group; "rect"; \
				"x"; $width*($i-1); \
				"y"; 0; \
				"width"; $width; \
				"height"; $height)
			
			//-----------------------------
	End case 
	
	DOM SET XML ATTRIBUTE:C866($Svg_unit; \
		"id"; String:C10($i); \
		"vdl:value"; $Ptr_values->{$i})
	
	If ($i=$id)
		
		DOM SET XML ATTRIBUTE:C866($Svg_unit; \
			"class"; "selected")
		
	End if 
End for 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End