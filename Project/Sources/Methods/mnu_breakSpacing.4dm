//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_BreakSpacing
  // Database: 4D Report
  // Created #5-04-2019 by Adrien Cagniant.
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations

C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_SubBreakSpacing;$Lon_parameters)
C_TEXT:C284($Mnu_menuReference)

If (False:C215)
	C_TEXT:C284(mnu_breakSpacing ;$0)
	C_LONGINT:C283(mnu_breakSpacing ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Lon_SubBreakSpacing:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_menuReference:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_subtotalSpacingMnuInPoint")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"spacingPoint")

If ($Lon_SubBreakSpacing=1)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_subtotalSpacingMnuInPercent")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"spacingPercent")

If ($Lon_SubBreakSpacing=2)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_subtotalSpacingMnuPageBreak")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"spacingPageBreak")

If ($Lon_SubBreakSpacing=3)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End