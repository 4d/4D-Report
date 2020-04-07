  // ----------------------------------------------------
  // Object method : NQR_HEADER_AND_FOOTER.text - (4D Report)
  // ID[0754479F14EF4F309CE570ECD3CD6FA3]
  // Created #17-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_fontSize;$Lon_formEvent;$Lon_selector;$Lon_styles;$Lon_target)
C_TEXT:C284($Txt_buffer;$Txt_font;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Lon_area:=QR_area
		
		  //get the font properties
		$Txt_font:=OBJECT Get font:C1069(*;$Txt_me)
		$Lon_fontSize:=OBJECT Get font size:C1070(*;$Txt_me)
		$Lon_styles:=OBJECT Get font style:C1071(*;$Txt_me)
		
		  //set the area
		$Lon_selector:=(OBJECT Get pointer:C1124(Object named:K67:5;"selector"))->
		$Lon_target:=Choose:C955($Lon_selector=1;qr header:K14906:4;qr footer:K14906:5)
		
		QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr font name:K14904:10;$Txt_font)
		QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr font size:K14904:2;$Lon_fontSize)
		QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr underline:K14904:5;Num:C11($Lon_styles>=4))
		$Lon_styles:=Choose:C955($Lon_styles>=4;$Lon_styles-4;$Lon_styles)
		QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr italic:K14904:4;Num:C11($Lon_styles>=2))
		$Lon_styles:=Choose:C955($Lon_styles>=2;$Lon_styles-2;$Lon_styles)
		QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr bold:K14904:3;Num:C11($Lon_styles=1))
		
		  //update UI
		OBJECT SET FONT:C164(*;$Txt_me;OBJECT Get font:C1069(*;""))
		OBJECT SET FONT SIZE:C165(*;$Txt_me;OBJECT Get font size:C1070(*;""))
		
		$Txt_buffer:=Replace string:C233($Txt_font;".Lucida Grande UI";"Lucida Grande")+" "+String:C10($Lon_fontSize)+Get localized string:C991("pts")
		OBJECT SET FONT STYLE:C166(*;$Txt_me;$Lon_styles)
		
		OBJECT SET FONT:C164(*;"text.style";$Txt_font)
		OBJECT SET FONT SIZE:C165(*;"text.style";$Lon_fontSize)
		OBJECT SET FONT STYLE:C166(*;"text.style";$Lon_styles)
		
		Self:C308->:=$Txt_buffer
		
		  //______________________________________________________
	: ($Lon_formEvent=On Getting Focus:K2:7)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"current_2"))->:=OBJECT Get name:C1087(Object current:K67:2)
		HIGHLIGHT TEXT:C210(*;$Txt_me;1;1)
		
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 