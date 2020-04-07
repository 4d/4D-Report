  // ----------------------------------------------------
  // Object method : NQR_OPTIONS.text.path - (4D Report)
  // Created #9-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_formEvent;$Lon_left;$Lon_right;$Lon_top;$Lon_type)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_;$Txt_me;$Txt_path;$Txt_templateName)

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
		
		  //NOTHING MORE TO DO
		
		  //______________________________________________________
	: ($Lon_formEvent=On Data Change:K2:15)  //set path
		
		$Txt_path:=$Ptr_me->
		
		If (QR_area#0)
			
			  //ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it. 
			$Txt_templateName:=QR Get HTML template:C751(QR_area)
			If (($Txt_templateName="") & Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517))
				$Txt_templateName:=ob_dialog.optionHTMLtemplate
			End if 
			
			QR GET DESTINATION:C756(QR_area;$Lon_type;$Txt_)
			
			If ($Txt_path#$Txt_)
				
				QR SET DESTINATION:C745(QR_area;$Lon_type;$Txt_path)
				QR SET HTML TEMPLATE:C750(QR_area;$Txt_templateName)
				
			End if 
		End if 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		  //resize the widget
		OBJECT GET COORDINATES:C663(*;$Txt_me+".template";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		OBJECT SET COORDINATES:C1248(*;$Txt_me;$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		  //Set offsets of the widget
		subform_SET_OFFSET ($Txt_me;\
			(OBJECT Get pointer:C1124(Object named:K67:5;"left"))->;\
			(OBJECT Get pointer:C1124(Object named:K67:5;"top"))->)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 