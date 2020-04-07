//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : mnu_FontSize
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

C_LONGINT:C283($Lon_checkedFontSize;$Lon_i;$Lon_parameters)
C_TEXT:C284($Mnu_menuReference;$Txt_buffer)

ARRAY TEXT:C222($tTxt_fonts;0)

If (False:C215)
	C_TEXT:C284(mnu_FontSize ;$0)
	C_LONGINT:C283(mnu_FontSize ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Lon_checkedFontSize:=$1
		
	End if 
	
	ARRAY LONGINT:C221($tLon_sizes;7)
	$tLon_sizes{1}:=8
	$tLon_sizes{2}:=9
	$tLon_sizes{3}:=10
	$tLon_sizes{4}:=12
	$tLon_sizes{5}:=14
	$tLon_sizes{6}:=18
	$tLon_sizes{7}:=24
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Mnu_menuReference:=Create menu:C408

For ($Lon_i;1;Size of array:C274($tLon_sizes);1)
	
	$Txt_buffer:=String:C10($tLon_sizes{$Lon_i})
	APPEND MENU ITEM:C411($Mnu_menuReference;$Txt_buffer)
	SET MENU ITEM PARAMETER:C1004($Mnu_menuReference;-1;"fontSize_"+$Txt_buffer)
	
	If ($tLon_sizes{$Lon_i}=$Lon_checkedFontSize)
		
		SET MENU ITEM MARK:C208($Mnu_menuReference;-1;Char:C90(18))
		
	End if 
End for 

$0:=$Mnu_menuReference

  // ----------------------------------------------------
  // End