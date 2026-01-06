//%attributes = {"invisible":true}
var $fileName; $Txt_errorHandlingMethod; $directory; $templateName : Text
var $destination; $table : Integer

QR GET DESTINATION:C756(QR_area; $destination; $directory)

If ($destination=qr text file:K14903:2)\
 | ($destination=qr HTML file:K14903:5)
	
	$fileName:=Select document:C905($directory; $destination=qr text file:K14903:2 ? ".txt" : ".html"; ""; File name entry:K24:17+Use sheet window:K24:11)
	
	If (Bool:C1537(OK))
		
		// MARK: ACI0099118 : set destination is erasing the html template, so we need to save it and re-set it.
		$templateName:=QR Get HTML template:C751(QR_area)
		
		If (Length:C16($templateName)=0)\
			 && Not:C34(ob_dialog.optionHTMLtemplate=Null:C1517)
			
			$templateName:=ob_dialog.optionHTMLtemplate
			
		End if 
		
		QR SET DESTINATION:C745(QR_area; $destination; DOCUMENT)
		QR SET HTML TEMPLATE:C750(QR_area; $templateName)
		
	End if 
	
Else 
	
	OK:=1
	
End if 

If (Not:C34(Bool:C1537(OK)))
	
	return 
	
End if 

$table:=QR Get report table:C758(QR_area)

If (Records in selection:C76(Table:C252($table)->)=0)
	
	ALL RECORDS:C47(Table:C252($table)->)
	
End if 

// Execute the report with the current settings, including the output type
Try
	
	QR RUN:C746(QR_area)
	
Catch
	
	ALERT:C41(Localized string:C991("previewIsNotPossible"))
	
End try