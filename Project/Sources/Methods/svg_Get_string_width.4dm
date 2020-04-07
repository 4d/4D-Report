//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Method : svg_Get_string_width
  // Created 22/07/08 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description
  // Returns the width of the parameter text, based on the font informations.
  // ----------------------------------------------------
C_REAL:C285($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_LONGINT:C283($Lon_fonStyle;$Lon_fontSize;$Lon_height;$Lon_Unused)
C_PICTURE:C286($Pic_buffer)
C_REAL:C285($Num_width)
C_TEXT:C284($Txt_fontName;$Txt_rootReference;$Txt_string;$Txt_textID)

If (False:C215)
	C_REAL:C285(svg_Get_string_width ;$0)
	C_TEXT:C284(svg_Get_string_width ;$1)
	C_TEXT:C284(svg_Get_string_width ;$2)
	C_LONGINT:C283(svg_Get_string_width ;$3)
	C_LONGINT:C283(svg_Get_string_width ;$4)
End if 

$Txt_string:=$1
$Txt_fontName:=$2
$Lon_fontSize:=$3

If (Count parameters:C259>=4)
	
	$Lon_fonStyle:=$4
	
End if 

$Txt_rootReference:=DOM Create XML Ref:C861("svg";"http://www.w3.org/2000/svg")

If (OK=1)
	
	$Txt_textID:=DOM Create XML element:C865($Txt_rootReference;"text";\
		"font-family";$Txt_fontName;\
		"font-size";$Lon_fontSize)
	
	If ($Lon_fonStyle>=8)  //line-through
		
		DOM SET XML ATTRIBUTE:C866($Txt_textID;\
			"text-decoration";"line-through")
		
		$Lon_fonStyle:=$Lon_fonStyle-8
		
	End if 
	
	If ($Lon_fonStyle>=4)  //underline
		
		DOM SET XML ATTRIBUTE:C866($Txt_textID;\
			"text-decoration";"underline")
		
		$Lon_fonStyle:=$Lon_fonStyle-4
		
	End if 
	
	If ($Lon_fonStyle>=2)  //italic
		
		DOM SET XML ATTRIBUTE:C866($Txt_textID;\
			"font-style";"italic")
		
		$Lon_fonStyle:=$Lon_fonStyle-2
		
	End if 
	
	If ($Lon_fonStyle=1)  //bold
		
		DOM SET XML ATTRIBUTE:C866($Txt_textID;\
			"font-weight";"bold")
		
	End if 
	
	  //Invisible characters are not treated properly
	  //So they were  replaced
	  //{
	$Txt_string:=Replace string:C233($Txt_string;"  ";"==")
	$Txt_string:=Replace string:C233($Txt_string;"\t";"====")
	  //}
	
	DOM SET XML ELEMENT VALUE:C868($Txt_textID;$Txt_string)
	
	SVG EXPORT TO PICTURE:C1017($Txt_rootReference;$Pic_buffer)
	PICTURE PROPERTIES:C457($Pic_buffer;$Num_width;$Lon_height;$Lon_Unused;$Lon_Unused;$Lon_Unused)
	$Pic_buffer:=$Pic_buffer*0
	
	$0:=$Num_width
	
	DOM CLOSE XML:C722($Txt_rootReference)
	
End if 