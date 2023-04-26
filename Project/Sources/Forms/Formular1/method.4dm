If (Form event code:C388=On Load:K2:1)
	C_LONGINT:C283(qrsub)
	QR NEW AREA:C1320(->qrsub)  //initializes a new report area
	
End if 


If (Form event code:C388=On Timer:K2:25)
	SET TIMER:C645(0)
	//GOTO OBJECT(qrsub)
End if 