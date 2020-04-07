  // ----------------------------------------------------
  // Form method : BALLOON_SUBTOTALLINE - (4D Report)
  //  // Created #28-03-2019 by Adrien cagniant
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_formEvent;$Lon_column;$Lon_row;$Lon_area)
C_OBJECT:C1216($Obj_param;$Obj_caller;$obj_buffer)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
SET TIMER:C645(0)

  // ----------------------------------------------------

Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"caller"))->:="{}"
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		  //triggered for the font picker
		
		  //______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		OB SET:C1220($Obj_param;\
			"action";"update";\
			"form";Current method name:C684)
		
		report_BALLOON_HDL ($Obj_param)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 

  //Always return to the variable that allow to use the Fonts dialog to keep the sync
  //GOTO OBJECT(*;"font.picker")