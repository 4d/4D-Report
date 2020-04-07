//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : report_AREA_UPDATE
  // Database: 4D Report
  // ID[F80AE67451E84D70A1819CD3FCFF9823]
  // Created #6-5-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_parameters)
C_POINTER:C301($Ptr_timerEvent)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	$Ptr_timerEvent:=OBJECT Get pointer:C1124(Object named:K67:5;"timerEvent")
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
If (Not:C34(Is nil pointer:C315($Ptr_timerEvent)))
	
	$Ptr_timerEvent->:=1
	SET TIMER:C645(-1)
	
Else 
	
	QR_area:=QR_area
	REDRAW:C174(QR_area)
	
End if 

  // ----------------------------------------------------
  // End