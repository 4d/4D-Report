//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_Color
  // Database: sandbox_14
  // ID[AEBFD273926047DC981A7CF5AC550B62]
  // Created #14-2-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_color;$Lon_current_color;$Lon_i;$Lon_parameters;$Lon_selected)
C_TEXT:C284($Mnu_menuReference;$Txt_mode;$Txt_prefix;$Txt_prefixParameter)

If (False:C215)
	C_TEXT:C284(mnu_Color ;$0)
	C_LONGINT:C283(mnu_Color ;$1)
	C_TEXT:C284(mnu_Color ;$2)
	C_TEXT:C284(mnu_Color ;$3)
	
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259
$Txt_prefixParameter:=""

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_color:=-1
	$Txt_mode:="front"
	
	If ($Lon_parameters>=1)
		
		$Lon_current_color:=$1  //{preselected} : -1 = automatic (default); RGB color
		
		If ($Lon_parameters>=2)
			
			$Txt_mode:=$2  //{target} : front (default); back
			
			If ($Lon_parameters>=3)
				
				$Txt_prefixParameter:=$3  //{prefix} : for border management
				
			End if 
			
		End if 
	End if 
	
	ARRAY LONGINT:C221($tLon_colors;18)
	
	$tLon_colors{1}:=1  //0xFFFFFFFF  //Automatic
	
	If ($Txt_mode="front")
		
		$tLon_colors{2}:=0x00AA753F
		$tLon_colors{3}:=0x00CC7A02
		$tLon_colors{4}:=0x00EF6B00
		$tLon_colors{5}:=0x00D81E05
		$tLon_colors{6}:=0x00BF30B5
		$tLon_colors{7}:=0x006607A5
		$tLon_colors{8}:=0x51BA
		$tLon_colors{9}:=0x99B5
		$tLon_colors{10}:=0x9E60
		$tLon_colors{11}:=0x004BB51E
		$tLon_colors{12}:=0x00BAD80A
		$tLon_colors{13}:=0x00877530
		$tLon_colors{14}:=0x0066594C
		$tLon_colors{15}:=0x00777772
		$tLon_colors{16}:=0x003F6075
		$tLon_colors{17}:=0x0066746B
		
	Else 
		
		$tLon_colors{2}:=0x00EDD3B5
		$tLon_colors{3}:=0x00FCBF49
		$tLon_colors{4}:=0x00FF993F
		$tLon_colors{5}:=0x00F9827F
		$tLon_colors{6}:=0x00E29ED6
		$tLon_colors{7}:=0x00B591D1
		$tLon_colors{8}:=0x00A8CEE2
		$tLon_colors{9}:=0x0072D1DD
		$tLon_colors{10}:=0x0096D8AF
		$tLon_colors{11}:=0x00B5DF95
		$tLon_colors{12}:=0x00E0EA68
		$tLon_colors{13}:=0x00CFD1A5
		$tLon_colors{14}:=0x00BAAA9E
		$tLon_colors{15}:=0x00C4C1BA
		$tLon_colors{16}:=0x00AFBCBF
		$tLon_colors{17}:=0x00A0AE9E
		
	End if 
	
	$tLon_colors{18}:=0x0000  //Personalized
	
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
		 & ($Txt_mode="back@")
		
		$Lon_selected:=1  //Automatic
		
		  //______________________________________________________
	Else 
		
		$Lon_selected:=Find in array:C230($tLon_colors;$Lon_current_color | 0x0000)
		$Lon_selected:=Choose:C955($Lon_selected>0;$Lon_selected;18)  //Personalized
		
		  //______________________________________________________
End case 

If ($Txt_mode="back@")\
 & (Length:C16($Txt_mode)>4)
	
	  //user mode
	$Txt_prefix:="back_"
	
Else 
	
	$Txt_prefix:=$Txt_mode+"_"
	
End if 

$Mnu_menuReference:=Create menu:C408

For ($Lon_i;0;17;1)
	
	APPEND MENU ITEM:C411($Mnu_menuReference;Get localized string:C991($Txt_prefix+String:C10($Lon_i)))
	SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$Txt_prefixParameter+$Txt_mode+"Color_"+String:C10($tLon_colors{$Lon_i+1};"&x"))
	SET MENU ITEM ICON:C984($Mnu_menuReference;-1;"#Images/colors/"+$Txt_prefix+String:C10($Lon_i)+".png")
	
End for 

SET MENU ITEM MARK:C208($Mnu_menuReference;$Lon_selected;Char:C90(18))

$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End