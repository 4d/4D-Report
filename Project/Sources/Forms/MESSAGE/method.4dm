// ----------------------------------------------------
// Form method : MESSAGE - (4D Report)
// ID[B1C4CB6F3D144B1AA6C7AFFA8BF75597]
// Created #4-12-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_; $Lon_bottom; $Lon_formEvent; $Lon_height; $Lon_left; $Lon_right)
C_LONGINT:C283($Lon_top; $Lon_width)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		// Adjust UI
		Obj_BEST_WIDTH(Align left:K42:2; "checkbox")
		
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		//______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)  // Update UI
		
		// Message
		(OBJECT Get pointer:C1124(Object named:K67:5; "text"))->:=Form:C1466.message
		
		// Comment {
		(OBJECT Get pointer:C1124(Object named:K67:5; "additional"))->:=Form:C1466.comment
		
		// Adjust UI
		OBJECT GET COORDINATES:C663(*; "text"; $Lon_left; $Lon_top; $Lon_right; $Lon_bottom)
		OBJECT GET BEST SIZE:C717(*; "text"; $Lon_width; $Lon_height; $Lon_right-$Lon_left)
		OBJECT SET COORDINATES:C1248(*; "text"; $Lon_left; $Lon_top; $Lon_right; $Lon_top+$Lon_height)
		
		$Lon_top:=$Lon_top+$Lon_height+10
		OBJECT GET COORDINATES:C663(*; "additional"; $Lon_left; $Lon_; $Lon_right; $Lon_)
		OBJECT GET BEST SIZE:C717(*; "additional"; $Lon_width; $Lon_height; $Lon_right-$Lon_left)
		OBJECT SET COORDINATES:C1248(*; "additional"; $Lon_left; $Lon_top; $Lon_right; $Lon_top+$Lon_height)
		//}
		
		// OK button's label
		If (Form:C1466.doLabel#Null:C1517)
			
			OBJECT SET TITLE:C194(*; "OK"; Form:C1466.doLabel)
			
		End if 
		
		// Adjust UI
		Obj_BEST_WIDTH(Align right:K42:4; "ok")
		
		// Cancel button's label
		If (Form:C1466.cancelLabel#Null:C1517)
			
			OBJECT SET TITLE:C194(*; "cancel"; Form:C1466.cancelLabel)
			OBJECT SET VISIBLE:C603(*; "cancel"; True:C214)
			
			// Adjust UI
			Obj_BEST_WIDTH(Align left:K42:2; "cancel")
			Obj_ALIGN(Align right:K42:4; 20; "ok"; "cancel")
			
		Else 
			
			OBJECT SET VISIBLE:C603(*; "cancel"; False:C215)
			
		End if 
		
		// Forget button's label {
		If (Form:C1466.forgetLabel#Null:C1517)
			
			OBJECT SET TITLE:C194(*; "forget"; Form:C1466.forgetLabel)
			OBJECT SET VISIBLE:C603(*; "forget"; True:C214)
			//%W-533.1
			OBJECT SET SHORTCUT:C1185(*; "forget"; Form:C1466.forgetLabel[[1]])
			//%W+533.1
			
			// Adjust UI
			Obj_BEST_WIDTH(Align left:K42:2; "forget")
			
		Else 
			
			OBJECT SET VISIBLE:C603(*; "forget"; False:C215)
			
		End if 
		//}
		
		// Checkbox "Do not ask again" {
		(OBJECT Get pointer:C1124(Object named:K67:5; "checkbox"))->:=0
		
		If (Bool:C1537(Form:C1466.checkbox))
			
			OBJECT SET VISIBLE:C603(*; "checkbox"; True:C214)
			
			// Set title
			
			If (Length:C16(String:C10(Form:C1466.checkboxLabel))#0)
				
				OBJECT SET TITLE:C194(*; "checkbox"; Form:C1466.checkboxLabel)
				
			Else 
				
				OBJECT SET TITLE:C194(*; "checkbox"; Get localized string:C991("doNotAskAgain"))
				
			End if 
			
			// Adjust UI
			Obj_BEST_WIDTH(Align left:K42:2; "checkbox")
			
		Else 
			
			OBJECT SET VISIBLE:C603(*; "checkbox"; False:C215)
			
		End if 
		//}
		
		// Reset interchange values
		Form:C1466.action:=""
		
		OB REMOVE:C1226(Form:C1466; "checkbox")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 