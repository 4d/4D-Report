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
C_POINTER:C301($1)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_area;$Lon_parameters;$Lon_tableNumber)
C_POINTER:C301($Ptr_container)

If (False:C215)
	C_POINTER:C301(report_CREATE_AREA ;$1)
End if 

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1;"Missing parameter"))
	
	  //Required parameters
	$Ptr_container:=$1
	
	  //Optional parameters
	If ($Lon_parameters>=2)
		
		  // <NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
$Lon_tableNumber:=report_Get_table 

If ($Lon_tableNumber#0)  //There is at least one table
	
	If (Asserted:C1132(Not:C34(Is nil pointer:C315($Ptr_container))))
		
		  //%W-518.7
		If (Not:C34(Undefined:C82($Ptr_container->)))
			  //%W+518.7
			
			If (QR_is_valid_area ($Ptr_container->))
				
				QR DELETE OFFSCREEN AREA:C754($Ptr_container->)
				
			End if 
		End if 
	End if 
	
	  //create the offscreen QR area
	QR NEW AREA:C1320($Ptr_container)
	
	IDLE:C311
	
	$Lon_area:=$Ptr_container->
	
	QR SET REPORT TABLE:C757($Lon_area;$Lon_tableNumber)
	QR SET REPORT KIND:C738($Lon_area;qr list report:K14902:1)
	QR SET DESTINATION:C745($Lon_area;qr printer:K14903:1)
	QR SET AREA PROPERTY:C796($Lon_area;qr view contextual menus:K14905:7;1)
	
	  //update the area reference
	OB SET:C1220(ob_area;\
		"area";$Lon_area)
	
	If (OB Get:C1224(ob_area;"4d-dialog";Is boolean:K8:9))  //4D dialog
		
		  //update the hash
		QR REPORT TO BLOB:C770($Lon_area;$Blb_buffer)
		OB SET:C1220(ob_area;\
			"_digest";Generate digest:C1147($Blb_buffer;\
			MD5 digest:K66:1))
		
		SET BLOB SIZE:C606($Blb_buffer;0)
		
	End if 
	
Else 
	
	  //create the offscreen QR area
	QR NEW AREA:C1320($Ptr_container)
	
	  //update the area reference
	OB SET:C1220(ob_area;\
		"area";$Ptr_container->)
	
End if 

  // ----------------------------------------------------
  // Return
  // <NONE>
  // ----------------------------------------------------
  // End