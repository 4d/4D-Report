//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : xmlColoredSyntax
// ID[20858E31C6A94C829CD0963124FCD4C1]
// Created 06/07/11 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Return colored XML to display in a Multi-style text object
// ----------------------------------------------------
// Declarations

#DECLARE($xml : Text) : Text


var \
$error; \
$count_parameters : Integer

var \
$attributeFontWeight; \
$attributeNameColor; \
$attributeValueColor; \
$commentColor; \
$commentFontWeight; \
$defaultColor; \
$defaultFontWeight; \
$doctypeColor; \
$doctypeFontWeight; \
$elementColor; \
$elementFontWeight; \
$entityColor; \
$entityFontWeight; \
$pattern; \
$processingColor; \
$processingFontWeight; \
$styleAttribute; \
$styleComment; \
$styleDoctype; \
$styleElement; \
$styleEntity; \
$styleProcessing : Text

If (False:C215)
	C_TEXT:C284(xmlColoredSyntax; $0)
	C_TEXT:C284(xmlColoredSyntax; $1)
End if 

// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; Get localized string:C991("error_missingParameter")))
	
	
	
	$defaultColor:="black"
	$defaultFontWeight:="normal"
	
	$elementColor:="#2a2aa7"
	$elementFontWeight:="normal"
	
	$attributeFontWeight:="normal"
	$attributeNameColor:="#f58953"
	$attributeValueColor:="#9d3d0a"
	
	$commentColor:="green"
	$commentFontWeight:="normal"
	
	$processingColor:="#8526C2"
	$processingFontWeight:="normal"
	
	$doctypeColor:="blue"
	$doctypeFontWeight:="normal"
	
	$entityColor:="#94961C"
	$entityFontWeight:="normal"
	
	$styleElement:="<span style=\"color:"+$elementColor\
		+";font-weight:"+$elementFontWeight+";\">\\1</span>"
	
	$styleAttribute:="<span style=\"color:"+$attributeNameColor\
		+";font-weight:"+$attributeFontWeight\
		+";\">\\1</span><span style=\"color:"+$defaultColor\
		+";font-weight:"+$defaultFontWeight\
		+";\">=\"<span style=\"color:"+$attributeValueColor\
		+";font-weight:"+$attributeFontWeight\
		+";\">\\2</span>\"</span>"
	
	$styleComment:="<span style=\"color:"+$commentColor\
		+";font-weight:"+$commentFontWeight+";\">\\1</span>"
	
	$styleProcessing:="<span style=\"color:"+$processingColor\
		+";font-weight:"+$processingFontWeight+";\">\\1</span>"
	
	$styleDoctype:="<span style=\"color:"+$doctypeColor\
		+";font-weight:"+$doctypeFontWeight+";\">\\1</span>"
	
	$styleEntity:="<span style=\"color:"+$entityColor\
		+";font-weight:"+$entityFontWeight+";\">\\1</span>"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

//replace < and > caracteres
$xml:=Replace string:C233($xml; "<"; "_§§")
$xml:=Replace string:C233($xml; ">"; "_¿¿")

//processing instruction
$pattern:="(_§§\\?[^_¿¿]*\\?_¿¿)"
$error:=Rgx_SubstituteText($pattern; $styleProcessing; ->$xml)

//attributes
$pattern:="(\\s+[^= ]*)=\"([^\"]*)\"(?!.*\\?_¿¿)"
$error:=Rgx_SubstituteText($pattern; $styleAttribute; ->$xml)

//elements
$pattern:="(_§§[^?_¿¿]*_¿¿)"
$error:=Rgx_SubstituteText($pattern; $styleElement; ->$xml)

//comments
$pattern:="(_§§!--.*?--_¿¿)"
$error:=Rgx_SubstituteText($pattern; $styleComment; ->$xml)

//default
$xml:="<span style=\"color:"+$defaultColor\
+";font-weight:"+$defaultFontWeight+";\">"+$xml+"</span>"

//doctype
$pattern:="(_§§\\![^-][^_¿¿]*_¿¿)"
$error:=Rgx_SubstituteText($pattern; $styleDoctype; ->$xml)

//entities
$pattern:="(&amp;[^;]*;)"
$error:=Rgx_SubstituteText($pattern; $styleEntity; ->$xml)

//restore < and > caracteres
$xml:=Replace string:C233($xml; "_§§"; "&lt;")
$xml:=Replace string:C233($xml; "_¿¿"; "&gt;")

// ----------------------------------------------------
// End

return $xml
