//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Rgx_Get_Pattern
// Created 16/12/05 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Modified by Vincent (28/09/07)
// 2004 -> v11
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_POINTER:C301($3)

C_LONGINT:C283($Lon_Error; $Lon_Parameters)
C_TEXT:C284($Txt_Buffer; $Txt_Element_Name; $Txt_Path; $Txt_Pattern_Name; $a16_Pattern; $a16_Patterns)
C_TEXT:C284($a16_Root)

//ARRAY TEXT($tTxt_Matches; 0)

If (False:C215)
	C_TEXT:C284(Rgx_Get_Pattern; $0)
	C_TEXT:C284(Rgx_Get_Pattern; $1)
	C_TEXT:C284(Rgx_Get_Pattern; $2)
	C_POINTER:C301(Rgx_Get_Pattern; $3)
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters>0)
	
	$Txt_Pattern_Name:=$1
	
	If ($Lon_Parameters>=2)
		
		$Txt_Path:=$2
		
	End if 
	
	If (Length:C16($Txt_Path)=0)
		
		$Txt_Path:=Get 4D folder:C485(_o_Extras folder:K5:12)+"regex.xml"
		
	End if 
	
	OK:=Num:C11(Test path name:C476($Txt_Path)=Is a document:K24:1)
	
	If (OK=1)
		
		$a16_Root:=DOM Parse XML source:C719($Txt_Path; False:C215)
		
		If (OK=1)
			
			$a16_Patterns:=DOM Find XML element:C864($a16_Root; "/REGEX/patterns/")
			
			If (OK=1)
				
				$a16_Pattern:=DOM Get first child XML element:C723($a16_Patterns)
				
				If (OK=1)
					
					Repeat 
						
						DOM GET XML ATTRIBUTE BY NAME:C728($a16_Pattern; "name"; $Txt_Element_Name)
						
						If ($Txt_Pattern_Name=$Txt_Element_Name)
							
							DOM GET XML ELEMENT VALUE:C731($a16_Pattern; $Txt_Buffer; $Txt_Buffer)
							
							If (Count parameters:C259>=3)
								
								DOM GET XML ATTRIBUTE BY NAME:C728($a16_Pattern; "groupsToExtract"; $3->)
								
							End if 
							
						Else 
							
							$a16_Pattern:=DOM Get next sibling XML element:C724($a16_Pattern)
							
						End if 
					Until ($Txt_Pattern_Name=$Txt_Element_Name)\
						 | (OK=0)
				End if 
			End if 
			
			DOM CLOSE XML:C722($a16_Root)
			
		End if 
		
		//Deleting Spaces & Comments
		$Lon_Error:=Rgx_SubstituteText("\\s*\\(\\?#[^)]*\\)|\\s"; ""; ->$Txt_Buffer)
		
	End if 
End if 

$0:=$Txt_Buffer