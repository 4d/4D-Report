//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_SET_HEADER_AND_FOOTER
  // Database: 4D Report
  // ID[EF3F702CB6D249C0ADE0D35F2DB63058]
  // Created #12-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_fontSize;$Lon_parameters;$Lon_selector;$Lon_styles;$Lon_target)
C_TEXT:C284($Txt_font)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //Required parameters
	  // <NONE>
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  // <NONE>
		
	End if 
	
	$Lon_area:=QR_area
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_selector:=(OBJECT Get pointer:C1124(Object named:K67:5;"selector"))->

If ($Lon_area#0)
	
	  //set texts, height and picture
	QR SET HEADER AND FOOTER:C774($Lon_area;$Lon_selector;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"box.left"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"box.center"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"box.right"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"height.points"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"picture"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"alignment"))->)
	
	  //set text properties
	$Txt_font:=OBJECT Get font:C1069(*;"text.style")
	$Lon_fontSize:=OBJECT Get font size:C1070(*;"text.style")
	$Lon_styles:=OBJECT Get font style:C1071(*;"text.style")
	
	$Lon_target:=Choose:C955($Lon_selector=1;qr header:K14906:4;qr footer:K14906:5)
	
	QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr font name:K14904:10;$Txt_font)
	QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr font size:K14904:2;$Lon_fontSize)
	QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr underline:K14904:5;Num:C11($Lon_styles>=4))
	$Lon_styles:=Choose:C955($Lon_styles>=4;$Lon_styles-4;$Lon_styles)
	QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr italic:K14904:4;Num:C11($Lon_styles>=2))
	$Lon_styles:=Choose:C955($Lon_styles>=2;$Lon_styles-2;$Lon_styles)
	QR SET TEXT PROPERTY:C759($Lon_area;1;$Lon_target;qr bold:K14904:3;Num:C11($Lon_styles=1))
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End