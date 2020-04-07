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
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_color;$Lon_current_color;$Lon_i;$Lon_new_color;$Lon_parameters;$Lon_selected)
C_TEXT:C284($Mnu_pop;$Txt_mode)

If (False:C215)
	C_LONGINT:C283(CONTROL_Get_color ;$0)
	C_LONGINT:C283(CONTROL_Get_color ;$1)
	C_TEXT:C284(CONTROL_Get_color ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_color:=-1
	$Txt_mode:="front"
	
	If ($Lon_parameters>=1)
		
		$Lon_current_color:=$1  //{preselected} : -1 = automatic (default); RGB color
		
		If ($Lon_parameters>=2)
			
			$Txt_mode:=$2  //{target} : front (default); back
			
		End if 
	End if 
	
	ARRAY LONGINT:C221($tLon_colors;18)
	
	$tLon_colors{1}:=0x00FFFFFF  //Automatic
	
	If ($Txt_mode="front")
		
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
	: ($Lon_current_color=-1)
		
		$Lon_selected:=1  //Automatic
		$Lon_current_color:=Choose:C955($Txt_mode="front";Black:K11:16;White:K11:1)
		
		  //______________________________________________________
	: ($Lon_current_color=Black:K11:16)\
		 & ($Txt_mode="front")
		
		$Lon_selected:=1  //Automatic
		
		  //______________________________________________________
	: ($Lon_current_color=White:K11:1)\
		 & ($Txt_mode="back")
		
		$Lon_selected:=1  //Automatic
		
		  //______________________________________________________
	Else 
		
		$Lon_selected:=Find in array:C230($tLon_colors;$Lon_current_color | 0xFF000000)
		$Lon_selected:=Choose:C955($Lon_selected>0;$Lon_selected;18)  //Personalized
		
		  //______________________________________________________
End case 

$Mnu_pop:=Create menu:C408

For ($Lon_i;0;17;1)
	
	APPEND MENU ITEM:C411($Mnu_pop;Get localized string:C991($Txt_mode+"_"+String:C10($Lon_i)))
	SET MENU ITEM PARAMETER:C1004($Mnu_pop;-1;String:C10($Lon_i+1))
	SET MENU ITEM ICON:C984($Mnu_pop;-1;"#Images/colors/"+$Txt_mode+"_"+String:C10($Lon_i)+".png")
	
End for 

SET MENU ITEM MARK:C208($Mnu_pop;$Lon_selected;Char:C90(18))
$Lon_new_color:=Num:C11(Dynamic pop up menu:C1006($Mnu_pop;String:C10($Lon_selected)))
RELEASE MENU:C978($Mnu_pop)

If ($Lon_new_color>0)
	
	Case of 
			
			  //________________________________________
		: ($Lon_new_color=1)  //automatic
			
			$Lon_color:=Choose:C955($Txt_mode="front";Black:K11:16;White:K11:1)
			
			  //________________________________________
		: ($Lon_new_color=18)  //let user choose
			
			$Lon_color:=Select RGB color:C956($Lon_current_color)
			
			  //________________________________________
		Else 
			
			$Lon_color:=$tLon_colors{$Lon_new_color}
			
			  //________________________________________
	End case 
	
	  // #9-5-2016
	If ($Txt_mode#"front")
		
		$Lon_color:=$Lon_color & 0x00FFFFFF
		
	End if 
End if 

$0:=$Lon_color

  // ----------------------------------------------------
  // End