//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : NQR_RELOAD
  // Database: 4D Report
  // ID[C5ACCF089A1F4D7AAEABC2E15928C860]
  // Created #11-6-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_parameters)

  // ----------------------------------------------------
  // Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0;"Missing parameter"))
	
	  //NO PARAMETERS REQUIRED
	
	  //Optional parameters
	If ($Lon_parameters>=1)
		
		  //<NONE>
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

  // ----------------------------------------------------
  //clear selection
NQR_SET_SELECTION ("none")

If (Length:C16(C_QR_INITPATH)>0)
	
	  //load the contents of the document
	DOCUMENT TO BLOB:C525(C_QR_INITPATH;$Blb_buffer)
	
	If (OK=1)
		
		  //place the report in the area
		QR BLOB TO REPORT:C771(QR_area;$Blb_buffer)
		
	End if 
	
Else 
	
	If (BLOB size:C605(C_QR_INITBLOB)>0)
		
		QR BLOB TO REPORT:C771(QR_area;C_QR_INITBLOB)
		
	Else 
		
		NQR_CLEAR 
		
	End if 
End if 

  //update the hash
NQR_DIGEST 

  //update UI
NQR_TOOLBAR ("update")

  // ----------------------------------------------------
  // Return
  //<NONE>
  // ----------------------------------------------------
  // End