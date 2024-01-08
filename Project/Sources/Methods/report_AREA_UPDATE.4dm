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

var \
$count_parameters : Integer

var \
$timer_event : Pointer



// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	//mark:ACI0103539
	//#DD : old system deprecated use Form.timerEvent instead
	$timer_event:=OBJECT Get pointer:C1124(Object named:K67:5; "timerEvent")
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

//todo: simplification remove $timer_event etc (DONE)

//Case of 
//: (True)

Form:C1466.timerEvent:=1
SET TIMER:C645(-1)

//: (Is nil pointer($timer_event))

//QR_area:=QR_area
//REDRAW(QR_area)

//Else 

////mark:ACI0103539
////#DD : old system deprecated use Form.timerEvent instead
//$timer_event->:=1



//End case 


// ----------------------------------------------------
// End