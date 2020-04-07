  // ----------------------------------------------------
  // Object method : SETTINGS.report.list - (4D Report)
  // ID[D4A262C5A7814835844B44337CA619C1]
  // Created #4-12-2015 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($0)

C_LONGINT:C283($Lon_formEvent;$Lon_process;$Lon_source)
C_POINTER:C301($Ptr_me;$Ptr_source)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$0:=-1

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		Obj_BOUND_WITH_LIST (New list:C375)
		
		  //________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		NQR_SETTING_HANDLER ("update")
		
		  //______________________________________________________
	: ($Lon_formEvent=On Begin Drag Over:K2:44)
		
		  //internal D&D is only possible if there is at least two lines
		If (Count list items:C380($Ptr_me->)>1)
			
			  //create the drag icon
			list_SET_DRAG_ICON ($Ptr_me)
			
			$0:=0  //accept drop
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drag Over:K2:13)
		
		_O_DRAG AND DROP PROPERTIES:C607($Ptr_source;$Lon_source;$Lon_process)
		
		If ($Lon_process=Current process:C322)\
			 & ($Lon_source#-1)\
			 & ($Ptr_source=$Ptr_me)
			
			$0:=0  //accept drop
			
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Drop:K2:12)
		
		NQR_SETTING_HANDLER ("move")
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		CLEAR LIST:C377($Ptr_me->;*)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessarily ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 