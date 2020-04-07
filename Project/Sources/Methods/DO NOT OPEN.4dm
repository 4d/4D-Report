//%attributes = {"invisible":true}
ALERT:C41("This component is a part of a software and cannot be used lonely.")

If (Not:C34(Shift down:C543))
	
	QUIT 4D:C291
	
End if 