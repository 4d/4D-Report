//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : _colorToStyled
  // Database: 4D Report
  // ID[DAE4F58313C540FA8EA472B0E217CCD9]
  // Created #8-7-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_color;$Lon_parameters)
C_TEXT:C284($Txt_color)

If (False:C215)
	C_TEXT:C284(_colorToStyled ;$0)
	C_LONGINT:C283(_colorToStyled ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		$Lon_color:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------

$Txt_color:=String:C10($Lon_color;"&x")

  //delete "0x"
$Txt_color:=Delete string:C232($Txt_color;1;2)

If (Length:C16($Txt_color)>6)
	
	  //delete"00" from start
	$Txt_color:=Delete string:C232($Txt_color;1;2)
	
Else 
	
	  //add "00" at the beginning
	$Txt_color:="00"+$Txt_color
	
End if 

$Txt_color:="#"+$Txt_color

  // ----------------------------------------------------
  // Return
$0:=$Txt_color

  // ----------------------------------------------------
  // End