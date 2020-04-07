
  // ----------------------------------------------------
  // Object method : NQR.toolbar.opened.save - (4D Report)
  // Created #19-3-2019 by adrien cagniant
  // ----------------------------------------------------


  // Declarations
C_BOOLEAN:C305($boo_saved)
C_TEXT:C284($Mnu_main;$Txt_choice)
C_LONGINT:C283($Lon_formEvent)

  // Initialisations
$Lon_formEvent:=Form event code:C388


If ((Length:C16(C_QR_INITPATH)>0) & (Test path name:C476(C_QR_INITPATH)=Is a document:K24:1))
	  // if there is a saved document associated with the actual opened report
	
	If (($Lon_formEvent=On Alternative Click:K2:36) | ($Lon_formEvent=On Long Click:K2:37))
		
		$Mnu_main:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_main;":xliff:toolbar_save")
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;String:C10(qr list report:K14902:1))
		
		APPEND MENU ITEM:C411($Mnu_main;":xliff:toolbar_saveAs")
		SET MENU ITEM PARAMETER:C1004($Mnu_main;-1;String:C10(qr cross report:K14902:2))
		
		$Txt_choice:=Dynamic pop up menu:C1006($Mnu_main)
		RELEASE MENU:C978($Mnu_main)
		
		
		If ((Length:C16($Txt_choice)#0))
			Case of 
				: ($Txt_choice="1")
					
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517;QR_area;qr cmd save:K14900:20)
						
					Else 
						
						$boo_saved:=NQR_Save 
						
					End if 
					
				: ($Txt_choice="2")
					If (C_QR_ONCOMMANDFORMULA#Null:C1517)
						
						C_QR_ONCOMMANDFORMULA.call(Null:C1517;QR_area;qr cmd save as:K14900:21)
						
					Else 
						
						$boo_saved:=NQR_SaveAs 
						
					End if 
					
			End case 
			
			
		End if 
		
	Else 
		  // click normal 
		If (C_QR_ONCOMMANDFORMULA#Null:C1517)
			
			C_QR_ONCOMMANDFORMULA.call(Null:C1517;QR_area;qr cmd save:K14900:20)
			
		Else 
			
			$boo_saved:=NQR_Save 
			
		End if 
		
	End if 
	
Else 
	  // there is no document 
	If (C_QR_ONCOMMANDFORMULA#Null:C1517)
		
		C_QR_ONCOMMANDFORMULA.call(Null:C1517;QR_area;qr cmd save:K14900:20)
		
	Else 
		
		$boo_saved:=NQR_Save 
		
	End if 
	
End if 



  // done inside the methods NQR_Save and NQR_SaveAs for #102041 feature
  //If (Not($boo_saved))
  //  //ALERT("an error occured")
  //Else 
  //ob_area.modified:=False
  //End if 
