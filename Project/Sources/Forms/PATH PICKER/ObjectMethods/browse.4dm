// ----------------------------------------------------
// Object method : PATH PICKER.browse
// ID[FBCDFA41F1B94F72901526D840F4C608]
// Created #10-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
#DECLARE()->$RESULT : Integer

var $is_ok : Boolean
var $e : Object

var $directory_code; $options; $type : Integer
var $self; $widget_pointer : Pointer
var $directory_path; $file_types; $path; $message; $object_name : Text

var $widget : Object



// ----------------------------------------------------
// Initialisations
$e:=FORM Event:C1606
$object_name:=OBJECT Get name:C1087(Object current:K67:2)
$self:=OBJECT Get pointer:C1124(Object current:K67:2)

$widget_pointer:=OBJECT Get pointer:C1124(Object named:K67:5; "ob_widget")
$widget:=JSON Parse:C1218($widget_pointer->)

$type:=OB Get:C1224($widget; "type"; Is longint:K8:6)

$RESULT:=-1

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($e.code=On Clicked:K2:4)
		
		$message:=OB Get:C1224($widget; "message"; Is text:K8:3)
		$directory_path:=OB Get:C1224($widget; "directory"; Is text:K8:3)
		$options:=OB Get:C1224($widget; "options"; Is longint:K8:6)
		
		$directory_code:=Num:C11($directory_path)
		
		Case of 
				
				//………………………………………………………………
			: ($type=Is a document:K24:1)
				
				$file_types:=OB Get:C1224($widget; "fileTypes"; Is text:K8:3)
				
				If (String:C10($directory_code)=$directory_path)
					
					//use a memorized access path
					$path:=Select document:C905($directory_code; $file_types; $message; $options)
					
				Else 
					
					$path:=Select document:C905($directory_path; $file_types; $message; $options)
					
				End if 
				
				$is_ok:=(OK=1)
				
				If ($is_ok)
					
					$path:=DOCUMENT
					
				End if 
				
				//………………………………………………………………
			: ($type=Is a folder:K24:2)
				
				If (String:C10($directory_code)=$directory_path)
					
					//use a memorized access path
					$path:=Select folder:C670($message; $directory_code; $options)
					
				Else 
					
					$path:=Select folder:C670($message; $directory_path; $options)
					
				End if 
				
				$is_ok:=(OK=1)
				
				//………………………………………………………………
			Else 
				
				//NOTHING MORE TO DO
				
				//………………………………………………………………
		End case 
		
		//______________________________________________________
	: ($e.code=On Drag Over:K2:13)
		
		$path:=Get file from pasteboard:C976(1)
		
		If (Test path name:C476($path)=$type)
			
			$RESULT:=0
			
		End if 
		
		//______________________________________________________
	: ($e.code=On Drop:K2:12)
		
		$path:=Get file from pasteboard:C976(1)
		
		$is_ok:=(Test path name:C476($path)=$type)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($e.code)+")")
		
		//______________________________________________________
End case 

If ($is_ok)
	
	OB SET:C1220($widget; \
		"accessPath"; $path)
	$widget_pointer->:=JSON Stringify:C1217($widget)
	
	//update UI
	path_picker_SET_LABEL($widget_pointer)
	
	//return value
	(OBJECT Get pointer:C1124(Object subform container:K67:4))->:=$path
	
End if 