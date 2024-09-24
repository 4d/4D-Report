//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONTROL_Get_color
// ID[AEBFD273926047DC981A7CF5AC550B62]
// Created #14-2-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($current_color : Integer; $mode : Text) : Integer

var $color; $new_color; $i; $selected; $count_parameters : Integer
var $popup_menu : Text

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	$color:=-1
	$mode:="front"
	
	If ($count_parameters>=1)
		
		$current_color:=$1  //{preselected} : -1 = automatic (default); RGB color
		
		If ($count_parameters>=2)
			
			$mode:=$2  //{target} : front (default); back
			
		End if 
	End if 
	
	ARRAY LONGINT:C221($tLon_colors; 18)
	
	$tLon_colors{1}:=0x00FFFFFF  //Automatic
	
	If ($mode="front")
		
		$tLon_colors{2}:=0xFFAA753F
		$tLon_colors{3}:=0xFFCC7A02
		$tLon_colors{4}:=0xFFEF6B00
		$tLon_colors{5}:=0xFFD81E05
		$tLon_colors{6}:=0xFFBF30B5
		$tLon_colors{7}:=0xFF6607A5
		$tLon_colors{8}:=0xFF0051BA
		$tLon_colors{9}:=0xFF0099B5
		$tLon_colors{10}:=0xFF009E60
		$tLon_colors{11}:=0xFF4BB51E
		$tLon_colors{12}:=0xFFBAD80A
		$tLon_colors{13}:=0xFF877530
		$tLon_colors{14}:=0xFF66594C
		$tLon_colors{15}:=0xFF777772
		$tLon_colors{16}:=0xFF3F6075
		$tLon_colors{17}:=0xFF66746B
		
	Else 
		
		$tLon_colors{2}:=0xFFEDD3B5
		$tLon_colors{3}:=0xFFFCBF49
		$tLon_colors{4}:=0xFFFF993F
		$tLon_colors{5}:=0xFFF9827F
		$tLon_colors{6}:=0xFFE29ED6
		$tLon_colors{7}:=0xFFB591D1
		$tLon_colors{8}:=0xFFA8CEE2
		$tLon_colors{9}:=0xFF72D1DD
		$tLon_colors{10}:=0xFF96D8AF
		$tLon_colors{11}:=0xFFB5DF95
		$tLon_colors{12}:=0xFFE0EA68
		$tLon_colors{13}:=0xFFCFD1A5
		$tLon_colors{14}:=0xFFBAAA9E
		$tLon_colors{15}:=0xFFC4C1BA
		$tLon_colors{16}:=0xFFAFBCBF
		$tLon_colors{17}:=0xFFA0AE9E
		
	End if 
	
	$tLon_colors{18}:=0xFF000000  //Personalized
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($current_color=-1)
		
		$selected:=1  //Automatic
		$current_color:=Choose:C955($mode="front"; Black:K11:16; White:K11:1)
		
		//______________________________________________________
	: ($current_color=Black:K11:16)\
		 & ($mode="front")
		
		$selected:=1  //Automatic
		
		//______________________________________________________
	: ($current_color=White:K11:1)\
		 & ($mode="back")
		
		$selected:=1  //Automatic
		
		//______________________________________________________
	Else 
		
		$selected:=Find in array:C230($tLon_colors; $current_color | 0xFF000000)
		$selected:=Choose:C955($selected>0; $selected; 18)  //Personalized
		
		//______________________________________________________
End case 

$popup_menu:=Create menu:C408

For ($i; 0; 17; 1)
	
	APPEND MENU ITEM:C411($popup_menu; Localized string:C991($mode+"_"+String:C10($i)))
	SET MENU ITEM PARAMETER:C1004($popup_menu; -1; String:C10($i+1))
	SET MENU ITEM ICON:C984($popup_menu; -1; "#Images/colors/"+$mode+"_"+String:C10($i)+".png")
	
End for 

SET MENU ITEM MARK:C208($popup_menu; $selected; Char:C90(18))
$new_color:=Num:C11(Dynamic pop up menu:C1006($popup_menu; String:C10($selected)))
RELEASE MENU:C978($popup_menu)

If ($new_color>0)
	
	Case of 
			
			//________________________________________
		: ($new_color=1)  //automatic
			
			$color:=Choose:C955($mode="front"; Black:K11:16; White:K11:1)
			
			//________________________________________
		: ($new_color=18)  //let user choose
			
			$color:=Select RGB color:C956($current_color)
			
			//________________________________________
		Else 
			
			$color:=$tLon_colors{$new_color}
			
			//________________________________________
	End case 
	
	// #9-5-2016
	If ($mode#"front")
		
		$color:=$color & 0x00FFFFFF
		
	End if 
End if 

return $color

// ----------------------------------------------------
// End