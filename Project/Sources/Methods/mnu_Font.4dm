//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_Font
  // Database: 4D Report
  // ID[2AE0122608FE4D6E80FCC71C0AD13B2E]
  // Created #24-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_size)
C_TEXT:C284($Mnu_hdl)

ARRAY TEXT:C222($tTxt_favoriteFonts;0)
ARRAY TEXT:C222($tTxt_recentFonts;0)

If (False:C215)
	C_TEXT:C284(mnu_Font ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //#TO_BE_DONE - alow passing a font name to check if any the current font
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_hdl:=Create menu:C408

FONT LIST:C460($tTxt_recentFonts;Recent fonts:K80:3)
SORT ARRAY:C229($tTxt_recentFonts)

$Lon_size:=Size of array:C274($tTxt_recentFonts)

For ($Lon_i;1;$Lon_size;1)
	
	If ($tTxt_recentFonts{$Lon_i}=".@")
		
		$tTxt_recentFonts{$Lon_i}:=Get localized string:C991("systemFont")
		
	End if 
	
	APPEND MENU ITEM:C411($Mnu_hdl;$tTxt_recentFonts{$Lon_i})
	SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"font_"+$tTxt_recentFonts{$Lon_i})
	
End for 

If (Count menu items:C405($Mnu_hdl)>0)
	
	APPEND MENU ITEM:C411($Mnu_hdl;"-")
	
End if 

FONT LIST:C460($tTxt_favoriteFonts;Favorite fonts:K80:2)
SORT ARRAY:C229($tTxt_favoriteFonts)
$Lon_size:=Size of array:C274($tTxt_favoriteFonts)

For ($Lon_i;1;$Lon_size;1)
	
	If ($tTxt_favoriteFonts{$Lon_i}=".@")
		
		$tTxt_favoriteFonts{$Lon_i}:=Get localized string:C991("systemFont")
		
	End if 
	
	If (Find in array:C230($tTxt_recentFonts;$tTxt_favoriteFonts{$Lon_i})=-1)
		
		APPEND MENU ITEM:C411($Mnu_hdl;$tTxt_favoriteFonts{$Lon_i})
		SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"font_"+$tTxt_favoriteFonts{$Lon_i})
		
	End if 
End for 

If (Count menu items:C405($Mnu_hdl)>0)
	
	If (Get menu item:C422($Mnu_hdl;-1)#"-")
		
		APPEND MENU ITEM:C411($Mnu_hdl;"-")
		
	End if 
End if 

APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_show_fonts")
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"font_picker")

$0:=$Mnu_hdl

  // ----------------------------------------------------
  // End