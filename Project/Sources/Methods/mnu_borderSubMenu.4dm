//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_borderSubMenu
  // Database: 4D Report
  // Created #30-9-2019 by Adrien Cagniant
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Mnu_menuReference;$txt_subMenu;$Mnu_submenu)


If (False:C215)
	C_TEXT:C284(mnu_borderSubMenu ;$0)
	C_TEXT:C284(mnu_borderSubMenu ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$txt_subMenu:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_menuReference:=Create menu:C408
$Mnu_submenu:=Create menu:C408

$Mnu_submenu:=mnu_borderThickness (-1;$txt_subMenu)

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_border_thickness";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"")
RELEASE MENU:C978($Mnu_submenu)

$Mnu_submenu:=mnu_Color (-1;"front";$txt_subMenu)
APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_border_color";$Mnu_submenu)
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"")
RELEASE MENU:C978($Mnu_submenu)


$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End