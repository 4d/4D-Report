//%attributes = {}
// ----------------------------------------------------
// Project method: HDI_PATH_PICKER
// ID[B9E4C0C8755B4287980CF03451A7C3F2]
// Created #9-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Description
//
// ----------------------------------------------------
// Declarations
#DECLARE($entry_point : Text)

var $count_parameters; $window_reference : Integer
var $menu_bar; $menu_edit; $method_name : Text


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If ($count_parameters>=1)
	
	//$entry_point:=$1
	
End if 

// ----------------------------------------------------
Case of 
		
		//___________________________________________________________
	: (Length:C16($entry_point)=0)
		
		$method_name:=Current method name:C684
		
		Case of 
				
				//……………………………………………………………………
			: (Method called on error:C704=$method_name)
				
				//Error handling manager
				
				//……………………………………………………………………
				//: (Method called on event=$Txt_methodName)
				
				//Event manager - disabled for a component method
				
				//……………………………………………………………………
			Else 
				
				//This method must be executed in a unique new process
				BRING TO FRONT:C326(New process:C317($method_name; 24*1024; "$"+$method_name; "_run"; *))
				
				//……………………………………………………………………
		End case 
		
		//___________________________________________________________
	: ($entry_point="_run")
		
		//First launch of this method executed in a new process
		HDI_PATH_PICKER("_declarations")
		HDI_PATH_PICKER("_init")
		
		$window_reference:=Open form window:C675("HDI_PATH_PICKER"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("HDI_PATH_PICKER")
		CLOSE WINDOW:C154
		
		HDI_PATH_PICKER("_deinit")
		
		//___________________________________________________________
	: ($entry_point="_declarations")
		
		//___________________________________________________________
	: ($entry_point="_init")
		
		$menu_bar:=Create menu:C408
		$menu_edit:=Create menu:C408
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemUndo"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Undo action:K59:16)
		SET MENU ITEM SHORTCUT:C423($menu_edit; -1; "Z"; Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuRedo"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Redo action:K59:17)
		SET MENU ITEM SHORTCUT:C423($menu_edit; -1; "Z"; Shift key mask:K16:3)
		
		APPEND MENU ITEM:C411($menu_edit; "-")
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemCut"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Cut action:K59:18)
		SET MENU ITEM SHORTCUT:C423($menu_edit; -1; "X"; Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemCopy"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Copy action:K59:19)
		SET MENU ITEM SHORTCUT:C423($menu_edit; -1; "C"; Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemPaste"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Paste action:K59:20)
		SET MENU ITEM SHORTCUT:C423($menu_edit; -1; "V"; Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemClear"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Clear action:K59:21)
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemSelectAll"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Select all action:K59:22)
		SET MENU ITEM SHORTCUT:C423($menu_edit; -1; "A"; Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($menu_edit; "(-")
		
		APPEND MENU ITEM:C411($menu_edit; Localized string:C991("CommonMenuItemShowClipboard"))
		SET MENU ITEM PROPERTY:C973($menu_edit; -1; Associated standard action:K56:1; _o_Show clipboard action:K59:23)
		
		APPEND MENU ITEM:C411($menu_bar; Localized string:C991("CommonMenuEdit"); $menu_edit)
		RELEASE MENU:C978($menu_edit)
		
		SET MENU BAR:C67($menu_bar)
		
		//___________________________________________________________
	: ($entry_point="_deinit")
		
		RELEASE MENU:C978(Get menu bar reference:C979)
		
		//___________________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unknown entry point ("+$entry_point+")")
		
		//___________________________________________________________
End case 