//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_GET_HEADER_AND_FOOTER
  // Database: 4D Report
  // ID[9DE1EAB44AEB44CB83D6C0821DBD957D]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_area;$Lon_bold;$Lon_fontSize;$Lon_height;$Lon_italic;$Lon_parameters)
C_LONGINT:C283($Lon_selector;$Lon_styles;$Lon_target;$Lon_underline;$Lon_unit)
C_PICTURE:C286($Pic_buffer)
C_POINTER:C301($Ptr_unit)
C_TEXT:C284($Txt_buffer;$Txt_font)

If (False:C215)
	C_LONGINT:C283(NQR_GET_HEADER_AND_FOOTER ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Lon_selector:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
	$Lon_area:=QR_area
	
Else 
	
	ABORT:C156
	
End if 

If ($Lon_area#0)
	
	  //get texts, height and picture
	QR GET HEADER AND FOOTER:C775($Lon_area;$Lon_selector;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"box.left"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"box.center"))->;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"box.right"))->;\
		$Lon_height;\
		$Pic_buffer;\
		(OBJECT Get pointer:C1124(Object named:K67:5;"alignment"))->)
	
	(OBJECT Get pointer:C1124(Object named:K67:5;"picture"))->:=$Pic_buffer
	(OBJECT Get pointer:C1124(Object named:K67:5;"height"))->:=$Lon_height
	
	  //get the text properties
	$Lon_target:=Choose:C955($Lon_selector=1;qr header:K14906:4;qr footer:K14906:5)
	
	$Txt_font:=QR Get text property:C760($Lon_area;1;$Lon_target;qr font name:K14904:10)
	$Lon_fontSize:=QR Get text property:C760($Lon_area;1;$Lon_target;qr font size:K14904:2)
	$Lon_bold:=QR Get text property:C760($Lon_area;1;$Lon_target;qr bold:K14904:3)
	$Lon_underline:=QR Get text property:C760($Lon_area;1;$Lon_target;qr underline:K14904:5)
	$Lon_italic:=QR Get text property:C760($Lon_area;1;$Lon_target;qr italic:K14904:4)
	
	  //update UI
	$Lon_styles:=(Bold:K14:2*$Lon_bold)+(Italic:K14:3*$Lon_italic)+(Underline:K14:4*$Lon_underline)
	$Txt_buffer:=Replace string:C233($Txt_font;".Lucida Grande UI";"Lucida Grande")+" "+String:C10($Lon_fontSize)+Get localized string:C991("pts")
	OBJECT SET FONT STYLE:C166(*;"pangram";$Lon_styles)
	
	OBJECT SET FONT:C164(*;"text.style";$Txt_font)
	OBJECT SET FONT SIZE:C165(*;"text.style";$Lon_fontSize)
	OBJECT SET FONT STYLE:C166(*;"text.style";$Lon_styles)
	
	(OBJECT Get pointer:C1124(Object named:K67:5;"pangram"))->:=$Txt_buffer
	
Else 
	
	  //test in matrix database
	(OBJECT Get pointer:C1124(Object named:K67:5;"alignment"))->:=1
	
End if 

  //The returned value for the height is always in points
(OBJECT Get pointer:C1124(Object named:K67:5;"height.points"))->:=$Lon_height

$Ptr_unit:=OBJECT Get pointer:C1124(Object named:K67:5;"height.unit")
$Lon_unit:=$Ptr_unit->

If ($Lon_unit#1)
	
	  //hide current
	SVG SET ATTRIBUTE:C1055(*;"unit";String:C10($Lon_unit);\
		"visibility";"hidden")
	
	  //change unit
	$Lon_unit:=1
	$Ptr_unit->:=$Lon_unit
	
	  //show current
	SVG SET ATTRIBUTE:C1055(*;"unit";String:C10($Lon_unit);\
		"visibility";"visible")
	
End if 

  //format the title
OBJECT SET TITLE:C194(*;"title";\
Get localized string:C991(Choose:C955($Lon_selector=1;"toolbar_header";"toolbar_footer")))

  //keep the selector
(OBJECT Get pointer:C1124(Object named:K67:5;"selector"))->:=$Lon_selector

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End