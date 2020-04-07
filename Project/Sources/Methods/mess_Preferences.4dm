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
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_show)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dir_preferences;$Dom_item;$Dom_report;$Dom_root;$File_preferences;$Txt_action)
C_TEXT:C284($Txt_item)

If (False:C215)
	C_BOOLEAN:C305(mess_Preferences ;$0)
	C_TEXT:C284(mess_Preferences ;$1)
	C_TEXT:C284(mess_Preferences ;$2)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Txt_item:=$1
	
	$Txt_action:="GET"
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		$Txt_action:=$2
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Dir_preferences:=Get 4D folder:C485(Active 4D Folder:K5:10)+Path to object:C1547(Structure file:C489(*)).name+Folder separator:K24:12

CREATE FOLDER:C475($Dir_preferences;*)

$File_preferences:=$Dir_preferences+"report.4DPreferences"

If (Test path name:C476($File_preferences)=Is a document:K24:1)
	
	  //parse source
	$Dom_root:=DOM Parse XML source:C719($File_preferences)
	
Else 
	
	  //create source
	$Dom_root:=DOM Create XML Ref:C861("preferences")
	
End if 

$Dom_report:=DOM Find XML element:C864($Dom_root;"preferences/doNotAskAgain")

If (OK=0)
	
	$Dom_report:=DOM Create XML element:C865($Dom_root;"doNotAskAgain")
	
End if 

$Dom_item:=DOM Find XML element:C864($Dom_report;"doNotAskAgain/"+$Txt_item)

Case of 
		
		  //______________________________________________________
	: ($Txt_action="GET")
		
		$Boo_show:=(OK=0)
		
		  //______________________________________________________
	: ($Txt_action="SET")
		
		If (OK=0)
			
			$Dom_item:=DOM Create XML element:C865($Dom_report;$Txt_item)
			
			DOM EXPORT TO FILE:C862($Dom_root;$File_preferences)
			
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point: \""+$Txt_action+"\"")
		
		  //______________________________________________________
End case 

DOM CLOSE XML:C722($Dom_root)

  // ----------------------------------------------------
  // Return
$0:=$Boo_show

  // ----------------------------------------------------
  // End