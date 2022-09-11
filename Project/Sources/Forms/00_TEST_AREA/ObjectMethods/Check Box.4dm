var $ptr : Pointer

$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "subform")

If ($ptr->#0)
	
	If (Self:C308->=1)
		
		QR SET REPORT KIND:C738($ptr->; qr cross report:K14902:2)
		
	Else 
		
		QR SET REPORT KIND:C738($ptr->; qr list report:K14902:1)
		
	End if 
	
End if 