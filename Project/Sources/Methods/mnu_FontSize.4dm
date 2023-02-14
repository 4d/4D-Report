//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : mnu_FontSize
// Database: 4D Report
// ID[AB9CB42EA04642FDAE0DCBDB347F31C3]
// Created #24-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($checked_font_size : Integer)->$menu : Text


var \
$count_parameters; \
$i : Integer

var \
$buffer : Text



If (False:C215)
	C_TEXT:C284(mnu_FontSize; $0)
	C_LONGINT:C283(mnu_FontSize; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	If ($count_parameters>=1)
		
		//$checked_font_size:=$1
		
	End if 
	
	ARRAY LONGINT:C221($_sizes; 7)
	$_sizes{1}:=8
	$_sizes{2}:=9
	$_sizes{3}:=10
	$_sizes{4}:=12
	$_sizes{5}:=14
	$_sizes{6}:=18
	$_sizes{7}:=24
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$menu:=Create menu:C408

For ($i; 1; Size of array:C274($_sizes); 1)
	
	$buffer:=String:C10($_sizes{$i})
	APPEND MENU ITEM:C411($menu; $buffer)
	SET MENU ITEM PARAMETER:C1004($menu; -1; "fontSize_"+$buffer)
	
	If ($_sizes{$i}=$checked_font_size)
		
		SET MENU ITEM MARK:C208($menu; -1; Char:C90(18))
		
	End if 
End for 

//$0:=$menu

// ----------------------------------------------------
// End