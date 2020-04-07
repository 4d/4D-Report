//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : CONTROL_Form_hdl
  // Database: sandbox_14
  // ID[2A84591689E1459E89A92122D807C6F7]
  // Created #12-2-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_LONGINT:C283($Lon_formEvent;$Lon_parameters)
C_PICTURE:C286($Pic_buffer)

If (False:C215)
	C_LONGINT:C283(CONTROL_Form_hdl ;$0)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	$Lon_formEvent:=Form event code:C388
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_CONTROL 
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		If (Structure file:C489=Structure file:C489(*))\
			 & (Shift down:C543)
			
			  //Create a poster for the widget
			FORM SCREENSHOT:C940($Pic_buffer)
			SET PICTURE TO PASTEBOARD:C521($Pic_buffer)
			
		End if 
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		CONTROL_Area_hdl 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

$0:=$Lon_formEvent

  // ----------------------------------------------------
  // End