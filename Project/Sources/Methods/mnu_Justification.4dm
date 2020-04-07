//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_Justification
  // Database: 4D Report
  // ID[AD6C407FBFEF4AE396AE02AB9358F02D]
  // Created #24-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_justification;$Lon_parameters)
C_TEXT:C284($Mnu_menuReference)

If (False:C215)
	C_TEXT:C284(mnu_Justification ;$0)
	C_LONGINT:C283(mnu_Justification ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Lon_justification:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_menuReference:=Create menu:C408

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_align_left")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"justification_2")

If ($Lon_justification=1)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_align_center")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"justification_3")

If ($Lon_justification=2)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_align_right")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"justification_4")

If ($Lon_justification=3)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_align_default")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"justification_1")

If ($Lon_justification=0)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End