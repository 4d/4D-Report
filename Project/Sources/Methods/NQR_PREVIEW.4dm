//%attributes = {"invisible":true}
C_OBJECT:C1216($Obj_current)
C_TEXT:C284($Txt_errorHandlingMethod)

  //save current
OB SET:C1220($Obj_current;\
"preview";Get print preview:C1197;\
"dialog";QR Get document property:C773(QR_area;qr printing dialog:K14907:1))

  //the print dialog is not displayed prior to printing
QR SET DOCUMENT PROPERTY:C772(QR_area;qr printing dialog:K14907:1;0)

  //force preview
SET PRINT PREVIEW:C364(True:C214)

$Txt_errorHandlingMethod:=report_catchErrors ("on")
QR RUN:C746(QR_area)

If (error#0)
	
	ALERT:C41(Get localized string:C991("previewIsNotPossible"))
	
End if 

report_catchErrors ("off";$Txt_errorHandlingMethod)

  //restore
SET PRINT PREVIEW:C364($Obj_current.preview)
QR SET DOCUMENT PROPERTY:C772(QR_area;qr printing dialog:K14907:1;OB Get:C1224($Obj_current;"dialog";Is longint:K8:6))

