//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : doc_volumeName
  // ID[2B6888351CBF4E87A0C1EA955B44C52E]
  // Created 30/11/10 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Lon_x)
C_TEXT:C284($Txt_buffer;$Txt_path;$Txt_volume)

If (False:C215)
	C_TEXT:C284(doc_volumeName ;$0)
	C_TEXT:C284(doc_volumeName ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	$Txt_path:=$1
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Length:C16($Txt_path)#0)
	
	$Lon_x:=Position:C15(":";$Txt_path)
	
	If ($Lon_x>0)
		
		$Txt_volume:=Substring:C12($Txt_path;1;$Lon_x)
		
		If (Folder separator:K24:12="\\")
			
			$Txt_volume:=$Txt_volume+"\\"
			
		End if 
		
	Else 
		
		If ($Lon_x=1)
			
			$Txt_buffer:="••"+Substring:C12($Txt_path;3)
			
			If ($Lon_x>0)
				
				$Txt_buffer[[$Lon_x]]:="•"
				
				If ($Lon_x>0)
					
					$Txt_volume:=Substring:C12($Txt_path;1;$Lon_x)
					
				End if 
			End if 
			
		Else 
			
			$Txt_volume:=Choose:C955(Folder separator:K24:12="\\";$Txt_path+":\\";$Txt_path+":")
			
		End if 
	End if 
End if 

$0:=$Txt_volume

  // ----------------------------------------------------
  // End