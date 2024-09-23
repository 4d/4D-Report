//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : path_picker_SET_LABEL
// ID[F366056285464A5390A355AA354BA923]
// Created #10-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($widget_pointer : Pointer)

var $count_parameters; $size : Integer
var $separator; $buffer; $file; $last_path; $path; $volume : Text
var $widget : Object


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$widget_pointer:=$1
	
	$widget:=JSON Parse:C1218($widget_pointer->)
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$path:=OB Get:C1224($widget; "accessPath"; Is text:K8:3)
$last_path:=OB Get:C1224($widget; "_lastPath"; Is text:K8:3)

If ($path#$last_path)
	
	$size:=Length:C16($path)
	
	If ($size>0)
		
		// C/S mode on Mac the path could be in Windows mode if server run on PC
		// E:\Backup Base Rezs v11\Ressources_4D_v11[0373].4BK
		
		Case of 
				
				//……………………………………………………………………………………………………………………
			: (Application type:C494=4D Remote mode:K5:5)\
				 & (Is macOS:C1572)\
				 & (Position:C15("\\"; $path)>0)
				
				$separator:="\\"
				
				//……………………………………………………………………………………………………………………
			: (Application type:C494=4D Remote mode:K5:5)\
				 & (Is Windows:C1573)\
				 & (Position:C15(":"; Replace string:C233($path; ":"; ""; 1))>0)
				
				$separator:=":"
				
				//……………………………………………………………………………………………………………………
			Else 
				
				$separator:=Folder separator:K24:12
				
				//……………………………………………………………………………………………………………………
		End case 
		
		$volume:=Replace string:C233(doc_volumeName($path); $separator; "")
		$file:=Replace string:C233(doc_getFromPath("fullName"; $path; $separator); $separator; "")
		
		If ($file#$volume)
			
			$buffer:=Replace string:C233(Localized string:C991("FileInVolume"); "{file}"; $file)
			$buffer:=Replace string:C233($buffer; "{volume}"; $volume)
			
		Else 
			
			$buffer:="\""+$file+"\""
			
		End if 
		
		OBJECT SET VISIBLE:C603(*; "plus"; True:C214)
		
	Else 
		
		CLEAR VARIABLE:C89($buffer)
		OBJECT SET VISIBLE:C603(*; "plus"; False:C215)
		
	End if 
	
	//store the current path value
	OB SET:C1220($widget; \
		"_lastPath"; $path)
	
	$widget_pointer->:=JSON Stringify:C1217($widget)
	
	(OBJECT Get pointer:C1124(Object named:K67:5; "accessPath"))->:=$buffer
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End