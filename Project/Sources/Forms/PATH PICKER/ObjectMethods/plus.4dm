// ----------------------------------------------------
// Object method : PATH PICKER.plus
// ID[B74219C236C449369799F773E0D32B78]
// Created #9-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var $i; $long : Integer
var $left; $bottom; $leftOffset; $topOffset : Integer

var $e : Object

var $self; $widget_pointer : Pointer
var $action; $buffer; $separator; $menu; $path; $text; $object_name : Text
var $widget : Object


ARRAY TEXT:C222($_volumes; 0)

// ----------------------------------------------------
// Initialisations

$e:=FORM Event:C1606
$object_name:=OBJECT Get name:C1087(Object current:K67:2)
$self:=OBJECT Get pointer:C1124(Object current:K67:2)

$widget_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "ob_widget")

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Clicked:K2:4)
		
		$widget:=JSON Parse:C1218($widget_pointer->)
		
		$path:=OB Get:C1224($widget; "accessPath"; Is text:K8:3)
		
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
		
		VOLUME LIST:C471($_volumes)
		
		//_O_PLATFORM PROPERTIES($platform)
		
		$menu:=Create menu:C408
		
		For ($i; 1; Length:C16($path); 1)
			
			If ($path[[$i]]=$separator)
				
				If (Is Windows:C1573)
					
					APPEND MENU ITEM:C411($menu; $buffer)
					
				Else 
					
					INSERT MENU ITEM:C412($menu; 0; $buffer)
					
				End if 
				
				//keep the item path
				SET MENU ITEM PARAMETER:C1004($menu; -1; Substring:C12($path; 1; $i))
				
				//set item icon
				$text:=Substring:C12($path; 1; $i-1)
				
				Case of 
						
						//-------------------------------------------
					: (Find in array:C230($_volumes; $text)>0)
						
						SET MENU ITEM ICON:C984($menu; -1; "#images/widgets/path/drive.png")
						
						//-------------------------------------------
					: (Test path name:C476($text)=Is a folder:K24:2)
						
						SET MENU ITEM ICON:C984($menu; -1; "#images/widgets/path/folder.png")
						
						//-------------------------------------------
					: (Test path name:C476($text)=Is a document:K24:1)
						
						SET MENU ITEM ICON:C984($menu; -1; "#images/widgets/path/file.png")
						
						//______________________________________________________
				End case 
				
				CLEAR VARIABLE:C89($buffer)
				
			Else 
				
				$buffer:=$buffer+$path[[$i]]
				
			End if 
		End for 
		
		If (Length:C16($buffer)>0)
			
			If (Is Windows:C1573)
				
				APPEND MENU ITEM:C411($menu; $buffer)
				
			Else 
				
				INSERT MENU ITEM:C412($menu; 0; $buffer)
				
			End if 
			
			SET MENU ITEM PARAMETER:C1004($menu; -1; $path)
			SET MENU ITEM ICON:C984($menu; -1; "#images/widgets/path/file.png")
			
		End if 
		
		If (Count menu items:C405($menu)>0)
			
			If (OB Get:C1224($widget; "showOnDisk"; Is boolean:K8:9))\
				 | (OB Get:C1224($widget; "copyPath"; Is boolean:K8:9))
				
				APPEND MENU ITEM:C411($menu; "-")
				
			End if 
			
			If (OB Get:C1224($widget; "showOnDisk"; Is boolean:K8:9))
				
				APPEND MENU ITEM:C411($menu; Localized string:C991("ShowOnDisk"))
				SET MENU ITEM PARAMETER:C1004($menu; -1; "show")
				
			End if 
			
			If (OB Get:C1224($widget; "copyPath"; Is boolean:K8:9))
				
				APPEND MENU ITEM:C411($menu; Localized string:C991("CopyPath"))
				SET MENU ITEM PARAMETER:C1004($menu; -1; "copy")
				
			End if 
			
			$leftOffset:=(OBJECT Get pointer:C1124(Object named:K67:5; "left"))->
			$topOffset:=(OBJECT Get pointer:C1124(Object named:K67:5; "top"))->
			
			If (($leftOffset+$topOffset)=0)
				
				$action:=Dynamic pop up menu:C1006($menu)
				
			Else 
				
				OBJECT GET COORDINATES:C663(*; "border"; $left; $long; $long; $bottom)
				
				$action:=Dynamic pop up menu:C1006($menu; ""; $left+$leftOffset; $bottom+$topOffset-5)
				
			End if 
			
			RELEASE MENU:C978($menu)
			
			Case of 
					
					//………………………
				: (Length:C16($action)=0)
					
					//………………………
				: ($action="copy")
					
					SET TEXT TO PASTEBOARD:C523($path)
					
					//………………………
				: ($action="show")
					
					SHOW ON DISK:C922($path)
					
					//………………………
				: (Not:C34(OB Get:C1224($widget; "openItem"; Is boolean:K8:9)))
					
					//NOTHING MORE TO DO
					
					//………………………
				Else 
					
					SHOW ON DISK:C922($action)
					
					//………………………
			End case 
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 