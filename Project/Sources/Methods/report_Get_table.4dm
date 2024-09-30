//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_Get_table
// Database: 4D Report
// ID[F1C41B317FAE4EE6971FEF8C4745D3D6]
// Created #1-4-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($table_number : Integer) : Integer


var $i; $count_parameters : Integer
var $current_table : Pointer

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	If ($count_parameters>=1)
		
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Not:C34(Is table number valid:C999($table_number)))
	
	$current_table:=Current default table:C363
	
	If (Not:C34(Is nil pointer:C315($current_table)))
		
		$table_number:=Table:C252($current_table)
		
	End if 
	
	If ($table_number=0)
		
		For ($i; 1; Last table number:C254; 1)
			
			If (Is table number valid:C999($i))
				
				$table_number:=$i
				$i:=MAXLONG:K35:2-1
				
			End if 
		End for 
	End if 
End if 

return $table_number

// ----------------------------------------------------
// End