C_TEXT:C284($Txt_templateName)


If (QR_area#0)
	
	//ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it. 
	$Txt_templateName:=QR Get HTML template:C751(QR_area)
	If (($Txt_templateName="") & Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517))
		$Txt_templateName:=ob_dialog.optionHTMLtemplate
	End if 
	
	QR SET DESTINATION:C745(QR_area; qr printer:K14903:1; "*"*Num:C11(Self:C308->=1))
	
	QR SET HTML TEMPLATE:C750(QR_area; $Txt_templateName)
	
	ob_area.modified:=True:C214
	
End if 