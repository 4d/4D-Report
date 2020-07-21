// ----------------------------------------------------
// Form method : NQR - (4D Report)
// ID[02F11CFEFC5849D1BE760AC1E5CD509B]
// Created #13-3-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_quickReport)
C_LONGINT:C283($Lon_area;$Lon_formEvent;$Lon_timerEvent)
C_POINTER:C301($Ptr_container;$Ptr_timer)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

$Ptr_timer:=OBJECT Get pointer:C1124(Object named:K67:5;"timerEvent")
$Ptr_container:=OBJECT Get pointer:C1124(Object subform container:K67:4)

If ($Lon_formEvent#On Load:K2:1)
	
	If (OB Is defined:C1231(ob_area))
		
		$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
		
	End if 
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		//#ACI0097809 =========================================================== [
		COMPILER_NQR
		
		// Resize the area to fill the container
		area_ADJUST
		
		//%W-518.7
		//If (Not(Is nil pointer($Ptr_container)))
		//  //#ACI0097373
		//If (Not(Undefined($Ptr_container->)))
		//If (Not(QR_is_valid_area ($Ptr_container->)))
		//  //#ACI0092804 - create an empty zone now
		//  // Reset the value: the zone will be created ASAP
		//  //$Ptr_container->:=0
		//report_CREATE_AREA ($Ptr_container)
		// End if
		// Else
		//report_CREATE_AREA ($Ptr_container)
		// End if
		//  // Store the area reference
		//OB SET(ob_area;"area";$Ptr_container->)
		// End if
		//%W+518.7
		//======================================================================= ]
		
		$Ptr_timer->:=-1  // Init
		SET TIMER:C645(-1)
		
		//______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)  // The area get the focus
		
		//
		
		//______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)  // Area update event
		
		// Store the area reference
		If (QR_is_valid_area($Ptr_container->))
			
			OB SET:C1220(ob_area;\
				"area";$Ptr_container->)
			
		End if 
		
		// STOP REENTRANCY
		If (OB Get:C1224(ob_area;"update";Is boolean:K8:9))
			
			OB SET:C1220(ob_area;\
				"update";False:C215)
			
		Else 
			
			$Ptr_timer->:=Choose:C955($Lon_area=0;-1;1)  // Init or update
			SET TIMER:C645(-1)
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		$Lon_timerEvent:=$Ptr_timer->
		$Ptr_timer->:=0
		
		Case of 
				
				//……………………………………………………………………………………
			: ($Lon_timerEvent=-1)  // Init
				
				//#ACI0097809 =========================================================== [
				
				//  // Test if the reference is valid
				//$Lon_area:=Choose(QR_is_valid_area ($Lon_area);$Lon_area;0)
				//If ($Lon_area=0)
				//report_CREATE_AREA ($Ptr_container)
				//  // Store the area reference
				//OB SET(ob_area;"area";$Ptr_container->)
				// End if
				//$Ptr_timer->:=1
				
				If (Type:C295($Ptr_container->)=Is undefined:K8:13)
					
					_4D THROW ERROR:C1520(New object:C1471(\
						"component";"4DQR";\
						"code";1;\
						"description";Get localized string:C991("ERROR_4DQR_1");\
						"deffered";True:C214))
					
				Else 
					
					// Test if the reference is valid
					$Lon_area:=Choose:C955(QR_is_valid_area($Lon_area);$Lon_area;0)
					
					If ($Lon_area=0)
						
						C_TEXT:C284($Txt_errorHandlingMethod)
						$Txt_errorHandlingMethod:=report_catchErrors("on")
						
						report_CREATE_AREA($Ptr_container)
						
						report_catchErrors("off";$Txt_errorHandlingMethod)
						
						If (ERROR=0)
							
							// Store the area reference
							OB SET:C1220(ob_area;\
								"area";$Ptr_container->)
							
							$Ptr_timer->:=1
							
						End if 
						
					Else 
						
						$Ptr_timer->:=1
						
					End if 
				End if 
				
				//====================================================================== ]
				
				//……………………………………………………………………………………
			: ($Lon_timerEvent=1)  // Update UI
				
				OB SET:C1220(ob_area;\
					"update";True:C214)  // STOP REENTRANCY
				
				
				report_DISPLAY_AREA($Lon_area)
				
				//……………………………………………………………………………………
		End case 
		
		area_ADJUST
		
		If ($Ptr_timer->#0)
			//stop reentrency
			
			SET TIMER:C645(-1)
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		$Boo_quickReport:=OB Get:C1224(ob_area;"4d-dialog";Is boolean:K8:9)  // True if Quick Report
		
		If (Not:C34($Boo_quickReport))
			
			// Delete the offscreen QR area
			If (QR_is_valid_area($Lon_area))
				
				QR DELETE OFFSCREEN AREA:C754($Lon_area)
				
			End if 
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 