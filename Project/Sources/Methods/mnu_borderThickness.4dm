//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_borderThickness
  // Database: 4D Report
  // Created #30-08-2019 by Adrien Cagniant.
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations

C_TEXT:C284($0;$2)
C_LONGINT:C283($1)
C_REAL:C285($real_thickness)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Mnu_menuReference;$txt_parameter)
C_BOOLEAN:C305($boo_menuWithZeroborder)

If (False:C215)
	C_TEXT:C284(mnu_borderThickness ;$0)
	C_LONGINT:C283(mnu_borderThickness ;$1)
	C_TEXT:C284(mnu_borderThickness ;$2)
	
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259
$txt_parameter:=""
$boo_menuWithZeroborder:=False:C215

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$real_thickness:=$1
		
		If ($Lon_parameters>=2)
			
			$txt_parameter:=$2
			$boo_menuWithZeroborder:=True:C214
			  // no border is not proposed in QR dial, only for embedded.
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_menuReference:=Create menu:C408

If ($boo_menuWithZeroborder)
	APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_thickness0")
	SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$txt_parameter+"0")
	
	If ($real_thickness=0)
		
		SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
		
	End if 
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_thickness1")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$txt_parameter+"1")

If ($real_thickness=1)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_thickness2")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$txt_parameter+"2")

If ($real_thickness=2)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 

APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_thickness3")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$txt_parameter+"3")

If ($real_thickness=3)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 
APPEND MENU ITEM:C411($Mnu_menuReference;":xliff:menu_thickness4")
SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;$txt_parameter+"4")

If ($real_thickness=4)
	
	SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
	
End if 


$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End