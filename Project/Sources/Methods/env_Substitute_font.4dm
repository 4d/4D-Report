//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : env_Substitute_font
// Database: runtime
// ID[6D23E29B256F44C4BC6FD96323C48236]
// Created #13-1-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($Txt_fontName : Text)->$Txt_fontSubstituted : Text


var \
$Lon_parameters : Integer

/*
var \
 $Txt_fontName; $Txt_fontSubstituted: Text
*/


If (False:C215)
	C_TEXT:C284(env_Substitute_font; $0)
	C_TEXT:C284(env_Substitute_font; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	//Optional parameters
	If ($Lon_parameters>=1)
		
		//$Txt_fontName:=$1  //{default font if omitted}
		
	Else 
		
		$Txt_fontName:=OBJECT Get font:C1069(*; "")
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Position:C15(".SF NS TEXT"; $Txt_fontName)>0)
		
		$Txt_fontSubstituted:=Replace string:C233($Txt_fontName; "\".SF NS Text\""; "'Helvetica Neue'")
		$Txt_fontSubstituted:=Replace string:C233($Txt_fontName; "'.SF NS Text'"; "'Helvetica Neue'")
		$Txt_fontSubstituted:=Replace string:C233($Txt_fontName; ".SF NS Text"; "'Helvetica Neue'")
		
		//______________________________________________________
	: (Position:C15("Lucida Grande UI"; $Txt_fontName)>0)
		
		$Txt_fontSubstituted:=Replace string:C233($Txt_fontName; "\".Lucida Grande UI\""; "'Lucida Grande'")
		$Txt_fontSubstituted:=Replace string:C233($Txt_fontName; "'.Lucida Grande UI'"; "'Lucida Grande'")
		$Txt_fontSubstituted:=Replace string:C233($Txt_fontName; ".Lucida Grande UI"; "'Lucida Grande'")
		
		//______________________________________________________
	Else 
		
		$Txt_fontSubstituted:=$Txt_fontName
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
//$0:=$Txt_fontSubstituted

// ----------------------------------------------------
// End