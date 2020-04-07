//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : Rgx_SubstituteText
  // Created 28/09/07 by Vincent
  // ----------------------------------------------------
  // Description
  // Alias "QF_RESubstituteText"
  // ----------------------------------------------------
  // Paramètres
  //$1 = Regular expression
  //$2 = Replacement text
  //$3 = Target text
  //$4 = Regular expression flags
  //$0 = Error result
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_i;$Lon_Index;$Lon_Options;$Lon_Parameters;$Lon_Size;$Lon_Start)
C_TEXT:C284($Txt_Buffer;$Txt_Error_Method;$Txt_Pattern;$Txt_Replacement;$Txt_Target)

ARRAY LONGINT:C221($tLon_Lengths;0)
ARRAY LONGINT:C221($tLon_Positions;0)
ARRAY LONGINT:C221($tLon_Tempo_Index;0)
ARRAY LONGINT:C221($tLon_Tempo_Lengths;0)
ARRAY LONGINT:C221($tLon_Tempo_Positions;0)
ARRAY TEXT:C222($tTxt_Tempo;0)

If (False:C215)
	C_LONGINT:C283(Rgx_SubstituteText ;$0)
	C_TEXT:C284(Rgx_SubstituteText ;$1)
	C_TEXT:C284(Rgx_SubstituteText ;$2)
	C_POINTER:C301(Rgx_SubstituteText ;$3)
	C_LONGINT:C283(Rgx_SubstituteText ;$4)
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters<3)
	
	rgx_Lon_Error:=-50  //Parameter error
	
Else 
	
	If ($Lon_Parameters>3)
		
		$Lon_Options:=$4
		
	End if 
	
	$Txt_Pattern:=rgx_Options ($Lon_Options)+$1
	$Txt_Replacement:=$2
	$Txt_Target:=$3->
	
	rgx_Lon_Error:=0
	
	If (Length:C16($Txt_Target)>0)
		
		$Txt_Error_Method:=Method called on error:C704
		ON ERR CALL:C155("rgx_NO_ERROR")
		
		$Lon_Start:=1
		
		Repeat 
			
			$Boo_OK:=Match regex:C1019($Txt_Pattern;$Txt_Target;$Lon_Start;$tLon_Positions;$tLon_Lengths)
			
			If ($Boo_OK)
				
				$Lon_Index:=0
				
				$Lon_Size:=Size of array:C274($tLon_Positions)
				
				For ($Lon_i;0;$Lon_Size;1)
					
					$Txt_Buffer:=Substring:C12($Txt_Target;$tLon_Positions{$Lon_i};$tLon_Lengths{$Lon_i})
					
					If ($tLon_Positions{$Lon_i}>0)
						
						$Lon_Start:=$tLon_Positions{$Lon_i}+$tLon_Lengths{$Lon_i}
						
					End if 
					
					If ($tLon_Lengths{$Lon_i}=0)
						
						$Boo_OK:=($Lon_i>0)
						
						If ($Boo_OK)
							
							$Boo_OK:=($tLon_Positions{$Lon_i}#$tLon_Positions{$Lon_i-1})
							
						End if 
					End if 
					
					If ($Boo_OK)
						
						APPEND TO ARRAY:C911($tTxt_Tempo;$Txt_Buffer)
						
						APPEND TO ARRAY:C911($tLon_Tempo_Positions;$tLon_Positions{$Lon_i})
						APPEND TO ARRAY:C911($tLon_Tempo_Lengths;$tLon_Lengths{$Lon_i})
						APPEND TO ARRAY:C911($tLon_Tempo_Index;$Lon_Index)
						
						$Lon_Index:=$Lon_Index+1
						
					Else 
						
						$Lon_i:=$Lon_Size+1
						
					End if 
				End for 
			End if 
		Until (Not:C34($Boo_OK))
		
		$Lon_Size:=Size of array:C274($tTxt_Tempo)
		
		If ($Lon_Size>0)
			
			$Lon_Index:=$Lon_Size
			
			Repeat 
				
				If ($tLon_Tempo_Index{$Lon_Index}#0)
					
					$Txt_Buffer:="\\"+String:C10($tLon_Tempo_Index{$Lon_Index})
					
					If (Position:C15($Txt_Buffer;$Txt_Replacement)>0)
						
						$Txt_Replacement:=Replace string:C233($Txt_Replacement;$Txt_Buffer;$tTxt_Tempo{$Lon_Index})
						
					End if 
					
				Else 
					
					$3->:=Delete string:C232($3->;$tLon_Tempo_Positions{$Lon_Index};$tLon_Tempo_Lengths{$Lon_Index})
					$3->:=Insert string:C231($3->;$Txt_Replacement;$tLon_Tempo_Positions{$Lon_Index})
					$Txt_Replacement:=$2
					
				End if 
				
				$Lon_Index:=$Lon_Index-1
				
			Until ($Lon_Index=0)
		End if 
		
		ON ERR CALL:C155($Txt_Error_Method)
		
	End if 
End if 

$0:=rgx_Lon_Error

rgx_Lon_Error:=0