//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_border
  // Database: 4D Report
  // Created #30-9-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_size)
C_TEXT:C284($Mnu_hdl;$Mnu_submenu)

ARRAY TEXT:C222($tTxt_favoriteFonts;0)
ARRAY TEXT:C222($tTxt_recentFonts;0)

If (False:C215)
	C_TEXT:C284(mnu_border ;$0)
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

  // outside
  // inside
  // vertical
  // horizontal
  //left
  // right
  // top
  //  bottom
  // all


$Mnu_submenu:=mnu_borderSubMenu ("borderAll")

APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_borderAll";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderOut")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_borderOutside";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderIns")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_borderInside";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderVer")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_borderVertical";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderHor")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_borderHorizontal";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderLef")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_border_left";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderRig")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_border_right";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderTop")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_border_top";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_borderSubMenu ("borderBot")
APPEND MENU ITEM:C411($Mnu_hdl;":xliff:menu_border_bottom";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_hdl;-1;"")
RELEASE MENU:C978($Mnu_submenu)


$0:=$Mnu_hdl

  // ----------------------------------------------------
  // End