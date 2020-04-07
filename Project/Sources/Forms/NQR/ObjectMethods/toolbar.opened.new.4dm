  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.new - (4D Report)
  // ID[D99287D390914BD9ACC0501C0367A2AB]
  // Created #4-7-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Mnu_main;$Txt_choice;$Txt_me)
C_OBJECT:C1216($Obj_message)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Obj_message:=New object:C1471(\
			"src";"new")
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main;":xliff:toolbar_list")
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;String:C10(qr list report:K14902:1))
		
		APPEND MENU ITEM:C411($Mnu_main;":xliff:toolbar_crossTable")
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;String:C10(qr cross report:K14902:2))
		
		$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		If ((Length:C16($Txt_choice)#0))
			
			$Obj_message.type:=Num:C11($Txt_choice)
			
			  // Save current report if any change have been done. 
			If (Bool:C1537(ob_area.modified))
				
				ob_area.message:=True:C214
				
				If (Length:C16(C_QR_INITPATH)>0)
					
					$Obj_message.checkbox:=True:C214  // Display checkbox
					$Obj_message.checkboxLabel:=Get localized string:C991("SaveInNewDocument")
					
					$Obj_message.message:=Get localized string:C991("DoYouWantToSaveChangesInThisDocument")
					
				Else 
					
					$Obj_message.checkbox:=False:C215
					
					$Obj_message.message:=Get localized string:C991("doYouWantToSaveChanges")
					
				End if 
				
				$Obj_message.doLabel:=Get localized string:C991("save")
				$Obj_message.cancelLabel:=Get localized string:C991("cancel")
				$Obj_message.forgetLabel:=Get localized string:C991("doNotSave")
				
				mess_DISPLAY ($Obj_message)
				
			Else 
				
				  //#ACI0092840
				  //OB SET($Obj_message;"action";"ok")
				$Obj_message.action:="forget"
				
				NQR_DO_IT ($Obj_message)
				
			End if 
		End if 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 


