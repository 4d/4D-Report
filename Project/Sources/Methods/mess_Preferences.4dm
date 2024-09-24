//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : mess_Preferences
// Database: 4D Report
// ID[607E53E77A2A4BB98E8D5E49B1EDE712]
// Created #20-1-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($item : Text; $action : Text) : Boolean

var $do_show : Boolean
var $count_parameters : Integer

var $folder_preferences; $dom_item; $dom_report; $dom_root; $file_preferences : Text





// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	
	$action:=($count_parameters<2) ? "GET" : $action
	
	//Optional parameters
	If ($count_parameters>=2)
		
		
		
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$folder_preferences:=Get 4D folder:C485(Active 4D Folder:K5:10)+Path to object:C1547(Structure file:C489(*)).name+Folder separator:K24:12

CREATE FOLDER:C475($folder_preferences; *)

$file_preferences:=$folder_preferences+"report.4DPreferences"

If (Test path name:C476($file_preferences)=Is a document:K24:1)
	
	//parse source
	$dom_root:=DOM Parse XML source:C719($file_preferences)
	
Else 
	
	//create source
	$dom_root:=DOM Create XML Ref:C861("preferences")
	
End if 

$dom_report:=DOM Find XML element:C864($dom_root; "preferences/doNotAskAgain")

If (OK=0)
	
	$dom_report:=DOM Create XML element:C865($dom_root; "doNotAskAgain")
	
End if 

$dom_item:=DOM Find XML element:C864($dom_report; "doNotAskAgain/"+$item)

Case of 
		
		//______________________________________________________
	: ($action="GET")
		
		$do_show:=(OK=0)
		
		//______________________________________________________
	: ($action="SET")
		
		If (OK=0)
			
			$dom_item:=DOM Create XML element:C865($dom_report; $item)
			
			DOM EXPORT TO FILE:C862($dom_root; $file_preferences)
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point: \""+$action+"\"")
		
		//______________________________________________________
End case 

DOM CLOSE XML:C722($dom_root)

// ----------------------------------------------------
// Return
return $do_show

// ----------------------------------------------------
// End