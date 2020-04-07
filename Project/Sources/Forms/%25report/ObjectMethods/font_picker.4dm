  // ----------------------------------------------------
  // Object method : Report.fontDescription - (report)
  // ID[A76AB0E900F547E2B263234E6FCA2AF5]
  // Created #4-4-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_fontSize;$Lon_fontStyle;$Lon_formEvent;$Lon_row)
C_TEXT:C284($Txt_fontName;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		
		  //______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Txt_fontName:=OBJECT Get font:C1069(*;$Txt_me)
		$Lon_fontSize:=OBJECT Get font size:C1070(*;$Txt_me)
		$Lon_fontStyle:=OBJECT Get font style:C1071(*;$Txt_me)
		
		$Lon_area:=OB Get:C1224(ob_area;"area";Is longint:K8:6)
		
		If (OB Get:C1224(ob_area;"crossReport";Is boolean:K8:9))
			
			$Lon_column:=OB Get:C1224(ob_area;"columnIndex";Is longint:K8:6)
			$Lon_row:=OB Get:C1224(ob_area;"rowIndex";Is longint:K8:6)
			
			If ($Lon_column=1)\
				 & ($Lon_row=1)
				
				$Lon_column:=0
				$Lon_row:=0
				
			End if 
			
		Else 
			
			$Lon_column:=OB Get:C1224(ob_area;"qrColumn";Is longint:K8:6)
			$Lon_row:=OB Get:C1224(ob_area;"qrRow";Is longint:K8:6)
			
		End if 
		
		QR_SET_TEXT_PROPERTY ($Lon_area;qr font name:K14904:10;$Txt_fontName;$Lon_column;$Lon_row)
		QR_SET_TEXT_PROPERTY ($Lon_area;qr font size:K14904:2;String:C10($Lon_fontSize);$Lon_column;$Lon_row)
		QR_SET_TEXT_PROPERTY ($Lon_area;qr bold:K14904:3;String:C10(Num:C11($Lon_fontStyle ?? 0));$Lon_column;$Lon_row)
		QR_SET_TEXT_PROPERTY ($Lon_area;qr italic:K14904:4;String:C10(Num:C11($Lon_fontStyle ?? 1));$Lon_column;$Lon_row)
		QR_SET_TEXT_PROPERTY ($Lon_area;qr underline:K14904:5;String:C10(Num:C11($Lon_fontStyle ?? 2));$Lon_column;$Lon_row)
		
		report_AREA_UPDATE 
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 