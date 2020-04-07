//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : pathPicker SET FILE TYPES
  // ID[E6A6D14A18404D3DA7496CA99AB21BDD]
  // Created #26-11-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284(${3})

C_LONGINT:C283($Lon_i;$Lon_parameters)
C_TEXT:C284($Txt_type;$Txt_widget)

If (False:C215)
	C_TEXT:C284(pathPicker SET FILE TYPES ;$1)
	C_TEXT:C284(pathPicker SET FILE TYPES ;$2)
	C_TEXT:C284(pathPicker SET FILE TYPES ;${3})
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_widget:=$1  //Name of the widget object
	
	  //Optional parameters
	If ($Lon_parameters=2)
		
		$Txt_type:=$2
		
	Else 
		
		For ($Lon_i;2;$Lon_parameters;1)
			
			$Txt_type:=$Txt_type+${$Lon_i}+(";"*Num:C11($Lon_i<$Lon_parameters))
			
		End for 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
path_picker_SET_TEXT_ATTRIBUTE ($Txt_widget;"fileTypes";$Txt_type)

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End