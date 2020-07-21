//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : db_virtualFormulaName
// Database: 4D Report
// Created #29-6-2020 by Adrien Cagniant
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters; $lon_Last; $lon_pos; $lon_posEnd)
C_TEXT:C284($kTxt_patternOperation; $kTxt_patternCommand; $Txt_structure_name; $Txt_virtual_name; $txt_fieldName; $txt_operator; $txt_command; $txt_secondOperand)
C_BOOLEAN:C305($boo_operatorFound; $boo_commandFound; $boo_startByOperator)


If (False:C215)
	C_TEXT:C284(db_virtualFormulaName; $0)
	C_TEXT:C284(db_virtualFormulaName; $1)
End if 

ARRAY TEXT:C222($tTxt_results; 0x0000; 0x0000)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	//Required parameters
	$Txt_structure_name:=$1
	
	//Optional parameters
	If ($Lon_parameters>=2)
		
		// <NONE>
		
	End if 
	
	$Txt_virtual_name:=$Txt_structure_name
	
	//extract the char which is delimiter each argument (field name 
	$kTxt_patternOperation:="[+:=*]+"
	$kTxt_patternCommand:="^.*\\(.*\\)?"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

ARRAY LONGINT:C221($lon_posFound; 0)
ARRAY LONGINT:C221($lon_lenghtFound; 0)

ARRAY LONGINT:C221($lon_posCommandFound; 0)
ARRAY LONGINT:C221($lon_lenghtCommandFound; 0)

If (True:C214)
	
	$Txt_virtual_name:=Parse formula:C1576($Txt_structure_name; Formula out with virtual structure:K88:2)
	
Else 
	
	$boo_operatorFound:=Match regex:C1019($kTxt_patternOperation; $Txt_structure_name; 1; $lon_posFound; $lon_lenghtFound)
	$boo_commandFound:=Match regex:C1019($kTxt_patternCommand; $Txt_structure_name; 1; $lon_posCommandFound; $lon_lenghtCommandFound)
	
	
	$boo_startByOperator:=Choose:C955(($boo_operatorFound & $boo_commandFound); $lon_posFound{0}<$lon_posCommandFound{0}; True:C214)
	
	
	Case of 
			
			
			
		: ($boo_commandFound & $boo_startByOperator)
			
			$lon_pos:=Position:C15("("; $Txt_structure_name)
			$lon_posEnd:=Position:C15(")"; $Txt_structure_name)
			
			$txt_fieldName:=Substring:C12($Txt_structure_name; $lon_pos+1; ($lon_posEnd-$lon_pos)-1)
			$txt_command:=Substring:C12($Txt_structure_name; 0; $lon_pos)
			$txt_secondOperand:=Substring:C12($Txt_structure_name; $lon_posEnd+1)
			$txt_fieldName:=db_virtualFormulaName($txt_fieldName)
			
			$Txt_virtual_name:=$txt_command+$txt_fieldName+")"+db_virtualFormulaName($txt_secondOperand)
			
			
		: ($boo_operatorFound)
			
			$lon_Last:=$lon_posFound{0}-1
			
			$txt_fieldName:=Substring:C12($Txt_structure_name; 0; $lon_Last)
			$txt_operator:=Substring:C12($Txt_structure_name; $lon_Last+1; 1)
			$txt_secondOperand:=Substring:C12($Txt_structure_name; $lon_Last+2; Length:C16($Txt_structure_name))
			
			$Txt_virtual_name:=db_virtualFormulaName($txt_fieldName)+$txt_operator+db_virtualFormulaName($txt_secondOperand)
			
			
		Else 
			
			$Txt_virtual_name:=db_virtualFieldName($Txt_structure_name)
			
	End case 
	
End if 

// ----------------------------------------------------
// Return
$0:=$Txt_virtual_name

// ----------------------------------------------------
// End