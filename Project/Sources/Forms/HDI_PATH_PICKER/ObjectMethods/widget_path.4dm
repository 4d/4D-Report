  // ----------------------------------------------------
  // Object method : HDI_PATH_PICKER.widget_path
  // ID[5AC07F61D04D4C29A136AA0B224F1384]
  // Created #9-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_left;$Lon_right;$Lon_top)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent<0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)
		
		  //update UI
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		  //Resize the widget
		OBJECT GET COORDINATES:C663(*;$Txt_me+".template";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		  //Offsets of the widget
		subform_SET_OFFSET ($Txt_me)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 