  // ----------------------------------------------------
  // Object method : PATH PICKER.browse
  // ID[FBCDFA41F1B94F72901526D840F4C608]
  // Created #10-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_directory;$Lon_formEvent;$Lon_options;$Lon_type)
C_POINTER:C301($Ptr_me;$Ptr_widget)
C_TEXT:C284($Txt_directory;$Txt_fileTypes;$Txt_me;$Txt_message;$Txt_path)
C_OBJECT:C1216($Obj_widget)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$Ptr_widget:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_widget")
$Obj_widget:=JSON Parse:C1218($Ptr_widget->)

$Lon_type:=OB Get:C1224($Obj_widget;"type";Is longint:K8:6)

$0:=-1

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Txt_message:=OB Get:C1224($Obj_widget;"message";Is text:K8:3)
		$Txt_directory:=OB Get:C1224($Obj_widget;"directory";Is text:K8:3)
		$Lon_options:=OB Get:C1224($Obj_widget;"options";Is longint:K8:6)
		
		$Lon_directory:=Num:C11($Txt_directory)
		
		Case of 
				
				  //………………………………………………………………
			: ($Lon_type=Is a document:K24:1)
				
				$Txt_fileTypes:=OB Get:C1224($Obj_widget;"fileTypes";Is text:K8:3)
				
				If (String:C10($Lon_directory)=$Txt_directory)
					
					  //use a memorized access path
					$Txt_path:=Select document:C905($Lon_directory;$Txt_fileTypes;$Txt_message;$Lon_options)
					
				Else 
					
					$Txt_path:=Select document:C905($Txt_directory;$Txt_fileTypes;$Txt_message;$Lon_options)
					
				End if 
				
				$Boo_OK:=(OK=1)
				
				If ($Boo_OK)
					
					$Txt_path:=DOCUMENT
					
				End if 
				
				  //………………………………………………………………
			: ($Lon_type=Is a folder:K24:2)
				
				If (String:C10($Lon_directory)=$Txt_directory)
					
					  //use a memorized access path
					$Txt_path:=Select folder:C670($Txt_message;$Lon_directory;$Lon_options)
					
				Else 
					
					$Txt_path:=Select folder:C670($Txt_message;$Txt_directory;$Lon_options)
					
				End if 
				
				$Boo_OK:=(OK=1)
				
				  //………………………………………………………………
			Else 
				
				  //NOTHING MORE TO DO
				
				  //………………………………………………………………
		End case 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		$Txt_path:=Get file from pasteboard:C976(1)
		
		If (Test path name:C476($Txt_path)=$Lon_type)
			
			$0:=0
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drop:K2:12)
		
		$Txt_path:=Get file from pasteboard:C976(1)
		
		$Boo_OK:=(Test path name:C476($Txt_path)=$Lon_type)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

If ($Boo_OK)
	
	OB SET:C1220($Obj_widget;\
		"accessPath";$Txt_path)
	$Ptr_widget->:=JSON Stringify:C1217($Obj_widget)
	
	  //update UI
	path_picker_SET_LABEL ($Ptr_widget)
	
	  //return value
	(OBJECT Get pointer:C1124(Object subform container:K67:4))->:=$Txt_path
	
End if 