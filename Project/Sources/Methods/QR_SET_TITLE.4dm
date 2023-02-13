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

#DECLARE($area : Integer; $column : Integer)

var \
$count_parameters; \
$width; \
$hidden; \
$repeated_values : Integer


var \
$format; \
$pattern; \
$object_name; \
$title; \
$variable : Text



ARRAY LONGINT:C221($_lengths; 0)
ARRAY LONGINT:C221($_positions; 0)

If (False:C215)
	C_LONGINT:C283(QR_SET_TITLE; $1)
	C_LONGINT:C283(QR_SET_TITLE; $2)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=2; "Missing parameter"))
	
	//Required parameters
	//$area:=$1
	//$column:=$2
	
	//Optional parameters
	If ($count_parameters>=3)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
QR GET INFO COLUMN:C766($area; \
$column; \
$title; \
$object_name; \
$hidden; \
$width; \
$repeated_values; \
$format; \
$variable)

Case of 
	: (Length:C16($title)=0)\
		 & (Length:C16($variable)#0)
		
		
		//If (<>withFeature111172)
		
		If (boo_useVirtualStructure)
			$title:=Parse formula:C1576($object_name; Formula out with virtual structure:K88:2)
			
		Else 
			$title:=$object_name
			
		End if 
		
		
		QR SET INFO COLUMN:C765($area; \
			$column; \
			$title; \
			$object_name; \
			$hidden; \
			$width; \
			$repeated_values; \
			$format)
		
		//End if 
		
		
	: (Length:C16($title)=0)\
		 & (Length:C16($variable)=0)
		
		$pattern:="(?mi-s)^\\[([^\\]]*)\\]([^-+*/\\\\%=?&|>,:\"(\\[\\$]{1,31})$"  //[table]field
		
		If (boo_useVirtualStructure)
			$title:=Parse formula:C1576($object_name; Formula out with virtual structure:K88:2)
			
		Else 
			$title:=$object_name
			
		End if 
		
		
		If (Match regex:C1019($pattern; $title; 1; $_positions; $_lengths))
			
			$title:=Substring:C12($title; $_positions{2}; $_lengths{2})
			
			QR SET INFO COLUMN:C765($area; \
				$column; \
				$title; \
				$object_name; \
				$hidden; \
				$width; \
				$repeated_values; \
				$format)
			
		End if 
		
End case 



// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End