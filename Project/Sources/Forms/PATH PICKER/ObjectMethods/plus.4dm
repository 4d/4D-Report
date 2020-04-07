  // ----------------------------------------------------
  // Object method : PATH PICKER.plus
  // ID[B74219C236C449369799F773E0D32B78]
  // Created #9-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_;$Lon_bottom;$Lon_formEvent;$Lon_i;$Lon_left;$Lon_leftOffset)
C_LONGINT:C283($Lon_platform;$Lon_topOffset)
C_POINTER:C301($Ptr_me;$Ptr_widget)
C_TEXT:C284($kTxt_Separator;$Mnu_popup;$Txt_;$Txt_action;$Txt_Buffer;$Txt_me)
C_TEXT:C284($Txt_path)
C_OBJECT:C1216($Obj_widget)

ARRAY TEXT:C222($tTxt_volumes;0)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$Ptr_widget:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_widget")

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Obj_widget:=JSON Parse:C1218($Ptr_widget->)
		
		$Txt_path:=OB Get:C1224($Obj_widget;"accessPath";Is text:K8:3)
		
		Case of 
				
				  //……………………………………………………………………………………………………………………
			: (Application type:C494=4D Remote mode:K5:5)\
				 & ($Lon_platform=Mac OS:K25:2)\
				 & (Position:C15("\\";$Txt_path)>0)
				
				$kTxt_Separator:="\\"
				
				  //……………………………………………………………………………………………………………………
			: (Application type:C494=4D Remote mode:K5:5)\
				 & ($Lon_platform=Windows:K25:3)\
				 & (Position:C15(":";Replace string:C233($Txt_path;":";"";1))>0)
				
				$kTxt_Separator:=":"
				
				  //……………………………………………………………………………………………………………………
			Else 
				
				$kTxt_Separator:=Folder separator:K24:12
				
				  //……………………………………………………………………………………………………………………
		End case 
		
		VOLUME LIST:C471($tTxt_volumes)
		_O_PLATFORM PROPERTIES:C365($Lon_platform)
		
		$Mnu_popup:=Create menu:C408
		
		For ($Lon_i;1;Length:C16($Txt_path);1)
			
			If ($Txt_path[[$Lon_i]]=$kTxt_Separator)
				
				If ($Lon_platform=Windows:K25:3)
					
					APPEND MENU ITEM:C411($Mnu_popup;$Txt_Buffer)
					
				Else 
					
					INSERT MENU ITEM:C412($Mnu_popup;0;$Txt_Buffer)
					
				End if 
				
				  //keep the item path
				SET MENU ITEM PARAMETER:C1004($Mnu_popup;-1;Substring:C12($Txt_path;1;$Lon_i))
				
				  //set item icon
				$Txt_:=Substring:C12($Txt_path;1;$Lon_i-1)
				
				Case of 
						
						  //-------------------------------------------
					: (Find in array:C230($tTxt_volumes;$Txt_)>0)
						
						SET MENU ITEM ICON:C984($Mnu_popup;-1;"#images/widgets/path/drive.png")
						
						  //-------------------------------------------
					: (Test path name:C476($Txt_)=Is a folder:K24:2)
						
						SET MENU ITEM ICON:C984($Mnu_popup;-1;"#images/widgets/path/folder.png")
						
						  //-------------------------------------------
					: (Test path name:C476($Txt_)=Is a document:K24:1)
						
						SET MENU ITEM ICON:C984($Mnu_popup;-1;"#images/widgets/path/file.png")
						
						  //______________________________________________________
				End case 
				
				CLEAR VARIABLE:C89($Txt_Buffer)
				
			Else 
				
				$Txt_Buffer:=$Txt_Buffer+$Txt_path[[$Lon_i]]
				
			End if 
		End for 
		
		If (Length:C16($Txt_Buffer)>0)
			
			If ($Lon_platform=Windows:K25:3)
				
				APPEND MENU ITEM:C411($Mnu_popup;$Txt_Buffer)
				
			Else 
				
				INSERT MENU ITEM:C412($Mnu_popup;0;$Txt_Buffer)
				
			End if 
			
			SET MENU ITEM PARAMETER:C1004($Mnu_popup;-1;$Txt_path)
			SET MENU ITEM ICON:C984($Mnu_popup;-1;"#images/widgets/path/file.png")
			
		End if 
		
		If (Count menu items:C405($Mnu_popup)>0)
			
			If (OB Get:C1224($Obj_widget;"showOnDisk";Is boolean:K8:9))\
				 | (OB Get:C1224($Obj_widget;"copyPath";Is boolean:K8:9))
				
				APPEND MENU ITEM:C411($Mnu_popup;"-")
				
			End if 
			
			If (OB Get:C1224($Obj_widget;"showOnDisk";Is boolean:K8:9))
				
				APPEND MENU ITEM:C411($Mnu_popup;Get localized string:C991("ShowOnDisk"))
				SET MENU ITEM PARAMETER:C1004($Mnu_popup;-1;"show")
				
			End if 
			
			If (OB Get:C1224($Obj_widget;"copyPath";Is boolean:K8:9))
				
				APPEND MENU ITEM:C411($Mnu_popup;Get localized string:C991("CopyPath"))
				SET MENU ITEM PARAMETER:C1004($Mnu_popup;-1;"copy")
				
			End if 
			
			$Lon_leftOffset:=(OBJECT Get pointer:C1124(Object named:K67:5;"left"))->
			$Lon_topOffset:=(OBJECT Get pointer:C1124(Object named:K67:5;"top"))->
			
			If (($Lon_leftOffset+$Lon_topOffset)=0)
				
				$Txt_action:=Dynamic pop up menu:C1006($Mnu_popup)
				
			Else 
				
				OBJECT GET COORDINATES:C663(*;"border";$Lon_left;$Lon_;$Lon_;$Lon_bottom)
				
				$Txt_action:=Dynamic pop up menu:C1006($Mnu_popup;"";$Lon_left+$Lon_leftOffset;$Lon_bottom+$Lon_topOffset-5)
				
			End if 
			
			RELEASE MENU:C978($Mnu_popup)
			
			Case of 
					
					  //………………………
				: (Length:C16($Txt_action)=0)
					
					  //………………………
				: ($Txt_action="copy")
					
					SET TEXT TO PASTEBOARD:C523($Txt_path)
					
					  //………………………
				: ($Txt_action="show")
					
					SHOW ON DISK:C922($Txt_path)
					
					  //………………………
				: (Not:C34(OB Get:C1224($Obj_widget;"openItem";Is boolean:K8:9)))
					
					  //NOTHING MORE TO DO
					
					  //………………………
				Else 
					
					SHOW ON DISK:C922($Txt_action)
					
					  //………………………
			End case 
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 