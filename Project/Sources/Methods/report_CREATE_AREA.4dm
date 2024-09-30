//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : report_CREATE_AREA
// Database: 4D Report
// ID[F8315533839B4D768542C6701FF10CEC]
// Created #24-6-2015 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations

#DECLARE($container_pointer : Pointer)

var $buffer : Blob

var $area; $count_parameters; $table_number : Integer


// ----------------------------------------------------
// Initialisations
$count_parameters:=Count parameters:C259

If (Asserted:C1132($count_parameters>=1; "Missing parameter"))
	
	//Required parameters
	
	//Optional parameters
	If ($count_parameters>=2)
		
		// <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$table_number:=report_Get_table

If ($table_number#0)  //There is at least one table
	
	If (Asserted:C1132(Not:C34(Is nil pointer:C315($container_pointer))))
		
		//%W-518.7
		If (Not:C34(Undefined:C82($container_pointer->)))
			//%W+518.7
			
			If (QR_is_valid_area($container_pointer->))
				
				QR DELETE OFFSCREEN AREA:C754($container_pointer->)
				
			End if 
		End if 
	End if 
	
	//create the offscreen QR area
	QR NEW AREA:C1320($container_pointer)
	
	IDLE:C311
	
	$area:=$container_pointer->
	
	QR SET REPORT TABLE:C757($area; $table_number)
	QR SET REPORT KIND:C738($area; qr list report:K14902:1)
	QR SET DESTINATION:C745($area; qr printer:K14903:1)
	QR SET AREA PROPERTY:C796($area; qr view contextual menus:K14905:7; 1)
	
	//update the area reference
	
	ob_area.area:=$area
	
	If (Bool:C1537(ob_area["4d-dialog"]))  //4D dialog
		
		//update the hash
		QR REPORT TO BLOB:C770($area; $buffer)
		
		
		ob_area._digest:=Generate digest:C1147($buffer; MD5 digest:K66:1)
		
		SET BLOB SIZE:C606($buffer; 0)
		
		//If (<>withFeature111172)
		If (Form_C_UseVirtualStructure=0)
			// we need to reinit the structure as we are not using the virtual structure in this special case: NQR + design mode. 
			boo_useVirtualStructure:=False:C215
			
			db_INIT_STRUCTURE
			
		End if 
		
		//End if 
		
	End if 
	
Else 
	
	//create the offscreen QR area
	QR NEW AREA:C1320($container_pointer)
	
	//update the area reference
	ob_area.area:=($container_pointer)->
	
End if 

// ----------------------------------------------------
// Return
// <NONE>
// ----------------------------------------------------
// End