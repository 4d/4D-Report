// ----------------------------------------------------
// Form method : NQR - (4D Report)
// ID[02F11CFEFC5849D1BE760AC1E5CD509B]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations

var \
$area; \
$timer_event : Integer

var \
$digest; \
$error_method : Text

var \
$available : Boolean

var \
$ui_subform_pointer : Pointer

var \
$blob : Blob

var \
$form_event : Object

// ----------------------------------------------------
// Initialisations
$form_event:=FORM Event:C1606
$ui_subform_pointer:=OBJECT Get pointer:C1124(Object subform container:K67:4)

If ($form_event.code#On Load:K2:1)
	
	If (OB Is defined:C1231(ob_area))
		
		$area:=Num:C11(ob_area.area)
		
	End if 
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($form_event.code=On Load:K2:1)
		
		COMPILER_NQR
		
		// Resize the area to fill the container
		area_ADJUST
		
		Form:C1466.timerEvent:=-1  // Init
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($form_event.code=On Activate:K2:9)  // The area get the focus
		
		//
		
		//______________________________________________________
	: ($form_event.code=On Bound Variable Change:K2:52)  // Area update event
		
		$available:=QR_is_valid_area($ui_subform_pointer->)
		
		If ($available)
			
			// Store the area reference
			ob_area.area:=$ui_subform_pointer->
			
		End if 
		
		If (Bool:C1537(ob_area.update))
			
			ob_area.update:=False:C215  // STOP
			SET TIMER:C645(0)
			
		Else 
			
			If ($available)
				
				$error_method:=report_catchErrors("on")
				QR REPORT TO BLOB:C770($ui_subform_pointer->; $blob)
				report_catchErrors("off"; $error_method)
				
				If (ERROR=0)
					
					$digest:=Generate digest:C1147($blob; MD5 digest:K66:1)
					
					If (String:C10(ob_area._digest)#$digest)
						
						ob_area._digest:=$digest
						
						Form:C1466.timerEvent:=($area=0) ? -1 : 1  // Init or update
						SET TIMER:C645(-1)
						
					End if 
				End if 
				
			Else 
				
				Form:C1466.timerEvent:=($area=0) ? -1 : 1  // Init or update
				SET TIMER:C645(-1)
				
			End if 
			
		End if 
		
		//______________________________________________________
	: ($form_event.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$timer_event:=Form:C1466.timerEvent
		Form:C1466.timerEvent:=0
		
		Case of 
				
				//……………………………………………………………………………………
			: ($timer_event=-1)  // Init
				
				If (Type:C295($ui_subform_pointer->)=Is undefined:K8:13)
					
					_4D THROW ERROR:C1520(New object:C1471(\
						"component"; "4DQR"; \
						"code"; 1; \
						"description"; Get localized string:C991("ERROR_4DQR_1"); \
						"deffered"; True:C214))
					
				Else 
					
					// Test if the reference is valid
					$area:=Choose:C955(QR_is_valid_area($area); $area; 0)
					
					If ($area=0)
						
						$error_method:=report_catchErrors("on")
						report_CREATE_AREA($ui_subform_pointer)
						report_catchErrors("off"; $error_method)
						
						If (ERROR=0)
							
							// Store the area reference
							ob_area.area:=$ui_subform_pointer->
							Form:C1466.timerEvent:=1
							
						End if 
						
					Else 
						
						Form:C1466.timerEvent:=1
						
					End if 
				End if 
				
				//……………………………………………………………………………………
			: ($timer_event=1)  // Update UI
				
				ob_area.update:=True:C214
				report_DISPLAY_AREA($area)
				
				//……………………………………………………………………………………
		End case 
		
		If (Form:C1466.timerEvent#0)
			
			SET TIMER:C645(-1)
			
		End if 
		
		area_ADJUST
		
		//______________________________________________________
	: ($form_event.code=On Unload:K2:2)
		
		If (Not:C34(Bool:C1537(ob_area["4d-dialog"])))  // True if embedded in a form in the host database
			
			If (QR_is_valid_area($area))
				
				// Delete the offscreen QR area
				QR DELETE OFFSCREEN AREA:C754($area)
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+$form_event.description+")")
		
		//______________________________________________________
End case 