  // ----------------------------------------------------
  // Form method : NQR_DESTINATION - (4D Report)
  // ID[5554ADED683245A7B906095DA252B307]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_bottom;$Lon_event;$Lon_formEvent;$Lon_height;$Lon_left;$Lon_page;$Lon_right;$Lon_top)
C_LONGINT:C283($Lon_width;$Lon_width_2)
C_POINTER:C301($Ptr_subformContainer)
C_TEXT:C284($Txt_object)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		COMPILER_NQR 
		
		OBJECT SET TITLE:C194(*;"title";Get localized string:C991("toolbar_header"))
		OBJECT GET BEST SIZE:C717(*;"title";$Lon_width;$Lon_height)
		
		OBJECT SET TITLE:C194(*;"title";Get localized string:C991("toolbar_footer"))
		OBJECT GET BEST SIZE:C717(*;"title";$Lon_width_2;$Lon_height)
		
		$Lon_width:=Choose:C955($Lon_width_2>$Lon_width;$Lon_width_2;$Lon_width)
		$Lon_width:=$Lon_width+40
		
		OBJECT GET COORDINATES:C663(*;"title";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		$Lon_right:=$Lon_left+$Lon_width
		OBJECT SET COORDINATES:C1248(*;"title";$Lon_left;$Lon_top;$Lon_right;$Lon_bottom)
		
		NQR_DRAW_TABS (\
			Get localized string:C991("tab_content");\
			Get localized string:C991("tab_settings"))
		
		  //default values
		(OBJECT Get pointer:C1124(Object named:K67:5;"height"))->:=25
		(OBJECT Get pointer:C1124(Object named:K67:5;"height.unit"))->:=1
		(OBJECT Get pointer:C1124(Object named:K67:5;"height.points"))->:=25
		(OBJECT Get pointer:C1124(Object named:K67:5;"alignment"))->:=1
		
		SET TIMER:C645(-1)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		SET TIMER:C645(0)
		
		  //______________________________________________________
	: ($Lon_formEvent=On Activate:K2:9)
		
		$Lon_page:=FORM Get current page:C276(*)
		
		Case of 
				
				  //………………………………………………………………
			: ($Lon_page=1)
				
				$Txt_object:=(OBJECT Get pointer:C1124(Object named:K67:5;"current_1"))->
				GOTO OBJECT:C206(*;Choose:C955(Length:C16($Txt_object)=0;"box.left";$Txt_object))
				
				  //………………………………………………………………
			: ($Lon_page=2)
				
				$Txt_object:=(OBJECT Get pointer:C1124(Object named:K67:5;"current_2"))->
				GOTO OBJECT:C206(*;Choose:C955(Length:C16($Txt_object)=0;"height";$Txt_object))
				
				  //………………………………………………………………
		End case 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Page Change:K2:54)
		
		$Lon_page:=FORM Get current page:C276(*)
		
		Case of 
				
				  //………………………………………………………………
			: ($Lon_page=1)
				
				$Txt_object:=(OBJECT Get pointer:C1124(Object named:K67:5;"current_1"))->
				GOTO OBJECT:C206(*;Choose:C955(Length:C16($Txt_object)=0;"box.left";$Txt_object))
				
				NQR_HEADER_AND_FOOTER_ON_RESIZE 
				
				  //………………………………………………………………
			: ($Lon_page=2)
				
				$Txt_object:=(OBJECT Get pointer:C1124(Object named:K67:5;"current_2"))->
				GOTO OBJECT:C206(*;Choose:C955(Length:C16($Txt_object)=0;"height";$Txt_object))
				
				  //………………………………………………………………
		End case 
		
		  //  //______________________________________________________
		  //: ($Lon_formEvent=On Data Change)
		
		  //NQR_SET_HEADER_AND_FOOTER 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Deactivate:K2:10)
		
		NQR_SET_HEADER_AND_FOOTER 
		
		  //______________________________________________________
	: ($Lon_formEvent=On Bound Variable Change:K2:52)
		
		$Ptr_subformContainer:=OBJECT Get pointer:C1124(Object subform container:K67:4)
		$Lon_event:=$Ptr_subformContainer->
		$Ptr_subformContainer->:=0
		
		Case of 
				
				  //………………………………………………………………
			: ($Lon_event=On Resize:K2:27)
				
				NQR_HEADER_AND_FOOTER_ON_RESIZE 
				NQR_DRAW_TABS (\
					Get localized string:C991("tab_content");\
					Get localized string:C991("tab_settings"))
				
				  //………………………………………………………………
			: ($Lon_event=On Deactivate:K2:10)
				
				NQR_SET_HEADER_AND_FOOTER 
				
				  //………………………………………………………………
			Else 
				
				TRACE:C157
				
				  //………………………………………………………………
		End case 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 