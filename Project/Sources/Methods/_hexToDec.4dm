//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : _hexToDec
  // Database: 4D Report
  // ID[F884C8FA4B13465E97BA16F4A332BA2B]
  // Created #25-3-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_dec;$Lon_digit;$Lon_i;$Lon_length;$Lon_parameters)
C_TEXT:C284($Txt_hex)

If (False:C215)
	C_LONGINT:C283(_hexToDec ;$0)
	C_TEXT:C284(_hexToDec ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Txt_hex:=$1
	
	$Lon_length:=Length:C16($Txt_hex)
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
For ($Lon_i;$Lon_length;1;-1)
	
	$Lon_digit:=Position:C15($Txt_hex[[$Lon_i]];"0123456789ABCDEF")-1
	
	If ($Lon_digit>0)
		
		$Lon_dec:=$Lon_dec+(($Lon_digit)*(16^($Lon_length-$Lon_i)))
		
	End if 
End for 

$0:=$Lon_dec

  // ----------------------------------------------------
  // End