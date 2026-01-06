//%attributes = {"invisible":true}
// Backup
var $backup:={\
preview: Get print preview:C1197; \
dialog: QR Get document property:C773(QR_area; qr printing dialog:K14907:1)\
}

// Force preview
SET PRINT PREVIEW:C364(True:C214)

// Don't dispaly the print dialog prior to printing
QR SET DOCUMENT PROPERTY:C772(QR_area; qr printing dialog:K14907:1; 0)

// MARK: ACI0106049
SET PRINT OPTION:C733(Destination option:K47:7; 1)

Try
	
	QR RUN:C746(QR_area)
	
Catch
	
	ALERT:C41(Localized string:C991("previewIsNotPossible"))
	
End try

// Restore
SET PRINT PREVIEW:C364($backup.preview)
QR SET DOCUMENT PROPERTY:C772(QR_area; qr printing dialog:K14907:1; $backup.dialog)