//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_SET_EVENTS
// Database: 4D Report
// ID[D32CCF6B30E642F5848C884C33236F58]
// Created #18-7-2016 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
#DECLARE($report_object : Text; $context : Text)


var $report_area; $count_parameters : Integer
var $Txt_me : Text


ARRAY LONGINT:C221($_events; 0)


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	//$report_object:=$1
	
	//Optional parameters
	If ($count_parameters>=2)
		
		//$context:=$2
		
	End if 
	
	$report_area:=OB Get:C1224(ob_area; "area"; Is longint:K8:6)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Length:C16($context)=0)
		
		APPEND TO ARRAY:C911($_events; On Drag Over:K2:13)
		APPEND TO ARRAY:C911($_events; On Drop:K2:12)
		APPEND TO ARRAY:C911($_events; On Column Moved:K2:30)
		APPEND TO ARRAY:C911($_events; On Scroll:K2:57)
		
		If (QR Get report kind:C755($report_area)=qr cross report:K14902:2)
			
			OBJECT SET EVENTS:C1239(*; $report_object; $_events; Disable events others unchanged:K42:39)
			
		Else 
			
			OBJECT SET EVENTS:C1239(*; $report_object; $_events; Enable events others unchanged:K42:38)
			
		End if 
		
		//______________________________________________________
	: (Length:C16($context)=0)\
		 | ($context="display")
		
		APPEND TO ARRAY:C911($_events; On Drag Over:K2:13)
		APPEND TO ARRAY:C911($_events; On Drop:K2:12)
		APPEND TO ARRAY:C911($_events; On Column Moved:K2:30)
		APPEND TO ARRAY:C911($_events; On Scroll:K2:57)
		
		If (QR Get report kind:C755($report_area)=qr cross report:K14902:2)
			
			OBJECT SET EVENTS:C1239(*; $report_object; $_events; Disable events others unchanged:K42:39)
			
		Else 
			
			OBJECT SET EVENTS:C1239(*; $report_object; $_events; Enable events others unchanged:K42:38)
			
		End if 
		
		//______________________________________________________
	: ($context="cell_edit")
		
		APPEND TO ARRAY:C911($_events; On Mouse Move:K2:35)
		APPEND TO ARRAY:C911($_events; On Mouse Leave:K2:34)
		APPEND TO ARRAY:C911($_events; On Double Clicked:K2:5)
		APPEND TO ARRAY:C911($_events; On Header Click:K2:40)
		APPEND TO ARRAY:C911($_events; On Drag Over:K2:13)
		APPEND TO ARRAY:C911($_events; On Drop:K2:12)
		APPEND TO ARRAY:C911($_events; On Column Moved:K2:30)
		APPEND TO ARRAY:C911($_events; On Column Resize:K2:31)
		
		If (OB Get:C1224(ob_area; "cellEdition"; Is boolean:K8:9))  //true if a cell is being edited
			
			OBJECT SET EVENTS:C1239(*; $Txt_me; $_events; Disable events others unchanged:K42:39)
			
		Else 
			
			OBJECT SET EVENTS:C1239(*; $Txt_me; $_events; Enable events others unchanged:K42:38)
			
		End if 
		
		//______________________________________________________
	Else 
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End