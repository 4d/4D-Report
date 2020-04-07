//%attributes = {}
  // ----------------------------------------------------
  // Project method: 00_OPEN_WIZARD
  // Database: 4D Report
  // ID[8D22AA9932B64DCFB8B952D48F2E6F82]
  // Created #28-6-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  //
  // ----------------------------------------------------
  // Declarations
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters;$Win_hdl)
C_TEXT:C284($Mnu_bar;$Mnu_edit;$Txt_entryPoint;$Txt_methodName)

If (False:C215)
	C_TEXT:C284(00_OPEN_WIZARD ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If ($Lon_parameters>=1)
	
	$Txt_entryPoint:=$1
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //___________________________________________________________
	: (Length:C16($Txt_entryPoint)=0)
		
		$Txt_methodName:=Current method name:C684
		
		Case of 
				
				  //……………………………………………………………………
			: (Method called on error:C704=$Txt_methodName)
				
				  //Error handling manager
				
				  //……………………………………………………………………
				  //: (Method called on event=$Txt_methodName)
				
				  //Event manager - disabled for a component method
				
				  //……………………………………………………………………
			Else 
				
				  //This method must be executed in a unique new process
				BRING TO FRONT:C326(New process:C317($Txt_methodName;0;"$"+$Txt_methodName;"_run";*))
				
				  //……………………………………………………………………
		End case 
		
		  //___________________________________________________________
	: ($Txt_entryPoint="_run")
		
		
		  //First launch of this method executed in a new process
		00_OPEN_WIZARD ("_declarations")
		00_OPEN_WIZARD ("_init")
		
		$Win_hdl:=Open form window:C675("NQR";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)  //;*)
		DIALOG:C40("NQR")
		CLOSE WINDOW:C154
		
		00_OPEN_WIZARD ("_deinit")
		
		  //___________________________________________________________
	: ($Txt_entryPoint="_declarations")
		
		  //___________________________________________________________
	: ($Txt_entryPoint="_init")
		
		$Mnu_bar:=Create menu:C408
		$Mnu_edit:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemUndo"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Undo action:K59:16)
		SET MENU ITEM SHORTCUT:C423($Mnu_edit;-1;"Z";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuRedo"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Redo action:K59:17)
		SET MENU ITEM SHORTCUT:C423($Mnu_edit;-1;"Z";Shift key mask:K16:3)
		
		APPEND MENU ITEM:C411($Mnu_edit;"-")
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemCut"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Cut action:K59:18)
		SET MENU ITEM SHORTCUT:C423($Mnu_edit;-1;"X";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemCopy"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Copy action:K59:19)
		SET MENU ITEM SHORTCUT:C423($Mnu_edit;-1;"C";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemPaste"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Paste action:K59:20)
		SET MENU ITEM SHORTCUT:C423($Mnu_edit;-1;"V";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemClear"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Clear action:K59:21)
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemSelectAll"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Select all action:K59:22)
		SET MENU ITEM SHORTCUT:C423($Mnu_edit;-1;"A";Command key mask:K16:1)
		
		APPEND MENU ITEM:C411($Mnu_edit;"(-")
		
		APPEND MENU ITEM:C411($Mnu_edit;Get localized string:C991("CommonMenuItemShowClipboard"))
		SET MENU ITEM PROPERTY:C973($Mnu_edit;-1;Associated standard action:K28:8;_o_Show clipboard action:K59:23)
		
		APPEND MENU ITEM:C411($Mnu_bar;Get localized string:C991("CommonMenuEdit");$Mnu_edit)
		RELEASE MENU:C978($Mnu_edit)
		
		SET MENU BAR:C67($Mnu_bar)
		
		  //___________________________________________________________
	: ($Txt_entryPoint="_deinit")
		
		RELEASE MENU:C978(Get menu bar reference:C979)
		
		  //___________________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Unknown entry point ("+$Txt_entryPoint+")")
		
		  //___________________________________________________________
End case 