  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.open - (4D Report)
  // ID[5399A7D88C724554A9E70B999CB7883F]
  // Created #28-6-2016 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_BOOLEAN:C305($Boo_run)
C_LONGINT:C283($Lon_formEvent;$Lon_i)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Dir_report;$Mnu_main;$Txt_choice;$Txt_me)
C_OBJECT:C1216($Obj_message)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$Obj_message:=New object:C1471("src";"open")


If ($Lon_formEvent=On Alternative Click:K2:36) | ($Lon_formEvent=On Long Click:K2:37)
	
	$Dir_report:=Get 4D folder:C485(Current resources folder:K5:16;*)+"reports"+Folder separator:K24:12
	
	$Mnu_main:=Create menu:C408
	
	If (Test path name:C476($Dir_report)=Is a folder:K24:2)
		
		ARRAY TEXT:C222($tTxt_files;0x0000)
		DOCUMENT LIST:C474($Dir_report;$tTxt_files;Ignore invisible:K24:16)
		
		For ($Lon_i;1;Size of array:C274($tTxt_files);1)
			
			If ($tTxt_files{$Lon_i}="@.4qr")
				
				APPEND MENU ITEM:C411($Mnu_main;$tTxt_files{$Lon_i})
				SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;$Dir_report+$tTxt_files{$Lon_i})
				
			End if 
		End for 
		
		$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		$Boo_run:=(Length:C16($Txt_choice)#0)
		
		If ($Boo_run)
			
			  // Keep the chosen file
			$Obj_message.target:=$Txt_choice
			
			  // Mark as a template
			$Obj_message.template:=True:C214
			
		End if 
	End if 
	
Else 
	
	$Boo_run:=True:C214
	
End if 

If ($Boo_run)
	
	  // Save current report if any
	If (Bool:C1537(ob_area.modified))
		
		ob_area.message:=True:C214
		
		If (Length:C16(C_QR_INITPATH)>0)
			
			$Obj_message.message:=Get localized string:C991("DoYouWantToSaveChangesInThisDocument")
			
			$Obj_message.checkbox:=True:C214
			$Obj_message.checkboxLabel:=Get localized string:C991("SaveInNewDocument")
			
		Else 
			
			$Obj_message.message:=Get localized string:C991("doYouWantToSaveChanges")
			$Obj_message.checkbox:=False:C215
			
		End if 
		
		$Obj_message.cancelLabel:=Get localized string:C991("cancel")
		$Obj_message.doLabel:=Get localized string:C991("save")
		$Obj_message.forgetLabel:=Get localized string:C991("doNotSave")
		
		mess_DISPLAY ($Obj_message)
		
	Else 
		
		$Obj_message.action:="none"
		
		NQR_DO_IT ($Obj_message)
		
	End if 
End if 

