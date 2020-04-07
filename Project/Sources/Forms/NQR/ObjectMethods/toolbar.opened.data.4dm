  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.data - (4D Report)
  // ID[641F835D88F448328760E7EF06EDC65A]
  // Created #16-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_Display)
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_left;$Lon_right;$Lon_top;$Lon_width)
C_TEXT:C284($Txt_buffer;$Txt_me;$Txt_src)
C_OBJECT:C1216($Obj_message)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=-1)  //clear
		
		$Txt_src:="clear"
		
		OB SET:C1220($Obj_message;\
			"src";$Txt_src)
		
		  //#redmine:25071 Add a confirm dialog when the user click on "Clear" button
		  //not only when assiocated with a document {
		  //If (Length(C_QR_INITPATH)>0)
		  //$Boo_Display:=mess_Preferences ($Txt_src)
		  //End if
		  //If ($Boo_Display)
		If (mess_Preferences ($Txt_src))
			  //}
			
			OB SET:C1220(ob_area;\
				"message";True:C214)
			
			OB SET:C1220($Obj_message;\
				"message";Get localized string:C991("areYouSure");\
				"doLabel";Get localized string:C991("toolbar_clear");\
				"cancelLabel";Get localized string:C991("cancel");\
				"checkbox";True:C214)
			
			mess_DISPLAY ($Obj_message)
			
		Else 
			
			OB SET:C1220($Obj_message;\
				"action";"ok")
			
			NQR_DO_IT ($Obj_message)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=-2)  //reload
		
		$Txt_src:="reload"
		
		OB SET:C1220($Obj_message;\
			"src";$Txt_src)
		
		If (OB Get:C1224(ob_area;"modified";Is boolean:K8:9))
			
			$Boo_Display:=mess_Preferences ($Txt_src)
			
		End if 
		
		If ($Boo_Display)
			
			OB SET:C1220(ob_area;\
				"message";True:C214)
			
			  //$Txt_buffer:=" \""+doc_getFromPath ("shortName";C_QR_INITPATH)+"\""
			$Txt_buffer:=" \""+Path to object:C1547(C_QR_INITPATH).name+"\""
			
			OB SET:C1220($Obj_message;\
				"message";Get localized string:C991("areYouSure");\
				"comment";Replace string:C233(Get localized string:C991("youWillLoseChangesMadeToThisDocument");"{document}";$Txt_buffer);\
				"doLabel";Get localized string:C991("toolbar_reload");\
				"cancelLabel";Get localized string:C991("cancel");\
				"checkbox";True:C214)
			
			mess_DISPLAY ($Obj_message)
			
		Else 
			
			OB SET:C1220($Obj_message;\
				"action";"ok")
			
			NQR_DO_IT ($Obj_message)
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent<0)  //set coordinates
		
		$Lon_width:=Abs:C99($Lon_formEvent)
		
		OBJECT GET COORDINATES:C663(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;$Txt_me;$Lon_left;$Lon_top;$Lon_left+$Lon_width;$Lon_bottom)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 