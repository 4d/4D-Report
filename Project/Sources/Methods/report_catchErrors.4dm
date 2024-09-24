//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_catchErrors
// Database: 4D Report
// ID[74749F6B547F4A08A87081D16677FEAC]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($entry_point : Text; $error_handler : Text) : Text

var $count_parameters : Integer


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	If ($count_parameters>=1)
		
		
		
		If ($count_parameters>=2)
			
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($count_parameters=0)  //errer-handling method
		
		//noError
		IDLE:C311
		
		//______________________________________________________
	: ($entry_point="on")
		
		//return the previous method isntalled
		$error_handler:=Method called on error:C704
		ERROR:=0
		
		ON ERR CALL:C155(Current method name:C684)
		
		return $error_handler
		
		//______________________________________________________
	: ($entry_point="off")
		
		//restaure the previous method
		ON ERR CALL:C155($error_handler)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$entry_point+"\"")
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// End