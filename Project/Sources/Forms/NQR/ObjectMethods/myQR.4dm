// ----------------------------------------------------
// Object method : NQR.myQR - (4D Report)
// ID[11541FF9865245B0A26374CDB762F3EA]
// Created #2-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=-1)  //Call from the widget
		
		
		If (ob_dialog=Null:C1517)
			ob_dialog:=New object:C1471
		End if 
		
		If ((OB Is defined:C1231(ob_dialog)) & (Undefined:C82(ob_dialog.action)))
			
			ob_dialog.action:="update"
			
		End if 
		
		NQR_AREA_HANDLE(ob_dialog)  // probleme de réentrance et de positionnement
		
		NQR_TOOLBAR("update")
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		//The widget is executed into a 4D dialog
		OB SET:C1220(ob_area; \
			"4d-dialog"; True:C214)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 