ok:=1
C_POINTER:C301($ptr)
C_TEXT:C284($path)

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"subform")

$path:=Folder:C1567(fk resources folder:K87:11).platformPath+"myReport.html"


QR SET DESTINATION:C745($ptr->;qr HTML file:K14903:5;$path)

QR RUN:C746($ptr->)

If (ok=1)
	
	SHOW ON DISK:C922($path)
	OPEN URL:C673($path)
	
End if 
