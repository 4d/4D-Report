//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : QR_SET_TITLE
// Database: TEST_DATABASE
// ID[E8294774399E4CA58E5188FE05DF0793]
// Created #6-4-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($Lon_area; $Lon_column; $Lon_hidden; $Lon_parameters; $Lon_repeated; $Lon_width)
C_TEXT:C284($Txt_format; $Txt_object; $Txt_pattern; $Txt_title; $Txt_variable)

ARRAY LONGINT:C221($tLon_lengths; 0)
ARRAY LONGINT:C221($tLon_positions; 0)

If (False:C215)
	C_LONGINT:C283(QR_SET_TITLE; $1)
	C_LONGINT:C283(QR_SET_TITLE; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	//Required parameters
	$Lon_area:=$1
	$Lon_column:=$2
	
	//Optional parameters
	If ($Lon_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
QR GET INFO COLUMN:C766($Lon_area; \
$Lon_column; \
$Txt_title; \
$Txt_object; \
$Lon_hidden; \
$Lon_width; \
$Lon_repeated; \
$Txt_format; \
$Txt_variable)

Case of 
	: (Length:C16($Txt_title)=0)\
		 & (Length:C16($Txt_variable)#0)
		
		
		If (<>withFeature111172)
			
			If (boo_useVirtualStructure)
				$Txt_title:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
				
			Else 
				$Txt_title:=$Txt_object
				
			End if 
			
			
			QR SET INFO COLUMN:C765($Lon_area; \
				$Lon_column; \
				$Txt_title; \
				$Txt_object; \
				$Lon_hidden; \
				$Lon_width; \
				$Lon_repeated; \
				$Txt_format)
			
		End if 
		
		
	: (Length:C16($Txt_title)=0)\
		 & (Length:C16($Txt_variable)=0)
		
		$Txt_pattern:="(?mi-s)^\\[([^\\]]*)\\]([^-+*/\\\\%=?&|>,:\"(\\[\\$]{1,31})$"  //[table]field
		
		If (boo_useVirtualStructure)
			$Txt_title:=Parse formula:C1576($Txt_object; Formula out with virtual structure:K88:2)
			
		Else 
			$Txt_title:=$Txt_object
			
		End if 
		
		
		If (Match regex:C1019($Txt_pattern; $Txt_title; 1; $tLon_positions; $tLon_lengths))
			
			$Txt_title:=Substring:C12($Txt_title; $tLon_positions{2}; $tLon_lengths{2})
			
			QR SET INFO COLUMN:C765($Lon_area; \
				$Lon_column; \
				$Txt_title; \
				$Txt_object; \
				$Lon_hidden; \
				$Lon_width; \
				$Lon_repeated; \
				$Txt_format)
			
		End if 
		
End case 



// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End