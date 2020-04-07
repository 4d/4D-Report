//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_FontSyle
  // Database: 4D Report
  // ID[AB9CB42EA04642FDAE0DCBDB347F31C3]
  // Created #24-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_parameters;$Lon_styles)
C_TEXT:C284($Mnu_menuReference)

If (False:C215)
	C_TEXT:C284(mnu_FontSyle ;$0)
	C_LONGINT:C283(mnu_FontSyle ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Lon_styles:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_menuReference:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_plain")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"fontStyle_plain")

If ($Lon_styles=0)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_bold")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"fontStyle_bold")

If ($Lon_styles ?? 0)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_italic")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"fontStyle_Italic")

If ($Lon_styles ?? 1)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_underline")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"fontStyle_underline")

If ($Lon_styles ?? 2)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End