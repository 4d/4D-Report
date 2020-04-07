//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : env_4D_Resources_folder_path
  // Database: 4D Labels
  // ID[8471613630494D63B0215B1E6F021915]
  // Created #7-4-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Path_buffer)

If (False:C215)
	C_TEXT:C284(env_4D_Resources_folder_path ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  // NO PARAMETERS REQUIRED
	
	  // Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Path_buffer:=Application file:C491

If (Is Windows:C1573)
	
	  // Get parent path
	  //For ($Lon_i;Length($Path_buffer);1;-1)
	  //If ($Path_buffer[[$Lon_i]]=Folder separator)
	  //$Path_buffer:=Substring($Path_buffer;1;$Lon_i)
	  //$Lon_i:=0
	  // End if
	  // End for
	
	$Path_buffer:=Path to object:C1547($Path_buffer).parentFolder
	
Else 
	
	  // Content path
	$Path_buffer:=$Path_buffer+Folder separator:K24:12+"Contents"+Folder separator:K24:12
	
End if 

  // ----------------------------------------------------
  // Return
$0:=$Path_buffer+"Resources"+Folder separator:K24:12

  // ----------------------------------------------------
  // End