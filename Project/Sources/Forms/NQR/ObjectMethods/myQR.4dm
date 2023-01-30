// ----------------------------------------------------
// Object method : NQR.myQR - (4D Report)
// ID[11541FF9865245B0A26374CDB762F3EA]
// Created #2-6-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var \
$event_code : Integer

//var \
$name : Text

//var \
$self : Pointer



// ----------------------------------------------------
// Initialisations
$event_code:=Form event code:C388
//$name:=OBJECT Get name(Object current)
//$self:=OBJECT Get pointer(Object current)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($event_code=-1)  //Call from the widget
		
		
		If (ob_dialog=Null:C1517)
			
			ob_dialog:=New object:C1471
			
		End if 
		
		If ((OB Is defined:C1231(ob_dialog)) & (Undefined:C82(ob_dialog.action)))
			
			ob_dialog.action:="update"
			
		End if 
		
		NQR_AREA_HANDLE(ob_dialog)  // probleme de réentrance et de positionnement
		
		NQR_TOOLBAR("update")
		
		NQR_AREA_HANDLE(New object:C1471("action"; "update"))
		
		//______________________________________________________
	: ($event_code=On Load:K2:1)
		
		//The widget is executed into a 4D dialog
		OB SET:C1220(ob_area; \
			"4d-dialog"; True:C214)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($event_code)+")")
		
		//______________________________________________________
End case 