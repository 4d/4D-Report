// ----------------------------------------------------
// Object method : BALLOON_COMMON.font.picker - (4D Report)
// ID[17EAF1BDC5B34A0CA9CD3D79A9DCD563]
// Created #18-9-2014 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_area; $Lon_color; $Lon_column; $Lon_formEvent; $Lon_row; $Lon_size)
C_LONGINT:C283($Lon_styles)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_font; $Txt_me)
C_OBJECT:C1216($Obj_caller)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Txt_font:=OBJECT Get font:C1069(*; $Txt_me)
		
		If ($Txt_font=".@")
			
			$Txt_font:=Get localized string:C991("systemFont")
			
		End if 
		
		$Lon_size:=OBJECT Get font size:C1070(*; $Txt_me)
		$Lon_styles:=OBJECT Get font style:C1071(*; $Txt_me)
		OBJECT GET RGB COLORS:C1074(*; $Txt_me; $Lon_color; $Lon_color)
		
		//update UI
		(OBJECT Get pointer:C1124(Object named:K67:5; "font.family.label"))->:=$Txt_font
		(OBJECT Get pointer:C1124(Object named:K67:5; "font.size.label"))->:=String:C10($Lon_size)
		(OBJECT Get pointer:C1124(Object named:K67:5; "font.style"))->:=$Lon_styles
		
		//update selection
		$Obj_caller:=JSON Parse:C1218((OBJECT Get pointer:C1124(Object named:K67:5; "caller"))->)
		$Lon_area:=OB Get:C1224($Obj_caller; "area"; Is longint:K8:6)
		$Lon_column:=OB Get:C1224($Obj_caller; "qrColumn"; Is longint:K8:6)
		$Lon_row:=OB Get:C1224($Obj_caller; "qrRow"; Is longint:K8:6)
		CLEAR VARIABLE:C89($Obj_caller)
		
		QR_SET_TEXT_PROPERTY($Lon_area; qr font name:K14904:10; $Txt_font; $Lon_column; $Lon_row)
		QR_SET_TEXT_PROPERTY($Lon_area; qr font size:K14904:2; String:C10($Lon_size); $Lon_column; $Lon_row)
		QR_SET_TEXT_PROPERTY($Lon_area; qr underline:K14904:5; String:C10(Num:C11($Lon_styles>=4)); $Lon_column; $Lon_row)
		$Lon_styles:=Choose:C955($Lon_styles>=4; $Lon_styles-4; $Lon_styles)
		QR_SET_TEXT_PROPERTY($Lon_area; qr italic:K14904:4; String:C10(Num:C11($Lon_styles>=2)); $Lon_column; $Lon_row)
		$Lon_styles:=Choose:C955($Lon_styles>=2; $Lon_styles-2; $Lon_styles)
		QR_SET_TEXT_PROPERTY($Lon_area; qr bold:K14904:3; String:C10(Num:C11($Lon_styles=1)); $Lon_column; $Lon_row)
		
		ob_area.modified:=True:C214
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		//______________________________________________________
End case 