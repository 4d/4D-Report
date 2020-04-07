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
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_i;$Lon_parameters;$Lon_tableNumber)
C_POINTER:C301($Ptr_currentTable)

If (False:C215)
	C_LONGINT:C283(report_Get_table ;$0)
	C_LONGINT:C283(report_Get_table ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Lon_tableNumber:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Not:C34(Is table number valid:C999($Lon_tableNumber)))
	
	$Ptr_currentTable:=Current default table:C363
	
	If (Not:C34(Is nil pointer:C315($Ptr_currentTable)))
		
		$Lon_tableNumber:=Table:C252($Ptr_currentTable)
		
	End if 
	
	If ($Lon_tableNumber=0)
		
		For ($Lon_i;1;Get last table number:C254;1)
			
			If (Is table number valid:C999($Lon_i))
				
				$Lon_tableNumber:=$Lon_i
				$Lon_i:=MAXLONG:K35:2-1
				
			End if 
		End for 
	End if 
End if 

$0:=$Lon_tableNumber

  // ----------------------------------------------------
  // End